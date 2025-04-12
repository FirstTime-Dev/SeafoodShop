<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
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
        <div class="header-add-container">
            <h2>Quản lý đơn hàng</h2>
        </div>
        <table>
            <thead>
            <tr>
                <th>Mã Đơn</th>
                <th>Khách Hàng</th>
                <th>Tổng Tiền</th>
                <th>Trạng Thái</th>
                <th>Hành Động</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>DH001</td>
                <td>Nguyễn Văn A</td>
                <td>1.200.000đ</td>
                <td>Chờ xác nhận</td>
                <td class="actions">
                    <button class="confirm">Xác nhận</button>
                    <button class="cancel">Hủy</button>
                </td>
            </tr>
            <tr>
                <td>DH002</td>
                <td>Trần Thị B</td>
                <td>850.000đ</td>
                <td>Chờ xác nhận</td>
                <td class="actions">
                    <button class="confirm">Xác nhận</button>
                    <button class="cancel">Hủy</button>
                </td>
            </tr>
            <!-- Thêm các đơn hàng khác ở đây -->
            </tbody>
        </table>
    </div>
</div>

</body>
</html>
