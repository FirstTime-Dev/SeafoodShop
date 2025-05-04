package SeafoodShop.dao;

import SeafoodShop.model.User;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DAOAdminAccount {

    public List<User> getAllUserActive() throws SQLException {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM Users\n" +
                "WHERE State = 1;";
        try (Connection conn = DataConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                User user = new User();
                user.setUserID(rs.getInt("UserID"));
                user.setFullName(rs.getString("FullName"));
                user.setUsername(rs.getString("Username"));
                user.setPassword(rs.getString("Password"));
                user.setEmail(rs.getString("Email"));
                user.setPhone(rs.getString("PhoneNumber"));
                user.setBirthday(rs.getDate("BirthDate"));
                user.setAddress(rs.getString("Address"));
                user.setRole(rs.getInt("Role"));
                user.setBan(rs.getInt("Ban"));
                user.setState(rs.getInt("State"));
                users.add(user);
            }
        }
        return users;
    }

    public boolean updateUser(User user) {
        if (user == null) {
            System.out.println("User object is null");
            return false;
        }

        String sql = "UPDATE Users SET FullName=?, Username=?, Password=?, Email=?, PhoneNumber=?, BirthDate=?, Address=?, Role=?, Ban=?, State=? WHERE UserID=?";
        try (Connection conn = DataConnect.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, user.getFullName());
            stmt.setString(2, user.getUsername());
            stmt.setString(3, user.getPassword());
            stmt.setString(4, user.getEmail());
            stmt.setString(5, user.getPhone());
            stmt.setDate(6, user.getBirthday());
            stmt.setString(7, user.getAddress());
            stmt.setInt(8, user.getRole());
            stmt.setInt(9, user.getBan());
            stmt.setInt(10, 1);
            stmt.setInt(11, user.getUserID());

            int rowsUpdated = stmt.executeUpdate();
            System.out.println("Rows updated: " + rowsUpdated);
            return rowsUpdated > 0;
        } catch (SQLException e) {
            System.out.println("SQL Error: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }


    public User getUserbyID(int UserID) throws SQLException {
        String sql = "SELECT * FROM Users WHERE UserID = ?";
        try (Connection conn = DataConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, UserID);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                User user = new User();
                user.setUserID(rs.getInt("UserID"));
                user.setFullName(rs.getString("FullName"));
                user.setUsername(rs.getString("Username"));
                user.setPassword(rs.getString("Password"));
                user.setEmail(rs.getString("Email"));
                user.setPhone(rs.getString("PhoneNumber"));
                user.setBirthday(rs.getDate("BirthDate"));
                user.setAddress(rs.getString("Address"));
                user.setRole(rs.getInt("Role"));
                user.setBan(rs.getInt("Ban"));
                user.setState(rs.getInt("State"));
                user.setEditCreatedAt(rs.getTimestamp("CreatedAt"));
                return user;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null; // Trả về null nếu không tìm thấy người dùng
    }


    public boolean updateBanStatus(String userID, int Ban) throws SQLException {
        String sql = "UPDATE Users SET Ban=? WHERE UserID=?";
        try (Connection conn = DataConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, Ban);
            ps.setString(2, userID);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean createUser(User user) {
        String sql = "INSERT INTO Users"
                + " (FullName, Username, Password, Email, PhoneNumber, BirthDate, Address)"
                + " VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DataConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, user.getFullName());
            ps.setString(2, user.getUsername());
            ps.setString(3, user.getPassword());
            ps.setString(4, user.getEmail());
            ps.setString(5, user.getPhone());
            if (user.getBirthday() != null) {
                ps.setDate(6, user.getBirthday());
            } else {
                ps.setNull(6, Types.DATE);
            }
            ps.setString(7, user.getAddress());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }


}
