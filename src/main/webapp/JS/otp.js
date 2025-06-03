document.addEventListener("DOMContentLoaded", function () {
    const inputs = document.querySelectorAll(".otp-input");

    inputs.forEach((input, index) => {
        input.addEventListener("input", function () {
            moveNext(this, index);
        });

        input.addEventListener("keydown", function (event) {
            handleKeyDown(event, index);
        });
    });
});

function moveNext(input, index) {
    const inputs = document.querySelectorAll(".otp-input");
    if (input.value.length === 1 && index < inputs.length - 1) {
        inputs[index + 1].focus();
    }
}

function handleKeyDown(event, index) {
    const inputs = document.querySelectorAll(".otp-input");
    if (event.key === "Backspace") {
        if (inputs[index].value === "" && index > 0) {
            inputs[index - 1].focus();
        }
    } else if (event.key >= "0" && event.key <= "9") {
        inputs[index].value = event.key;
        if (index < inputs.length - 1) {
            inputs[index + 1].focus();
        }
        event.preventDefault();
    }
}

async function submitOTP() {
    const inputs = document.querySelectorAll(".otp-input");
    let otp = "";
    inputs.forEach(input => {
        otp += input.value;
    });

    if (otp.length === 6) {
        try {
            const response = await fetch("/SeafoodShop_war_exploded/otp", {
                method: "POST",
                headers: {
                    "Content-Type": "application/json"
                },
                body: JSON.stringify({ otp: otp })
            });

            const result = await response.json();
            if (result.status === "success") {
                const role = result.role;
                if (role === 1) {
                    window.location.href = "/SeafoodShop_war_exploded/homeController";
                } else if (role === 2 || role === 3) {
                    window.location.href = "/SeafoodShop_war_exploded/AdminOverview";
                } else {
                    alert("Unknown role");
                }
            } else {
                alert("Invalid OTP");
            }
        } catch (error) {
            console.error("Error verifying OTP:", error);
            alert("Something went wrong.");
        }
    } else {
        alert("Please enter all 6 digits.");
    }
}


function sendAgain() {
    let sendAgainText = document.querySelector(".send-again");

    // Hiệu ứng khi nhấn
    sendAgainText.style.transform = "scale(0.9)";
    setTimeout(() => {
        sendAgainText.style.transform = "scale(1)";
    }, 150);

    // Giả lập gửi lại OTP
    alert("A new OTP has been sent to your registered phone/email.");
}