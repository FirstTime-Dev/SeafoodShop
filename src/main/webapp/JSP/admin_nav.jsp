<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/CSS/admin_nav.css">
</head>
<body>
<div class="admin-nav">
    <h3>Admin Panel</h3>
    <p>Welcome, Admin</p>
    <a href="admin_overview.jsp">Overview</a>
    <a href="admin_accounts.jsp">Account</a>
    <a href="admin_orders.jsp">Order</a>
    <a href="admin_discounts.jsp">Discount</a>
    <a href="admin_categories.jsp">Category</a>
    <a href="admin_products.jsp">Product</a>
    <a href="admin_reviews.jsp">Review</a>
    <a href="admin_suppliers.jsp">Supplier</a>
    <a href="admin_log.jsp">Log</a>
</div>
</body>
</html>
