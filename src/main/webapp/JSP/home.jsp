<%@ page import="SeafoodShop.dao.DataConnect" %>
<%@ page import="SeafoodShop.model.Product" %>
<%@ page import="java.math.BigDecimal" %>
<%@  page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <script src="<%= request.getContextPath() %>/JS/home.js"></script>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hải Sản Tươi Sống - Chất Lượng Từ Đại Dương</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/CSS/home.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/CSS/breadcrumb.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.css"
          integrity="sha512-UTNP5BXLIptsaj5WdKFrkFov94lDx+eBvbKyoe1YAfjeRPC+gT5kyZ10kOHCfNZqEui1sxmqvodNUx3KbuYI/A=="
          crossorigin="anonymous" referrerpolicy="no-referrer" />
    <script src="https://code.jquery.com/jquery-1.12.4.min.js"
            integrity="sha256-ZosEbRLbNQzLpnKIkEdrPv7lOy9C27hHQ+Xp8a4MxAQ=" crossorigin="anonymous"></script>
</head>
<body>

<jsp:include page="header.jsp"/>

<div class="breadcrumb">
    <div class="container">
        <ul>
            <li><a href="<%= request.getContextPath() %>JSP/home.jsp">Trang chủ</a></li>
        </ul>
    </div>
</div>

<div class="home-slide-show">
    <div class="owl-carousel owl-theme">
        <div class="item">
            <img src="<%= request.getContextPath() %>/IMG/homepageBackground.jpg"  alt="">
        </div>
        <div class="item">
            <img src="<%= request.getContextPath() %>/IMG/homepageBackground.jpg" alt="">
        </div>
        <div class="item">
            <img src="<%= request.getContextPath() %>/IMG/homepageBackground.jpg" alt="">

        </div>
        <div class="item">
            <img src="<%= request.getContextPath() %>/IMG/homepageBackground.jpg" alt="">
        </div>
        <div class="item">
            <img src="<%= request.getContextPath() %>/IMG/homepageBackground.jpg" alt="">
        </div>
    </div>
</div>
<div id="products"  class="products">
    <div class="products_main">

        <%DataConnect dao = new DataConnect();
        for(Product pr : dao.getProductList()){
            String productName= pr.getName();
            BigDecimal productPrice = pr.getPrice();%>
        <div class="products1">
            <div class="products_img">
                <img src="" alt="">
            </div>
            <div class="products_name">
                <h3><%=productName%>></h3>
                <p><%=productPrice%>đ/1kg</p>
            </div>
            <div class="products_buttons">
                <form action="<%= request.getContextPath() %>/addToCart" method="post">
                    <input type="hidden" id="product_id" name="product_id" value="<%=pr.getProductID()%>">
                    <button type="submit" class="add_to_cart" id="addToCartBtn">Thêm vào giỏ hàng</button>
                </form>
                <button class="buy-now" >mua ngay</button>
            </div>
        </div>
        <%
        }
        %>

    </div>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js"
        integrity="sha512-bPs7Ae6pVvhOSiIcyUClR7/q2OAsRiovw4vAkX+zJbw3ShAeeqezq50RIIcIURq7Oa20rW2n2q+fyXBNcU9lrw=="
        crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script>
    $('.owl-carousel').owlCarousel({
        loop: true,
        margin: 0,
        nav: true,
        autoplay: true,
        autoplayTimeout: 1500,
        autoplayHoverPause: true,
        nav: false,
        responsive: {
            0: {
                items: 1
            },
            800: {
                items: 1
            },
            1000: {
                items: 1
            }
        }
    })

</script>

<jsp:include page="footer.jsp"/>

</body>
</html>


