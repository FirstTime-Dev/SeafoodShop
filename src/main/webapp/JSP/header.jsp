<%--
  Created by IntelliJ IDEA.
  User: hieul
  Date: 3/12/2025
  Time: 1:31 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Header</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/CSS/header.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
</head>
<body>
<div class="header-container">
    <header>
        <!-- thanh bên trên của header -->
        <div class="top-bar">
            <div class="language-currency">
                <select>
                    <option>EN</option>
                    <option>VN</option>
                </select>
            </div>
            <form action="" id="search-bar" class="search-bar">
                <input type="text" id="search-text" placeholder="What are you looking for?" required autocomplete="off">
                <button id="search-btn"><i class="fa-solid fa-magnifying-glass"></i></button>
            </form>

            <div class="contact-auth">
                <span>+1 234 567 890</span>
                <%
                    // Lấy session (nếu chưa có thì trả về null)
                    session = request.getSession(false);
                    Integer userId = null;
                    if (session != null) {
                        userId = (Integer) session.getAttribute("user_id");
                    }
                    if (userId == null) {
                        // Chưa đăng nhập → hiển thị Sign In/Sign Up
                %>
                <a href="<%= request.getContextPath() %>/loginController">Sign In/Sign Up</a>
                <%
                } else {
                    // Đã đăng nhập → hiển thị link tới trang User Info
                    // Bạn có thể thay "userInfo.jsp" hoặc một Servlet nào đó mà bạn đã tạo
                %>
                <a href="<%= request.getContextPath() %>/UserInfo">User Info</a>
                <!-- Nếu muốn hiển thị thêm nút Logout -->
                <span style="margin:0 8px;">|</span>
                <a href="<%= request.getContextPath() %>/Logout">Logout</a>
                <%
                    }
                %>
            </div>
        </div>
        <!-- header chính -->
        <nav class="Bottom-nav">
            <div class="logo"><img src="<%= request.getContextPath() %>/IMG/logo.png" alt=""></div>

            <ul class="header_tag-list">
                <li class="tag-name"><a href="#">CÁ</a></li>
                <li class="tag-name"><a href="#">TÔM</a></li>
                <li class="tag-name"><a href="#">CUA</a></li>
                <li class="tag-name"><a href="#">MỰC</a></li>
                <li class="tag-name"><a href="#">ỐC</a></li>
                <li class="tag-name tag-name-other"><a href="#">KHÁC</a>
                    <ul class="other">
                        <ul class="other-list">
                            <li class="other-list-header"><a href="#">mực khô</a></li>
                            <li class="other-list-text"><a href="#">mực khô</a></li>
                            <li class="other-list-text"><a href="#">mực 1 nắng</a></li>
                            <li class="other-list-text"><a href="#">mực 2 nắng</a></li>
                        </ul>
                        <ul class="other-list">
                            <li class="other-list-header"><a href="#"> chả cá </a></li>
                            <li class="other-list-text"><a href="#">chả cá thát lát </a></li>
                            <li class="other-list-text"><a href="#">chả cá rô phi </a></li>
                        </ul>
                    </ul>

                </li>

            </ul>
            <ul class="header_icon-list">
                <li class="shopping-icon"><a href="<%= request.getContextPath() %>/JSP/cart.jsp"><i
                        class="fa-solid fa-cart-shopping"></i></a></li>
                </li>
            </ul>
        </nav>
    </header>
</div>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        let lastScrollTop = 0;
        const topBar = document.querySelector(".top-bar");
        const bottomNav = document.querySelector(".Bottom-nav");
        window.addEventListener("scroll", function () {
            let scrollTop = window.scrollY;
            if (scrollTop > lastScrollTop) {
                topBar.classList.add("hidden");
                bottomNav.classList.add("fixed-top");
            } else {
                topBar.classList.remove("hidden");
                bottomNav.classList.remove("fixed-top");
            }
            lastScrollTop = scrollTop;
        });
    });
</script>
</body>
</html>
