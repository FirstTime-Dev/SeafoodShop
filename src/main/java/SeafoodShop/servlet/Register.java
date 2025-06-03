package SeafoodShop.servlet;

import SeafoodShop.dao.DataConnect;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/register")
public class Register extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("register_username");
        String password = req.getParameter("register_password");
        String email = req.getParameter("register_email");

        DataConnect db = new DataConnect();
        try {
            db.register(name,password,email);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
