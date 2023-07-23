package ganesh;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.annotation.WebServlet;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.mindrot.jbcrypt.BCrypt;


@WebServlet("/Registration")
public class Registerservlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final String INSERT_QUERY = "INSERT INTO user (name, email, password, radio) VALUES (?, ?, ?, 'admin')";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        response.setContentType("text/html");
        String name = request.getParameter("sign-name");
        String email = request.getParameter("sign-email");
        String password = request.getParameter("new-password");
        RequestDispatcher dispatcher = null;
        Connection con = null;

        try {
            
            // Hash and salt the password
            String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

            // Generate the connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql:///ganesh?useSSL=false", "root", "Pa1@mysql");
            PreparedStatement stmt = con.prepareStatement(INSERT_QUERY);

            stmt.setString(1, name);
            stmt.setString(2, email);
            stmt.setString(3, hashedPassword);

            // Execute the query
            int count = stmt.executeUpdate();
            dispatcher = request.getRequestDispatcher("login.jsp");
            if (count > 0) {
                request.setAttribute("status", "success");
            } else {
                request.setAttribute("status", "failed");
            }
            dispatcher.forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("status", "failed");
            dispatcher = request.getRequestDispatcher("login.jsp");
            dispatcher.forward(request, response);
        } finally {
            try {
                con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
