package Controller;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class UsuarioController {
    
    // Mostrar formulario de registro
@GetMapping("/registro.htm")
public ModelAndView mostrarFormularioRegistro() {
    return new ModelAndView("usuarios/registro");
}


// Procesar registro de usuario
@PostMapping("/registro.htm")
public ModelAndView registrarUsuario(
        @RequestParam("cuenta") String cuenta,
        @RequestParam("password") String password,
        @RequestParam("nombre") String nombre,
        @RequestParam("email") String email,
        HttpServletRequest request) {

    try {
        // Verificar si ya existe una cuenta con ese nombre
        String sqlCheckCuenta = "SELECT COUNT(*) FROM usuarios WHERE cuenta = ?";
        Integer countCuenta = jdbcTemplate.queryForObject(sqlCheckCuenta, Integer.class, cuenta);

        if (countCuenta != null && countCuenta > 0) {
            ModelAndView mav = new ModelAndView("usuarios/registro");
            mav.addObject("error", "Esta cuenta ya existe)");
                    return mav;
        }

        // Verificar si ya existe un usuario con ese email
        String sqlCheckEmail = "SELECT COUNT(*) FROM usuarios WHERE email = ?";
        Integer countEmail = jdbcTemplate.queryForObject(sqlCheckEmail, Integer.class, email);

        if (countEmail != null && countEmail > 0) {
            ModelAndView mav = new ModelAndView("usuarios/registro");
            mav.addObject("error", "El correo ya está registrado.");
            return mav;
        }

        // Insertar nuevo usuario con rol por defecto (USER)
        String sqlInsert = "INSERT INTO usuarios (cuenta, password, nombre, email) VALUES (?, ?, ?, ?)";
        jdbcTemplate.update(sqlInsert, cuenta, password, nombre, email);

        return new ModelAndView("redirect:/login.htm");

    } catch (Exception e) {
        e.printStackTrace();
        ModelAndView mav = new ModelAndView("usuarios/registro");
        mav.addObject("error", "Error al registrar el usuario: " + e.getMessage());
        return mav;
    }
}


    @Autowired
    private JdbcTemplate jdbcTemplate;

    // Mostrar lista usuarios
@GetMapping("/panelUsuario.htm")
public ModelAndView listarUsuarios(HttpSession session) {
    if (session == null || session.getAttribute("usuario") == null) {
        return new ModelAndView("redirect:/login.htm");
    }
    Map<String,Object> usuario = (Map<String,Object>) session.getAttribute("usuario");
    String rol = (String) usuario.get("role");
    if (!"ADMIN".equalsIgnoreCase(rol)) {
        return new ModelAndView("redirect:/login.htm"); // o página de acceso denegado
    }

    List<Map<String,Object>> usuarios = jdbcTemplate.queryForList("SELECT * FROM usuarios");
    ModelAndView mav = new ModelAndView("usuarios/panelUsuario");
    mav.addObject("listaUsuarios", usuarios);
    return mav;
}


    // Eliminar usuario (POST)
    @PostMapping("/eliminarUsuario.htm")
    public ModelAndView eliminarUsuario(@RequestParam("iduser") int iduser, HttpSession session) {
        Object usuarioSesion = session.getAttribute("usuario");
        if (usuarioSesion == null || !isAdmin(usuarioSesion)) {
            return accesoDenegado();
        }

        // Evitar que un admin se elimine a sí mismo 
        Map<?, ?> usuarioMap = (Map<?, ?>) usuarioSesion;
        if (usuarioMap.get("iduser") != null && ((Number) usuarioMap.get("iduser")).intValue() == iduser) {
            ModelAndView mav = new ModelAndView("panelusuario/panelUsuario");
            mav.addObject("error", "No puedes eliminar tu propia cuenta.");
            List<Map<String, Object>> listaUsuarios = jdbcTemplate.queryForList("SELECT * FROM usuarios");
            mav.addObject("listaUsuarios", listaUsuarios);
            return mav;
        }

        jdbcTemplate.update("DELETE FROM usuarios WHERE iduser = ?", iduser);
        return new ModelAndView("redirect:/panelUsuario.htm");
    }

    // Validar rol ADMIN, según Map con clave role
    private boolean isAdmin(Object usuarioSesion) {
        if (usuarioSesion instanceof Map) {
            Object role = ((Map<?, ?>) usuarioSesion).get("role");
            return role != null && "ADMIN".equalsIgnoreCase(role.toString());
        }
        return false;
    }

    // Vista acceso denegado
    private ModelAndView accesoDenegado() {
        ModelAndView mav = new ModelAndView("accesoDenegado");
        mav.addObject("mensaje", "Acceso denegado. No tienes permiso para ver esta página.");
        return mav;
    }
}