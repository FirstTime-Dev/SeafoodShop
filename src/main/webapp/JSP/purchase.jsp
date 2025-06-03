<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/CSS/purchase.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/CSS/breadcrumb.css">
    <script defer src="<%=request.getContextPath()%>/JS/purchase.js"></script> <!-- Thêm defer để tránh lỗi tải script -->
    <title>Purchase</title>

</head>
<body>

<jsp:include page="header.jsp"/>
<div class="breadcrumb">
    <div class="breadcrumb-container">
        <ul>
            <li><a href="<%= request.getContextPath() %>JSP/home.jsp">Trang chủ</a></li>
            <li><a href="<%= request.getContextPath() %>JSP/purchase.jsp">Thông tin đơn hàng</a></li>
        </ul>
    </div>
</div>

<div class="container">
    <h2>My purchase</h2>

    <div class="tabs">
        <div class="tab" data-status="all" onclick="filterOrders('all')">All</div>
        <div class="tab" data-status="processing" onclick="filterOrders('processing')">Processing</div>
        <div class="tab" data-status="shipping" onclick="filterOrders('shipping')">Delivering</div>
        <div class="tab" data-status="completed" onclick="filterOrders('completed')">Done</div>
        <div class="tab" data-status="cancelled" onclick="filterOrders('cancelled')">Cancel</div>
    </div>

    <ul class="order-list" id="orderList">
        <!-- Danh sách đơn hàng sẽ được hiển thị ở đây -->
    </ul>

</div>

<jsp:include page="footer.jsp"/>

</body>
</html>
