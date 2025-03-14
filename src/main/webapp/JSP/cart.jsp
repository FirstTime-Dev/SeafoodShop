<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/JS/cart.js">
    <title>Cart</title>
</head>
<body>
<div class="container">
    <h1>Your cart</h1>
    <div class="product-container">
        <button id="delete-button" formaction="delete">X</button>
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
            </div>
        </div>
    </div>
</div>
</body>
</html>
