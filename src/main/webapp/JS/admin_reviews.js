document.addEventListener("DOMContentLoaded", function () {
    const reviews = [
        {
            name: "Nguyễn Văn A",
            date: "03/04/2025",
            content: "Sản phẩm rất tươi, đóng gói cẩn thận, giao hàng nhanh.",
            reply: null
        },
        {
            name: "Trần Thị B",
            date: "02/04/2025",
            content: "Giao hơi chậm nhưng chất lượng ok.",
            reply: "Cảm ơn bạn! Shop sẽ cải thiện tốc độ giao hàng."
        }
    ];

    const container = document.getElementById("review-list");
    const alertBox = document.getElementById("alert");

    function renderReviews() {
        container.innerHTML = "";
        let hasUnread = false;

        reviews.forEach((review, index) => {
            const card = document.createElement("div");
            card.className = "review-card";

            card.innerHTML = `
                <div class="review-header">
                    <span>${review.name}</span>
                    <span>${review.date}</span>
                </div>
                <div class="rating">⭐⭐⭐⭐⭐</div>
                <div class="review-text">${review.content}</div>
            `;

            if (review.reply) {
                card.innerHTML += `
                    <div class="admin-reply">
                        <strong>Phản hồi từ cửa hàng:</strong>
                        <p>${review.reply}</p>
                    </div>
                `;
            } else {
                hasUnread = true;
                const replySection = document.createElement("div");
                replySection.className = "reply-section";
                replySection.innerHTML = `
                    <label class="reply-label">Phản hồi khách hàng:</label>
                    <textarea placeholder="Nhập phản hồi..." id="reply-${index}"></textarea>
                    <button class="reply-btn" onclick="submitReply(${index})">Gửi phản hồi</button>
                `;
                card.appendChild(replySection);
            }

            container.appendChild(card);
        });
        alertBox.style.display = hasUnread ? "block" : "none";
    }

    function submitReply(index) {
        const textarea = document.getElementById(`reply-${index}`);
        const replyText = textarea.value.trim();
        if (replyText !== "") {
            reviews[index].reply = replyText;
            renderReviews(); // Cập nhật lại giao diện
        } else {
            alert("Vui lòng nhập nội dung phản hồi!");
        }
    }

    renderReviews();
});
