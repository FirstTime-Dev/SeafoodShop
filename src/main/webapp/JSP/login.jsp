<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Login/Register</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/CSS/login.css"/>
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel="stylesheet"/>
</head>
<body>
<%--<img src="../IMG/login-background.png" id="login-background-img">--%>
<div class="container">
    <div class="form-box login">
        <form action="">
            <h1>Login</h1>
            <div class="input-box">
                <label>
                    <input type="text" placeholder="Username" required>
                </label>
                <i class='bx bxs-user'></i>
            </div>
            <div class="input-box">
                <label>
                    <input type="password" placeholder="Password" required>
                </label>
                <i class='bx bxs-lock'></i>
            </div>
            <div class="forgot-link">
                <a href="#">Forgot Password?</a>
            </div>
            <button type="submit" class="btn">Login</button>
            <p>Or login with social platforms</p>
            <div class="social-icons">
                <a id="googleSignInBtn" ><i class='bx bxl-google'></i></a>
                <a ><i class='bx bxl-facebook'></i></a>
                <a ><i class='bx bxl-github'></i></a>
            </div>
        </form>
    </div>

    <div class="form-box register">
        <form action="">
            <h1>Registration</h1>
            <div class="input-box">
                <label>
                    <input type="text" placeholder="Username" required>
                </label>
                <i class='bx bxs-user'></i>
            </div>
            <div class="input-box">
                <label>
                    <input type="email" placeholder="Email" required>
                </label>
                <i class='bx bxs-envelope'></i>
            </div>
            <div class="input-box">
                <label>
                    <input type="password" placeholder="Password" required>
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
<script src="../JS/login.js"></script>
</body>
</html>
