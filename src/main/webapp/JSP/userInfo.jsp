<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 18/03/2025
  Time: 1:36 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/CSS/userInfo.css">
    <script defer src="<%=request.getContextPath()%>/JS/userInfo.js"></script>
    <title>thông tin cá nhân</title>
    
</head>
<body>
<div class="sidebar">
    <ul>
        <li id="menu-thong-bao" class="menu-item">Thông Báo</li>
        <li id="menu-tai-khoan" class="menu-item">Tài Khoản Của Tôi</li>
        <ul>
            <li id="menu-ho-so" class="menu-item">Hồ Sơ</li>
            <li id="menu-dia-chi" class="menu-item">Địa Chỉ</li>
            <li id="menu-doi-mat-khau" class="menu-item">Đổi Mật Khẩu</li>
        </ul>
        <li id="menu-don-mua" class="menu-item">Đơn Mua</li>
        <li id="menu-kho-voucher" class="menu-item">Kho Voucher</li>
    </ul>
</div>

<div class="content" id="main-content">
    <div id="content-thong-bao" class="content-section active">
        <h2>Thông Báo</h2>
        <p>Nội dung thông báo.</p>
    </div>
    <!-- hồ sơ cá nhân jsp -->
    <div id="content-tai-khoan" class="content-section">
        <h2>Hồ Sơ Của Tôi</h2>
        <p>Quản lý thông tin hồ sơ để bảo mật tài khoản</p>
        <form>
            <label for="username">Tên đăng nhập</label><br>
            <input type="text" id="username" value="" readonly><br>
            <small>Tên Đăng nhập chỉ có thể thay đổi một lần.</small><br><br>

            <label for="fullname">Tên</label><br>
            <input type="text" id="fullname"><br><br>

            <label>Email</label><br>
            <span>***********@gmail.com</span> <a href="#">Thay Đổi</a><br><br>

            <label>Số điện thoại</label><br>
            <span>********</span> <a href="#">Thay Đổi</a><br><br>

            <label>Giới tính</label><br>
            <input type="radio" id="gender-male" name="gender" checked>
            <label for="gender-male">Nam</label>
            <input type="radio" id="gender-female" name="gender">
            <label for="gender-female">Nữ</label>
            <input type="radio" id="gender-other" name="gender">
            <label for="gender-other">Khác</label><br><br>

            <label>Ngày sinh</label><br>
            <select name="day">
                <option>Ngày</option>
            </select>

            <select name="month">
                <option>Tháng</option>
            </select>

            <select name="year">
                <option>Năm</option>
            </select><br><br>

            <button type="submit">Lưu</button>
        </form>

        <div style="margin-top: 20px;">
            <img src="" alt="avatar" style="width: 100px; height: 100px; border-radius: 50%; border: 1px solid #ccc;"><br><br>
            <input type="file" accept="image/png, image/jpeg"><br>
            <small>Dung lượng file tối đa 1 MB. Định dạng: .JPEG, .PNG</small>
        </div>

    </div>
    <div id="content-ho-so" class="content-section">
        <h2>Hồ Sơ</h2>
        <p>Thông tin hồ sơ cá nhân.</p>
    </div>
    <div id="content-ngan-hang" class="content-section">
        <h2>Ngân Hàng</h2>
        <p>Thông tin tài khoản ngân hàng.</p>
    </div>
    <div id="content-dia-chi" class="content-section">
        <h2>Địa Chỉ</h2>
        <p>Danh sách địa chỉ đã lưu.</p>

        <!-- Nút thêm địa chỉ -->
        <button id="btn-add-address">+ Thêm địa chỉ mới</button>

        <div id="address-list">
            <div class="address-card">
                <strong>Nguyễn Trung Thành</strong> | <span>(+84) 338 719 141</span><br>
                <span>122/20/14a, Đường Số 11<br>
      Phường Trường Thọ, Thành Phố Thủ Đức, TP. Hồ Chí Minh</span><br>
                <span class="default-label">Mặc định</span><br>
                <button class="btn-set-default" disabled>Thiết lập mặc định</button>
                <button class="btn-edit">Cập nhật</button>
            </div>

            <div class="address-card">
                <strong>Nguyễn Thành</strong> | <span>(+84) 338 719 141</span><br>
                <span>Gần Chùa Định Phước Di Đà<br>
      Phường Đông Hòa, Thành Phố Dĩ An, Bình Dương</span><br>
                <button class="btn-set-default">Thiết lập mặc định</button>
                <button class="btn-edit">Cập nhật</button>
                <button class="btn-delete">Xóa</button>
            </div>
        </div>
    </div>
    <!-- đổi mật khẩu jsp -->
    <div id="content-doi-mat-khau" class="content-section">
        <h2>Đổi Mật Khẩu</h2>
        <p>Để bảo mật tài khoản, vui lòng không chia sẻ mật khẩu với người khác</p>

        <form id="change-password-form">
            <div class="form-group">
                <label for="current-password">Mật khẩu hiện tại</label>
                <input type="password" id="current-password" name="current-password" required>
                <small class="error-message"></small>
            </div>

            <div class="form-group">
                <label for="new-password">Mật khẩu mới</label>
                <input type="password" id="new-password" name="new-password" required>
                <small class="hint">Mật khẩu phải có ít nhất 8 ký tự, bao gồm chữ và số</small>
                <small class="error-message"></small>
            </div>

            <div class="form-group">
                <label for="confirm-password">Xác nhận mật khẩu mới</label>
                <input type="password" id="confirm-password" name="confirm-password" required>
                <small class="error-message"></small>
            </div>

            <button type="submit" class="save-btn">Lưu mật khẩu</button>
        </form>
    </div>
    <div id="content-thong-bao-cai-dat" class="content-section">
        <h2>Cài Đặt Thông Báo</h2>
        <p>Tuỳ chỉnh thông báo.</p>
    </div>
    <div id="content-thiet-lap-rieng-tu" class="content-section">
        <h2>Thiết Lập Riêng Tư</h2>
        <p>Các tùy chọn bảo mật và quyền riêng tư.</p>
    </div>
    <div id="content-don-mua" class="content-section">
        <h2>Đơn Mua</h2>
        <p>Lịch sử mua hàng.</p>
    </div>
    <div id="content-kho-voucher" class="content-section">
        <h2>Kho Voucher</h2>
        <p>Danh sách voucher đã lưu.</p>
    </div>
</div>
</body>
</html>
