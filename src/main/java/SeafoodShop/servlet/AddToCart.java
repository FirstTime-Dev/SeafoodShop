package SeafoodShop.servlet;

import SeafoodShop.dao.DataConnect;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/addToCart")
public class AddToCart extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            HttpSession session = req.getSession();
            int product_id = Integer.parseInt(req.getParameter("product_id"));
            int user_id = (int) session.getAttribute("user_id");
            DataConnect dc = new DataConnect();
            dc.addProductToCart(user_id, product_id);
        }catch (SQLException e){
            e.printStackTrace();
        }
    }
}
