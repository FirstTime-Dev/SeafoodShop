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
                "WHERE Status = 2 AND " +
                "MONTH(OrderDate) = MONTH(GETDATE()) AND " +
                "YEAR(OrderDate) = YEAR(GETDATE())";
        DataConnect dc = new DataConnect();
        try (Connection conn = dc.getConnection();
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
                "WHERE Status = 2 AND " +
                "YEAR(OrderDate) = YEAR(GETDATE())";
        DataConnect dc = new DataConnect();
        try (Connection conn = dc.getConnection();
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
        String hotProductM = "";
        String sql = "SELECT TOP 1 P.Name, SUM(OD.Quantity) AS TotalSold " +
                "FROM OrderDetails OD " +
                "JOIN Orders O ON OD.OrderID = O.OrderID " +
                "JOIN Products P ON OD.ProductID = P.ProductID " +
                "WHERE MONTH(O.OrderDate) = MONTH(GETDATE()) " +
                "AND YEAR(O.OrderDate) = YEAR(GETDATE()) " +
                "AND O.Status = 2 " +
                "GROUP BY P.Name " +
                "ORDER BY TotalSold DESC";
        DataConnect dc = new DataConnect();
        try (Connection conn = dc.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                hotProductM = rs.getString("Name");
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return hotProductM;
    }

    public String getTopProductOfYear() {
        String hotProductY = "";
        String sql = "SELECT TOP 1 P.Name, SUM(OD.Quantity) AS TotalSold " +
                "FROM OrderDetails OD " +
                "JOIN Orders O ON OD.OrderID = O.OrderID " +
                "JOIN Products P ON OD.ProductID = P.ProductID " +
                "WHERE YEAR(O.OrderDate) = YEAR(GETDATE()) " +
                "AND O.Status = 2 " +
                "GROUP BY P.Name " +
                "ORDER BY TotalSold DESC";
        DataConnect dc = new DataConnect();
        try (Connection conn = dc.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                hotProductY = rs.getString("Name");
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return hotProductY;
    }

    public int getDeliveredOrdersOfMonth() {
        String sql = "SELECT COUNT(*) AS Total FROM Orders " +
                "WHERE Status = 2 " +
                "AND MONTH(OrderDate) = MONTH(GETDATE()) " +
                "AND YEAR(OrderDate) = YEAR(GETDATE())";
        DataConnect dc = new DataConnect();
        try (Connection conn = dc.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("Total");
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return 0;
    }

    public int getDeliveredOrdersOfYear() {
        String sql = "SELECT COUNT(*) AS Total FROM Orders " +
                "WHERE Status = 2 " +
                "AND YEAR(OrderDate) = YEAR(GETDATE())";
        DataConnect dc = new DataConnect();
        try (Connection conn = dc.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("Total");
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return 0;
    }

    public int getExpiredProducts() {
        String sql = "SELECT \n" +
                "    ISNULL(SUM(pid.Quantity), 0) AS TotalExpiredQuantity\n" +
                "FROM \n" +
                "    ProductInDetail pid\n" +
                "WHERE \n" +
                "    pid.Quantity > 0\n" +
                "    AND pid.ExpiryDate < CAST(GETDATE() AS DATE);";
        DataConnect dc = new DataConnect();
        try (Connection conn = dc.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("TotalExpiredQuantity");
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return 0;
    }

    public int getExpiringProducts() {
        String sql = "SELECT \n" +
                "    SUM(pid.Quantity) AS TotalExpiringSoonQuantity\n" +
                "FROM \n" +
                "    ProductInDetail pid\n" +
                "WHERE \n" +
                "    pid.Quantity > 0\n" +
                "    AND pid.ExpiryDate BETWEEN CAST(GETDATE() AS DATE) AND DATEADD(DAY, 30, GETDATE());";
        DataConnect dc = new DataConnect();
        try (Connection conn = dc.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("TotalExpiringSoonQuantity");
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return 0;
    }

    public int getAlmostOutOfStockProducts() {
        String sql = "SELECT \n" +
                "    p.ProductID,\n" +
                "    p.Name,\n" +
                "    (p.StockQuantity + ISNULL(SUM(pid.Quantity), 0) - ISNULL(SUM(od.Quantity), 0)) AS CurrentStock\n" +
                "FROM \n" +
                "    Products p\n" +
                "LEFT JOIN ProductInDetail pid ON p.ProductID = pid.ProductID\n" +
                "LEFT JOIN OrderDetails od ON p.ProductID = od.ProductID\n" +
                "LEFT JOIN Orders o ON od.OrderID = o.OrderID AND o.Status = 2\n" +
                "GROUP BY \n" +
                "    p.ProductID, p.Name, p.StockQuantity\n" +
                "HAVING \n" +
                "    (p.StockQuantity + ISNULL(SUM(pid.Quantity), 0) - ISNULL(SUM(od.Quantity), 0)) <= 40\n" +
                "ORDER BY \n" +
                "    CurrentStock ASC;";
        DataConnect dc = new DataConnect();
        try (Connection conn = dc.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("CurrentStock");
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return 0;
    }

    public int getOutOfStockProducts() {
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
                "    LEFT JOIN Orders o ON od.OrderID = o.OrderID AND o.Status = 2\n" +
                "    GROUP BY \n" +
                "        p.ProductID, p.StockQuantity\n" +
                ") AS InventoryCalc\n" +
                "WHERE CurrentStock <= 0;\n";
        DataConnect dc = new DataConnect();
        try (Connection conn = dc.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("OutOfStockCount");
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return 0;
    }

    public int getTotalCategories() {
        String sql = "SELECT \n" +
                "    COUNT(*) AS TotalCategories\n" +
                "FROM \n" +
                "    Categories;";
        DataConnect dc = new DataConnect();
        try (Connection conn = dc.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("TotalCategories");
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return 0;
    }

    public int getTotalIventory() {
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
                "    LEFT JOIN Orders o ON od.OrderID = o.OrderID AND o.Status = 2 \n" +
                "    GROUP BY \n" +
                "        p.ProductID, p.StockQuantity\n" +
                ") AS StockCalculation;";
        DataConnect dc = new DataConnect();
        try (Connection conn = dc.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("TotalStock");
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return 0;
    }

    public int getActiveAccounts() {
        String sql = "SELECT COUNT(*) AS ActiveAccountCount\n" +
                "FROM Users\n" +
                "WHERE State = 1;";
        DataConnect dc = new DataConnect();
        try (Connection conn = dc.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("ActiveAccountCount");
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return 0;
    }

    public int getDisableAccounts() {
        String sql = "SELECT COUNT(*) AS DisabledAccountCount\n" +
                "FROM Users\n" +
                "WHERE State = 0;";
        DataConnect dc = new DataConnect();
        try (Connection conn = dc.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("DisabledAccountCount");
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return 0;
    }

    public int getNumberOfSuppliers() {
        String sql = "SELECT COUNT(*) AS Suppliers\n" +
                "FROM Suppliers";
        DataConnect dc = new DataConnect();
        try (Connection conn = dc.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("Suppliers");
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return 0;
    }

    public int getCategoryCount() {
        String sql = "SELECT COUNT(*) AS CategoryCount\n" +
                "From Categories";
        DataConnect dc = new DataConnect();
        try (Connection conn = dc.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("CategoryCount");
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return 0;
    }

    public int getDiscountCount() {
        String sql = "SELECT COUNT(*) AS TotalDiscounts FROM Discounts;\n";
        DataConnect dc = new DataConnect();
        try (Connection conn = dc.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("TotalDiscounts");
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return 0;
    }

    public int getDiscountIsAvailable() {
        String sql = "SELECT COUNT(*) AS TotalActiveDiscounts\n" +
                "FROM Discounts\n" +
                "WHERE IsActive = 1;";
        DataConnect dc = new DataConnect();
        try (Connection conn = dc.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("TotalActiveDiscounts");
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return 0;
    }

    public double getAvgRating() {
        String sql = "SELECT AVG(CAST(Rating AS FLOAT)) AS AverageRating\n" +
                "FROM Reviews;";
        DataConnect dc = new DataConnect();
        try (Connection conn = dc.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("AverageRating");
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return 0.0;
    }

    public int getTotalReviews() {
        String sql = "SELECT COUNT(*) AS TotalReviews FROM Reviews;\n";
        DataConnect dc = new DataConnect();
        try (Connection conn = dc.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("TotalReviews");
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return 0;
    }
}
