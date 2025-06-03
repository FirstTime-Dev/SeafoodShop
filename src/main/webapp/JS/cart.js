function changeQuantity(amount) {
    let input = document.getElementById("quantity");
    let value = parseInt(input.value) || 1;
    value += amount;
    if(value<1) value = 1;
    input.value = value;
}

//
//     document.addEventListener("DOMContentLoaded", function () {
//     const checkboxes = document.querySelectorAll(".choose-button");
//     const summaryContainer = document.querySelector(".summary-container");
//
//     checkboxes.forEach((checkbox, index) => {
//     checkbox.addEventListener("change", function () {
//     const productContainer = this.closest(".product-container");
//     const name = productContainer.querySelector(".product-name").textContent.trim();
//     const price = productContainer.querySelector(".product-price").textContent.trim();
//     const summaryId = `dynamic-summary-${index}`;
//
//     if (this.checked) {
//     if (!document.getElementById(summaryId)) {
//     const summaryItem = document.createElement("div");
//     summaryItem.className = "summary-item";
//     summaryItem.id = summaryId;
//     summaryItem.innerHTML = `
//                         <span>${name}</span>
//                         <span>Quantity: 1</span>
//                         <span>Price: ${price}</span>
//                     `;
//     summaryContainer.appendChild(summaryItem);
// }
// } else {
//     const itemToRemove = document.getElementById(summaryId);
//     if (itemToRemove) {
//     summaryContainer.removeChild(itemToRemove);
// }
// }
// });
// });
// });

document.addEventListener("DOMContentLoaded", function () {
    const checkboxes = document.querySelectorAll(".choose-button");
    const summaryContainer = document.querySelector(".summary-container");

    checkboxes.forEach((checkbox, index) => {
        checkbox.addEventListener("change", function () {
            const productContainer = this.closest(".product-item");
            const name = productContainer.querySelector(".product-name").textContent.trim();
            const price = productContainer.querySelector(".product-price").textContent.trim();
            const summaryId = `dynamic-summary-${index}`;

            if (this.checked) {
                if (!document.getElementById(summaryId)) {
                    const summaryItem = document.createElement("div");
                    summaryItem.className = "summary-item";
                    summaryItem.id = summaryId;
                    summaryItem.innerHTML = `
                        <span>${name}</span>
                        <span>Quantity: 1</span>
                        <span>Price: ${price}</span>
                    `;
                    summaryContainer.appendChild(summaryItem);
                }
            } else {
                const itemToRemove = document.getElementById(summaryId);
                if (itemToRemove) {
                    summaryContainer.removeChild(itemToRemove);
                }
            }
        });
    });

    let deletedCartIds = [];

    $(".delete-btn").click(function () {
        const productItem = $(this).closest(".product-item");
        const cartId = productItem.find(".cart-id").val();

        productItem.hide();

        if (!deletedCartIds.includes(cartId)) {
            deletedCartIds.push(cartId);
        }
    });

    $(".save-btn").click(function () {
        if (deletedCartIds.length === 0) {
            alert("Không có sản phẩm nào để xóa.");
            return;
        }
        const contextPath = window.contextPath;
        $.ajax({
            url: contextPath +"/removeFromCart",
            method: "POST",
            data: {
                deletedIds: JSON.stringify(deletedCartIds)
            },
            success: function () {
                alert("Đã lưu thay đổi giỏ hàng!");
                location.reload();
            },
            error: function () {
                alert("Có lỗi xảy ra khi lưu giỏ hàng.");
            }
        });
    });

});

