<%@ page import="SeafoodShop.model.Product" %>
<%@ page import="SeafoodShop.model.Category" %>
<%@ page import="SeafoodShop.dao.DataConnect" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/CSS/home.css">
</head>
<body>

<jsp:include page="header.jsp"/>

<%
    // Lấy các attribute do servlet SearchProduct gán
    String query = (String) request.getAttribute("searchQuery");
    Integer selectedCatId = (Integer) request.getAttribute("selectedCatId");
    List<Product> results = (List<Product>) request.getAttribute("searchResults");

    // Nếu có selectedCatId, lấy ra CategoryName tương ứng
    String categoryTitle = null;
    if (selectedCatId != null) {
        DataConnect dao = new DataConnect();
        List<Category> cats = dao.getAllCategories();
        for (Category c : cats) {
            if (c.getCategoryID() == selectedCatId.intValue()) {
                categoryTitle = c.getCategoryName();
                break;
            }
        }
    }
%>

<div class="breadcrumb">
    <div class="breadcrumb-container">
        <ul>
            <li><a href="<%= request.getContextPath() %>/JSP/home.jsp">Trang chủ</a></li>
            <li>
                <% if (selectedCatId != null) { %>
                <a href="#">Danh mục: <%= categoryTitle %>
                </a>
                <% } else if (query != null && !query.isEmpty()) { %>
                <a href="#">Kết quả tìm kiếm</a>
                <% } else { %>
                <a href="#">Tất cả sản phẩm</a>
                <% } %>
            </li>
        </ul>
    </div>
</div>

<div class="products">
    <% if (selectedCatId != null) { %>
    <h2 class="category-title">Danh mục: “<%= categoryTitle %>”</h2>
    <% } else if (query != null && !query.isEmpty()) { %>
    <h2 class="category-title">Kết quả tìm kiếm cho: “<%= query %>”</h2>
    <% } else { %>
    <h2 class="category-title">Tất cả sản phẩm</h2>
    <% } %>

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
                <img src="<%= request.getContextPath() %>/<%= imgUrl %>"
                     alt="<%= pr.getName() %>">
                <%
                    }
                %>
            </div>
            <div class="products_name">
                <h3><%= pr.getName() %>
                </h3>
                <p><%= pr.getPrice() %> đ/1kg</p>
            </div>
            <div class="products_buttons">
                <form action="<%= request.getContextPath() %>/addToCart" method="post">
                    <input type="hidden" name="product_id" value="<%= pr.getProductID() %>">
                    <button type="submit" class="add_to_cart">Thêm vào giỏ hàng</button>
                </form>
                <form action="<%= request.getContextPath() %>/Payment" method="get">
                    <input type="hidden" name="product_id" value="<%= pr.getProductID() %>">
                    <button type="submit" class="buy-now">Mua ngay</button>
                </form>

            </div>
        </div>
        <% }
        } else {
        %>
        <p style="text-align:center; width:100%;">Không tìm thấy sản phẩm nào phù hợp.</p>
        <% } %>
    </div>
</div>

<jsp:include page="footer.jsp"/>

</body>
</html>
