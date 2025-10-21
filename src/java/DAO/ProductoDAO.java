package DAO;

import ModelProductos.Producto;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Objects;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

//  Importamos utilidades Guava
import com.google.common.base.Preconditions;
import com.google.common.base.Strings;
import com.google.common.collect.ImmutableList;

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
        // 🟢 Usamos Guava para evitar errores si query viene nulo o vacío
        String keyword = "%" + Strings.nullToEmpty(query).trim() + "%";

        String sql = """
            SELECT p.*, pr.nombre AS proveedorNombre
            FROM productos p
            LEFT JOIN proveedores pr ON p.idproveedor = pr.idproveedor
            WHERE p.nombre LIKE ? OR p.clave LIKE ?
        """;

        List<Producto> resultados = jdbcTemplate.query(sql, new ProductoMapper(), keyword, keyword);
        // 🟢 Convertimos a lista inmutable (no se puede modificar accidentalmente)
        return ImmutableList.copyOf(resultados);
    }

    // ✅ Buscar por categoría o clave
    public List<Producto> listarPorClave(String clave) {
        Preconditions.checkArgument(!Strings.isNullOrEmpty(clave), "La clave no puede ser nula ni vacía");

        String sql = """
            SELECT p.*, pr.nombre AS proveedorNombre
            FROM productos p
            LEFT JOIN proveedores pr ON p.idproveedor = pr.idproveedor
            WHERE p.clave = ?
        """;

        List<Producto> lista = jdbcTemplate.query(sql, new ProductoMapper(), clave);
        return ImmutableList.copyOf(lista);
    }

    // ✅ Buscar un producto por ID
    public Producto obtenerPorId(int id) {
        Preconditions.checkArgument(id > 0, "El ID del producto debe ser positivo");

        String sql = """
            SELECT p.*, pr.nombre AS proveedorNombre
            FROM productos p
            LEFT JOIN proveedores pr ON p.idproveedor = pr.idproveedor
            WHERE p.idprod = ?
        """;

        Producto p = jdbcTemplate.queryForObject(sql, new ProductoMapper(), id);
        // 🟢 Validamos que el producto realmente exista
        Preconditions.checkNotNull(p, "No se encontró producto con ID: %s", id);
        return p;
    }

    // ✅ Verificar stock
    public int obtenerStockPorId(int id) {
        Preconditions.checkArgument(id > 0, "El ID debe ser mayor a 0");

        String sql = "SELECT cantidad FROM productos WHERE idprod = ?";
        try {
            Integer stock = jdbcTemplate.queryForObject(sql, Integer.class, id);
            return Objects.requireNonNullElse(stock, 0);
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
            p.setIdproveedor((Integer) rs.getObject("idproveedor"));
            p.setProveedorNombre(rs.getString("proveedorNombre"));
            return p;
        }
    }
}
