package servlet;

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
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();

        String username = req.getParameter("username");
        String password = req.getParameter("password");
        DataConnect dc = new DataConnect();
        try {
            dc.getConnection();
            int role;
            if((role = dc.getUserRole(username,password)) != -1){
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
