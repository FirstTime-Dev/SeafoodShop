const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
        if (entry.isIntersecting) {
            entry.target.classList.add('animate');
        }
    });
});

const elements = document.getElementsByClassName('.product-content');
document.querySelectorAll(".product-content").forEach(el => {
    const animationClass = el.dataset.animation;
    el.classList.add(animationClass); // Thêm class animation ban đầu
    observer.observe(el);
});

$(document).ready(function () {
    $('#addToCartBtn').on('submit', function (e) {
        e.preventDefault(); // Ngăn form gửi theo cách mặc định

        const product_id = $('#product_id').val().trim();

        $.ajax({
            url: '<%= request.getContextPath() %>/addToCart', // servlet URL mapping
            type: 'POST',
            data: {
                product_id: product_id,
            },
            success: function (response) {
                // Xử lý kết quả trả về từ SeafoodShop.servlet
                if (response === 'success') {

                } else {
                    console.log('Error adding to cart');
                }
            },
            error: function () {
                console.log('Error adding to cart 1');
            }
        });

    });
});