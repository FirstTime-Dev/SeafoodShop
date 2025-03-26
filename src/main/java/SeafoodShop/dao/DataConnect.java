package SeafoodShop.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DataConnect {
    private static final String URL = "jdbc:sqlserver://localhost:1433;databaseName=SeafoodStore;encrypt=false";
    private static final String USER = "sa";
    private static final String PASSWORD = "0";

    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver"); // Đăng ký driver
        } catch (ClassNotFoundException e) {
            throw new SQLException("Không tìm thấy driver JDBC", e);
        }
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }

    public static void main(String[] args) {
        try (Connection conn = getConnection()) {
            System.out.println("Kết nối thành công!");
        } catch (SQLException e) {
            System.err.println("Lỗi kết nối: " + e.getMessage());
        }
    }
}
