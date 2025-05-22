package SeafoodShop.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/cartController")
public class CartController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        if(session.getAttribute("role") == null) {
            String userRequest = "showUserCart";
            session.setAttribute("userRequest", userRequest);
            req.getRequestDispatcher("/JSP/login.jsp").forward(req, resp);
        }else{
            req.getRequestDispatcher("/JSP/cart.jsp").forward(req, resp);
        }
    }
}
