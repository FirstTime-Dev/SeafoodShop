<%@ page import="SeafoodShop.dao.DataConnect" %>
<%@ page import="SeafoodShop.model.Cart" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/CSS/cart.css">
    <link rel="stylesheet"  href="<%=request.getContextPath() %>/CSS/breadcrumb.css">
    <script src="<%= request.getContextPath() %>/JS/cart.js"></script>
    <title>Cart</title>
</head>
<body>

<jsp:include page="header.jsp" />

<div class="breadcrumb">
    <div class="container">
        <ul>
            <li><a href="<%= request.getContextPath() %>JSP/home.jsp">Trang chủ</a></li>
            <li><a href="<%= request.getContextPath() %>JSP/home.jsp">Thanh toán</a></li>
        </ul>
    </div>
</div>

<div class="container">
    <h1>Your cart</h1>
    <div class="product-container">
            <% DataConnect dc = new DataConnect();
            BigDecimal totalPrice = new BigDecimal("0.0");
                for(Cart c : dc.getCartList((int) session.getAttribute("user_id"))){
                    String productImgUrl = c.getProductImageURL();
                    String productName = c.getProductName();
                    BigDecimal productPrice = c.getProductPrice();
                    totalPrice = totalPrice.add(productPrice);%>
        <button id="delete-button" formaction="delete" type="button">X</button>
        <input class="choose-button" id="choose-button" type="checkbox" >
        <div class="product-info-container">
            <img src="<%=request.getContextPath()%>/<%=productImgUrl%>" id="img-description">
            <div class="product-info-description">
                <label class="product-name"><%=productName%></label>
                <label class="product-price"><%=productPrice%></label>
            </div>
                <%
                }
                %>
            <div class="quantity-container">
                <button class="quantity-button" type="button" onclick="changeQuantity(-1)">-</button>
                <input id="quantity" type="number" class="quantity-button" value="1" min="1">
                <button class="quantity-button" type="button" onclick="changeQuantity(+1)">+</button>
                <label id="total-price">Total price: <%=totalPrice%></label>
            </div>
        </div>

    </div>
    <div class="cart-summary">
        <h2>Order Summary</h2>
        <div class="summary-container">
        </div>
        <div id="grand-total">Grand Total: 1.500.000VNĐ</div>
        <button id="checkout-button"><a href="<%= request.getContextPath() %>/JSP/payment.jsp">Proceed to Checkout</a></button>
    </div>
</div>
<jsp:include page="footer.jsp" />
</body>
<script src="<%= request.getContextPath() %>/JS/cart.js"></script>
</html>
