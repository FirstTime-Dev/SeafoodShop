const container = document.querySelector('.container');
const registerBtn = document.querySelector('.register-btn');
const loginBtn = document.querySelector('.login-btn');

registerBtn.addEventListener('click', () => {
    container.classList.add('active');
})

loginBtn.addEventListener('click', () => {
    container.classList.remove('active');
})

///auth/userinfo.email
///auth/userinfo.profile

const CLIENT_ID = "880084586805-kljemathregs925afo81bcrhb8aadosc.apps.googleusercontent.com";
const LINK_GET_GOOGLE_TOKEN = `https://accounts.google.com/o/oauth2/v2/auth?scope=https://www.googleapis.com/auth/userinfo.email%20https://www.googleapis.com/auth/userinfo.profile&response_type=token&redirect_uri=http://localhost:8080/SeafoodShop_war_exploded/JSP/login.jsp&client_id=${CLIENT_ID}`

document.addEventListener('DOMContentLoaded', () => {
    const googleSignInBtn = document.getElementById('googleSignInBtn');
    googleSignInBtn.addEventListener('click', () => {
        window.location.href = LINK_GET_GOOGLE_TOKEN;
    });
});
const getGoogleToken = () => {
    const saveAccessToken = window.localStorage.getItem("access_token");

    if (saveAccessToken) {
        console.log(saveAccessToken);
        return saveAccessToken;
    }else {
        const url = new URLSearchParams(window.location.hash.substring(1));
        const token = url.get("access_token");
        window.localStorage.setItem("access_token", token);
        return token;
    }
}

const getGoogleUserInfoToken = async () => {
    const accessToken = getGoogleToken();
    const respone = await fetch(
        `https://www.googleapis.com/oauth2/v3/userinfo?access_token=${accessToken}`
    );
    const data = await respone.json();
    window.location.href = "home.jsp";
    console.log(data);
}
getGoogleUserInfoToken();

