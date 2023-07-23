<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Rest Password</title>
	<link rel="stylesheet" href="style.css">
</head>
<body>
 <!-- /*________________________ status of sweetalert box_____________________________ */ -->
   <input type="hidden" id="status"   value="<%=request.getAttribute("status") %>">
   <input type="hidden" id="otpSent"  value="<%=session.getAttribute("otpSent") %>">
	
	<div class="container">
		<div id="ResetPasswordForm">
        <form action="ResetPassword" method="post">
            <div class="center mt-20">
                <input class="input-text"  type="text" id="resetPassEmail" placeholder="Email Address">
            </div>
            <div class="center mt-20">
                <button type="button" onclick="sendOTP()" class="Submit-Btn" id="sendOTPBtn">Send OTP</button>
            </div>
            <div class="center mt-20" id="otpInputField" style="display: none;">
                <input class="input-text" type="text" id="resetPassOTP" placeholder="Enter OTP">
            </div>
            <div class="center mt-20" id="newPasswordFields" style="display: none;">
                <input class="input-text" type="password" id="newPassword" placeholder="New Password">
                <input class="input-text" type="password" id="confirmNewPassword" placeholder="Confirm New Password">
            </div>
            <div class="center mt-20" id="resetPasswordBtns" style="display: none;">
                <button type="button" onclick="resetPassword()" class="Submit-Btn" id="setNewPasswordBtn">Set New Password</button>
            </div>
        </form>
    </div>
	</div>

	 <script src="js/main.js" type="text/javascript"></script>
	<script src="js/validation.js" type="text/javascript"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js" integrity="sha512-AA1Bzp5Q0K1KanKKmvN/4d3IRKVlv9PYgwFPvm32nPO6QS8yH1HO7LbgB1pgiOxPtfeg5zEn2ba64MUcqJx6CA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<script>
		// Handle OTP sending and visibility of "Set New Password" fields
        var status = document.getElementById("status").value;
        var otpSent = document.getElementById("otpSent").value;
        if (status == "success" && otpSent == "true") {
            showOTPInputField();
        }

        function sendOTP() {
            var resetPassEmail = document.getElementById('resetPassEmail').value;

            // Perform AJAX request to your server to send OTP to the provided email
            // Handle success and failure accordingly
            // For simplicity, we'll just assume the OTP is sent successfully
            var otpSent = true;

            if (otpSent) {
                showOTPInputField();
            } else {
                swal("Error", "Failed to send OTP. Please try again later.", "error");
            }
        }

        function showOTPInputField() {
            document.getElementById('sendOTPBtn').style.display = 'none';
            showElement('otpInputField');
            showElement('newPasswordFields');
            showElement('resetPasswordBtns');
        }

        function resetPassword() {
            var resetPassEmail = document.getElementById('resetPassEmail').value;
            var resetPassOTP = document.getElementById('resetPassOTP').value;
            var newPassword = document.getElementById('newPassword').value;
            var confirmNewPassword = document.getElementById('confirmNewPassword').value;

            // Validate OTP and new passwords
            if (!isValidOTP(resetPassOTP)) {
                swal("Error", "Invalid OTP. Please enter a valid OTP.", "error");
                return;
            }

            if (!isValidPassword(newPassword)) {
                swal("Error", "Invalid password. Password must be at least 8 characters long and contain alphabets, numbers, and special characters.", "error");
                return;
            }

            if (newPassword !== confirmNewPassword) {
                swal("Error", "Passwords do not match. Please re-enter your new password.", "error");
                return;
            }

            // If all validations pass, submit the form to your server for resetting the password
            // Handle success and failure accordingly
            // For simplicity, we'll just assume the password is reset successfully
            swal("Success", "Password reset successful!", "success");
            // You can redirect the user to the login page or any other appropriate page after resetting the password.
        }
	</script>
</body>
</html> 