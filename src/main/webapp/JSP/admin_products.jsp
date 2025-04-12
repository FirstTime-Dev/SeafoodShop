<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/CSS/admin_products.css">
    <script src="<%= request.getContextPath() %>/JS/admin_products.js"></script>
    <meta charset="UTF-8">
    <title>Quản lý sản phẩm</title>
</head>
<body>
<div class="container">
    <div class="nav-container">
        <jsp:include page="admin_nav.jsp"/>
    </div>
    <div class="admin-content">
        <div class="header-add-container">
            <h2>Quản lý sản phẩm</h2>
            <div class="button-group">
                <button class="import-stock-btn">📦 Nhập kho</button>
                <button class="add-customer-btn">➕ Tạo mới</button>
            </div>
        </div>
        <table>
            <thead>
            <tr>
                <th>ID</th>
                <th>Tên sản phẩm</th>
                <th>Danh mục</th>
                <th>Giá (VNĐ)</th>
                <th>Tồn kho</th>
                <th>Ngày thêm</th>
                <th>Hành động</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>P001</td>
                <td>Cá hồi Na Uy</td>
                <td>Hải sản tươi sống</td>
                <td>250,000</td>
                <td><span class="badge stock" data-stock="49">49</span></td>
                <td>2025-03-30</td>
                <td class="actions">
                    <button class="view" title="Xem chi tiết">👁️</button>
                    <button class="edit" title="Chỉnh sửa">✏️</button>
                    <button class="toggle-visibility" title="Ẩn/Hiện">👁️‍🗨️</button>
                    <button class="delete" title="Xoá sản phẩm">🗑️</button>
                </td>
            </tr>
            <tr>
                <td>P002</td>
                <td>Tôm sú Cà Mau</td>
                <td>Hải sản tươi sống</td>
                <td>180,000</td>
                <td><span class="badge stock" data-stock="0">0</span></td>
                <td>2025-02-10</td>
                <td class="actions">
                    <button class="view" title="Xem chi tiết">👁️</button>
                    <button class="edit" title="Chỉnh sửa">✏️</button>
                    <button class="toggle-visibility" title="Ẩn/Hiện">👁️‍🗨️</button>
                    <button class="delete" title="Xoá sản phẩm">🗑️</button>
                </td>
            </tr>
            <tr>
                <td>P003</td>
                <td>Tôm sú Cà Mau</td>
                <td>Hải sản tươi sống</td>
                <td>180,000</td>
                <td><span class="badge stock" data-stock="50">50</span></td>
                <td>2025-02-10</td>
                <td class="actions">
                    <button class="view" title="Xem chi tiết">👁️</button>
                    <button class="edit" title="Chỉnh sửa">✏️</button>
                    <button class="toggle-visibility" title="Ẩn/Hiện">👁️‍🗨️</button>
                    <button class="delete" title="Xoá sản phẩm">🗑️</button>
                </td>
            </tr>
            </tbody>
        </table>
        <!-- Form popup nhập hàng -->
        <div id="importStockModal" class="modal">
            <div class="modal-content">
                <span class="close-modal">&times;</span>
                <h3>Nhập hàng</h3>
                <form>
                    <label for="productName">Tên sản phẩm: </label>
                    <input type="text" id="productName" name="productName" required>

                    <label for="category">Danh mục: </label>
                    <input type="text" id="category" name="category" required>

                    <label for="quantity">Số lượng nhập: </label>
                    <input type="number" id="quantity" name="quantity" min="1" step="1" required>

                    <label for="supplier">Nhà cung cấp: </label>
                    <input type="text" id="supplier" name="supplier" required>

                    <label for="cost">Giá: </label>
                    <input type="text" id="cost" name="cost" min="0" required>

                    <button type="submit" class="confirm-import-btn">Xác nhận nhập</button>
                </form>

            </div>
        </div>
    </div>
</div>
</body>
</html>
