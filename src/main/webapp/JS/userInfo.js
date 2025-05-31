// chuyển giữa các tab
const menuItems = document.querySelectorAll('.menu-item');
const contentSections = document.querySelectorAll('.content-section');

menuItems.forEach(item => {
    item.addEventListener('click', () => {
        const id = item.id.replace('menu-', 'content-');

        contentSections.forEach(section => {
            section.classList.remove('active');
        });

        const selectedSection = document.getElementById(id);
        if (selectedSection) {
            selectedSection.classList.add('active');
        }
    });
})
// js cho chức năng chọn ngày sinh
// Thêm tùy chọn ngày, tháng, năm
const daySelect = document.querySelector('select[name="day"]');
const monthSelect = document.querySelector('select[name="month"]');
const yearSelect = document.querySelector('select[name="year"]');

// Thêm ngày (1–31)
for (let i = 1; i <= 31; i++) {
    const option = document.createElement("option");
    option.value = i;
    option.textContent = i;
    daySelect.appendChild(option);
}

// Thêm tháng (1–12)
for (let i = 1; i <= 12; i++) {
    const option = document.createElement("option");
    option.value = i;
    option.textContent = i;
    monthSelect.appendChild(option);
}

// Thêm năm (1950–nay)
const currentYear = new Date().getFullYear();
for (let i = currentYear; i >= 1950; i--) {
    const option = document.createElement("option");
    option.value = i;
    option.textContent = i;
    yearSelect.appendChild(option);
}

// Cập nhật ngày theo tháng + năm
function updateDaysInMonth() {
    const month = parseInt(monthSelect.value);
    const year = parseInt(yearSelect.value);

    if (!month || !year) return;

    const daysInMonth = new Date(year, month, 0).getDate();

    [...daySelect.options].forEach((option, index) => {
        if (index === 0) return; // option đầu "Ngày"
        const day = index;
        option.style.display = day <= daysInMonth ? "block" : "none";

        // Nếu ngày hiện tại vượt quá số ngày hợp lệ, reset về "Ngày"
        if (daySelect.value > daysInMonth) {
            daySelect.value = "";
        }
    });
}