package SeafoodShop.dao;

import java.sql.*;

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

    public static void main(String[] args) throws SQLException {
        DataConnect dc = new DataConnect();
        dc.getConnection();
        System.out.println(dc.getUserRole("nguyenvana","123456"));
    }
}
