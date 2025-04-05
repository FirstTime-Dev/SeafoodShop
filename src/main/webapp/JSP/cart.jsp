<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/CSS/cart.css">
    <script src="<%= request.getContextPath() %>/JS/cart.js"></script>
    <title>Cart</title>
</head>
<body>

<jsp:include page="header.jsp" />

<div class="container">
    <h1>Your cart</h1>
    <div class="product-container">
        <button id="delete-button" formaction="delete">X</button>
        <input id="choose-butotn" type="checkbox" >
        <div class="product-info-container">
            <img src="../IMG/login-background.png" id="img-description">
            <div class="product-info-description">
                <label>product name</label>
                <label>price</label>
            </div>
            <div class="quantity-container">
                <button class="quantity-button" type="button" onclick="changeQuantity(-1)">-</button>
                <input id="quantity" type="number" class="quantity-button" value="1" min="1">
                <button class="quantity-button" type="button" onclick="changeQuantity(+1)">+</button>
                <label id="total-price">Total price: 500.000VNĐ</label>
            </div>
        </div>
    </div>
    <div class="cart-summary">
        <h2>Order Summary</h2>
        <div class="summary-container">
            <div class="summary-item">
                <span>Product 1</span>
                <span>Quantity: 2</span>
                <span>Price: 1.000.000VNĐ</span>
            </div>
            <div class="summary-item">
                <span>Product 2</span>
                <span>Quantity: 1</span>
                <span>Price: 500.000VNĐ</span>
            </div>
            <div class="summary-item">
                <span>Product 1</span>
                <span>Quantity: 2</span>
                <span>Price: 1.000.000VNĐ</span>
            </div>
            <div class="summary-item">
                <span>Product 2</span>
                <span>Quantity: 1</span>
                <span>Price: 500.000VNĐ</span>
            </div><div class="summary-item">
            <span>Product 1</span>
            <span>Quantity: 2</span>
            <span>Price: 1.000.000VNĐ</span>
        </div>
            <div class="summary-item">
                <span>Product 2</span>
                <span>Quantity: 1</span>
                <span>Price: 500.000VNĐ</span>
            </div><div class="summary-item">
            <span>Product 1</span>
            <span>Quantity: 2</span>
            <span>Price: 1.000.000VNĐ</span>
        </div>
            <div class="summary-item">
                <span>Product 2</span>
                <span>Quantity: 1</span>
                <span>Price: 500.000VNĐ</span>
            </div><div class="summary-item">
            <span>Product 1</span>
            <span>Quantity: 2</span>
            <span>Price: 1.000.000VNĐ</span>
        </div>
            <div class="summary-item">
                <span>Product 2</span>
                <span>Quantity: 1</span>
                <span>Price: 500.000VNĐ</span>
            </div><div class="summary-item">
            <span>Product 1</span>
            <span>Quantity: 2</span>
            <span>Price: 1.000.000VNĐ</span>
        </div>
            <div class="summary-item">
                <span>Product 2</span>
                <span>Quantity: 1</span>
                <span>Price: 500.000VNĐ</span>
            </div>
        </div>
        <div id="grand-total">Grand Total: 1.500.000VNĐ</div>
        <button id="checkout-button">Proceed to Checkout</button>
    </div>
</div>
<jsp:include page="footer.jsp" />
</body>
</html>
