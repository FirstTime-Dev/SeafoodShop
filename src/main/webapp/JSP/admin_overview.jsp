<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="<%= request.getContextPath()%>/CSS/admin_overview.css">
    <title>Overview</title>
</head>
<body>
<div class="container">
    <div class="nav-container">
        <jsp:include page="admin_nav.jsp"/>
    </div>
    <div class="admin-content">
        <h2>Overview</h2>
        <div class="grid">
                <div class="box">
                    <h3>Doanh thu</h3>
                    <p><strong>Theo tháng: 50,000,000 VND</strong></p>
                    <p><strong>Theo năm: 600,000,000 VND</strong></p>
                </div>
            </a>

            <a href="admin_inventory.jsp" class="box-link">
                <div class="box">
                    <h3>Tình trạng tồn kho</h3>
                    <p class="out-stock"><strong>Hết hàng: 12 sản phẩm</strong></p>
                    <p class="low-stock"><strong>Sắp hết: 8 sản phẩm</strong></p>
                </div>
            </a>

            <a href="admin_accounts.jsp" class="box-link">
                <div class="box">
                    <h3>Tài khoản</h3>
                    <p><strong>1,200 người dùng</strong></p>
                </div>
            </a>

            <a href="admin_products.jsp" class="box-link">
                <div class="box">
                    <h3>Sản phẩm</h3>
                    <p><strong>320 sản phẩm</strong></p>
                </div>
            </a>

            <a href="admin_suppliers.jsp" class="box-link">
                <div class="box">
                    <h3>Nhà cung cấp</h3>
                    <p><strong>35 nhà cung cấp</strong></p>
                </div>
            </a>

            <a href="admin_categories.jsp" class="box-link">
                <div class="box">
                    <h3>Danh mục</h3>
                    <p><strong>18 danh mục</strong></p>
                </div>
            </a>

            <a href="admin_discounts.jsp" class="box-link">
                <div class="box">
                    <h3>Chương trình khuyến mãi</h3>
                    <p><strong>5 chương trình</strong></p>
                </div>
            </a>

            <a href="admin_reviews.jsp" class="box-link">
                <div class="box">
                    <h3>Đánh giá sản phẩm</h3>
                    <p><strong>Trung bình: 4.3 / 5 sao</strong></p>
                    <p><strong>Tổng đánh giá: 920</strong></p>
                </div>
            </a>
        </div>
    </div>
</div>
</body>
</html>
