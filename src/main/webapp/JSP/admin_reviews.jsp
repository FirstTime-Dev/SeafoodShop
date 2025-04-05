<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/CSS/admin_reviews.css">
    <meta charset="UTF-8">
    <title>Quản lý đánh giá sản phẩm</title>

</head>
<body>
<div class="container">
    <div class="nav-container">
        <jsp:include page="admin_nav.jsp"/>
    </div>
    <div class="admin-content">
        <h2>Quản lý đánh giá khách hàng</h2>
        <div class="review-card">
            <div class="review-header">
                <span class="reviewer-name">Nguyễn Văn A</span>
                <span class="review-date">03/04/2025</span>
            </div>
            <div class="rating">⭐⭐⭐⭐⭐</div>
            <div class="review-text">
                Sản phẩm rất tươi, đóng gói cẩn thận, giao hàng nhanh.
            </div>

            <!-- Nếu đã có phản hồi từ admin -->
            <div class="admin-reply">
                <strong>Phản hồi từ quản trị viên:</strong>
                <p>Cảm ơn bạn đã tin tưởng và ủng hộ! Rất mong được phục vụ bạn lần sau.</p>
            </div>

            <!-- Nếu chưa có phản hồi thì hiện khung nhập -->
            <!--
            <div class="reply-section">
              <label class="reply-label">Phản hồi khách hàng:</label>
              <textarea placeholder="Nhập phản hồi của bạn..."></textarea>
              <button class="reply-btn">Gửi phản hồi</button>
            </div>
            -->
        </div>
    </div>
</div>
</body>
</html>
