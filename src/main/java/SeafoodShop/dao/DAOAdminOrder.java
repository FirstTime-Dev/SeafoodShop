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
        String sql = "SELECT " +
                "od.OrderID, " +
                "p.Name AS ProductName, " +
                "od.Quantity, " +
                "od.Price, " +
                "od.Total, " +
                "u.FullName, " +
                "u.PhoneNumber, " +
                "u.Email, " +
                "u.Address, " +
                "o.Status " +
                "FROM OrderDetails od " +
                "JOIN Orders o ON od.OrderID = o.OrderID " +
                "JOIN Users u ON o.UserID = u.UserID " +
                "JOIN Products p ON od.ProductID = p.ProductID " +
                "WHERE od.OrderID = ?";

        DataConnect dc = new DataConnect();
        try (Connection conn = dc.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, orderID);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    orderDetail = new OrderDetail();
                    orderDetail.setOrderID(rs.getInt("OrderID"));
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


//    public static void main(String[] args) {
//        DAOAdminOrder dao = new DAOAdminOrder();
//        List<Order> orders = dao.getPendingOrders();
//        for (Order order : orders) {
//            System.out.println(order.getOrderID());
//        }
//    }
}
