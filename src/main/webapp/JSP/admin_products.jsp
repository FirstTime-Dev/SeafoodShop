<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/CSS/admin_products.css">
    <meta charset="UTF-8">
    <title>Quản lý sản phẩm</title>
</head>
<body>
<div class="container">
    <div class="nav-container">
        <jsp:include page="admin_nav.jsp"/>
    </div>
    <div class="admin-content">
        <h2>Quản lý sản phẩm</h2>
        <table>
            <thead>
            <tr>
                <th>ID</th>
                <th>Tên sản phẩm</th>
                <th>Danh mục</th>
                <th>Giá (VNĐ)</th>
                <th>Tồn kho</th>
                <th>Trạng thái hiển thị</th>
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
                <td><span class="badge instock">Còn hàng</span></td>
                <td><span class="badge visible">Hiển thị</span></td>
                <td>2025-03-30</td>
                <td class="actions">
                    <div class="tooltip">
                        <button class="view">👁️</button>
                        <span class="tooltiptext">Xem chi tiết</span>
                    </div>
                    <div class="tooltip">
                        <button class="edit">✏️</button>
                        <span class="tooltiptext">Chỉnh sửa</span>
                    </div>
                    <div class="tooltip">
                        <button class="delete">🗑️</button>
                        <span class="tooltiptext">Xoá sản phẩm</span>
                    </div>
                </td>
            </tr>

            <tr>
                <td>P002</td>
                <td>Tôm sú Cà Mau</td>
                <td>Hải sản tươi sống</td>
                <td>180,000</td>
                <td><span class="badge outofstock">Hết hàng</span></td>
                <td><span class="badge hidden">Ẩn</span></td>
                <td>2025-02-10</td>
                <td class="actions">
                    <div class="tooltip">
                        <button class="view">👁️</button>
                        <span class="tooltiptext">Xem chi tiết</span>
                    </div>
                    <div class="tooltip">
                        <button class="edit">✏️</button>
                        <span class="tooltiptext">Chỉnh sửa</span>
                    </div>
                    <div class="tooltip">
                        <button class="delete">🗑️</button>
                        <span class="tooltiptext">Xoá sản phẩm</span>
                    </div>
                </td>
            </tr>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>
