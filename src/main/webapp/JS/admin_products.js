document.addEventListener("DOMContentLoaded", function () {
    // 1. Tô màu cho số lượng tồn kho (badge)
    document.querySelectorAll('.stock').forEach(function (span) {
        const stock = parseInt(span.dataset.stock);
        if (!span.textContent.trim()) span.textContent = stock; // đảm bảo có số
        if (stock >= 50) {
            span.classList.add('stock-high');
        } else if (stock >= 10) {
            span.classList.add('stock-medium');
        } else {
            span.classList.add('stock-low');
        }
    });

    // 2. Ẩn-hiện sản phẩm
    const toggleButtons = document.querySelectorAll(".toggle-visibility");
    toggleButtons.forEach(button => {
        button.addEventListener("click", function () {
            const row = this.closest("tr");
            row.classList.toggle("hidden-product");
            if (row.classList.contains("hidden-product")) {
                this.textContent = "🚫";
                this.title = "Hiện sản phẩm";
            } else {
                this.textContent = "👁️‍🗨️";
                this.title = "Ẩn sản phẩm";
            }
        });
    });
    // 3. Nhập kho
    const importBtn = document.querySelector(".import-stock-btn");
    const modal = document.getElementById("importStockModal");
    const closeBtn = document.querySelector(".close-modal");

    importBtn.addEventListener("click", () => {
        modal.style.display = "block";
    });
    closeBtn.addEventListener("click", () => {
        modal.style.display = "none";
    });
    window.addEventListener("click", (e) => {
        if (e.target === modal) {
            modal.style.display = "none";
        }
    });
    // 4. Xử lý nhập giá với VND và phân tách hàng nghìn
    const costInput = document.getElementById("cost");

    costInput.addEventListener("input", function () {
        let value = costInput.value;

        // Loại bỏ tất cả ký tự không phải số và dấu chấm (nhưng không xóa số)
        value = value.replace(/[^0-9.,]/g, ""); // Cho phép dấu phẩy và dấu chấm

        // Nếu có dấu chấm, tách phần nguyên và phần thập phân
        let [integer, decimal] = value.split('.');

        // Định dạng phần nguyên với dấu phẩy phân tách hàng nghìn
        if (integer) {
            integer = integer.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        }

        // Nếu có phần thập phân, nối lại
        if (decimal) {
            value = integer + "." + decimal;
        } else {
            value = integer;
        }

        // Cập nhật lại giá trị trong ô input với ký hiệu VND
        costInput.value = value + " VND";
    });
});

