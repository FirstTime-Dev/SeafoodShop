document.addEventListener("DOMContentLoaded", function () {
    document.querySelectorAll('.stock').forEach(function (el) {
        const value = el.textContent.trim().toLowerCase();
        const label = el.previousElementSibling?.textContent.trim();
        if (value === "0" || (label && label.includes("Hết"))) {
            el.classList.add('stock-out');
        } else if (label && label.includes("Sắp hết")) {
            el.classList.add('stock-low');
        }
    });
});
