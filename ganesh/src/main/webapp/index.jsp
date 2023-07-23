<%
	if(session.getAttribute("email")==null){
		response.sendRedirect("login.jsp");
	}
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Main index</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
     <!-- /*________________________ navbar_____________________________ */ -->
   	 <nav>
        <img src="img/pa1logo.PNG" alt="logo" class="nav-logo">
        <div class="nav-title">
            <h6><strong> SVU-MCA-PDF's</strong></h6>
        </div>
        <div class="nav-links">
            <a href="" class="nav-link" >user dashboard</a>
            <a href="https://www.linkedin.com/in/pavankalyan-akola/" target="_blank" class="nav-link nav-link-margin">Linkedin</a>
        </div>
    </nav> 
     <!-- /*________________________ navbar_____________________________ */ -->
   <button type="submit" onclick="location.href='login.jsp'" class="logout-btn">Logout</button>
   
   <script src="js/main.js" type="text/javascript"></script>
	<script src="js/validation.js" type="text/javascript"></script>
</body>
</html>
