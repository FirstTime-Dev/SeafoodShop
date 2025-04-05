<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/CSS/admin_accounts.css">
    <meta charset="UTF-8">
    <title>Quản lý tài khoản</title>
</head>
<body>
<div class="container">
    <div class="nav-container">
        <jsp:include page="admin_nav.jsp"/>
    </div>
    <div class="admin-content">

        <div class="header-add-container">
            <h2>Quản lý tài khoản</h2>
            <button class="add-customer-btn">➕ Thêm khách hàng</button>
        </div>
        <table>
            <thead>
            <tr>
                <th>ID</th>
                <th>Tên người dùng</th>
                <th>Email</th>
                <th>Trạng thái</th>
                <th>Level</th>
                <th>Ngày tạo</th>
                <th>Hành động</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>U001</td>
                <td>Nguyễn Văn A</td>
                <td>a.nguyen@example.com</td>
                <td><span class="badge active">Active</span></td>
                <td><span class="level-user">User</span></td>
                <td>2025-03-01</td>
                <td class="actions">
                    <button class="view" title="View">👁️</button>
                    <button class="edit" title="Edit">✏️</button>
                    <button class="ban" title="Ban">🔒</button>
                    <button class="delete" title="Delete">🗑️</button>
                </td>
            </tr>
            <tr>
                <td>U002</td>
                <td>Trần Thị B</td>
                <td>b.tran@example.com</td>
                <td><span class="badge banned">Banned</span></td>
                <td><span class="level-admin">Admin</span></td>
                <td>2025-01-15</td>
                <td class="actions">
                    <button class="view">👁️</button>
                    <button class="edit">✏️</button>
                    <button class="ban">🔓</button>
                    <button class="delete">🗑️</button>
                </td>
            </tr>
            <!-- Thêm nhiều dòng khác ở đây -->
            </tbody>
        </table>
    </div>
</div>
</body>
</html>
