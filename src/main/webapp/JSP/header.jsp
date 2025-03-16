<%--
  Created by IntelliJ IDEA.
  User: hieul
  Date: 3/12/2025
  Time: 1:31 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Header</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/CSS/header.css">

</head>
<body>
<header>
    <a href="#" class="logo">SEAFOOD</a>
    <ul class="menu">
        <li class="menu_list"><a href="#">Home</a></li>
        <li class="menu_list"><a href="#">About</a></li>
        <li class="menu_list"><a href="#">Product</a></li>
        <li class="menu_list"><a href="#">Search</a></li>
    </ul>
    <button type="button" class="signIn_btn"><a href="login.jsp">Sign in</a></button>
</header>
</body>
</html>
