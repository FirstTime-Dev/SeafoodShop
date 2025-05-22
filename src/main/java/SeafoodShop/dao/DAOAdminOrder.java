package SeafoodShop.dao;

import SeafoodShop.model.Order;
import SeafoodShop.model.OrderDetail;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DAOAdminOrder {

    public List<Order> getActiveOrders() {
        List<Order> orderList = new ArrayList<Order>();
        String sql = "SELECT * FROM Orders WHERE State=1";
        DataConnect dc = new DataConnect();
        try (Connection conn = dc.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Order order = new Order();
                order.setUserID(rs.getInt("UserID"));
                order.setOrderID(rs.getInt("OrderID"));
                order.setTotalAmount(rs.getDouble("TotalAmount"));
                order.setOrderStatus(rs.getInt("Status"));
                orderList.add(order);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return orderList;
    }

    public OrderDetail getOrderDetail(int orderID) {
        OrderDetail orderDetail = null;
        String sql = "SELECT \n" +
                "    od.OrderID,\n" +
                "\to.OrderDate,\n" +
                "    p.Name AS ProductName,\n" +
                "    od.Quantity,\n" +
                "    od.Price,\n" +
                "    od.Total,\n" +
                "    u.FullName,\n" +
                "    u.PhoneNumber,\n" +
                "    u.Email,\n" +
                "    u.Address,\n" +
                "    o.Status\n" +
                "FROM OrderDetails od\n" +
                "JOIN Orders o ON od.OrderID = o.OrderID\n" +
                "JOIN Users u ON o.UserID = u.UserID\n" +
                "JOIN Products p ON od.ProductID = p.ProductID\n" +
                "WHERE od.OrderID = ?;";

        DataConnect dc = new DataConnect();
        try (Connection conn = dc.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderID);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    orderDetail = new OrderDetail();
                    orderDetail.setOrderID(rs.getInt("OrderID"));
                    orderDetail.setOrderDate(rs.getDate("OrderDate"));
                    orderDetail.setProductName(rs.getString("ProductName"));
                    orderDetail.setQuantity(rs.getInt("Quantity"));
                    orderDetail.setPrice(rs.getDouble("Price"));
                    orderDetail.setTotal(rs.getDouble("Total"));
                    orderDetail.setFullName(rs.getString("FullName"));
                    orderDetail.setPhoneNumber(rs.getString("PhoneNumber"));
                    orderDetail.setEmail(rs.getString("Email"));
                    orderDetail.setAddress(rs.getString("Address"));
                    orderDetail.setStatus(rs.getInt("Status"));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error retrieving order detail for OrderID: " + orderID, e);
        }

        return orderDetail;
    }

    public boolean updateOrderStatus(int orderID, int status) {
        String sql = "UPDATE Orders SET Status = ? WHERE OrderID = ?";
        DataConnect dc = new DataConnect();
        try (Connection conn = dc.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, status);
            ps.setInt(2, orderID);
            int i = ps.executeUpdate();
            return i > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

//    public static void main(String[] args) {
//        DAOAdminOrder dao = new DAOAdminOrder();
//        List<Order> orders = dao.getPendingOrders();
//        for (Order order : orders) {
//            System.out.println(order.getOrderID());
//        }
//    }
}
