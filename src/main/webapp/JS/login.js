const container = document.querySelector('.container');
const registerBtn = document.querySelector('.register-btn');
const loginBtn = document.querySelector('.login-btn');

registerBtn.addEventListener('click', () => {
    container.classList.add('active');
})

loginBtn.addEventListener('click', () => {
    container.classList.remove('active');
})

const CLIENT_ID = "880084586805-kljemathregs925afo81bcrhb8aadosc.apps.googleusercontent.com";
const LINK_GET_GOOGLE_TOKEN = `https://accounts.google.com/o/oauth2/v2/auth?scope=https://www.googleapis.com/auth/userinfo.email%20https://www.googleapis.com/auth/userinfo.profile&response_type=token&redirect_uri=http://localhost:8080/SeafoodShop_war_exploded/JSP/login.jsp&client_id=${CLIENT_ID}`

document.addEventListener('DOMContentLoaded', () => {
    const googleSignInBtn = document.getElementById('googleSignInBtn');

// Sự kiện click nút Google Sign-in
    googleSignInBtn.addEventListener("click", () => {
        window.localStorage.removeItem("access_token");
        window.location.href = LINK_GET_GOOGLE_TOKEN;
    });
    handleGoogleRedirect();
});

// Hàm xử lý token từ URL hash
const getGoogleToken = () => {
    const hash = window.location.hash.substring(1);
    const urlParams = new URLSearchParams(hash);
    const token = urlParams.get('access_token');
    console.log(token);
    if (token) {
        return token;
    }
    return null;
}

// Hàm chính xử lý thông tin người dùng
const handleGoogleUser = async () => {
    // try {
    const accessToken = getGoogleToken();
    if (!accessToken) return;

    // Lấy thông tin người dùng từ Google
    const userResponse = await fetch(
        `https://www.googleapis.com/oauth2/v3/userinfo?access_token=${accessToken}`
    );

    if (!userResponse.ok) throw new Error('Lỗi xác thực Google');

    const userData = await userResponse.json();
    console.log('Thông tin người dùng:', userData);

    console.log("Tên:", userData.family_name + " " + userData.given_name);
    await fetch('/SeafoodShop_war_exploded/Google_login', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=UTF-8',
        },
        body: new Blob([JSON.stringify({
            email: userData.email,
            family_name: userData.family_name,
            given_name: userData.given_name
        })], { type: 'application/json; charset=UTF-8' })
    })
        .then(res => res.json())
        .then(data => {
            if (data.status === 'success') {
                const role = data.role;
                if (role === 'admin') {
                    window.location.href = '/SeafoodShop_war_exploded/admin/dashboard.jsp';
                } else {
                    window.location.href = '/SeafoodShop_war_exploded/JSP/home.jsp';
                }
            } else {
                alert("Lỗi: " + data.message);
            }
        });


}

// Hàm xử lý redirect từ Google
const handleGoogleRedirect = () => {
    const token = getGoogleToken();
    if (token) {
        handleGoogleUser();
    }
}
function checkLogin() {
    const username = document
        .getElementById('login_username').value;
    const password = document
        .getElementById('login_password').value;
    const message = document.getElementById('errorMessage');
    message.textContent = "";

    // Validate username
    if (/\s/.test(username)) {
        // event.preventDefault();
        message.textContent = "Tên đăng nhập không thể chứa khoảng trống";
        message.className = "invalid";
        return false;
    }
    if (username.trim() === "") {
        // event.preventDefault();
        message.textContent = "Tên đăng nhập không thể để trống";
        message.className = "invalid";
        return false;
    }

    if (username.length < 5) {
        // event.preventDefault();
        message.textContent = "Tên đăng nhập phải chứa ít nhất 5 kí tự";
        message.className = "invalid";
        return false;
    }

    if (/[^a-zA-Z0-9]/.test(username)) {
        // event.preventDefault();
        message.textContent = "Tên đăng nhâp chỉ có thể chứa chữ cái và số";
        message.className = "invalid";
        return false;
    }

    // Validate password
    if (password.length < 6) {
        // event.preventDefault();
        message.textContent = "Mật khẩu phải chứa ít nhất 6 kí tự";
        message.className = "invalid";
        return false;
    }
    /*	if (!/[A-Z]/.test(password)) {
            event.preventDefault();
            message.textContent = "Password must contain at least one uppercase letter.";
            message.className = "invalid";
            return;
        }*/
    // if (!/[a-z]/.test(password)) {
    //     // event.preventDefault();
    //     message.textContent = "Mật khẩu phải chứ ít nhất 1 kí tự thường";
    //     message.className = "invalid";
    //     return false;
    // }
    if (!/[0-9]/.test(password)) {
        // event.preventDefault();
        message.textContent = "Mật khẩu phải chứa ít nhất 1 chữ số";
        message.className = "invalid";
        return false;
    }/*
			if (!/[@$!%*?&]/.test(password)) {
			event.preventDefault();
				message.textContent = "Password must contain at least one special character.";
				message.className = "invalid";
				return;
			}*/
    if (/\s/.test(password)) {
        // event.preventDefault();
        message.textContent = "Mật khẩu không thể chứa khoảng trắng";
        message.className = "invalid";
        return false;
    }

    // Nếu vượt qua tất cả các kiểm tra, form sẽ tự động gửi dữ liệu đến Servlet (action="login")
    message.textContent = "";
    message.className = "valid";
    return true;
    // });
}
