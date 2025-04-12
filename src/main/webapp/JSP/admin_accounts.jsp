<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <script src="<%= request.getContextPath() %>/JS/admin_accounts.js"></script>
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
            <button class="add-customer-btn">➕ Tạo mới</button>
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
                    <button class="view" title="view">👁️</button>
                    <button class="edit" title="edit">✏️</button>
                    <button class="ban toggle-visibility" title="Ban/Unban">🔒</button>
                    <button class="delete" title="delete">🗑️</button>
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
                    <button class="view" title="view">👁️</button>
                    <button class="edit" title="edit">✏️</button>
                    <button class="ban toggle-visibility" tilte="Ban/Unban">🔓</button>
                    <button class="delete" title="delete">🗑️</button>
                </td>
            </tr>
            <!-- Thêm nhiều dòng khác ở đây -->
            </tbody>
        </table>
        <!-- Modal: Tạo tài khoản -->
        <div id="createAccountModal" class="modal">
            <div class="modal-content">
                <span class="close-modal">&times;</span>
                <h3>Tạo tài khoản mới</h3>
                <form method="post" action="createAccount"> <!-- Bạn đổi servlet xử lý nếu cần -->
                    <label for="fullName">Họ và tên:</label>
                    <input type="text" id="fullName" name="fullName" required maxlength="100">

                    <label for="username">Tên đăng nhập:</label>
                    <input type="text" id="username" name="username" required maxlength="50">

                    <label for="password">Mật khẩu:</label>
                    <input type="password" id="password" name="password" required maxlength="255">

                    <label for="email">Email:</label>
                    <input type="email" id="email" name="email" required maxlength="100">

                    <label for="phone">Số điện thoại:</label>
                    <input type="tel" id="phone" name="phone" required maxlength="15" pattern="[0-9]{10,15}">

                    <label for="birthDate">Ngày sinh:</label>
                    <input type="date" id="birthDate" name="birthDate" required>

                    <button type="submit" class="confirm-import-btn">💾 Tạo tài khoản</button>
                </form>
            </div>
        </div>

    </div>
</div>
</body>
</html>
