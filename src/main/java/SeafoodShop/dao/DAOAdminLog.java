package SeafoodShop.dao;

import SeafoodShop.model.Log;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class DAOAdminLog {

    public boolean saveLog(Log log) {
        String sql = "INSERT INTO LogActivity ( " +
                "UserID, Action, Resource, DataBefore, DataAfter, IPAddress, SeverityLevel, Timestamp, Location " +
                ") VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        DataConnect dataConnect = new DataConnect();
        try (Connection conn = dataConnect.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, log.getUserID());
            stmt.setString(2, log.getAction());
            stmt.setString(3, log.getResource());
            stmt.setString(4, log.getBefore());
            stmt.setString(5, log.getAfter());
            stmt.setString(6, log.getIp());
            stmt.setString(7, log.getLevels());
            stmt.setTimestamp(8, log.getTimestamp());
            stmt.setString(9, log.getLocation());

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }


}
