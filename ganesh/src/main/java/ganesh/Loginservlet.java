package ganesh;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.mindrot.jbcrypt.BCrypt;

@WebServlet("/Login")
public class Loginservlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        response.setContentType("text/html");
        String email = request.getParameter("log-email");
        String password = request.getParameter("current-password");
        String radio = request.getParameter("log-radio");
        HttpSession session = request.getSession();

        Connection con = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        RequestDispatcher dispatcher = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql:///ganesh?useSSL=false", "root", "Pa1@mysql");

            // Prepare the SQL statement
            stmt = con.prepareStatement("SELECT * FROM user WHERE email = ? AND radio = ?");
            stmt.setString(1, email);
            stmt.setString(2, radio);

            rs = stmt.executeQuery();

            if (rs.next()) {
                // Verify password
                String hashedPasswordFromDB = rs.getString("password");
                if (BCrypt.checkpw(password, hashedPasswordFromDB)) {
                    // Set email attribute in session for later use
                    session.setAttribute("email", rs.getString("email"));

                    if ("admin".equals(radio)) {
                        dispatcher = request.getRequestDispatcher("admin.jsp");
                    } else if ("user".equals(radio)) {
                        dispatcher = request.getRequestDispatcher("index.jsp");
                    } else {
                        // Invalid radio value
                        request.setAttribute("status", "failed");
                        dispatcher = request.getRequestDispatcher("login.jsp");
                    }
                } else {
                    // Incorrect password
                    request.setAttribute("status", "failed");
                    dispatcher = request.getRequestDispatcher("login.jsp");
                }
            } else {
                // User not found
                request.setAttribute("status", "failed");
                dispatcher = request.getRequestDispatcher("login.jsp");
            }

            dispatcher.forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("status", "failed");
            dispatcher = request.getRequestDispatcher("login.jsp");
            dispatcher.forward(request, response);
        } finally {
            // Close the resources in the reverse order of their creation
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (stmt != null) {
                try {
                    stmt.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
