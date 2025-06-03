<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/CSS/otp.css">
    <script src="<%= request.getContextPath() %>/JS/otp.js"></script>
    <title>OTP</title>
</head>
<body>
<div class="otp-container">
    <h2>Enter OTP</h2>
    <div>
        <input type="text" class="otp-input" maxlength="1" oninput="moveNext(this, 0)"
               onkeydown="handleKeyDown(event, 0)">
        <input type="text" class="otp-input" maxlength="1" oninput="moveNext(this, 1)"
               onkeydown="handleKeyDown(event, 1)">
        <input type="text" class="otp-input" maxlength="1" oninput="moveNext(this, 2)"
               onkeydown="handleKeyDown(event, 2)">
        <input type="text" class="otp-input" maxlength="1" oninput="moveNext(this, 3)"
               onkeydown="handleKeyDown(event, 3)">
        <input type="text" class="otp-input" maxlength="1" oninput="moveNext(this, 4)"
               onkeydown="handleKeyDown(event, 4)">
        <input type="text" class="otp-input" maxlength="1" oninput="moveNext(this, 5)"
               onkeydown="handleKeyDown(event, 5)">
    </div>
    <button class="submit-btn" onclick="submitOTP()">Verify</button>
    <div class="send-again" onclick="sendAgain()">Didn't receive? <span>Send again.</span></div>
</div>
</body>
</html>