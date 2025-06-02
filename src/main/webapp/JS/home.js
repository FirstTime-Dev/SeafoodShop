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
    // Gán submit cho tất cả form thêm vào giỏ hàng
    $('form[action$="addToCart"]').on('submit', function (e) {
        e.preventDefault(); // Ngăn gửi form theo cách mặc định

        const form = $(this); // Lấy form đang được submit
        const product_id = form.find('input[name="product_id"]').val().trim();

        $.ajax({
            url: form.attr('action'), // URL của form
            type: 'POST',
            data: {
                product_id: product_id,
            },
            success: function (response) {
                if (response === 'success') {
                    alert('Đã thêm sản phẩm vào giỏ hàng!');
                } else {
                    alert('Có lỗi xảy ra khi thêm sản phẩm!');
                }
            },
            error: function () {
                alert('Lỗi kết nối khi thêm sản phẩm!');
            }
        });
    });
});
