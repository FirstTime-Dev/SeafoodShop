<%@  page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <script src="<%= request.getContextPath() %>/JS/home.js"></script>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hải Sản Tươi Sống - Chất Lượng Từ Đại Dương</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/CSS/home.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.css"
          integrity="sha512-UTNP5BXLIptsaj5WdKFrkFov94lDx+eBvbKyoe1YAfjeRPC+gT5kyZ10kOHCfNZqEui1sxmqvodNUx3KbuYI/A=="
          crossorigin="anonymous" referrerpolicy="no-referrer" />
    <script src="https://code.jquery.com/jquery-1.12.4.min.js"
            integrity="sha256-ZosEbRLbNQzLpnKIkEdrPv7lOy9C27hHQ+Xp8a4MxAQ=" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/CSS/breadcrumb.css">
</head>
<body>

<jsp:include page="header.jsp"/>

<div class="breadcrumb">
    <div class="container">
        <ul>
            <li><a href="<%= request.getContextPath() %>/home.jsp">Trang chủ</a></li>
        </ul>
    </div>
</div>

<div class="home-slide-show">
    <div class="owl-carousel owl-theme">
        <div class="item">
            <img src="../IMG/homepageBackground.jpg" alt="">
        </div>
        <div class="item">
            <img src="../IMG/homepageBackground.jpg" alt="">

        </div>
        <div class="item">
            <img src="../IMG/homepageBackground.jpg" alt="">

        </div>
        <div class="item">
            <img src="../IMG/homepageBackground.jpg" alt="">

        </div>
        <div class="item">
            <img src="../IMG/homepageBackground.jpg" alt="">

        </div>
    </div>
</div>
<div id="products"  class="products">
    <div class="products_main">
        <div class="products1">
            <div class="products_img">
                <img src="" alt="">
            </div>
            <div class="products_name">
                <h3>Mực</h3>
                <p>300.000đ/1kg</p>
            </div>
            <div class="products_buttons">
                <button class="add_to_cart">Thêm vào giỏ hàng</button>
                <button class="buy-now">mua ngay</button>
            </div>
        </div>
        <div class="products1">
            <div class="products_img">
                <img src="" alt="">
            </div>
            <div class="products_name">
                <h3>Cá thu</h3>
                <p>250.000đ/1kg</p>
            </div>
            <div class="products_buttons">
                <button class="add_to_cart">Thêm vào giỏ hàng</button>
                <button class="buy-now">mua ngay</button>
            </div>
        </div>
        <div class="products1">
            <div class="products_img">
                <img src="Cua hoàng đế" alt="">
            </div>
            <div class="products_name">
                <h3>Ốc</h3>
                <p>200.000đ/1kg</p>
            </div>
            <div class="products_buttons">
                <button class="add_to_cart">Thêm vào giỏ hàng</button>
                <button class="buy-now">mua ngay</button>
            </div>
        </div>
        <div class="products1">
            <div class="products_img">
                <img src="" alt="">
            </div>
            <div class="products_name">
                <h3>cá hồi</h3>
                <p>550.000đ/1kg</p>
            </div>
            <div class="products_buttons">
                <button class="add_to_cart">Thêm vào giỏ hàng</button>
                <button class="buy-now">mua ngay</button>
            </div>
        </div>
        <div class="products1">
            <div class="products_img">
                <img src="" alt="">
            </div>
            <div class="products_name">
                <h3>mực khô</h3>
                <p>750.000đ/1kg</p>
            </div>
            <div class="products_buttons">
                <button class="add_to_cart">Thêm vào giỏ hàng</button>
                <button class="buy-now">mua ngay</button>
            </div>
        </div>
        <div class="products1">
            <div class="products_img">
                <img src="" alt="">
            </div>
            <div class="products_name">
                <h3>Mực một nắng</h3>
                <p>200.000đ/1kg</p>
            </div>
            <div class="products_buttons">
                <button class="add_to_cart">Thêm vào giỏ hàng</button>
                <button class="buy-now">mua ngay</button>
            </div>
        </div>
        <div class="products1">
            <div class="products_img">
                <img src="" alt="">
            </div>
            <div class="products_name">
                <h3>Cá chép</h3>
                <p>200.000đ/1kg</p>
            </div>
            <div class="products_buttons">
                <button class="add_to_cart">Thêm vào giỏ hàng</button>
                <button class="buy-now">mua ngay</button>
            </div>
        </div>
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


