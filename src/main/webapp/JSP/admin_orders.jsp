<%@ page import="SeafoodShop.model.Order" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <script src="<%= request.getContextPath() %>/JS/admin_orders.js"></script>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/CSS/admin_orders.css">
    <title>Admin_orders</title>
</head>
<body>
<div class="container">
    <div class="nav-container">
        <jsp:include page="admin_nav.jsp"/>
    </div>
    <div class="admin-content">
        <%
            List<Order> orders = (List<Order>) request.getAttribute("orders");
        %>
        <div class="header-add-container">
            <h2>Quản lý đơn hàng</h2>
        </div>
        <table>
            <thead>
            <tr>
                <th>Mã Đơn</th>
                <th>Mã khách hàng</th>
                <th>Tổng Tiền</th>
                <th>Trạng Thái</th>
                <th>Hành Động</th>
            </tr>
            </thead>
            <tbody>
            <%
                if (orders != null) {
                    for (Order order : orders) {
                        String statusStr = "";
                        switch (order.getOrderStatus()) {
                            case 1:
                                statusStr = "Chờ xác nhận";
                                break;
                            case 2:
                                statusStr = "Đã xác nhận";
                                break;
                            case 3:
                                statusStr = "Đã hủy";
                                break;
                            default:
                                statusStr = "Không xác định";
                        }
            %>
            <tr>
                <td>
                    <a href="#" class="order-detail-link" data-id="<%= order.getOrderID() %>">
                        <%= order.getOrderID() %>
                    </a>
                </td>

                <td><%= order.getUserID() %>
                </td>
                <td><%= order.getTotalAmount() %> VND</td>
                <td><%= statusStr %>
                </td>
                <td>
                    <%
                        int status = order.getOrderStatus();
                        if (status == 1) {
                    %>
                    <button class="confirm-btn <%= (order.getOrderStatus() == 1) ? "" : "hidden" %>"
                            data-id="<%= order.getOrderID() %>">Xác nhận
                    </button>
                    <button class="cancel-btn <%= (order.getOrderStatus() == 1 || order.getOrderStatus() == 2) ? "" : "hidden" %>"
                            data-id="<%= order.getOrderID() %>">Hủy
                    </button>
                    <%
                    } else if (status == 2) {
                    %>
                    <button class="cancel-btn <%= (order.getOrderStatus() == 1 || order.getOrderStatus() == 2) ? "" : "hidden" %>"
                            data-id="<%= order.getOrderID() %>">Hủy
                    </button>
                    <%
                        } // status == 3 => không hiển thị gì
                    %>
                </td>
                <%
                        }
                    }
                %>
            </tr>
            </tbody>
        </table>
        <div id="orderDetailPopup" class="popup">
            <div class="popup-content">
                <span id="closeOrderDetailPopup" class="close-popup">&times;</span>
                <h2>Chi Tiết Đơn Hàng</h2>
                <div id="orderDetailContent">
                    <table class="detail-table">
                        <tr>
                            <th>Mã Đơn Hàng:</th>
                            <td id="popupOrderID"></td>
                        </tr>
                        <tr>
                            <th>Tên Sản Phẩm:</th>
                            <td id="popupProductName"></td>
                        </tr>
                        <tr>
                            <th>Số Lượng:</th>
                            <td id="popupQuantity"></td>
                        </tr>
                        <tr>
                            <th>Giá:</th>
                            <td id="popupPrice"></td>
                        </tr>
                        <tr>
                            <th>Tổng:</th>
                            <td id="popupTotal"></td>
                        </tr>
                        <tr>
                            <th>Ngày Đặt Hàng:</th>
                            <td id="popupOrderDate"></td>
                        </tr>
                        <tr>
                            <th>Họ Tên Khách:</th>
                            <td id="popupFullName"></td>
                        </tr>
                        <tr>
                            <th>SĐT:</th>
                            <td id="popupPhoneNumber"></td>
                        </tr>
                        <tr>
                            <th>Email:</th>
                            <td id="popupEmail"></td>
                        </tr>
                        <tr>
                            <th>Địa Chỉ:</th>
                            <td id="popupAddress"></td>
                        </tr>
                        <tr>
                            <th>Trạng Thái:</th>
                            <td id="popupStatus"></td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>