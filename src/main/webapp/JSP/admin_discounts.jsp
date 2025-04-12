<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/CSS/admin_discounts.css">
    <title>Discounts</title>
</head>
<body>
<div class="container">
    <div class="nav-container">
        <jsp:include page="admin_nav.jsp"/>
    </div>
    <div class="admin-content">

        <div class="header-add-container">
            <h2>Discount Management</h2>
            <button class="add-customer-btn">➕ Tạo mới</button>
        </div>

        <table>
            <thead>
            <tr>
                <th>Tên chương trình</th>
                <th>Giảm giá</th>
                <th>Thời gian</th>
                <th>Mô tả</th>
                <th>Hành động</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>Khuyến mãi mùa hè</td>
                <td>20%</td>
                <td>01/06/2025 - 30/06/2025</td>
                <td>Giảm giá 20% cho tất cả sản phẩm tươi sống trong mùa hè.</td>
                <td class="actions">
                    <button class="edit" title="Edit">✏️</button>
                    <button class="delete" title="Delete">🗑️</button>
                </td>
            </tr>
            <tr>
                <td>Khuyến mãi Giáng Sinh</td>
                <td>30%</td>
                <td>20/12/2025 - 25/12/2025</td>
                <td>Giảm giá 30% cho các sản phẩm quà tặng trong dịp lễ Giáng Sinh.</td>
                <td class="actions">
                    <button class="edit" title="Edit">✏️</button>
                    <button class="delete" title="Delete">🗑️</button>
                </td>
            </tr>
            <tr>
                <td>Khuyến mãi năm mới</td>
                <td>15%</td>
                <td>01/01/2025 - 05/01/2025</td>
                <td>Tặng mã giảm giá 15% cho các đơn hàng đầu năm mới.</td>
                <td class="actions">
                    <button class="edit" title="Edit">✏️</button>
                    <button class="delete" title="Delete">🗑️</button>
                </td>
            </tr>
            <!-- Thêm nhiều chương trình khuyến mãi tại đây -->
            </tbody>
        </table>

    </div>
</div>
</div>
</body>
</html>
