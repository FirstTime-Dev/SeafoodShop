<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <script src="<%= request.getContextPath() %>/JS/admin_log.js"></script>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/CSS/admin_log.css">
    <title>Log</title>
</head>
<body>
<div class="container">
    <div class="nav-container">
        <jsp:include page="admin_nav.jsp"/>
    </div>
    <div class="admin-content">
        <h2>Log</h2>
        <div class="log-record-content">
            <div class="level-actions">
                <button class="all-info-btn">Tất cả</button>
                <button class="info-btn">INFO</button>
                <button class="warning-info-btn">WARNING</button>
                <button class="error-info-btn">ERROR</button>
                <button class="critical-info-btn">CRITICAL</button>
            </div>
            <table class="main-content">
                <thead class="table-contetn">
                <tr>
                    <th>Thời gian</th>
                    <th>Người dùng</th>
                    <th>Hành động</th>
                    <th>Tài nguyên</th>
                    <th>Mức độ</th>
                    <th>Chi tiết</th>
                </tr>
                </thead>
                <tbody>
                <tr class="info-content">

                </tr>
                <tr class="table-danger">
                    <td>2025-05-30 10:20</td>
                    <td>user456</td>
                    <td>DELETE</td>
                    <td>Post</td>
                    <td><i class="fas fa-times-circle text-danger me-1"></i> ERROR</td>
                    <td>
                        <button class="btn btn-sm btn-outline-primary" data-bs-toggle="collapse" data-bs-target="#log2">
                            Xem
                        </button>
                    </td>
                </tr>
                <tr>
                    <td colspan="6" class="p-0">
                        <div class="collapse" id="log2">
                            <div class="p-3 bg-light border-top">
                                <strong>Data Before:</strong> {"title":"Bán căn hộ..."}<br>
                                <strong>Data After:</strong> null<br>
                                <strong>IP:</strong> 192.168.1.99 | <strong>Location:</strong> Đà Nẵng
                            </div>
                        </div>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>
</body>
</html>
