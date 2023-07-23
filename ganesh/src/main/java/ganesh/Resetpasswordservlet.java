package ganesh;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.mindrot.jbcrypt.BCrypt;

/**
 * Servlet implementation class Resetpasswordservlet
 */
@WebServlet("/ResetPassword")
public class Resetpasswordservlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	 @Override
	 protected void doPost(HttpServletRequest request, HttpServletResponse response)
	         throws ServletException, IOException {
	     PrintWriter out = response.getWriter();
	     response.setContentType("text/html");

	     String resetPassEmail = request.getParameter("resetPassEmail");
	     String resetPassOTP = request.getParameter("resetPassOTP");
	     String newPassword = request.getParameter("newPassword");
	     String confirmNewPassword = request.getParameter("confirmNewPassword");

	     HttpSession session = request.getSession();

	     // Check if the provided OTP matches the one stored in the session
	     String sessionOTP = (String) session.getAttribute("otp");
	     if (sessionOTP != null && sessionOTP.equals(resetPassOTP)) {
	         // Perform additional validations for new password and confirmation
	         if (newPassword.equals(confirmNewPassword)) {
	             // Generate a salt and hash the new password
	             String salt = BCrypt.gensalt();
	             String hashedPassword = BCrypt.hashpw(newPassword, salt);

	             // Update the user's password in the database
	             boolean isPasswordUpdated = updatePasswordInDatabase(resetPassEmail, hashedPassword);

	             if (isPasswordUpdated) {
	                 session.removeAttribute("otp"); // Remove the OTP from the session after successful reset
	                 // Show a success message using JavaScript's alert
	                 out.println("<script>alert('Password has been reset successfully!'); window.location.href='login.jsp';</script>");
	             } else {
	                 // Password update failed
	                 request.setAttribute("status", "failed");
	                 RequestDispatcher dispatcher = request.getRequestDispatcher("reset-password.jsp");
	                 dispatcher.forward(request, response);
	             }
	         } else {
	             // Passwords don't match
	             request.setAttribute("status", "failed");
	             RequestDispatcher dispatcher = request.getRequestDispatcher("reset-password.jsp");
	             dispatcher.forward(request, response);
	         }
	     } else {
	         // Invalid OTP
	         request.setAttribute("status", "failed");
	         RequestDispatcher dispatcher = request.getRequestDispatcher("reset-password.jsp");
	         dispatcher.forward(request, response);
	     }
	 }

	 private boolean updatePasswordInDatabase(String email, String hashedPassword) {
	     // Your code to update the user's password in the database goes here
	     // Use the email parameter to identify the user and update the 'password' column with the hashedPassword value
	     // Return true if the password update is successful, otherwise return false
	     // Replace this with your actual database update logic

	     try {
	         Class.forName("com.mysql.cj.jdbc.Driver");
	         Connection con = DriverManager.getConnection("jdbc:mysql:///ganesh?useSSL=false", "root", "Pa1@mysql");
	         PreparedStatement stmt = con.prepareStatement("UPDATE user SET password = ? WHERE email = ?");
	         stmt.setString(1, hashedPassword);
	         stmt.setString(2, email);
	         int rowsUpdated = stmt.executeUpdate();

	         // Close the connection and resources
	         stmt.close();
	         con.close();

	         return rowsUpdated > 0;
	     } catch (Exception e) {
	         e.printStackTrace();
	         return false;
	     }
	 }
}