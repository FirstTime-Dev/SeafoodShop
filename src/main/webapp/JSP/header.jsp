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
    <link rel="stylesheet" href="../CSS/header.css">

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


            <div class="contact-auth">
                <span>+1 234 567 890</span>
                <a href="<%= request.getContextPath()%>/JSP/login.jsp">Sign In</a>
                <a href="<%= request.getContextPath()%>/JSP/login.jsp">Register</a>
            </div>
        </div>
        <!-- header chính -->
        <nav class="Bottom-nav">
            <div class="logo">SEA<span>FOOD</span></div>
            <form action="" id="search-bar" class="search-bar">
                <input type="text" id="search-text" placeholder="What are you looking for?" required autocomplete="off">
                <ul id="suggestions" class="suggestions-list"></ul>
                <datalist id="input">
                    <option value="tom">Tôm</option>
                    <option value="cua">Cua</option>
                    <option value="ca">Cá</option>
                    <option value="so">Sò</option>
                    <option value="muc">Mực</option>
                    <option value="ngheu">Nghêu</option>
                    <option value="hau">Hàu</option>
                    <option value="bacha">Bạch tuộc</option>
                </datalist>
                <button id="search-btn"><i class="fa-solid fa-magnifying-glass"></i></button>
            </form>
            <ul class="header_tag-list">
                <li class="tag-name"><a href="#">FISH</a></li>
                <li class="tag-name" ><a href="#">CRAB</a></li>
                <li class="tag-name"><a href="#">TUNA</a></li>
                <li class="tag-name"><a href="#">SALMON</a></li>
                <li class="tag-name"><a href="#">SHRIMP</a></li>
                <li class="tag-name"><a href="#">SQUID</a></li>
                <ul class="header_icon-list">
                    <li class="shopping-icon"><a href="<%= request.getContextPath() %>/JSP/cart.jsp"><i class="fa-solid fa-cart-shopping"></i></a></li>
                    </li>
                </ul>
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
