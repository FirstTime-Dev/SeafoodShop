<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<meta charset="UTF-8">
<html>
<head>
    <title>Login/Register</title>
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/CSS/login.css"/>
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel="stylesheet"/>
</head>
<body>
<%--<img src="../IMG/login-background.png" id="login-background-img">--%>

<div class="container">
    <%--    đăng nhập--%>
    <div class="form-box login">
        <form action="<%= request.getContextPath() %>/login" method="post" id="loginForm">
            <h1>Login</h1>
            <div class="input-box">
                <label>
                    <input id="login_username" type="text" placeholder="Username" name="login_username">
                </label>

                <i class='bx bxs-user'></i>
            </div>
            <div class="input-box">
                <label>
                    <input id="login_password" type="password" placeholder="Password" name="login_password">
                </label>
                <div id="errorMessage" style="color:red; font-size: 12px; margin-top: 5px;"></div>

                <i class='bx bxs-lock'></i>
            </div>
            <div class="forgot-link">
                <a href="#">Forgot Password?</a>
            </div>
            <button type="submit" class="btn login_btn">Login</button>
            <p>Or login with social platforms</p>
            <div class="social-icons">
                <a id="googleSignInBtn"><i class='bx bxl-google'></i></a>
                <a><i class='bx bxl-facebook'></i></a>
                <a><i class='bx bxl-github'></i></a>
            </div>
        </form>
    </div>
    <%--đăng kí--%>
    <div class="form-box register">
        <form action="<%= request.getContextPath() %>/login" method="post" id="registerForm">
            <h1>Registration</h1>
            <div class="input-box">
                <label>
                    <input class="username" type="text" placeholder="Username" name="register_username"
                           oninput="checkUsername(this)">
                </label>
                <i class='bx bxs-user'></i>
            </div>
            <div class="input-box">
                <label>
                    <input type="email" placeholder="Email" name="register_email" oninput="checkEmail(this)">
                </label>
                <i class='bx bxs-envelope'></i>
            </div>
            <div class="input-box">
                <label>
                    <input type="password" placeholder="Password" name="register_password">
                </label>
                <i class='bx bxs-lock'></i>
            </div>
            <button type="submit" class="btn">Register</button>
            <p>Or register with social platforms</p>
            <div class="social-icons">
                <a href="#"><i class='bx bxl-google'></i></a>
                <a href="#"><i class='bx bxl-facebook'></i></a>
                <a href="#"><i class='bx bxl-github'></i></a>
            </div>
        </form>
    </div>
    <div class="toggle-box">
        <div class="toggle-panel toggle-left">
            <h1>Hello, Welcome</h1>
            <p>Don't have an account?</p>
            <button class="btn register-btn">Register</button>
        </div>
        <div class="toggle-panel toggle-right">
            <h1>Welcome Back</h1>
            <p>Already have an account?</p>
            <button class="btn login-btn">Login</button>
        </div>
    </div>
</div>
<script src="<%= request.getContextPath() %>/JS/login.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script>
    function checkEmail(param) {
        var email = param.value;
        $.ajax({
            url: '<%=request.getContextPath()%>/checkEmail',
            type: 'post',
            data: { email: email },
            success: function (data) {},
            error: function () {
                alert("Đã xảy ra lỗi khi tìm kiếm.");
            }
        });
    }

    function checkUsername(param) {
        var username = param.value;
        $.ajax({
            url: '<%=request.getContextPath()%>/checkUsername',
            type: 'post',
            data: { username: username },
            success: function (data) {},
            error: function () {
                alert("Đã xảy ra lỗi khi tìm kiếm.");
            }
        });
    }

    $(document).ready(function () {
        $('#loginForm').on('submit', function (e) {
            e.preventDefault();
            if (!checkLogin()) return;

            const username = $('#login_username').val().trim();
            const password = $('#login_password').val().trim();

            $.ajax({
                url: '<%= request.getContextPath() %>/login',
                type: 'POST',
                data: JSON.stringify({ username: username, password: password }),
                contentType: 'application/json; charset=UTF-8',
                success: function (response) {
                    if (response.status === 'success') {
                        sessionStorage.setItem('otp', response.otp);
                        window.location.href = '<%= request.getContextPath() %>/JSP/otp.jsp';
                    } else {
                        $('#errorMessage').text(response.message || 'Tên đăng nhập hoặc mật khẩu không đúng.');
                    }
                },
                error: function () {
                    $('#errorMessage').text('Đã xảy ra lỗi trong quá trình xử lý.');
                }
            });
        });
    });
</script>
</body>
</html>