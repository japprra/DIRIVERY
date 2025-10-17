package Controller;

import DAO.ProductoDAO;
import ModelProductos.Producto;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/")
public class PaginasController {
    
@Autowired
private JdbcTemplate jdbcTemplate;

    @Autowired
    private ProductoDAO productoDAO;

    @GetMapping({"", "/inde x.htm"})
    public ModelAndView mostrarTodoProductos() {
        List<Producto> productos = productoDAO.listarTodos();
        ModelAndView mav = new ModelAndView("index");
        mav.addObject("productos", productos);
        return mav;
    }

    @GetMapping("/polo.htm")
    public ModelAndView mostrarpolo() {
        List<Producto> productos = productoDAO.listarPorClave("Cultura");
        return new ModelAndView("paginas/polo", "productos", productos);
    }

    @GetMapping("/cuadros.htm")
    public ModelAndView mostrarCuadro() {
        List<Producto> productos = productoDAO.listarPorClave("Manufactura");
        return new ModelAndView("paginas/cuadros", "productos", productos);
    }

    @GetMapping("/accesorios.htm")
    public ModelAndView mostrarAccesorios() {
        List<Producto> productos = productoDAO.listarPorClave("agroindustria");
        return new ModelAndView("paginas/accesorios", "productos", productos);
    }

    @GetMapping("/busqueda.htm")
    public String buscarProductos(@RequestParam("query") String query, Model model) {
        List<Producto> productos = productoDAO.buscar(query);
        model.addAttribute("productos", productos);
        return "paginas/busqueda";
    }

    // ------------------- 🛒 Carrito -------------------

    @GetMapping("/carrito/agregar.htm")
    public String agregarCarrito(@RequestParam("id") int id,
                                 @RequestParam(value = "redirect", required = false) String redirect,
                                 HttpSession session) {

        Producto p = productoDAO.obtenerPorId(id);
        p.setCantidad(1);

        List<Producto> carrito = (List<Producto>) session.getAttribute("carrito");
        if (carrito == null) carrito = new ArrayList<>();

        carrito.add(p);
        session.setAttribute("carrito", carrito);

        int totalItems = carrito.stream().mapToInt(Producto::getCantidad).sum();
        session.setAttribute("contadorCarrito", totalItems);

        return redirect != null ? "redirect:/" + redirect + ".htm" : "redirect:/index.htm";
    }
    
    
@GetMapping("/carrito/vaciar.htm")
public ModelAndView vaciarCarrito(HttpSession session) {
    // 🧹 Vaciar el carrito
    session.removeAttribute("carrito");

    // 🔄 Reiniciar contador del carrito
    session.setAttribute("contadorCarrito", 0);

    // 💬 Redirigir al carrito vacío con mensaje
    ModelAndView mav = new ModelAndView("redirect:/carrito/ver.htm");
    mav.addObject("mensaje", "Tu carrito ha sido vaciado correctamente.");
    return mav;
}

    
    @GetMapping("/carrito/ver.htm")
    public ModelAndView verCarrito(HttpSession session) {
        List<Producto> carrito = (List<Producto>) session.getAttribute("carrito");
        if (carrito == null) carrito = new ArrayList<>();

        double total = carrito.stream()
                .mapToDouble(p -> p.getPrecio() * p.getCantidad())
                .sum();

        ModelAndView mav = new ModelAndView("paginas/carrito");
        mav.addObject("carrito", carrito);
        mav.addObject("total", total);
        return mav;
    }

    @GetMapping("/checkout.htm")
public ModelAndView mostrarCheckout(HttpSession session) {
    List<Producto> carrito = (List<Producto>) session.getAttribute("carrito");
    if (carrito == null || carrito.isEmpty()) {
        // Si el carrito está vacío, redirige al carrito
        ModelAndView mav = new ModelAndView("redirect:/carrito/ver.htm");
        mav.addObject("mensajeError", "Tu carrito está vacío. Agrega productos antes de pagar.");
        return mav;
    }

    double total = carrito.stream()
            .mapToDouble(p -> p.getPrecio() * p.getCantidad())
            .sum();

    ModelAndView mav = new ModelAndView("paginas/checkout"); // ✅ JSP checkout.jsp
    mav.addObject("carrito", carrito);
    mav.addObject("total", total);
    return mav;
}

 // ------------------- ✅ Procesar Pedido -------------------

   @PostMapping("/procesarPedido.htm")
public ModelAndView procesarPedido(
        @RequestParam("contacto") String contacto,
        @RequestParam("destino") String destino,
        @RequestParam("ubicacion") String ubicacion,
        HttpSession session) {

    List<Producto> carrito = (List<Producto>) session.getAttribute("carrito");
    if (carrito == null || carrito.isEmpty()) {
        ModelAndView mav = new ModelAndView("redirect:/carrito/ver.htm");
        mav.addObject("mensajeError", "Tu carrito está vacío. No se puede procesar el pedido.");
        return mav;
    }

    double total = carrito.stream()
            .mapToDouble(p -> p.getPrecio() * p.getCantidad())
            .sum();

    try {
        // ✅ 1️⃣ Insertar pedido
String sqlPedido = "INSERT INTO pedidos (usuario_id, contacto, destino, ubicacion, total, fecha) VALUES (?, ?, ?, ?, ?, NOW())";
jdbcTemplate.update(sqlPedido, 1, contacto, destino, ubicacion, total);

// ✅ 2️⃣ Obtener el ID del pedido recién insertado
Integer idPedido = jdbcTemplate.queryForObject("SELECT MAX(idpedido) FROM pedidos", Integer.class);


        // 🔹 3️⃣ Insertar los detalles y actualizar stock (campo 'cantidad')
        String sqlDetalle = "INSERT INTO pedido_detalle (idpedido, producto_id, cantidad, precio) VALUES (?, ?, ?, ?)";
        String sqlStock = "UPDATE productos SET cantidad = cantidad - ? WHERE idprod = ? AND cantidad >= ?";

        for (Producto p : carrito) {
            // Insertar detalle del pedido
            jdbcTemplate.update(sqlDetalle, idPedido, p.getIdprod(), p.getCantidad(), p.getPrecio());

            // Actualizar stock solo si hay suficiente
            int filas = jdbcTemplate.update(sqlStock, p.getCantidad(), p.getIdprod(), p.getCantidad());
            if (filas == 0) {
                throw new RuntimeException("Stock insuficiente para el producto: " + p.getNombre());
            }
        }

        // 🔹 4️⃣ Vaciar carrito después de procesar el pedido
        session.removeAttribute("carrito");
        session.setAttribute("contadorCarrito", 0);

        // 🔹 5️⃣ Mostrar confirmación
        ModelAndView mav = new ModelAndView("paginas/confirmacionPedido");
        mav.addObject("mensaje", "¡Gracias por tu compra!");
        mav.addObject("total", total);
        mav.addObject("destino", destino);
        return mav;

    } catch (Exception e) {
        e.printStackTrace();
        ModelAndView mav = new ModelAndView("paginas/checkout");
        mav.addObject("mensajeError", "Error al procesar el pedido: " + e.getMessage());
        return mav;
    }
}


    @GetMapping("/carrito/eliminar.htm")
    public String eliminarDelCarrito(@RequestParam("id") int id, HttpSession session) {
        List<Producto> carrito = (List<Producto>) session.getAttribute("carrito");
        if (carrito != null) {
            carrito.removeIf(p -> p.getIdprod() == id);
            session.setAttribute("carrito", carrito);
        }
        return "redirect:/carrito/ver.htm";
    }

    @PostMapping("/carrito/actualizar.htm")
    public String actualizarCantidad(@RequestParam("id") int id,
                                     @RequestParam("cantidad") int cantidad,
                                     HttpSession session,
                                     RedirectAttributes redirect) {

        int stock = productoDAO.obtenerStockPorId(id);
        if (cantidad > stock) {
            redirect.addFlashAttribute("mensajeError", "Stock insuficiente (" + stock + " disponibles)");
            return "redirect:/carrito/ver.htm";
        }

        List<Producto> carrito = (List<Producto>) session.getAttribute("carrito");
        if (carrito != null) {
            for (Producto p : carrito) {
                if (p.getIdprod() == id) {
                    p.setCantidad(cantidad);
                    break;
                }
            }
            session.setAttribute("carrito", carrito);
        }
        return "redirect:/carrito/ver.htm";
    }
    

@GetMapping("/blog.htm")
public ModelAndView mostrarBlog() {
    // Si quieres enviar productos al blog, por ejemplo, puedes usar:
    List<Producto> productos = productoDAO.listarTodos();
    
    // Retorna la vista blog.jsp dentro de /WEB-INF/jsp/paginas/
    ModelAndView mav = new ModelAndView("paginas/blog");
    mav.addObject("productos", productos); // Opcional, si necesitas pasar datos
    return mav;
}

// Dentro de PaginasController
@GetMapping("/servicioCliente.htm")
public ModelAndView mostrarServicioCliente() {
    // Si quieres enviar información de productos, contactos, etc., puedes hacerlo
    List<Producto> productos = productoDAO.listarTodos(); // opcional
    ModelAndView mav = new ModelAndView("paginas/servicioCliente");
    mav.addObject("productos", productos); // opcional, puedes omitir si no necesitas pasar datos
    return mav;
}

// Dentro de PaginasController
@GetMapping("/contacto.htm")
public ModelAndView mostrarContacto() {
    // Si deseas enviar datos adicionales al JSP, puedes agregarlos aquí
    ModelAndView mav = new ModelAndView("paginas/contacto");
    return mav;
}

}









