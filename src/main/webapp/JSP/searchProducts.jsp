<%@ page import="SeafoodShop.model.Product" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/CSS/home.css">
</head>
<body>

<jsp:include page="header.jsp"/>

<%
    String query = (String) request.getAttribute("searchQuery");
    List<Product> results = (List<Product>) request.getAttribute("searchResults");
%>

<div class="breadcrumb">
    <div class="breadcrumb-container">
        <ul>
            <li><a href="<%= request.getContextPath() %>/JSP/home.jsp">Trang chủ</a></li>
            <li><a href="#">Kết quả tìm kiếm</a></li>
        </ul>
    </div>
</div>

<div class="proproducts">
    <h2 class="category-title">Kết quả tìm kiếm cho: “<%= query %>”</h2>
    <div class="products_main">
        <%
            if (results != null && !results.isEmpty()) {
                for (Product pr : results) {
        %>
        <div class="products1">
            <div class="products_img">
                <%
                    String imgUrl = pr.getImgUrl();
                    if (imgUrl == null || imgUrl.isEmpty()) {
                %>
                <img src="<%= request.getContextPath() %>/IMG/default-product.png" alt="No Image">
                <%
                } else {
                %>
                <img src="<%= request.getContextPath() %>/IMG/products/<%= imgUrl %>"
                     alt="<%= pr.getName() %>">
                <%
                    }
                %>
            </div>
            <div class="products_name">
                <h3><%= pr.getName() %></h3>
                <p><%= pr.getPrice() %> đ/1kg</p>
            </div>
            <div class="products_buttons">
                <form action="<%= request.getContextPath() %>/addToCart" method="post">
                    <input type="hidden" name="product_id" value="<%= pr.getProductID() %>">
                    <button type="submit" class="add_to_cart">Thêm vào giỏ hàng</button>
                </form>
                <button class="buy-now">Mua ngay</button>
            </div>
        </div>
        <%   }
        } else {
        %>
        <p style="text-align:center; width:100%;">Không tìm thấy sản phẩm nào phù hợp.</p>
        <% } %>
    </div>
</div>

<jsp:include page="footer.jsp"/>

</body>
</html>
