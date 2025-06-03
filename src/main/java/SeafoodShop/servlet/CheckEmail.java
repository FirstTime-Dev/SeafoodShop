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

@WebServlet("/checkEmail")
public class CheckEmail extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");

        DataConnect db = new DataConnect();
        try {
            if(db.getUserIDByEmail(email)!=-1){
                resp.setContentType("text/plain");
                PrintWriter out = resp.getWriter();
                out.print("email exists");
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
