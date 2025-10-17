
package DAO;

import ModelProveedores.Proveedor;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

@Repository
public class ProveedorDAO {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    // Listar todos los proveedores
    public List<Proveedor> listar() {
        String sql = "SELECT * FROM proveedores";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(Proveedor.class));
    }

    // Obtener un proveedor por su ID
    public Proveedor obtenerPorId(int id) {
        String sql = "SELECT * FROM proveedores WHERE idproveedor = ?";
        return jdbcTemplate.queryForObject(sql, new Object[]{id}, new BeanPropertyRowMapper<>(Proveedor.class));
    }

    // Agregar nuevo proveedor
    public int agregar(Proveedor proveedor) {
        String sql = "INSERT INTO proveedores (nombre, contacto, telefono, email, direccion) VALUES (?, ?, ?, ?, ?)";
        return jdbcTemplate.update(sql,
                proveedor.getNombre(),
                proveedor.getContacto(),
                proveedor.getTelefono(),
                proveedor.getEmail(),
                proveedor.getDireccion());
    }

    // Actualizar proveedor existente
    public int actualizar(Proveedor proveedor) {
        String sql = "UPDATE proveedores SET nombre = ?, contacto = ?, telefono = ?, email = ?, direccion = ? WHERE idproveedor = ?";
        return jdbcTemplate.update(sql,
                proveedor.getNombre(),
                proveedor.getContacto(),
                proveedor.getTelefono(),
                proveedor.getEmail(),
                proveedor.getDireccion(),
                proveedor.getIdproveedor());
    }

    // Eliminar proveedor
    public int eliminar(int id) {
        String sql = "DELETE FROM proveedores WHERE idproveedor = ?";
        return jdbcTemplate.update(sql, id);
    }
}