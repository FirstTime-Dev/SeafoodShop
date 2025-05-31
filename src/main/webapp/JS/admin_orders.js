document.addEventListener("DOMContentLoaded", function () {
    // Mở popup và hiển thị chi tiết đơn hàng
    document.querySelectorAll(".order-detail-link").forEach(link => {
        link.addEventListener("click", function (e) {
            e.preventDefault();
            const orderID = this.getAttribute("data-id");

            fetch(`/SeafoodShop_war_exploded/AdminOrder?orderID=${encodeURIComponent(orderID)}`)
                .then(response => response.json())
                .then(data => {
                    console.log("Dữ liệu nhận từ server:", data);
                    // Đổ dữ liệu vào popup
                    document.getElementById("popupOrderID").textContent = data.orderID;
                    document.getElementById("popupProductName").textContent = data.productName;
                    document.getElementById("popupQuantity").textContent = data.quantity;
                    document.getElementById("popupPrice").textContent = data.price;
                    document.getElementById("popupTotal").textContent = data.total;
                    document.getElementById("popupOrderDate").textContent = data.orderDate;
                    document.getElementById("popupFullName").textContent = data.fullName;
                    document.getElementById("popupPhoneNumber").textContent = data.phoneNumber;
                    document.getElementById("popupEmail").textContent = data.email;
                    document.getElementById("popupAddress").textContent = data.address;
                    renderStatus(data.status);
                    // Hiện popup
                    document.getElementById("orderDetailPopup").style.display = "block";
                });
        });
    });

    // Đóng popup khi nhấn nút X
    document.getElementById("closeOrderDetailPopup").addEventListener("click", function () {
        document.getElementById("orderDetailPopup").style.display = "none";
    });

    // Đóng popup khi nhấn ra ngoài phần nội dung popup
    window.addEventListener("click", function (event) {
        const popup = document.getElementById("orderDetailPopup");
        if (event.target === popup) {
            popup.style.display = "none";
        }
    });

    // Xác nhận đơn hàng
    document.querySelectorAll(".confirm-btn").forEach(btn => {
        btn.addEventListener("click", function () {
            const orderId = this.dataset.id;
            fetch("/SeafoodShop_war_exploded/AdminOrder", {
                method: "POST",
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: `orderId=${orderId}&action=confirm`
            }).then(res => res.json())
                .then(data => {
                    if (data.success) location.reload(); else alert("Xác nhận thất bại!"); // reload để cập nhật trạng thái
                });
        });
    });

    //Hủy đơn hàng
    document.querySelectorAll(".cancel-btn").forEach(btn => {
        btn.addEventListener("click", () => {
            const orderId = btn.dataset.id;
            fetch("/SeafoodShop_war_exploded/AdminOrder", {
                method: "POST",
                headers: {"Content-Type": "application/x-www-form-urlencoded"},
                body: `orderId=${orderId}&action=cancel`
            }).then(res => res.json())
                .then(data => {
                    if (data.success) location.reload(); else alert("Hủy đơn thất bại!");
                });
        });
    });

    // Hiện thị trạng thái status trong popup orderDetail
    function renderStatus(orderDetailsStatus) {
        const statusMap = {
            1: "Đang chờ duyệt",
            2: "Đã duyệt",
            3: "Đã từ chối"
        };

        const statusText = statusMap[orderDetailsStatus] || "Không xác định";
        document.getElementById("popupStatus").textContent = `${statusText}`;
    }

});
