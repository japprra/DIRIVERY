    package Controller;

import java.util.List;
import java.util.Map;
import ModelProductos.Producto;
import ModelProveedores.Proveedor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
@Controller
  // Asegúrate que el bean tenga este nombre para el xml

public class ProyController {

    @Autowired
    private JdbcTemplate jdbcTemplate;
    
   

 
@RequestMapping(value = "/login.htm", method = RequestMethod.GET)
public ModelAndView mostrarLogin() {
    return new ModelAndView("login"); // carga /WEB-INF/jsp/login.jsp
}


 

// Mostrar formulario para agregar producto (GET)
@GetMapping("/agregarProducto.htm")
public ModelAndView agregarForm(HttpSession session) {
    if (session == null || session.getAttribute("usuario") == null) {
        return new ModelAndView("redirect:/login.htm");
    }

    ModelAndView mav = new ModelAndView("panelproducto/agregarProducto");
    mav.addObject("producto", new Producto());

    // 🔹 Obtener lista de proveedores desde la BD
    String sql = "SELECT idproveedor, nombre FROM proveedores";
    List<Map<String, Object>> proveedores = jdbcTemplate.queryForList(sql);
    mav.addObject("proveedores", proveedores);

    return mav;
}




// Procesar formulario para agregar producto (POST)
@PostMapping("/agregarProducto.htm")
public String guardarNuevoProducto(@ModelAttribute Producto producto, HttpSession session) {
    if (session == null || session.getAttribute("usuario") == null) {
        return "redirect:/login.htm";
    }

    // Insertar producto con proveedor
    String sql = "INSERT INTO productos (clave, nombre, precio, cantidad, imagen, idproveedor) VALUES (?, ?, ?, ?, ?, ?)";
    jdbcTemplate.update(sql,
        producto.getClave(),
        producto.getNombre(),
        producto.getPrecio(),
        producto.getCantidad(),
        producto.getImagen(),
        producto.getIdproveedor()
    );

    return "redirect:/panelProductos.htm";
}

    
@PostMapping("/guardarProducto")
public String guardarProducto(@ModelAttribute Producto producto, HttpSession session) {
    if (session == null || session.getAttribute("usuario") == null) {
        return "redirect:/login.htm";
    }

    if (producto.getIdprod() != null && producto.getIdprod() > 0) {
        // Actualizar producto existente
        String sql = "UPDATE productos SET clave=?, nombre=?, precio=?, cantidad=?, imagen=? WHERE idprod=?";
        jdbcTemplate.update(sql,
            producto.getClave(),
            producto.getNombre(),
            producto.getPrecio(),
            producto.getCantidad(),
            producto.getImagen(),
            producto.getIdprod()
        );
    } else {
        // Insertar nuevo producto
        if (productoExiste(producto.getClave())) {
            // Manejar error clave duplicada (puedes mostrar mensaje o redirigir)
            return "redirect:/agregarProducto.htm?error=claveDuplicada";
        }
        String sql = "INSERT INTO productos (clave, nombre, precio, cantidad, imagen) VALUES (?, ?, ?, ?, ?)";
        jdbcTemplate.update(sql,
            producto.getClave(),
            producto.getNombre(),
            producto.getPrecio(),
            producto.getCantidad(),
            producto.getImagen()
        );
    }
    return "redirect:/panelProductos.htm";
}

@GetMapping("/editarProducto.htm")
public ModelAndView editarForm(@RequestParam("idprod") int idprod, HttpSession session) {
    if (session == null || session.getAttribute("usuario") == null) {
        return new ModelAndView("redirect:/login.htm");
    }

    ModelAndView mav = new ModelAndView("panelproducto/editarProducto");

    // Obtener producto
    List<Map<String,Object>> datos = jdbcTemplate.queryForList(
        "SELECT * FROM productos WHERE idprod = ?", idprod
    );

    if (!datos.isEmpty()) {
        Map<String,Object> p = datos.get(0);
        Producto producto = new Producto();
        producto.setIdprod((int)p.get("idprod"));
        producto.setClave((String)p.get("clave"));
        producto.setNombre((String)p.get("nombre"));
        producto.setPrecio(((Number)p.get("precio")).doubleValue());
        producto.setCantidad((int)p.get("cantidad"));
        producto.setImagen((String)p.get("imagen"));
        producto.setIdproveedor((Integer)p.get("idproveedor")); // <-- asegúrate de tener este campo
        mav.addObject("producto", producto);
    }

    // Obtener lista de proveedores
    List<Proveedor> proveedores = jdbcTemplate.query(
        "SELECT * FROM proveedores",
        (rs, rowNum) -> {
            Proveedor pr = new Proveedor();
            pr.setIdproveedor(rs.getInt("idproveedor"));
            pr.setNombre(rs.getString("nombre"));
            pr.setContacto(rs.getString("contacto"));
            pr.setTelefono(rs.getString("telefono"));
            pr.setEmail(rs.getString("email"));
            pr.setDireccion(rs.getString("direccion"));
            return pr;
        }
    );

    mav.addObject("proveedores", proveedores);

    return mav;
}



// Procesar edición (POST)@PostMapping("/editarProducto.htm")
@PostMapping("/editarProducto.htm")
public String actualizarProducto(@ModelAttribute Producto producto, HttpSession session) {
    if (session == null || session.getAttribute("usuario") == null) {
        return "redirect:/login.htm";
    }

    // 🔹 Actualizar también el proveedor
    String sql = "UPDATE productos SET clave=?, nombre=?, precio=?, cantidad=?, imagen=?, idproveedor=? WHERE idprod=?";
    jdbcTemplate.update(sql,
        producto.getClave(),
        producto.getNombre(),
        producto.getPrecio(),
        producto.getCantidad(),
        producto.getImagen(),
        producto.getIdproveedor(),  // ✅ Nuevo campo
        producto.getIdprod()
    );

    return "redirect:/panelProductos.htm";
}



// Eliminar producto
@GetMapping("/eliminarProducto.htm")
public String eliminar(@RequestParam("idprod") int idprod, HttpSession session) {
    if (session == null || session.getAttribute("usuario") == null) {
        return "redirect:/login.htm";
    }
    jdbcTemplate.update("DELETE FROM productos WHERE idprod = ?", idprod);
    return "redirect:/panelProductos.htm";
}


@RequestMapping(value = "login.htm", method = RequestMethod.POST)
public ModelAndView validarLogin(HttpServletRequest request) {
    String cuenta = request.getParameter("cuenta");
    String clave = request.getParameter("clave");

    String sql = "SELECT * FROM usuarios WHERE cuenta=? AND password=?";
    List<Map<String, Object>> resultado = jdbcTemplate.queryForList(sql, cuenta, clave);

    if (!resultado.isEmpty()) {
        Map<String, Object> user = resultado.get(0);
        HttpSession session = request.getSession();
        session.setAttribute("usuario", user);               // Guardar todo el usuario
        session.setAttribute("username", user.get("cuenta")); // Guardar solo el nombre de usuario
        session.setAttribute("role", user.get("role"));       // Guardar el rol

        String rol = (String) user.get("role");

        if ("ADMIN".equalsIgnoreCase(rol)) {
            return new ModelAndView("redirect:/panelProductos.htm");
        } else if ("USER".equalsIgnoreCase(rol)) {
            return new ModelAndView("redirect:/index.htm");
        } else {
            ModelAndView mav = new ModelAndView("login");
            mav.addObject("error", "Rol de usuario no reconocido.");
            return mav;
        }
    } else {
        ModelAndView mav = new ModelAndView("login");
        mav.addObject("error", "Credenciales incorrectas");
        return mav;
    }
}


@GetMapping("/panelProductos.htm")
public ModelAndView listarProductos(HttpSession session) {
    if (session == null || session.getAttribute("usuario") == null) {
        return new ModelAndView("redirect:/login.htm");
    }

    Map<String,Object> usuario = (Map<String,Object>) session.getAttribute("usuario");
    String rol = (String) usuario.get("role");
    if (!"ADMIN".equalsIgnoreCase(rol)) {
        return new ModelAndView("redirect:/login.htm");
    }

    // 🔹 Traer productos con nombre del proveedor
    String sql = """
        SELECT p.*, pr.nombre AS proveedor_nombre
        FROM productos p
        LEFT JOIN proveedores pr ON p.idproveedor = pr.idproveedor
    """;

    List<Map<String,Object>> datos = jdbcTemplate.queryForList(sql);

    ModelAndView mav = new ModelAndView("panelproducto/panelProductos");
    mav.addObject("lista", datos);
    return mav;
}







    // Cerrar sesión
@RequestMapping(value = "/logout.htm", method = RequestMethod.GET)
public ModelAndView logout(HttpServletRequest request) {
    HttpSession session = request.getSession(false);
    if (session != null) {
        session.invalidate();
    }
    ModelAndView mav = new ModelAndView("login");
    mav.addObject("mensaje", "Sesión cerrada");
    return mav;
}
    

 public boolean productoExiste(String clave) {
    String sql = "SELECT COUNT(*) FROM productos WHERE clave=?";
    Integer count = jdbcTemplate.queryForObject(sql, Integer.class, clave);
    return count != null && count > 0;
}
 

@GetMapping("/pedidos.htm")
public ModelAndView listarPedidos(HttpSession session) {
    if (session == null || session.getAttribute("usuario") == null) {
        return new ModelAndView("redirect:/login.htm");
    }

    Map<String, Object> usuario = (Map<String, Object>) session.getAttribute("usuario");
    String rol = (String) usuario.get("role");

    if (!"ADMIN".equalsIgnoreCase(rol)) {
        return new ModelAndView("redirect:/login.htm");
    }

    String sqlPedidos = "SELECT * FROM pedidos ORDER BY fecha DESC";
    List<Map<String, Object>> pedidos = jdbcTemplate.queryForList(sqlPedidos);

    for (Map<String, Object> pedido : pedidos) {
        int idpedido = (int) pedido.get("idpedido");

        String sqlDetalles = """
            SELECT pd.*, p.nombre 
            FROM pedido_detalle pd 
            JOIN productos p ON pd.producto_id = p.idprod 
            WHERE pd.idpedido = ?
        """;

        List<Map<String, Object>> detalles = jdbcTemplate.queryForList(sqlDetalles, idpedido);
        pedido.put("detalles", detalles);
    }

    ModelAndView mav = new ModelAndView("panelproducto/pedidos");
    mav.addObject("pedidos", pedidos);
    return mav;
}

@PostMapping("/EliminarPedido.htm")
public String eliminarPedido(@RequestParam("idpedido") int idpedido, HttpSession session) {

    if (session == null || session.getAttribute("usuario") == null) {
        return "redirect:/login.htm";
    }

    Map<String, Object> usuario = (Map<String, Object>) session.getAttribute("usuario");
    String rol = (String) usuario.get("role");

    if (!"ADMIN".equalsIgnoreCase(rol)) {
        return "redirect:/login.htm"; // o página de acceso denegado
    }

    // Eliminar primero los detalles del pedido
    jdbcTemplate.update("DELETE FROM pedido_detalle WHERE idpedido = ?", idpedido);

    // Luego eliminar el pedido
    jdbcTemplate.update("DELETE FROM pedidos WHERE idpedido = ?", idpedido);

    return "redirect:/pedidos.htm"; // Redirige al panel actualizado
}


// Guardar contacto
@PostMapping("/guardarContacto.htm")
public String guardarContacto(@RequestParam("nombre") String nombre,
                              @RequestParam("correo") String correo,
                              @RequestParam("mensaje") String mensaje,
                              HttpSession session) {

    // Validar que el usuario esté logueado
    if (session == null || session.getAttribute("usuario") == null) {
        return "redirect:/login.htm"; // Redirige si no está logueado
    }

    String sql = "INSERT INTO contactos (nombre, correo, mensaje) VALUES (?, ?, ?)";
    jdbcTemplate.update(sql, nombre, correo, mensaje);

    return "redirect:/verContactos.htm";
}



// Mostrar lista de contactos
@GetMapping("/verContactos.htm")
public ModelAndView verContactos(HttpSession session) {
    // Solo ADMIN puede ver contactos (opcional)
    if (session == null || session.getAttribute("usuario") == null) {
        return new ModelAndView("redirect:/login.htm");
    }

    Map<String, Object> usuario = (Map<String, Object>) session.getAttribute("usuario");
    String rol = (String) usuario.get("role");
    if (!"ADMIN".equalsIgnoreCase(rol)) {
        return new ModelAndView("redirect:/login.htm");
    }

    String sql = "SELECT * FROM contactos ORDER BY fecha DESC";
    List<Map<String, Object>> contactos = jdbcTemplate.queryForList(sql);

    ModelAndView mav = new ModelAndView("panelproducto/verContactos");
    mav.addObject("contactos", contactos);
    return mav;
}

@GetMapping("/eliminarContacto.htm")
public String eliminarContacto(@RequestParam("id") int id, HttpSession session) {
    if (session == null || session.getAttribute("usuario") == null) {
        return "redirect:/login.htm";
    }

    Map<String, Object> usuario = (Map<String, Object>) session.getAttribute("usuario");
    String rol = (String) usuario.get("role");

    if (!"ADMIN".equalsIgnoreCase(rol)) {
        return "redirect:/login.htm";
    }

    jdbcTemplate.update("DELETE FROM contactos WHERE id = ?", id);
    return "redirect:/verContactos.htm?msg=Contacto eliminado";
}

}


