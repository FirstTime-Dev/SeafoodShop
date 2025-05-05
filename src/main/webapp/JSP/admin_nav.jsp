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
    <a href="AdminOverview">Overview</a>
    <a href="AdminAccount">Account</a>
    <a href="AdminOrder">Order</a>
    <a href="AdminDiscount">Discount</a>
    <a href="AdminCategory">Category</a>
    <a href="AdminProduct">Product</a>
    <a href="AdminReview">Review</a>
    <a href="AdminSupplier">Supplier</a>
    <a href="AdminLog">Log</a>
</div>
</body>
</html>
