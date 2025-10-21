package test;

import java.sql.Connection;
import java.sql.DriverManager;

public class testBD {
    public static void main(String[] args) {
        String url = "jdbc:mysql://localhost:3307/proyecto?useSSL=false&serverTimezone=UTC";
        String user = "root";
        String pass = "2008";

        try (Connection conn = DriverManager.getConnection(url, user, pass)) {
            if (conn != null && !conn.isClosed()) {
                System.out.println("Conexion exitosa a la base de datos.");
            } else {
                System.out.println("No se pudo conectar a la base de datos.");
            }
        } catch (Exception e) {
            System.out.println("No se pudo conectar a la base de datos.");
            e.printStackTrace(); // Esto ayuda a ver la causa real
        }
    }
}

