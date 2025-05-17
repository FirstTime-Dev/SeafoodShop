document.addEventListener('DOMContentLoaded', () => {
    // --- Modal tạo tài khoản mới ---
    const createForm = document.getElementById("createAccountForm");

    if (createForm) {
        // Mở modal tạo tài khoản
        const openBtn = document.querySelector(".add-customer-btn");
        if (openBtn) {
            openBtn.addEventListener("click", () => {
                const modal = document.getElementById("createAccountModal");
                if (modal) modal.style.display = "block";
            });
        }

        // Đóng modal khi bấm nút đóng
        const closeBtn = document.getElementById("createAccountModal")?.querySelector(".close-modal");
        if (closeBtn) {
            closeBtn.addEventListener("click", () => {
                const modal = document.getElementById("createAccountModal");
                if (modal) modal.style.display = "none";
            });
        }

        // Đóng modal khi click ra ngoài
        window.addEventListener("click", (event) => {
            const modal = document.getElementById("createAccountModal");
            if (event.target === modal) modal.style.display = "none";
        });

        // Gửi dữ liệu tạo tài khoản
        createForm.addEventListener("submit", async (event) => {
            event.preventDefault();

            const formData = new FormData(createForm);
            const params = new URLSearchParams();
            for (let [k, v] of formData) params.append(k, v);

            try {
                const response = await fetch("/SeafoodShop_war_exploded/CreateNewAccount", {
                    method: "POST",
                    headers: {
                        "Content-Type": "application/x-www-form-urlencoded"
                    },
                    body: params.toString()
                });

                if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`);

                const text = await response.text();
                console.log("Raw response text:", text);

                let result;
                try {
                    result = JSON.parse(text);
                } catch (e) {
                    throw new Error("Phản hồi không phải JSON hợp lệ");
                }

                if (result.success) {
                    showToast("Tạo tài khoản thành công!", "success");
                    document.getElementById("createAccountModal").style.display = "none";
                    createForm.reset();
                    setTimeout(() => window.location.reload(), 1000);
                } else {
                    showToast("Tạo thất bại: " + (result.error || "Không rõ lỗi"), "error");
                }
            } catch (error) {
                console.error("Error:", error);
                showToast("Lỗi tạo tài khoản: " + error.message, "error");
            }
        });
    }

    // Hàm hiển thị toast
    function showToast(message, type = "info") {
        const toast = document.createElement("div");
        toast.className = `toast ${type}`;
        toast.textContent = message;
        document.body.appendChild(toast);
        setTimeout(() => {
            toast.classList.add("show");
            setTimeout(() => {
                toast.classList.remove("show");
                setTimeout(() => toast.remove(), 300);
            }, 3000);
        }, 100);
    }

    // Xử lý ban/unban người dùng
    document.querySelectorAll(".toggle-visibility").forEach(button => {
        button.addEventListener("click", async function () {
            const userId = this.dataset.userid;
            const currentBan = parseInt(this.dataset.currentban);
            const newBan = currentBan === 1 ? 0 : 1;
            const row = document.querySelector(`#user-row-${userId}`);
            const toggleBtn = this;

            try {
                const response = await fetch(
                    `/SeafoodShop_war_exploded/AdminAccount?userId=${userId}`, {
                        method: "POST",
                        headers: {"Content-Type": "application/json"},
                        body: JSON.stringify({banStatus: newBan})
                    });
                if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`);
                const result = await response.json();

                if (result.success) {
                    // 1) Ẩn/hiện row
                    row.classList.toggle("hidden-product", newBan === 1);

                    // 2) Cập nhật trạng thái tại nút
                    toggleBtn.dataset.currentban = newBan;
                    toggleBtn.title = newBan === 1 ? "Unban" : "Ban";

                    // 3) Luôn hiển thị icon 🚫
                    toggleBtn.innerText = '🚫';

                    showToast(
                        newBan === 1 ? "Đã ban người dùng" : "Đã unban người dùng",
                        "success"
                    );
                } else {
                    showToast("Cập nhật trạng thái thất bại", "error");
                }
            } catch (error) {
                console.error("Error:", error);
                showToast("Đã xảy ra lỗi: " + error.message, "error");
            }
        });
    });

    // Khai báo modals
    const modals = {
        edit: {
            element: document.getElementById("editUserPopup"),
        }
    };

// Xử lý popup chỉnh sửa người dùng
    const editForm = document.getElementById("editUserForm");

    if (editForm) {

        // Đóng popup khi nhấn nút X
        const closeBtn = document.getElementById("closeEditPopup");
        if (closeBtn) {
            closeBtn.addEventListener("click", () => {
                modals.edit.element.style.display = "none";
            });
        }

        // Đóng popup khi nhấn ra ngoài modal-content
        window.addEventListener("click", function (event) {
            if (event.target === modals.edit.element) {
                modals.edit.element.style.display = "none";
            }
        });

        // Mở popup chỉnh sửa
        document.querySelectorAll(".edit").forEach(button => {
            button.addEventListener("click", async function () {
                const userID = this.getAttribute("data-userid");
                if (!userID) {
                    showToast("Không thể chỉnh sửa: Thiếu ID người dùng", "error");
                    return;
                }
                try {
                    const response = await fetch(`/SeafoodShop_war_exploded/EditUserInformation?userID=${userID}`);
                    if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`);
                    const user = await response.json();
                    if (!user || user.error) throw new Error(user?.error || "Không tìm thấy thông tin người dùng");
                    fillEditForm(user);

                    // Hiển thị modal
                    if (modals.edit.element) {
                        modals.edit.element.style.display = "block";
                    }
                } catch (error) {
                    console.error("Error:", error);
                    showToast("Lỗi khi tải thông tin: " + error.message, "error");
                }
            });
        });

        // Submit form chỉnh sửa (URL-encoded)
        editForm.addEventListener("submit", async function (event) {
            event.preventDefault();
            const userID = document.getElementById("UserID").value;
            const formData = new FormData(this);
            const params = new URLSearchParams();
            for (let [k, v] of formData) params.append(k, v);

            try {
                const response = await fetch(`/SeafoodShop_war_exploded/EditUserInformation?userID=${userID}`, {
                    method: "POST",
                    headers: {"Content-Type": "application/x-www-form-urlencoded"},
                    body: params.toString()
                });
                if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`);
                const result = await response.json();
                if (result.status === "success") {
                    showToast("Cập nhật thành công!", "success");
                    setTimeout(() => window.location.reload(), 1500);
                } else {
                    showToast("Cập nhật thất bại: " + (result.message || ""), "error");
                }
            } catch (error) {
                console.error("Error:", error);
                showToast("Lỗi khi cập nhật: " + error.message, "error");
            }
        });
    }


    // Hàm điền dữ liệu vào form chỉnh sửa
    function fillEditForm(user) {
        document.getElementById("UserID").value = user.userID;
        document.getElementById("editFullName").value = user.fullName || "";
        document.getElementById("editUsername").value = user.username || "";
        document.getElementById("editPassword").value = user.password || "";
        document.getElementById("editEmail").value = user.email || "";
        document.getElementById("editPhone").value = user.phone || "";
        document.getElementById("editBirthDate").value = user.birthday
            ? new Date(user.birthday).toISOString().split('T')[0]
            : "";
        document.getElementById("editAddress").value = user.address || "";
        document.getElementById("editRole").value = user.role || "0";
        document.getElementById("editBan").value = user.ban === 1 ? "1" : "0";
        if (document.getElementById("editCreatedAt")) {
            const d = new Date(user.editCreatedAt);
            document.getElementById("editCreatedAt").value =
                !isNaN(d.getTime())
                    ? d.toLocaleString()
                    : "";
        }

    }

    // Hàm hiển thị thông báo toast
    function showToast(message, type = "info") {
        const toast = document.createElement("div");
        toast.className = `toast ${type}`;
        toast.textContent = message;
        document.body.appendChild(toast);
        setTimeout(() => {
            toast.classList.add("show");
            setTimeout(() => {
                toast.classList.remove("show");
                setTimeout(() => toast.remove(), 300);
            }, 3000);
        }, 100);
    }
});
