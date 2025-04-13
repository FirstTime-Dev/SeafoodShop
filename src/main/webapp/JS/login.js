const container = document.querySelector('.container');
const registerBtn = document.querySelector('.register-btn');
const loginBtn = document.querySelector('.login-btn');

registerBtn.addEventListener('click', () => {
    container.classList.add('active');
})

loginBtn.addEventListener('click', () => {
    container.classList.remove('active');
})
//
// ///auth/userinfo.email
// ///auth/userinfo.profile
//
// const CLIENT_ID = "880084586805-kljemathregs925afo81bcrhb8aadosc.apps.googleusercontent.com";
// const LINK_GET_GOOGLE_TOKEN = `https://accounts.google.com/o/oauth2/v2/auth?scope=https://www.googleapis.com/auth/userinfo.email%20https://www.googleapis.com/auth/userinfo.profile&response_type=token&redirect_uri=http://localhost:8080/SeafoodShop_war_exploded/JSP/login.jsp&client_id=${CLIENT_ID}`
//
// document.addEventListener('DOMContentLoaded', () => {
//     const googleSignInBtn = document.getElementById('googleSignInBtn');
//     googleSignInBtn.addEventListener("click", () => {
//         // window.localStorage.removeItem("access_token");
//         window.location.href = LINK_GET_GOOGLE_TOKEN;
//
//     });
// });
// const getGoogleToken = () => {
//     // const hash = window.location.hash.substring(1);
//     // const urlParams = new URLSearchParams(hash);
//     // const token = urlParams.get('access_token');
//     // console.log(token);
//     //
//     // if (token) {
//     //     // window.localStorage.setItem("access_token", token);
//     //     window.history.replaceState({}, document.title, window.location.pathname);
//     //     console.log(token);
//     //     return token;
//     // }
//     // console.log(token);
//     // // return window.localStorage.getItem("access_token") || null;
//     // return null;
//     const url = new URLSearchParams(window.location.hash.substring(1));
//     const token = url.get("access_token");
//     console.log(token);
//     return token;
// }
//
// const getGoogleUserInfoToken = async () => {
//     const accessToken = getGoogleToken();
//     const respone = await fetch(
//         `https://www.googleapis.com/oauth2/v3/userinfo?access_token=${accessToken}`
//     );
//     const data = await respone.json();
//     console.log(data);
//     // window.location.href = "home.jsp";
// }
//
//
//
// ... (Phần code container và nút đăng ký/đăng nhập giữ nguyên)

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

    if (token) {
        // window.history.replaceState({}, document.title, window.location.pathname);
        return token;
    }
    return null;
}

// Hàm gửi OTP đến server
const sendOTP = async (email) => {
    // try {
        const response = await fetch('/SeafoodShop_war_exploded/Google_login', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({ email: email })
        });

        // if (!response.ok) {
        //     throw new Error('Gửi OTP thất bại');
        // }

        // const result = await response.json();
        // console.log('OTP sent:', result);
        return true;
    // } catch (error) {
    //     console.error('Lỗi gửi OTP:', error);
    //     return false;
    // }
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
    //     const response = await fetch('/SeafoodShop_war_exploded/login', {
    //     method: 'POST',
    //     headers: {
    //         'Content-Type': 'application/json',
    //     },
    //     body: JSON.stringify({ userData })
    // });

        // sendOTP(userData.email);
        // Gửi OTP đến email
        const otpSent = await sendOTP(userData.email);

        if (otpSent) {
            // Lưu email vào sessionStorage để xác thực OTP
            sessionStorage.setItem('otpEmail', userData.email);

            // Chuyển hướng đến trang OTP
            // window.location.href = 'otp.jsp';

        }
    // } catch (error) {
    //     console.error('Lỗi hệ thống:', error);
    //     alert('Đăng nhập thất bại! Vui lòng thử lại.');
    // }
}

// Hàm xử lý redirect từ Google
const handleGoogleRedirect = () => {
    const token = getGoogleToken();
    if (token) {
        handleGoogleUser();
    }
}
// document
//     .getElementById('loginForm')
//     .addEventListener(
//         'submit',
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
            if (password.length < 8) {
                // event.preventDefault();
                message.textContent = "Mật khẩu phải chứa ít nhất 8 kí tự";
                message.className = "invalid";
                return false;
            }
            /*	if (!/[A-Z]/.test(password)) {
                    event.preventDefault();
                    message.textContent = "Password must contain at least one uppercase letter.";
                    message.className = "invalid";
                    return;
                }*/
            if (!/[a-z]/.test(password)) {
                // event.preventDefault();
                message.textContent = "Mật khẩu phải chứ ít nhất 1 kí tự thường";
                message.className = "invalid";
                return false;
            }
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