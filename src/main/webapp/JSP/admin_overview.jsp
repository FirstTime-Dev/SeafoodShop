<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css"
          integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg=="
          crossorigin="anonymous" referrerpolicy="no-referrer"/>
    <link rel="stylesheet" href="<%= request.getContextPath()%>/CSS/admin_overview.css">
    <script src="<%= request.getContextPath() %>/JS/admin_overview.js"></script>
    <title>Overview</title>
</head>
<body>
<div class="container">
    <div class="nav-container">
        <jsp:include page="admin_nav.jsp"/>
    </div>
    <div class="admin-content">
        <%
            boolean hasAlert = true;
        %>
        <h2 class="overview-header">
            Overview
            <% if (hasAlert) { %>
            <a href="<%= request.getContextPath() %>/JSP/admin_log.jsp">
                <img src="<%= request.getContextPath() %>/IMG/warning.png" class="alert-img" title="Cảnh báo hệ thống">
            </a>
            <% } %>
        </h2>
        <div class="revenue-hot-products">
            <!-- Bảng Doanh thu -->
            <div class="revenue-box">
                <h3>Doanh thu</h3>
                <table class="revenue-table">
                    <tr>
                        <th>Theo tháng</th>
                        <td>50,000,000 VND</td>
                    </tr>
                    <tr>
                        <th>Theo năm</th>
                        <td>600,000,000 VND</td>
                    </tr>
                </table>
            </div>
            <!-- Sản phẩm bán chạy -->
            <div class="info-pair">
                <div class="hot-products-box">
                    <h3>Sản phẩm bán chạy</h3>
                    <table class="info-table">
                        <tr>
                            <th>Tháng</th>
                            <td>Cá hồi Na Uy</td>
                        </tr>
                        <tr>
                            <th>Năm</th>
                            <td>Tôm sú Cà Mau</td>
                        </tr>
                    </table>
                </div>
                <!-- Đơn hàng đã giao -->
                <div class="delivered-orders-box">
                    <h3>Đơn hàng đã giao</h3>
                    <table class="info-table">
                        <tr>
                            <th>Trong tháng</th>
                            <td>65 đơn hàng</td>
                        </tr>
                        <tr>
                            <th>Trong năm</th>
                            <td>712 đơn hàng</td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
        <div class="grid">
            <a href="admin_products.jsp" class="box-link">
                <div class="box">
                    <h3>Tình trạng tồn kho</h3>
                    <p><strong>Tổng: 320 sản phẩm</strong></p>
                    <p><strong><span class="label">Sắp hết</span> <span class="badge stock">12</span></strong></p>
                    <p><strong><span class="label">Hết</span> <span class="badge stock">8</span></strong></p>
                </div>
            </a>
            <a href="admin_accounts.jsp" class="box-link">
                <div class="box">
                    <h3>Tài khoản</h3>
                    <p><strong>1,200 người dùng</strong></p>
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
