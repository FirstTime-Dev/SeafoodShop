<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý danh mục</title>
    <script src="<%= request.getContextPath() %>/JS/admin_categories.js"></script>
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/CSS/admin_categories.css">
</head>
<body>
<div class="container">
    <div class="nav-container">
        <jsp:include page="admin_nav.jsp"/>
    </div>
    <div class="admin-content">
        <div class="header-add-container">
            <h2>Category Management</h2>
            <button class="add-customer-btn">➕ Tạo mới</button>
        </div>
        <table>
            <thead>
            <tr>
                <th>ID</th>
                <th>Tên danh mục</th>
                <th>Mô tả</th>
                <th>Hành động</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>C001</td>
                <td>Hải sản tươi</td>
                <td>Các loại hải sản mới đánh bắt</td>
                <td class="actions">
                    <button class="edit" title="Edit">✏️</button>
                    <button class="toggle-visibility" title="Ẩn/Hiện">👁️‍🗨️</button>
                    <button class="delete" title="Delete">🗑️</button>
                </td>
            </tr>
            <tr>
                <td>C002</td>
                <td>Đồ khô</td>
                <td>Hải sản khô, đóng gói sẵn</td>
                <td class="actions">
                    <button class="edit" title="Edit">✏️</button>
                    <button class="toggle-visibility" title="Ẩn/Hiện">👁️‍🗨️</button>
                    <button class="delete" title="Delete">🗑️</button>
                </td>
            </tr>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>
