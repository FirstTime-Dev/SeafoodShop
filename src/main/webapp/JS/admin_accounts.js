document.addEventListener('DOMContentLoaded', () => {
    // Mở modal tạo tài khoản
    const createModal = document.getElementById('createAccountModal');
    const openCreateBtn = document.querySelector('.add-customer-btn');
    const closeModalBtn = createModal.querySelector('.close-modal');

    openCreateBtn.addEventListener('click', () => {
        createModal.style.display = 'block';
    });

    closeModalBtn.addEventListener('click', () => {
        createModal.style.display = 'none';
    });

    // Đóng modal khi click ra ngoài
    window.addEventListener('click', (event) => {
        if (event.target === createModal) {
            createModal.style.display = 'none';
        }
    });

    // Ẩn hiện account
    document.querySelectorAll('.toggle-visibility').forEach(button => {
        const row = button.closest('tr');
        if (button.textContent === '🔒') {
            row.classList.add('hidden-product');
        } else {
            row.classList.remove('hidden-product');
        }
        button.addEventListener('click', () => {
            const isHidden = row.classList.toggle('hidden-product');
            button.textContent = isHidden ? '🔒' : '🔓';
        });
    });
});
