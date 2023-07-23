<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>ganesh chaturti</title>
<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet" href="dist/sweetalert.css">
</head>
<body>
    <!-- /*________________________ status of sweetalert box_____________________________ */ -->
   <input type="hidden" id="status" value="<%= request.getAttribute("status") %>">
	<div class="container">
        <!-- /*________________________ navbar_____________________________ */ -->
     <nav>
        <img src="img/pa1logo.PNG" alt="logo" class="nav-logo">
        <!-- <div class="nav-title">
            <h6><strong> SVU-MCA-PDF's</strong></h6>
        </div> -->
        <div class="nav-links">
            <a href="" class="nav-link" >My Portfolio</a>
            <a href="https://www.linkedin.com/in/pavankalyan-akola/" target="_blank" class="nav-link nav-link-margin">Linkedin</a>
        </div>
    </nav>
     <!-- /*________________________ navbar_____________________________ */ -->

     <!-- switch between login and signup -->
    <div id="LoginAndRegistrationForm">
		<h1 id="formTitle">Login</h1>
		<div id="formSwitchBtn">
			<button onclick="ShowLoginForm()" id="ShowLoginBtn" class="active">Login</button>
			<button onclick="ShowRegistrationForm()" id="ShowRegistrationBtn">Registration</button>
		</div>
    <!-- login page -->
		<div id="LoginFrom">
			<form action="Login" method="post">
				
                <div id="RadioButtons" class="center mt-20">
                    <div>
						<input type="radio" id="adminRadio" name="log-radio" value="admin">
                   		<label for="adminRadio">Admin</label>
					</div>
					<div>
						<input type="radio" id="userRadio" name="log-radio" value="user">
                    	<label for="userRadio">User</label>
					</div> 
                </div>

				<div class="center">
					<input id="LoginEmail" name="log-email" class="input-text" type="text" placeholder="Email Address"> 
					<div class="password-container-toggle">
						<input id="LoginPassword" name="current-password" class="mt-10 input-text password-container-toggle" type="password" placeholder="Password">
						<img class="password-toggle" src="img/show.png" alt=" " onclick="togglePasswordVisibility('LoginPassword')" />
					</div>
				</div>
				
				<div class="forgot-pass-remember-me mt-10">
					<div class="forgot-pass">
						<a id="ForgotPassword" href="JavaScript:void(0);" onclick="ShowForgotPasswordForm()">Forgot Password?</a>
					</div>
					<div class="remember-me">
						<input id="rememberMe" type="checkbox">
						<label for="rememberMe">Remember Me</label>
					</div>
				</div>
				<div class="center mt-20">
					<input onclick="return ValidateLoginForm();"  class="Submit-Btn" type="submit" value="Login" id="LoginBtn">
				</div>
			</form>
			<p class="center mt-20 dont-have-account">
				Don't have an account? 
				<a href="JavaScript:void(0);" onclick="ShowRegistrationForm()">Registration now</a>
			</p>
		</div>
        <!-- registration page -->
		<div id="RegistrationFrom">
			<form action="Registration" method="post">
				<div class="center">
					<input id="RegiName" name="sign-name" class="input-text" type="text" placeholder="Full Name" required>
   					<input id="RegiEmailAddres" name="sign-email" class="input-text mt-10" type="email" placeholder="Email Address" required>
    				<div class="password-container-toggle" >
						<input id="RegiPassword" name="new-password" class="mt-10 input-text" type="password" placeholder="Password" required>
						<img class="password-toggle" src="img/show.png" alt=" " onclick="togglePasswordVisibility('RegiPassword')" />
					</div>
					<input id="RegiConfirmPassword" name="new-password" class="mt-10 input-text" type="password" placeholder="Confirm Password" required>
					<input name="sign-radio" type="hidden">
				</div>
				<div class="center mt-20">
					<input onclick="return ValidateRegistrationForm();" class="Submit-Btn" type="submit" value="Registration" id="RegistrationitBtn">
				</div>
			</form>
			<p class="center mt-20 already-have-account">
				Already have an account? 
				<a href="#" onclick="ShowLoginForm()">Login now</a>
			</p>
		</div>
        <!-- forgot password  -->
		<div id="ForgotPasswordForm">
			<form action="ForgotPassword">
				<div class="center mt-20">
					<input class="input-text " type="email" id="forgotPassEmail" placeholder="Email Address">
				</div>
				<div class="center mt-20">
					<input onclick="return ValidateForgotPasswordForm();" class="Submit-Btn" type="submit" value="Reset Password" id="PasswordResetBtn" >
				</div>
			</form>
			<p class="center mt-20 already-have-account">
				Back to the 
				<a href="JavaScript:void(0);" onclick="ShowLoginForm()">Login page</a> | <a href="JavaScript:void(0);" onclick="ShowRegistrationForm()">Registration page</a>
			</p>
		</div>
	</div>

	<script src="js/main.js" type="text/javascript"></script>
	<script src="js/validation.js" type="text/javascript"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js" integrity="sha512-AA1Bzp5Q0K1KanKKmvN/4d3IRKVlv9PYgwFPvm32nPO6QS8yH1HO7LbgB1pgiOxPtfeg5zEn2ba64MUcqJx6CA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<script>
		var status = document.getElementById("status").value;
		if(status == "success"){
			swal("congrats","Account Created Successfully","success");
		}else if (status == "failed"){
			swal("Sorry","wrong username or password", "error");
		}
	</script>
</body>
</html>
