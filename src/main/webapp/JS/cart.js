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

    $(".quantity-input").on("input", function () {
        const newQuantity = $(this).val();

        const productItem = $(this).closest(".product-item");
        const hiddenInput = productItem.find("input[type=hidden]").first();

        const currentValue = hiddenInput.val();
        const parts = currentValue.split(",");

        const cartId = parts[0];
        const newState = "change";

        hiddenInput.val(`${cartId},${newQuantity},${newState}`);
    });

    $(".save-btn").click(function () {
        sendDeletedItems();
        sendUpdatedItems();
        location.reload();
    });

    // Gửi dữ liệu xóa
    function sendDeletedItems() {
        if (deletedCartIds.length === 0) return;

        $.ajax({
            url: contextPath + "/removeFromCart",
            method: "POST",
            data: {
                deletedIds: JSON.stringify(deletedCartIds)
            },
            success: function () {
                console.log("Xóa sản phẩm thành công.");
            },
            error: function () {
                alert("Lỗi khi xóa sản phẩm.");
            }
        });
    }

    // Gửi dữ liệu cập nhật
    function sendUpdatedItems() {
        const updatedItems = [];

        $(".hidden-info").each(function () {
            const value = $(this).val();
            const parts = value.split(",");
            if (parts[2] === "change") {
                updatedItems.push(value);
            }
        });

        if (updatedItems.length === 0) return;

        $.ajax({
            url: contextPath + "/editCart",
            method: "POST",
            contentType: "application/json",
            data: JSON.stringify({ cartItems: updatedItems }),
            success: function () {
                console.log("Cập nhật giỏ hàng thành công.");
            },
            error: function () {
                alert("Lỗi khi cập nhật giỏ hàng.");
            }
        });
    }
});

