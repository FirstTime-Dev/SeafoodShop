package SeafoodShop.dao;

import SeafoodShop.model.Cart;
import SeafoodShop.model.Category;
import SeafoodShop.model.Product;
import SeafoodShop.model.User;

import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DataConnect {
    private static final String URL = "jdbc:sqlserver://localhost:1433;databaseName=SeafoodProject;encrypt=false;sendStringParametersAsUnicode=true";
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

    public int getUserIDByEmail(String email) throws SQLException {
        String sql = "select UserID from Users where email = ? ";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("UserID");
            }
        }
        return -1;
    }

    public int getUserID(String username, String password) throws SQLException {
        String sql = "select * from Users where Username=? and password=?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                System.out.println(rs.getInt("UserID"));
                return rs.getInt("UserID");
            }
        }
        return -1;
    }

    public boolean isExistUser(String username) throws SQLException {
        String sql = "select UserID from Users where Username=?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        }
    }

    public User getUserById(int userID) throws SQLException {
        String sql = "select * from Users where UserID = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                User user = new User();
                user.setUserID(rs.getInt("UserID"));
                user.setUsername(rs.getString("Username"));
                user.setRole(rs.getInt("Role"));
                return user;
            }
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
        try (Connection conn = getConnection()) {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("Role");
            }
        }
        return -1;
    }

    public void register(String username, String password, String email) throws SQLException {
        String sql = "insert into Users (Username, Password, Email) values(?,?,?)";
        PreparedStatement ps = getConnection().prepareStatement(sql);
        ps.setString(1, username);
        ps.setString(2, password);
        ps.setString(3, email);
        ps.executeUpdate();
    }

    public void register(String email, String fullName) throws SQLException {
        String sql = "insert into Users (Email, FullName) values(?,?)";
        PreparedStatement ps = getConnection().prepareStatement(sql);
        ps.setString(1, email);
        ps.setString(2, fullName);
        ps.executeUpdate();
    }

    public List<Product> getProductList() throws SQLException {
        List<Product> productList = new ArrayList<>();
        String sql = "SELECT p.*, img.ImageURL FROM Products p JOIN Images img ON p.ProductID = img.ProductID";
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
        String sql = "SELECT p.*, img.ImageURL FROM Products p JOIN Images img ON p.ProductID = img.ProductID  WHERE p.ProductID = ?";
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
        String imgURL = rs.getString("ImageURL");

        return new Product(description, productID, name, categoryID, price, stockQuantity,
                supplierID, origin, storageCondition, expiryDate, weight, state, imgURL);
    }

    public int getAllProductQuantityInCart(int productID) throws SQLException {
        int count = 0;
        String sql = "SELECT * FROM Cart WHERE ProductID = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, productID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                count += rs.getInt("Quantity");
            }
        }
        return count;
    }

    public int getProductCount(int product_id) throws SQLException {
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
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, product_id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("StockQuantity");
            }
        }
        return -1;
    }

    public List<Cart> getCartList(int user_id) throws SQLException {
        List<Cart> cartList = new ArrayList<>();
        String sql = "SELECT c.*,p.Name,p.Price, img.ImageURL FROM Cart c JOIN Images img ON c.ProductID = img.ProductID JOIN Products p ON c.ProductID = p.ProductID WHERE c.UserID = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, user_id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Cart cart = new Cart();
                cart.setCartId(rs.getInt("CartID"));
                cart.setUserId(rs.getInt("UserID"));
                cart.setProductId(rs.getInt("ProductID"));
                cart.setQuantity(rs.getInt("Quantity"));
                cart.setProductName(rs.getString("Name"));
                cart.setProductImageURL(rs.getString("ImageURL"));
                cart.setProductPrice(rs.getBigDecimal("Price"));
                cart.setAddAt(rs.getDate("AddedAt"));
                cartList.add(cart);
            }
            return cartList;
        }
    }

    public boolean addProductToCart(int user_id, int product_id) throws SQLException {
        int productQuantity = getProductCount(product_id);
        int productQuantityInCart = getAllProductQuantityInCart(product_id);
        if (productQuantity - productQuantityInCart - 1 >= 0) {
            String sql = "INSERT INTO [dbo].[Cart] ([UserID],[ProductID],[Quantity],[AddedAt])\n" +
                    "VALUES (? , ?, 1, GETDATE());";
            try (Connection conn = getConnection();
                 PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, user_id);
                ps.setInt(2, product_id);
                ps.executeUpdate();
                return true;
            }
        }
        return false;
    }

    public String getEmailByUsername(String username) throws SQLException {
        Connection conn = getConnection();
        String email = null;
        String sql = "SELECT email FROM Users WHERE username = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, username);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            email = rs.getString("email");
        }
        rs.close();
        ps.close();
        return email;
    }

    public List<Product> getProductsByCategory(int categoryId) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM Products WHERE CategoryID = ? AND State = 1";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, categoryId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product p = new Product();
                p.setProductID(rs.getInt("ProductID"));
                p.setName(rs.getString("ProductName"));
                p.setPrice(rs.getBigDecimal("Price"));
                p.setImgUrl(rs.getString("Image")); // giả sử có trường Image
                list.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Category> getAllCategories() {
        List<Category> categories = new ArrayList<>();
        String sql = "SELECT * FROM Categories WHERE State = 1";
        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                Category c = new Category();
                c.setCategoryID(rs.getInt("CategoryID"));
                c.setCategoryName(rs.getString("CategoryName"));
                categories.add(c);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return categories;
    }

    public List<Product> searchProductsWithImage(String keyword) {
        List<Product> list = new ArrayList<>();
        String sql =
                "SELECT "
                        + "  p.ProductID, p.Name, p.CategoryID, p.Price, p.StockQuantity, "
                        + "  p.SupplierID, p.Description, p.Origin, p.StorageCondition, "
                        + "  p.ExpiryDate, p.Weight, p.State, "
                        + "  i.ImageURL "
                        + "FROM Products AS p "
                        + "LEFT JOIN Images AS i "
                        + "  ON p.ProductID = i.ProductID "
                        + "WHERE p.State = 1 "
                        + "  AND (p.Name LIKE ? OR p.Description LIKE ?);";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            String pattern = "%" + keyword + "%";
            ps.setString(1, pattern);
            ps.setString(2, pattern);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product p = new Product();
                p.setProductID(rs.getInt("ProductID"));
                p.setName(rs.getString("Name"));
                p.setCategoryID(rs.getInt("CategoryID"));
                p.setPrice(rs.getBigDecimal("Price"));
                p.setStockQuantity(rs.getInt("StockQuantity"));
                p.setSupplierID(rs.getString("SupplierID"));
                p.setDescription(rs.getString("Description"));
                p.setOrigin(rs.getString("Origin"));
                p.setStorageCondition(rs.getString("StorageCondition"));
                p.setExpiryDate(rs.getDate("ExpiryDate"));
                p.setWeight(rs.getBigDecimal("Weight"));
                p.setState(rs.getInt("State"));

                String img = rs.getString("ImageURL");
                p.setImgUrl(img != null ? img : "");

                list.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public static void main(String[] args) throws SQLException {
        DataConnect dc = new DataConnect();
//        System.out.println(dc.getProductByID(2));
        dc.getConnection();
//        System.out.println(dc.getAllCategories().get(0).getCategoryName());
//        System.out.println(dc.getUserRole("vuthif","$2a$10$zLx..."));
//        System.out.println(dc.searchProducts("Cua").get(0).getName());
//        System.out.println(dc.getProductList());
//        System.out.println(dc.getProductByID(2));
//        System.out.println(dc.getProductCount(1));
//        System.out.println("Nguyễn Văn A ");
//        System.out.println(dc.getAllProductQuantityInCart(1));
//        List<Product> list = dc.getProductList();
//        for(Product p : list) {
//            System.out.println(p.getProductID());
//        }
    }
}
