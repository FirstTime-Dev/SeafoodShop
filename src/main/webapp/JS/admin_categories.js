document.addEventListener("DOMContentLoaded", function () {
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
});