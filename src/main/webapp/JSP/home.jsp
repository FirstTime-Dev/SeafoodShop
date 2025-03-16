<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <script src="<%= request.getContextPath() %>/JS/home.js"></script>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hải Sản Tươi Sống - Chất Lượng Từ Đại Dương</title>
    <link rel="stylesheet" href="../CSS/home.css">
</head>
<body>
<!-- Phần giới thiệu đầu trang -->
<section class="intro-section">
    <div class="intro-content">
        <h1 class="title">Hải Sản Tươi Ngon - Đậm Vị Đại Dương</h1>
        <p>Chúng tôi cung cấp hải sản tươi mới nhất mỗi ngày</p>
    </div>
</section>

<div class="hotProducts">
    <p>Hải sản tươi mới trong ngày</p>
</div>

<section class="product-section">
    <div class="product-content">
        <div class="img-wrapper">
            <img src="../IMG/tunaFish.png" alt="">
        </div>
        <p class="description">Cá ngừ nguyên con loại 30kg/con</p>
        <p style="margin-top: -5px">190,000đ/Kg</p>
    </div>
    <div class="product-content">
        <div class="img-wrapper">
            <img src="../IMG/shrimpSu.png" alt="">
        </div>
        <p class="description">Tôm Sú tươi sống</p>
        <p style="margin-top: -5px">450,000đ/Kg</p>
    </div>
    <div class="product-content">
        <div class="img-wrapper">
            <img src="../IMG/mucOng.png" alt="">
        </div>
        <p class="description">mực ống 1Kg (12 con)</p>
        <p style="margin-top: -5px">280,000đ/Kg</p>
    </div>
</section>

</body>
</html>


