package SeafoodShop.dao;

import SeafoodShop.model.Product;

import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DataConnect {
    private static final String URL = "jdbc:sqlserver://localhost:1433;databaseName=SeafoodProject;encrypt=false";
    private static final String USER = "sa";
    private static final String PASSWORD = "0";

    public Connection getConnection() throws SQLException {
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException e) {
            throw new SQLException("Không tìm thấy driver JDBC", e);
        }
    }

    public int getUserRole(String username, String password) throws SQLException {
        String sql = "SELECT Role FROM Users WHERE Username = ? AND Password = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, password);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("Role");
                }
            }
        }
        return -1;
    }

    public List<Product> getProductList() throws SQLException {
        List<Product> productList = new ArrayList<>();
        String sql = "SELECT * FROM Products";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Product pr = extractProductFromResultSet(rs);
                productList.add(pr);
            }
        }
        return productList;
    }

    public Product getProductByID(int productID) throws SQLException {
        String sql = "SELECT * FROM Products WHERE ProductID = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, productID);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return extractProductFromResultSet(rs);
                }
            }
        }
        return null;
    }

    // Hàm dùng chung để tạo đối tượng Product từ ResultSet
    private Product extractProductFromResultSet(ResultSet rs) throws SQLException {
        String description = rs.getString("Description");
        int productID = rs.getInt("ProductID");
        String name = rs.getString("Name");
        int categoryID = rs.getInt("CategoryID");
        BigDecimal price = rs.getBigDecimal("Price");
        int stockQuantity = rs.getInt("StockQuantity");
        String supplierID = rs.getString("SupplierID");
        String origin = rs.getString("Origin");
        String storageCondition = rs.getString("StorageCondition");
        Date expiryDate = rs.getDate("ExpiryDate");
        BigDecimal weight = rs.getBigDecimal("Weight");
        int state = rs.getInt("State");

        return new Product(description, productID, name, categoryID, price, stockQuantity,
                supplierID, origin, storageCondition, expiryDate, weight, state);
    }

    public static void main(String[] args) throws SQLException {
        DataConnect dc = new DataConnect();
        System.out.println(dc.getProductByID(2));
    }
}
