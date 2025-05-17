package SeafoodShop.servlet;

import SeafoodShop.dao.DAOAdminOrder;
import SeafoodShop.model.Order;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.ServletException;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminOrder", value = "/AdminOrder")
public class AdminOrder extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DAOAdminOrder daoAdminOrder = new DAOAdminOrder();

        List<Order> orders = daoAdminOrder.getActiveOrders();
        request.setAttribute("orders", orders);

        request.getRequestDispatcher("/JSP/admin_orders.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        doGet(request, response);
    }
}