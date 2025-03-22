const orders = [
    { id: 1, product: "Fresh seafood", total: 300000, status: "processing" },
    { id: 2, product: "Alaskan Lobster", total: 1200000, status: "shipping" },
    { id: 3, product: "Imported Salmon", total: 500000, status: "completed" },
    { id: 4, product: "Japanese Scallops", total: 700000, status: "cancelled" },
    { id: 5, product: "King Crab", total: 1500000, status: "processing" }
];

const statusText = {
    "processing": "Processing",
    "shipping": "Shipping",
    "completed": "Completed",
    "cancelled": "Cancelled"
};

function renderOrders(filter) {
    const orderList = document.getElementById("orderList");
    orderList.innerHTML = "";

    const filteredOrders = filter === "all" ? orders : orders.filter(order => order.status === filter);

    if (filteredOrders.length === 0) {
        orderList.innerHTML = "<p>No orders available.</p>";
        return;
    }

    filteredOrders.forEach(order => {
        const li = document.createElement("li");
        li.classList.add("order-item");
        li.innerHTML = `
            <p><strong>Order ID:</strong> #${order.id}</p>
            <p><strong>Product:</strong> ${order.product}</p>
            <p><strong>Total Price:</strong> ${order.total.toLocaleString()} VND</p>
            <p class="order-status"><strong>Status:</strong> ${statusText[order.status]}</p>
        `;
        orderList.appendChild(li);
    });
}

function filterOrders(status) {
    document.querySelectorAll(".tab").forEach(tab => tab.classList.remove("active"));

    // Lấy tab tương ứng mà không bị lỗi querySelector
    document.querySelector(`.tab[data-status="${status}"]`).classList.add("active");

    renderOrders(status);
}

// Show all orders on page load
document.addEventListener("DOMContentLoaded", () => {
    renderOrders("all");
});
