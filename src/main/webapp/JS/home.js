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