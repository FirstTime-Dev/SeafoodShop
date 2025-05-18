<%@ page import="SeafoodShop.model.Product" %>
<%@ page import="java.math.BigDecimal" %><%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 23/03/2025
  Time: 5:38 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="../CSS/productDetail.css">
</head>
<body>
<div class="breadcrumb">
    <div class="container">
        <ul>
            <li><a href="<%= request.getContextPath() %>JSP/home.jsp">Trang chủ</a></li>
            <li><a href="<%= request.getContextPath() %>JSP/cart.jsp">sản phẩm </a></li>
            <li><a href="<%= request.getContextPath() %>JSP/cart.jsp">đơn hàng </a></li>
        </ul>
    </div>
</div>
<div class="product-container">
    <div class="product-image">
        <img src="img/tải xuống.jpg" alt="Nghêu Sống" />
    </div>

    <div class="product-details">
        <h1>Nghêu Sân - Sống</h1>

<%--        <div class="product-info">--%>
<%--            <p><strong>Xuất xứ:</strong> Phan Thiết, Việt Nam</p>--%>
<%--            <p><strong>Khối lượng:</strong> 10 - 20 con/kg</p>--%>
<%--            <p><span class="highlight">Giao nhanh 2H</span></p>--%>
<%--        </div>--%>

<%--        <div class="price">249,000đ</div>--%>

<%--        <div class="options">--%>
<%--            <label><input type="radio" name="weight" checked> 1 kg</label>--%>
<%--            <label><input type="radio" name="weight"> 0.5 kg</label>--%>
<%--        </div>--%>

<%--        <div class="quantity">--%>
<%--            <label for="qty">Số lượng:</label>--%>
<%--            <input type="number" id="qty" value="1" min="1">--%>
<%--        </div>--%>

<%--        <div class="buttons">--%>
<%--            <button class="btn add-cart">THÊM VÀO GIỎ</button>--%>
<%--            <button class="btn buy-now">MUA NGAY</button>--%>
<%--        </div>--%>
    </div>
    <%
        Product pr = (Product) request.getAttribute("product");
        BigDecimal productPrice = pr.getPrice();
        String productOrigin = pr.getOrigin();
        int productQuantity = pr.getStockQuantity();
        BigDecimal productWeight = pr.getWeight();
    %>
    <h1>Nghêu Sân - Sống</h1>

    <div class="product-info">
        <p><strong>Xuất xứ:</strong><%=productOrigin%>></p>
        <p><strong>Khối lượng:</strong><%=productWeight%>kg</p>
        <p><span class="highlight">Giao nhanh 2H</span></p>
    </div>

    <div class="price"><%=productPrice%>đ</div>

    <div class="options">
        <label><input type="radio" name="weight" checked> 1 kg</label>
        <label><input type="radio" name="weight"> 0.5 kg</label>
    </div>

    <div class="quantity">
        <label for="qty">Số lượng: <%=productQuantity%></label>
        <input type="number" id="qty" value="1" min="1">
    </div>

    <div class="buttons">
        <button class="btn add-cart">THÊM VÀO GIỎ</button>
        <button class="btn buy-now">MUA NGAY</button>
    </div>

</div>
<div class="review-selection">
    <div class="productReview">
        <h3>Đánh giá sản phẩm</h3>

        <div class="star-rating" id="user-rating">
            <i class="fa-solid fa-star" data-value="5"></i>
            <i class="fa-solid fa-star" data-value="4"></i>
            <i class="fa-solid fa-star" data-value="3"></i>
            <i class="fa-solid fa-star" data-value="2"></i>
            <i class="fa-solid fa-star" data-value="1"></i>
        </div>
        <input type="hidden" id="rating-value" value="0">


        <div class="review-wrapper">
            <!-- Bình luận -->
            <div class="cmt">
                <h3>Bình luận</h3>
                <div class="input-wrap">
                    <input type="text" id="comment-input" style="margin-left:20px ;" placeholder="Nhập bình luận...">
                    <div class="sent" id="send-btn">
                        <i class="fa-solid fa-paper-plane"></i>
                    </div>
                    <span class="underline"></span>
                </div>
                <div class="comment-list">
                    <div class="comment-item">
                        <div class="comment-header">
                            <strong>Nguyễn Văn A</strong> -
                            <span class="stars">
              <i class="fa-solid fa-star" style="color:gold;"></i>
              <i class="fa-solid fa-star" style="color:gold;"></i>
              <i class="fa-solid fa-star" style="color:gold;"></i>
              <i class="fa-solid fa-star" style="color:gold;"></i>
              <i class="fa-solid fa-star" style="color:gold;"></i>
            </span>
                        </div>
                        <p class="comment-content">Nghêu rất tươi, giao hàng nhanh đúng như quảng cáo. Lần sau sẽ ủng hộ tiếp!</p>
                    </div>
                    <div class="comment-item">
                        <div class="comment-header">
                            <strong>Nguyễn Văn A</strong> -
                            <span class="stars">
              <i class="fa-solid fa-star" style="color:gold;"></i>
              <i class="fa-solid fa-star" style="color:gold;"></i>
              <i class="fa-solid fa-star" style="color:gold;"></i>
              <i class="fa-solid fa-star" style="color:gold;"></i>
              <i class="fa-solid fa-star" style="color:gold;"></i>
            </span>
                        </div>
                        <p class="comment-content">Nghêu rất tươi, giao hàng nhanh đúng như quảng cáo. Lần sau sẽ ủng hộ tiếp!</p>
                    </div>
                    <div class="comment-item">
                        <div class="comment-header">
                            <strong>Nguyễn Văn A</strong> -
                            <span class="stars">
              <i class="fa-solid fa-star" style="color:gold;"></i>
              <i class="fa-solid fa-star" style="color:gold;"></i>
              <i class="fa-solid fa-star" style="color:gold;"></i>
              <i class="fa-solid fa-star" style="color:gold;"></i>
              <i class="fa-solid fa-star" style="color:gold;"></i>
            </span>
                        </div>
                        <p class="comment-content">Nghêu rất tươi, giao hàng nhanh đúng như quảng cáo. Lần sau sẽ ủng hộ tiếp!</p>
                    </div>
                    <div class="comment-item">
                        <div class="comment-header">
                            <strong>Nguyễn Văn A</strong> -
                            <span class="stars">
              <i class="fa-solid fa-star" style="color:gold;"></i>
              <i class="fa-solid fa-star" style="color:gold;"></i>
              <i class="fa-solid fa-star" style="color:gold;"></i>
              <i class="fa-solid fa-star" style="color:gold;"></i>
              <i class="fa-solid fa-star" style="color:gold;"></i>
            </span>
                        </div>
                        <p class="comment-content">Nghêu rất tươi, giao hàng nhanh đúng như quảng cáo. Lần sau sẽ ủng hộ tiếp!</p>
                    </div>
                    <div class="comment-item">
                        <div class="comment-header">
                            <strong>Nguyễn Văn A</strong> -
                            <span class="stars">
              <i class="fa-solid fa-star" style="color:gold;"></i>
              <i class="fa-solid fa-star" style="color:gold;"></i>
              <i class="fa-solid fa-star" style="color:gold;"></i>
              <i class="fa-solid fa-star" style="color:gold;"></i>
              <i class="fa-solid fa-star" style="color:gold;"></i>
            </span>
                        </div>
                        <p class="comment-content">Nghêu rất tươi, giao hàng nhanh đúng như quảng cáo. Lần sau sẽ ủng hộ tiếp!</p>
                    </div>
                    <div class="comment-item">
                        <div class="comment-header">
                            <strong>Nguyễn Văn A</strong> -
                            <span class="stars">
              <i class="fa-solid fa-star" style="color:gold;"></i>
              <i class="fa-solid fa-star" style="color:gold;"></i>
              <i class="fa-solid fa-star" style="color:gold;"></i>
              <i class="fa-solid fa-star" style="color:gold;"></i>
              <i class="fa-solid fa-star" style="color:gold;"></i>
            </span>
                        </div>
                        <p class="comment-content">Nghêu rất tươi, giao hàng nhanh đúng như quảng cáo. Lần sau sẽ ủng hộ tiếp!</p>
                    </div>
                    <div class="comment-item">
                        <div class="comment-header">
                            <strong>Nguyễn Văn A</strong> -
                            <span class="stars">
              <i class="fa-solid fa-star" style="color:gold;"></i>
              <i class="fa-solid fa-star" style="color:gold;"></i>
              <i class="fa-solid fa-star" style="color:gold;"></i>
              <i class="fa-solid fa-star" style="color:gold;"></i>
              <i class="fa-solid fa-star" style="color:gold;"></i>
            </span>
                        </div>
                        <p class="comment-content">Nghêu rất tươi, giao hàng nhanh đúng như quảng cáo. Lần sau sẽ ủng hộ tiếp!</p>
                    </div>
                    <div class="comment-item">
                        <div class="comment-header">
                            <strong>Nguyễn Văn A</strong> -
                            <span class="stars">
              <i class="fa-solid fa-star" style="color:gold;"></i>
              <i class="fa-solid fa-star" style="color:gold;"></i>
              <i class="fa-solid fa-star" style="color:gold;"></i>
              <i class="fa-solid fa-star" style="color:gold;"></i>
              <i class="fa-solid fa-star" style="color:gold;"></i>
            </span>
                        </div>
                        <p class="comment-content">Nghêu rất tươi, giao hàng nhanh đúng như quảng cáo. Lần sau sẽ ủng hộ tiếp!</p>
                    </div>
                    <div class="comment-item">
                        <div class="comment-header">
                            <strong>Nguyễn Văn A</strong> -
                            <span class="stars">
              <i class="fa-solid fa-star" style="color:gold;"></i>
              <i class="fa-solid fa-star" style="color:gold;"></i>
              <i class="fa-solid fa-star" style="color:gold;"></i>
              <i class="fa-solid fa-star" style="color:gold;"></i>
              <i class="fa-solid fa-star" style="color:gold;"></i>
            </span>
                        </div>
                        <p class="comment-content">Nghêu rất tươi, giao hàng nhanh đúng như quảng cáo. Lần sau sẽ ủng hộ tiếp!</p>
                    </div>
                    <div class="comment-item">
                        <div class="comment-header">
                            <strong>Nguyễn Văn A</strong> -
                            <span class="stars">
              <i class="fa-solid fa-star" style="color:gold;"></i>
              <i class="fa-solid fa-star" style="color:gold;"></i>
              <i class="fa-solid fa-star" style="color:gold;"></i>
              <i class="fa-solid fa-star" style="color:gold;"></i>
              <i class="fa-solid fa-star" style="color:gold;"></i>
            </span>
                        </div>
                        <p class="comment-content">Nghêu rất tươi, giao hàng nhanh đúng như quảng cáo. Lần sau sẽ ủng hộ tiếp!</p>
                    </div>
                    <div class="comment-item">
                        <div class="comment-header">
                            <strong>Nguyễn Văn A</strong> -
                            <span class="stars">
              <i class="fa-solid fa-star" style="color:gold;"></i>
              <i class="fa-solid fa-star" style="color:gold;"></i>
              <i class="fa-solid fa-star" style="color:gold;"></i>
              <i class="fa-solid fa-star" style="color:gold;"></i>
              <i class="fa-solid fa-star" style="color:gold;"></i>
            </span>
                        </div>
                        <p class="comment-content">Nghêu rất tươi, giao hàng nhanh đúng như quảng cáo. Lần sau sẽ ủng hộ tiếp!</p>
                    </div>
                    <div class="comment-item">
                        <div class="comment-header">
                            <strong>Nguyễn Văn A</strong> -
                            <span class="stars">
              <i class="fa-solid fa-star" style="color:gold;"></i>
              <i class="fa-solid fa-star" style="color:gold;"></i>
              <i class="fa-solid fa-star" style="color:gold;"></i>
              <i class="fa-solid fa-star" style="color:gold;"></i>
              <i class="fa-solid fa-star" style="color:gold;"></i>
            </span>
                        </div>
                        <p class="comment-content">Nghêu rất tươi, giao hàng nhanh đúng như quảng cáo. Lần sau sẽ ủng hộ tiếp!</p>
                    </div>


                    <button id="toggle-comments">Xem thêm bình luận</button>
                </div>

            </div>
        </div>
        <!-- Sản phẩm đề cử -->

    </div>
    <div class="recommend">
        <h3>Sản phẩm đề cử</h3>
        <div class="rec-item">
            <img src="img/tải xuống.jpg" alt="Sò Lụa" />
            <p class="rec-title">Sò Lụa Sống</p>
            <p class="rec-price">199,000đ</p>
        </div>
        <div class="rec-item">
            <img src="img/tải xuống.jpg" alt="Hàu Sữa" />
            <p class="rec-title">Hàu Sữa Tươi</p>
            <p class="rec-price">179,000đ</p>
        </div>
        <div class="rec-item">
            <img src="img/tải xuống.jpg" alt="Hàu Sữa" />
            <p class="rec-title">Hàu Sữa Tươi</p>
            <p class="rec-price">179,000đ</p>
        </div>
        <div class="rec-item">
            <img src="img/tải xuống.jpg" alt="Hàu Sữa" />
            <p class="rec-title">Hàu Sữa Tươi</p>
            <p class="rec-price">179,000đ</p>
        </div>
    </div>
</div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        const toggleBtn = document.getElementById("toggle-comments");
        const comments = document.querySelectorAll(".comment-item");

        const visibleCount = 2;
        let expanded = false;
        function updateComments() {
            comments.forEach((comment, index) => {
                if (index < visibleCount || expanded) {
                    comment.style.display = "block";
                } else {
                    comment.style.display = "none";
                }
            });
            toggleBtn.textContent = expanded ? "Ẩn bớt" : "Xem thêm bình luận";
        }

        toggleBtn.addEventListener("click", () => {
            expanded = !expanded;
            updateComments();
        });

        updateComments(); // initial state
    });

</script>
<script>
    const stars = document.querySelectorAll('#user-rating .fa-solid');
    const ratingValue = document.getElementById('rating-value');

    stars.forEach((star) => {
        star.addEventListener('click', () => {
            const value = star.getAttribute('data-value');
            ratingValue.value = value;
            stars.forEach(s => {
                s.style.color = (s.getAttribute('data-value') <= value) ? 'gold' : '#ccc';
            });
        });
    });
</script>

</body>
</html>
