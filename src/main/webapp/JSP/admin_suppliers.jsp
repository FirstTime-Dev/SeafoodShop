<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 04/04/2025
  Time: 10:49 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <script src="<%= request.getContextPath() %>/JS/admin_categories.js"></script>
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/CSS/admin_suppliers.css">
    <title>Suppliers</title>
</head>
<body>
<div class="container">
    <div class="nav-container">
        <jsp:include page="admin_nav.jsp"/>
    </div>
    <div class="admin-content">
        <div class="header-add-container">
            <h2>Quản lý nhà cung cấp</h2>
            <button class="add-customer-btn">➕ Tạo mới</button>
        </div>
        <table>
            <thead>
            <tr>
                <th>ID</th>
                <th>Tên nhà cung cấp</th>
                <th>Email</th>
                <th>SĐT</th>
                <th>Địa chỉ</th>
                <th>Hành động</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>SUP001</td>
                <td>Seafood Co.</td>
                <td>seafood@gmail.com</td>
                <td>0901234567</td>
                <td>123 Biển Đông, Q.1, TP.HCM</td>
                <td class="actions">
                    <button class="edit">✏️</button>
                    <button class="toggle-visibility" title="Ẩn/Hiện">👁️‍🗨️</button>
                    <button class="delete">🗑️</button>
                </td>
            </tr>
            <tr>
                <td>SUP002</td>
                <td>FreshCatch Ltd</td>
                <td>freshcatch@mail.com</td>
                <td>0987654321</td>
                <td>456 Đại Dương, Q.3, TP.HCM</td>
                <td class="actions">
                    <button class="edit">✏️</button>
                    <button class="toggle-visibility" title="Ẩn/Hiện">👁️‍🗨️</button>
                    <button class="delete">🗑️</button>
                </td>
            </tr>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>
