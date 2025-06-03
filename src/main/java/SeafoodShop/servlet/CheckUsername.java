package SeafoodShop.servlet;

import SeafoodShop.dao.DataConnect;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

@WebServlet("/checkUsername")
public class CheckUsername extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");

        DataConnect db = new DataConnect();
        try {
            if(db.isExistUser(username)){
                resp.setContentType("text/plain");
                PrintWriter out = resp.getWriter();
                out.print("username exists");
            }else{
                resp.setContentType("text/plain");
                PrintWriter out = resp.getWriter();
                out.print("success");
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
