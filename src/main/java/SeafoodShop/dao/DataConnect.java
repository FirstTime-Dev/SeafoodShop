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
    public static Connection conn = null;

    public  Connection getConnection() throws SQLException {
        if(conn == null){
            try {
                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver"); // Đăng ký driver
            } catch (ClassNotFoundException e) {
                throw new SQLException("Không t.ìm thấy driver JDBC", e);
            }
            conn = DriverManager.getConnection(URL, USER, PASSWORD);
        }
        return conn;
    }

    public int getUserRole(String username, String password) throws SQLException {
        getConnection();
        String sql = "select * from Users where Username=? and password=?";
        PreparedStatement ps =  conn.prepareStatement(sql);
        ps.setString(1, username);
        ps.setString(2, password);
        ResultSet rs = ps.executeQuery();
        if(rs.next()){
            return rs.getInt("Role");
        }
        return -1;
    }

    public List<Product> getProductList() throws SQLException {
        getConnection();
        String sql = "select * from Products";
        PreparedStatement ps =  conn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();
        List<Product> productList = new ArrayList<Product>();
        while(rs.next()){
            String description = rs.getString("Description");
            int productID = rs.getInt("ProductID");
            String name = rs.getString("Name");
            int categoryID = rs.getInt("CategoryID");
            BigDecimal price  = rs.getBigDecimal("Price");
            int stockQuantity = rs.getInt("StockQuantity");
            String supplierID  = rs.getString("SupplierID");
            String origin = rs.getString("Origin");
            String storageCondition = rs.getString("StorageCondition");
            Date expiryDate = rs.getDate("ExpiryDate");
            BigDecimal weight = rs.getBigDecimal("Weight");
            int state = rs.getInt("State");
            Product pr = new Product(description,productID,name,categoryID,price,stockQuantity,supplierID,origin,storageCondition,expiryDate,weight,state);
            productList.add(pr);
        }
        return productList;
    }

    public Product getProductByID(int productID) throws SQLException {
        getConnection();
        String sql = "select * from Products where ProductID=?";
        PreparedStatement ps =  conn.prepareStatement(sql);
        ps.setInt(1, productID);
        ResultSet rs = ps.executeQuery();
        Product pr = null;
        if(rs.next()){
            String description = rs.getString("Description");
            String name = rs.getString("Name");
            int categoryID = rs.getInt("CategoryID");
            BigDecimal price  = rs.getBigDecimal("Price");
            int stockQuantity = rs.getInt("StockQuantity");
            String supplierID  = rs.getString("SupplierID");
            String origin = rs.getString("Origin");
            String storageCondition = rs.getString("StorageCondition");
            Date expiryDate = rs.getDate("ExpiryDate");
            BigDecimal weight = rs.getBigDecimal("Weight");
            int state = rs.getInt("State");
            pr = new Product(description,productID,name,categoryID,price,stockQuantity,supplierID,origin,storageCondition,expiryDate,weight,state);
        }
        return pr;
    }



    public static void main(String[] args) throws SQLException {
        DataConnect dc = new DataConnect();
        dc.getConnection();
//        System.out.println(dc.getUserRole("nguyenvana","123456"));
//        System.out.println(dc.getProductList());
        System.out.println(dc.getProductByID(2));
    }
}
