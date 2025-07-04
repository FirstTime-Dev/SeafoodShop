<%@ page import="SeafoodShop.dao.DataConnect" %>
<%@ page import="SeafoodShop.model.Cart" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/CSS/cart.css">
    <link rel="stylesheet"  href="<%=request.getContextPath() %>/CSS/breadcrumb.css">
    <script src="https://code.jquery.com/jquery-1.12.4.min.js"
            integrity="sha256-ZosEbRLbNQzLpnKIkEdrPv7lOy9C27hHQ+Xp8a4MxAQ=" crossorigin="anonymous"></script>
    <script>
        window.contextPath = "<%= request.getContextPath() %>";
    </script>
    <script src="<%= request.getContextPath() %>/JS/cart.js"></script>
    <title>Cart</title>
</head>
<body>

<jsp:include page="header.jsp" />

<div class="breadcrumb">
    <div class="breadcrumb-container">
        <ul>
            <li><a href="<%= request.getContextPath() %>JSP/home.jsp">Trang chủ</a></li>
            <li><a href="<%= request.getContextPath() %>JSP/home.jsp">Thanh toán</a></li>
        </ul>
    </div>
</div>
<div class="container">
    <h1>Your Cart</h1>
    <div class="cart-content">
        <div class="products-section">
            <% DataConnect dc = new DataConnect();
                BigDecimal totalPrice = new BigDecimal("0.0");
                for(Cart c : dc.getCartList((int) session.getAttribute("user_id"))){
                    String productImgUrl = c.getProductImageURL();
                    String productName = c.getProductName();
                    BigDecimal productPrice = c.getProductPrice();
                    totalPrice = totalPrice.add(productPrice);
                    int cartId = c.getCartId();
                    int quantity = c.getQuantity();
            %>
            <div class="product-item">
                <div class="product-select">
                    <input type="checkbox" class="choose-button" >
                </div>
                <div class="product-info">
                    <img src="<%=request.getContextPath()%>/<%=productImgUrl%>" class="product-image">
                    <div class="product-details">
                        <h3 class="product-name"><%=productName%></h3>
                        <p class="product-price"><%=productPrice%>₫</p>
                        <div class="quantity-control">
                            <input type="hidden" value="<%=cartId%>,<%=quantity%>,state" class="hidden-info" >
                            <input type="number" class="quantity-input" value="<%=quantity%>" min="1">
                        </div>
                    </div>
                </div>
                <input type="hidden" class="cart-id" value="<%=cartId%>">
                <button class="delete-btn">×</button>
            </div>

            <%
                }
            %>
            <div class="save"><button class="save-btn">lưu</button></div>
        </div>

        <div class="order-summary">
            <h2>Order Summary</h2>
            <div class="summary-container"></div>

            <div class="summary-row total">
                <strong>Total</strong>
                <strong class="summary-total-amount">0₫</strong>
            </div>

            <form action="<%= request.getContextPath() %>/Payment" method="post">
                <button type="submit" class="checkout-btn">Proceed to Checkout</button>
            </form>
        </div>
    </div>
</div>
<jsp:include page="footer.jsp" />
</body>
</html>
