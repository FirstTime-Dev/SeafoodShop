<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="SeafoodShop.model.User" %>

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
        <%
            List<User> users = (List<User>) request.getAttribute("users");
        %>
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
                <th>Số điện thoại</th>
                <th>Role</th>
                <th>Hành động</th>
            </tr>
            </thead>
            <tbody>
            <%
                if (users != null) {
                    for (User user : users) {
                        int role = user.getRole();
                        String roleStr = (role == 1) ? "User" : (role == 2) ? "Manager" : "Admin";
                        boolean isBanned = user.getBan() == 1;
            %>
            <tr class="<%= isBanned ? "hidden-product" : "" %>" id="user-row-<%= user.getUserID() %>">
                <td><%= user.getUserID() %>
                </td>
                <td><%= user.getFullName() %>
                </td>
                <td><%= user.getEmail() %>
                </td>
                <td><%= user.getPhone() %>
                </td>
                <td><%= roleStr %>
                </td>
                <td class="actions">
                    <button class="edit" title="Sửa" data-userid="<%= user.getUserID() %>">✏️</button>
                    <button class="toggle-visibility"
                            title="<%= isBanned ? "Unban" : "Ban" %>"
                            data-userid="<%= user.getUserID() %>"
                            data-currentban="<%= user.getBan() %>">🚫
                    </button>
                    <button class="delete" title="Xóa">🗑️</button>
                </td>
            </tr>
            <%
                }
            } else {
            %>
            <tr>
                <td colspan="10">Không có dữ liệu người dùng</td>
            </tr>
            <%
                }
            %>
            </tbody>

        </table>
        <!-- Modal: Tạo tài khoản -->
        <div id="createAccountModal" class="modal">
            <div class="modal-content">
                <span class="close-modal">&times;</span>
                <h3>Tạo tài khoản mới</h3>
                <form id="createAccountForm" method="post" action="CreateNewAccount">
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

                    <label for="birthday">Ngày sinh:</label>
                    <input type="date" id="birthday" name="birthday" required>

                    <label for="address">Địa chỉ:</label>
                    <input type="text" id="address" name="address" required>

                    <button type="submit" class="confirm-import-btn">Tạo tài khoản</button>
                </form>
            </div>
        </div>
        <!-- Popup Chỉnh Sửa Người Dùng -->
        <div id="editUserPopup" class="popup">
            <div class="popup-content">
                <span id="closeEditPopup" class="close-popup">&times;</span>
                <h2>Chỉnh Sửa Người Dùng</h2>
                <form id="editUserForm" method="post" action="EditUserInformation">
                    <label for="UserID">ID người dùng:</label>
                    <input type="text" id="UserID" name="userID" readonly>

                    <label for="editFullName">Họ và tên:</label>
                    <input type="text" id="editFullName" name="fullName" required>

                    <label for="editUsername">Tên đăng nhập:</label>
                    <input type="text" id="editUsername" name="username" required>

                    <label for="editPassword">Mật khẩu:</label>
                    <input type="password" id="editPassword" name="password" required>

                    <label for="editEmail">Email:</label>
                    <input type="email" id="editEmail" name="email" required>

                    <label for="editPhone">Số điện thoại:</label>
                    <input type="tel" id="editPhone" name="phone" maxlength="15" required>

                    <label for="editBirthDate">Ngày sinh:</label>
                    <input type="date" id="editBirthDate" name="birthDate" min="1900-01-01" max="2100-12-31" required>

                    <label for="editAddress">Địa chỉ:</label>
                    <input type="text" id="editAddress" name="address">

                    <label for="editRole">Vai trò:</label>
                    <select id="editRole" name="role" required>
                        <option value="1">User</option>
                        <option value="2">Manager</option>
                        <option value="3">Admin</option>
                    </select>

                    <label for="editBan">Ban:</label>
                    <select id="editBan" name="ban" required>
                        <option value="0">Mở khóa</option>
                        <option value="1">Khóa</option>
                    </select>

                    <label for="editCreatedAt">Ngày tạo:</label>
                    <input type="text" id="editCreatedAt" readonly>

                    <button type="submit">Lưu Thay Đổi</button>
                </form>
            </div>
        </div>

    </div>
</div>
</body>
</html>
