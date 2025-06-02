package SeafoodShop.servlet;

import SeafoodShop.dao.DataConnect;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

@WebServlet("/login")
public class Login extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();

        String username = req.getParameter("login_username");
        String password = req.getParameter("login_password");
        DataConnect dc = new DataConnect();
        try {
            dc.getConnection();
            int role;
            int user_id;
            if((role = dc.getUserRole(username,password)) != -1){
                user_id = dc.getUserID(username,password);
                session.setAttribute("user_id",user_id);
                session.setAttribute("role",role);
                resp.setContentType("text/plain");
                PrintWriter out = resp.getWriter();
                out.print("success");
            }else{
                resp.setContentType("text/plain");
                PrintWriter out = resp.getWriter();
                out.print("non exist");
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }
}
