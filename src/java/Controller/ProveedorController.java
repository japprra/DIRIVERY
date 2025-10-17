
package Controller;
import DAO.ProveedorDAO;
import ModelProveedores.Proveedor;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/proveedores")
public class ProveedorController {

    @Autowired
    private ProveedorDAO proveedorDAO;

    @GetMapping("/listar")
    public String listar(Model model) {
        List<Proveedor> lista = proveedorDAO.listar();
        model.addAttribute("proveedores", lista);
        return "proveedores/listar"; // JSP en /WEB-INF/jsp/proveedores/listar.jsp
    }

    @GetMapping("/nuevo")
    public String nuevo(Model model) {
        model.addAttribute("proveedor", new Proveedor());
        return "proveedores/nuevo";
    }

    @PostMapping("/guardar")
    public String guardar(@ModelAttribute Proveedor proveedor) {
        proveedorDAO.agregar(proveedor);
        return "redirect:/proveedores/listar";
    }

    @GetMapping("/editar/{id}")
    public String editar(@PathVariable int id, Model model) {
        Proveedor proveedor = proveedorDAO.obtenerPorId(id);
        model.addAttribute("proveedor", proveedor);
        return "proveedores/editar";
    }

    @PostMapping("/actualizar")
    public String actualizar(@ModelAttribute Proveedor proveedor) {
        proveedorDAO.actualizar(proveedor);
        return "redirect:/proveedores/listar";
    }

    @GetMapping("/eliminar/{id}")
    public String eliminar(@PathVariable int id) {
        proveedorDAO.eliminar(id);
        return "redirect:/proveedores/listar";
    }
}