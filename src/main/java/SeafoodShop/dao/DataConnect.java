package SeafoodShop.dao;

import SeafoodShop.model.Product;
import SeafoodShop.model.User;

import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DataConnect {
    private static final String URL = "jdbc:sqlserver://localhost:1433;databaseName=SeafoodProject;encrypt=false";
    private static final String USER = "sa";
    private static final String PASSWORD = "0";


    private static Connection conn = null;


    public Connection getConnection() throws SQLException {
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException e) {
            throw new SQLException("Không tìm thấy driver JDBC", e);
        }
    }

    public int getUserIDByEmail(String email) throws SQLException {
        getConnection();
        String sql = "select UserID from Users where email = ? ";
        PreparedStatement ps = getConnection().prepareStatement(sql);
        ps.setString(1, email);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            return rs.getInt("UserID");
        }
        return -1;
    }

    public int getUserID(String username, String password) throws SQLException {
        getConnection();
        String sql = "select * from Users where Username=? and password=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, username);
        ps.setString(2, password);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            return rs.getInt("UserID");
        }
        return -1;
    }

    public User getUserById(int userID) throws SQLException {
        getConnection();
        String sql = "select * from Users where UserID = ?";
        PreparedStatement ps =  conn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            User user = new User();
            user.setUserID(rs.getInt("UserID"));
            user.setUsername(rs.getString("Username"));
            user.setRole(rs.getInt("Role"));
            return user;
        }
        return null;
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

    public int getUserRole(int id) throws SQLException {
        String sql = "SELECT Role FROM Users WHERE UserID = ?";
        try (Connection conn = getConnection()){
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                return rs.getInt("Role");
            }
        }
        return -1;
    }

    public void register(String username, String password, String email) throws SQLException {
        getConnection();
        String sql = "insert into Users (Username, Password, Email) values(?,?,?)";
        PreparedStatement ps = getConnection().prepareStatement(sql);
        ps.setString(1, username);
        ps.setString(2, password);
        ps.setString(3, email);
        ps.executeUpdate();
    }

    public void register(String email, String fullName) throws SQLException {
        getConnection();
        String sql = "insert into Users (Email, FullName) values(?,?)";
        PreparedStatement ps = getConnection().prepareStatement(sql);
        ps.setString(1, email);
        ps.setString(2, fullName);
        ps.executeUpdate();
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




    public int getProductCount(int product_id) throws SQLException {
        getConnection();
        String sql = "SELECT \n" +
                "    p.ProductID,\n" +
                "    p.Name,\n" +
                "    ISNULL(SUM(pid.Quantity), 0) AS TotalImported,\n" +
                "    ISNULL(SUM(od.Quantity), 0) AS TotalSold,\n" +
                "    (ISNULL(SUM(pid.Quantity), 0) - ISNULL(SUM(od.Quantity), 0)) AS StockQuantity\n" +
                "FROM \n" +
                "    Products p\n" +
                "LEFT JOIN (\n" +
                "    SELECT \n" +
                "        pid.ProductID, \n" +
                "        SUM(pid.Quantity) AS Quantity\n" +
                "    FROM \n" +
                "        ProductInDetail pid\n" +
                "    JOIN ProductIn pi ON pid.ProductInID = pi.ProductInID\n" +
                "    GROUP BY pid.ProductID\n" +
                ") pid ON p.ProductID = pid.ProductID\n" +
                "LEFT JOIN (\n" +
                "    SELECT \n" +
                "        od.ProductID, \n" +
                "        SUM(od.Quantity) AS Quantity\n" +
                "    FROM \n" +
                "        OrderDetails od\n" +
                "    JOIN Orders o ON od.OrderID = o.OrderID\n" +
                "    GROUP BY od.ProductID\n" +
                ") od ON p.ProductID = od.ProductID\n" +
                "WHERE p.ProductID = ? \n" +
                "GROUP BY \n" +
                "    p.ProductID, p.Name;\n";
        PreparedStatement ps = getConnection().prepareStatement(sql);
        ps.setInt(1, product_id);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            return rs.getInt("StockQuantity");
        }
        return -1;
    }

    public void addProductToCart(int user_id, int product_id) throws SQLException {
        getProductByID(product_id);
        if (getProductCount(product_id) - 1 >= 0) {
            String sql = "INSERT INTO [dbo].[Cart] ([UserID],[ProductID],[Quantity],[AddedAt])\n" +
                    "VALUES (? , ?, 1, GETDATE());";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, user_id);
            ps.setInt(2, user_id);
            ps.executeUpdate();
        }
    }

    public static void main(String[] args) throws SQLException {
        DataConnect dc = new DataConnect();
        System.out.println(dc.getProductByID(2));
        dc.getConnection();
//        System.out.println(dc.getUserRole("nguyenvana","123456"));
//        System.out.println(dc.getProductList());
//        System.out.println(dc.getProductByID(2));
        System.out.println(dc.getProductCount(1));
        System.out.println("Nguyễn Văn A ");
    }
}
