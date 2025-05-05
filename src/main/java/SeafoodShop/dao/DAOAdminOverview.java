package SeafoodShop.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DAOAdminOverview {

    public double getMonthlyRevenue() {
        double revenue = 0;
        String sql = "SELECT SUM(TotalAmount) AS Revenue " +
                "FROM Orders " +
                "WHERE Status = 'Completed' AND " +
                "MONTH(OrderDate) = MONTH(GETDATE()) AND " +
                "YEAR(OrderDate) = YEAR(GETDATE())";

        try (Connection conn = DataConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                revenue = rs.getDouble("Revenue");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return revenue;
    }

    public double getYearlyRevenue() {
        double revenue = 0;
        String sql = "SELECT SUM(TotalAmount) AS Revenue " +
                "FROM Orders " +
                "WHERE Status = 'Completed' AND " +
                "YEAR(OrderDate) = YEAR(GETDATE())";

        try (Connection conn = DataConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                revenue = rs.getDouble("Revenue");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return revenue;
    }

    public String getTopProductOfMonth() {
        String hotProduct = "";
        String sql = "SELECT TOP 1 P.Name, SUM(OD.Quantity) AS TotalSold " +
                "FROM OrderDetails OD " +
                "JOIN Orders O ON OD.OrderID = O.OrderID " +
                "JOIN Products P ON OD.ProductID = P.ProductID " +
                "WHERE MONTH(O.OrderDate) = MONTH(GETDATE()) " +
                "AND YEAR(O.OrderDate) = YEAR(GETDATE()) " +
                "AND O.Status = 'Completed' " +
                "GROUP BY P.Name " +
                "ORDER BY TotalSold DESC";
        try (Connection conn = DataConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                hotProduct = rs.getString("Name");
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return hotProduct;
    }

    public String getTopProductOfYear() {
        String hotProduct = "";
        String sql = "SELECT TOP 1 P.Name, SUM(OD.Quantity) AS TotalSold " +
                "FROM OrderDetails OD " +
                "JOIN Orders O ON OD.OrderID = O.OrderID " +
                "JOIN Products P ON OD.ProductID = P.ProductID " +
                "WHERE YEAR(O.OrderDate) = YEAR(GETDATE()) " +
                "AND O.Status = 'Completed' " +
                "GROUP BY P.Name " +
                "ORDER BY TotalSold DESC";
        try (Connection conn = DataConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                hotProduct = rs.getString("Name");
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return hotProduct;
    }

    public int getDeliveredOrdersOfMonth() throws SQLException {
        String sql = "SELECT COUNT(*) AS Total FROM Orders " +
                "WHERE Status = 'Completed' " +
                "AND MONTH(OrderDate) = MONTH(GETDATE()) " +
                "AND YEAR(OrderDate) = YEAR(GETDATE())";

        try (Connection conn = DataConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("Total");
            }
        }
        return 0;
    }

    public int getDeliveredOrdersOfYear() throws SQLException {
        String sql = "SELECT COUNT(*) AS Total FROM Orders " +
                "WHERE Status = 'Completed' " +
                "AND YEAR(OrderDate) = YEAR(GETDATE())";

        try (Connection conn = DataConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("Total");
            }
        }
        return 0;
    }

    public int getExpiredProducts() throws SQLException {
        String sql = "SELECT \n" +
                "    ISNULL(SUM(pid.Quantity), 0) AS TotalExpiredQuantity\n" +
                "FROM \n" +
                "    ProductInDetail pid\n" +
                "WHERE \n" +
                "    pid.Quantity > 0\n" +
                "    AND pid.ExpiryDate < CAST(GETDATE() AS DATE);";
        try (Connection conn = DataConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("TotalExpiredQuantity");
            }
        }
        return 0;
    }

    public int getExpiringProducts() throws SQLException {
        String sql = "SELECT \n" +
                "    SUM(pid.Quantity) AS TotalExpiringSoonQuantity\n" +
                "FROM \n" +
                "    ProductInDetail pid\n" +
                "WHERE \n" +
                "    pid.Quantity > 0\n" +
                "    AND pid.ExpiryDate BETWEEN CAST(GETDATE() AS DATE) AND DATEADD(DAY, 30, GETDATE());";
        try (Connection conn = DataConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("TotalExpiringSoonQuantity");
            }
        }
        return 0;
    }

    public int getAlmostOutOfStockProducts() throws SQLException {
        String sql = "SELECT \n" +
                "    p.ProductID,\n" +
                "    p.Name,\n" +
                "    (p.StockQuantity + ISNULL(SUM(pid.Quantity), 0) - ISNULL(SUM(od.Quantity), 0)) AS CurrentStock\n" +
                "FROM \n" +
                "    Products p\n" +
                "LEFT JOIN ProductInDetail pid ON p.ProductID = pid.ProductID\n" +
                "LEFT JOIN OrderDetails od ON p.ProductID = od.ProductID\n" +
                "LEFT JOIN Orders o ON od.OrderID = o.OrderID AND o.Status = 'Completed'\n" +
                "GROUP BY \n" +
                "    p.ProductID, p.Name, p.StockQuantity\n" +
                "HAVING \n" +
                "    (p.StockQuantity + ISNULL(SUM(pid.Quantity), 0) - ISNULL(SUM(od.Quantity), 0)) <= 40\n" +
                "ORDER BY \n" +
                "    CurrentStock ASC;";
        try (Connection conn = DataConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("CurrentStock");
            }
        }
        return 0;
    }

    public int getOutOfStockProducts() throws SQLException {
        String sql = "SELECT \n" +
                "    COUNT(*) AS OutOfStockCount\n" +
                "FROM (\n" +
                "    SELECT \n" +
                "        p.ProductID,\n" +
                "        (p.StockQuantity + ISNULL(SUM(pid.Quantity), 0) - ISNULL(SUM(od.Quantity), 0)) AS CurrentStock\n" +
                "    FROM \n" +
                "        Products p\n" +
                "    LEFT JOIN ProductInDetail pid ON p.ProductID = pid.ProductID\n" +
                "    LEFT JOIN OrderDetails od ON p.ProductID = od.ProductID\n" +
                "    LEFT JOIN Orders o ON od.OrderID = o.OrderID AND o.Status = 'Completed'\n" +
                "    GROUP BY \n" +
                "        p.ProductID, p.StockQuantity\n" +
                ") AS InventoryCalc\n" +
                "WHERE CurrentStock <= 0;\n";
        try (Connection conn = DataConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("OutOfStockCount");
            }
        }
        return 0;
    }

    public int getTotalCategories() throws SQLException {
        String sql = "SELECT \n" +
                "    COUNT(*) AS TotalCategories\n" +
                "FROM \n" +
                "    Categories;";
        try (Connection conn = DataConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("TotalCategories");
            }
        }
        return 0;
    }

    public int getTotalIventory() throws SQLException {
        String sql = "SELECT \n" +
                "    SUM(CurrentStock) AS TotalStock\n" +
                "FROM (\n" +
                "    SELECT \n" +
                "        p.ProductID,\n" +
                "        p.StockQuantity + ISNULL(SUM(pid.Quantity), 0) - ISNULL(SUM(od.Quantity), 0) AS CurrentStock\n" +
                "    FROM \n" +
                "        Products p\n" +
                "    LEFT JOIN ProductInDetail pid ON p.ProductID = pid.ProductID\n" +
                "    LEFT JOIN OrderDetails od ON p.ProductID = od.ProductID\n" +
                "    LEFT JOIN Orders o ON od.OrderID = o.OrderID AND o.Status = 'Completed' \n" +
                "    GROUP BY \n" +
                "        p.ProductID, p.StockQuantity\n" +
                ") AS StockCalculation;";
        try (Connection conn = DataConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("TotalStock");
            }
        }
        return 0;
    }

    public int getActiveAccounts() throws SQLException {
        String sql = "SELECT COUNT(*) AS ActiveAccountCount\n" +
                "FROM Users\n" +
                "WHERE State = 1;";
        try (Connection conn = DataConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("ActiveAccountCount");
            }
        }
        return 0;
    }

    public int getDisableAccounts() throws SQLException {
        String sql = "SELECT COUNT(*) AS DisabledAccountCount\n" +
                "FROM Users\n" +
                "WHERE State = 0;";
        try (Connection conn = DataConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("DisabledAccountCount");
            }
        }
        return 0;
    }

    public int getNumberOfSuppliers() throws SQLException {
        String sql = "SELECT COUNT(*) AS Suppliers\n" +
                "FROM Suppliers";
        try (Connection conn = DataConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("Suppliers");
            }
        }
        return 0;
    }

    public int getCategoryCount() throws SQLException {
        String sql = "SELECT COUNT(*) AS CategoryCount\n" +
                "From Categories";
        try (Connection conn = DataConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("CategoryCount");
            }
        }
        return 0;
    }

    public int getDiscountCount() throws SQLException {
        String sql = "SELECT COUNT(*) AS TotalDiscounts FROM Discounts;\n";
        try (Connection conn = DataConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("TotalDiscounts");
            }
        }
        return 0;
    }

    public int getDiscountIsAvailable() throws SQLException {
        String sql = "SELECT COUNT(*) AS TotalActiveDiscounts\n" +
                "FROM Discounts\n" +
                "WHERE IsActive = 1;";
        try (Connection conn = DataConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("TotalActiveDiscounts");
            }
        }
        return 0;
    }

    public double getAvgRating() throws SQLException {
        String sql = "SELECT AVG(CAST(Rating AS FLOAT)) AS AverageRating\n" +
                "FROM Reviews;";
        try (Connection conn = DataConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("AverageRating");
            }
        }
        return 0.0;
    }
    public int getTotalReviews() throws SQLException {
        String sql = "SELECT COUNT(*) AS TotalReviews FROM Reviews;\n";
        try (Connection conn = DataConnect.getConnection();
        PreparedStatement ps = conn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("TotalReviews");
            }
        }
        return 0;
    }
}
