<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/CSS/admin_reviews.css">
    <script src="<%= request.getContextPath() %>/JS/admin_reviews.js"></script>
    <title>Quản lý đánh giá sản phẩm</title>
</head>
<body>
<div class="container">
    <div class="nav-container">
        <jsp:include page="admin_nav.jsp"/>
    </div>
    <div class="admin-content">
        <h2>Phản hồi đánh giá sản phẩm</h2>
        <div id="alert" class="unread-alert" style="display: none;">
            🔔 Có đánh giá mới chưa phản hồi. Vui lòng kiểm tra bên dưới.
        </div>
        <div id="review-list">
            <!-- Các đánh giá sẽ được render ở đây -->
        </div>
    </div>
</div>
</body>
</html>
