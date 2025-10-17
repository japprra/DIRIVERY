package DAO;

import ModelProductos.Producto;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

@Repository
public class ProductoDAO {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    // ✅ Listar todos los productos (con nombre del proveedor)
    public List<Producto> listarTodos() {
        String sql = """
            SELECT p.*, pr.nombre AS proveedorNombre
            FROM productos p
            LEFT JOIN proveedores pr ON p.idproveedor = pr.idproveedor
        """;
        return jdbcTemplate.query(sql, new ProductoMapper());
    }

    // ✅ Buscar por palabra clave (nombre o clave)
    public List<Producto> buscar(String query) {
        String sql = """
            SELECT p.*, pr.nombre AS proveedorNombre
            FROM productos p
            LEFT JOIN proveedores pr ON p.idproveedor = pr.idproveedor
            WHERE p.nombre LIKE ? OR p.clave LIKE ?
        """;
        String keyword = "%" + query + "%";
        return jdbcTemplate.query(sql, new ProductoMapper(), keyword, keyword);
    }

    // ✅ Buscar por categoría o clave
    public List<Producto> listarPorClave(String clave) {
        String sql = """
            SELECT p.*, pr.nombre AS proveedorNombre
            FROM productos p
            LEFT JOIN proveedores pr ON p.idproveedor = pr.idproveedor
            WHERE p.clave = ?
        """;
        return jdbcTemplate.query(sql, new ProductoMapper(), clave);
    }

    // ✅ Buscar un producto por ID
    public Producto obtenerPorId(int id) {
        String sql = """
            SELECT p.*, pr.nombre AS proveedorNombre
            FROM productos p
            LEFT JOIN proveedores pr ON p.idproveedor = pr.idproveedor
            WHERE p.idprod = ?
        """;
        return jdbcTemplate.queryForObject(sql, new ProductoMapper(), id);
    }

    // ✅ Verificar stock
    public int obtenerStockPorId(int id) {
        String sql = "SELECT cantidad FROM productos WHERE idprod = ?";
        try {
            Integer stock = jdbcTemplate.queryForObject(sql, Integer.class, id);
            return stock != null ? stock : 0;
        } catch (Exception e) {
            return 0;
        }
    }

    // ✅ Mapper interno (mapea todos los campos, incluido el proveedor)
    private static class ProductoMapper implements RowMapper<Producto> {
        @Override
        public Producto mapRow(ResultSet rs, int rowNum) throws SQLException {
            Producto p = new Producto();
            p.setIdprod(rs.getInt("idprod"));
            p.setClave(rs.getString("clave"));
            p.setNombre(rs.getString("nombre"));
            p.setPrecio(rs.getDouble("precio"));
            p.setCantidad(rs.getInt("cantidad"));
            p.setImagen(rs.getString("imagen"));
             // p.setDescripcion(rs.getString("descripcion")); // ❌ quita o comenta esto
            p.setIdproveedor((Integer) rs.getObject("idproveedor"));
            p.setProveedorNombre(rs.getString("proveedorNombre")); // ✅ Campo nuevo
            return p;
        }
    }
}
