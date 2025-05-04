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
                        <td><%= String.format("%,.0f VND", (Double) request.getAttribute("revenueMonth")) %>
                        </td>
                    </tr>
                    <tr>
                        <th>Theo năm</th>
                        <td><%= String.format("%,.0f VND", (Double) request.getAttribute("revenueYear")) %>
                        </td>
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
                            <td><%=request.getAttribute("topMonthProduct")%>
                            </td>
                        </tr>
                        <tr>
                            <th>Năm</th>
                            <td><%=request.getAttribute("topYearProduct")%>
                            </td>
                        </tr>
                    </table>
                </div>
                <!-- Đơn hàng đã giao -->
                <div class="delivered-orders-box">
                    <h3>Đơn hàng đã giao</h3>
                    <table class="info-table">
                        <tr>
                            <th>Trong tháng</th>
                            <td><%= request.getAttribute("ordersMonth")%>
                            </td>
                        </tr>
                        <tr>
                            <th>Trong năm</th>
                            <td><%= request.getAttribute("ordersYear")%>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
        <div class="grid">
            <div class="box">
                <a href="admin_products.jsp" class="box-link">
                    <h3>Tình trạng kho hàng</h3>
                    <h3>Tổng: <%= request.getAttribute("totalIventory") %> sản phẩm</h3>
                    <p><strong><span class="label">Sắp hết HSD: </span> <span
                            class="badge stock"><%= request.getAttribute("expiringProductCount") %></span></strong></p>
                    <p><strong><span class="label">Hết HSD: </span> <span
                            class="badge stock"><%= request.getAttribute("expiredProductCount") %></span></strong></p>
                    <p><strong><span class="label">Sắp hết hàng: </span> <span
                            class="badge stock"><%= request.getAttribute("almostOutOfStockProducts") %></span></strong>
                    </p>
                    <p><strong><span class="label">Hết hàng: </span> <span
                            class="badge stock"><%= request.getAttribute("outOfStockProducts") %></span></strong></p>
                </a>
            </div>
            <div class="box">
                <a href="admin_accounts.jsp" class="box-link">
                    <h3>Tài khoản</h3>
                    <h3>Tổng : <%
                        int active = (int) request.getAttribute("activeAccounts");
                        int disable = (int) request.getAttribute("disableAccounts");
                        int total = active + disable;%><%= total %> tài khoản</h3>
                    <p><strong>Tài khoản khả dụng: <%= request.getAttribute("activeAccounts") %></strong></p>
                    <p><strong>Tài khoản bị vô hiệu hóa : <%= request.getAttribute("disableAccounts") %></strong></p>
                </a>
            </div>
            <div class="box">
            <a href="admin_suppliers.jsp" class="box-link">
                    <h3>Nhà cung cấp</h3>
                    <h3>Tổng : <%= request.getAttribute("totalSuppliers") %> nhà cung cấp</strong></h3>
            </a>
            </div>
            <div class="box">
                <a href="admin_categories.jsp" class="box-link">
                    <h3>Danh mục</h3>
                    <h3>Tổng : <%= request.getAttribute("totalCategory") %> danh mục</h3>
                </a>
            </div>
            <div class="box">
                <a href="admin_discounts.jsp" class="box-link">
                    <h3>Chương trình khuyến mãi</h3>
                    <h3>Tổng : <%= request.getAttribute("totalDiscount") %> chương trình</h3>
                    <p><strong>Số khuyến mãi còn hiệu lực : <%= request.getAttribute("totalAvailableDiscount") %></strong></p>
                </a>
            </div>
            <div class="box">
                <a href="admin_reviews.jsp" class="box-link">
                    <h3>Đánh giá sản phẩm</h3>
                    <p><strong>Trung bình: <%= request.getAttribute("avgRating") %> / 5 sao</strong></p>
                    <p><strong>Tổng đánh giá: <%= request.getAttribute("totalReview") %></strong></p>
                </a>
            </div>
        </div>
    </div>
</div>
</body>
</html>
