package SeafoodShop.servlet;

import SeafoodShop.dao.DAOAdminOrder;
import SeafoodShop.model.Order;
import SeafoodShop.model.OrderDetail;
import com.google.gson.Gson;
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

        String orderIDParam = request.getParameter("orderID");

        if (orderIDParam == null) {
            List<Order> orders = daoAdminOrder.getActiveOrders();
            request.setAttribute("orders", orders);
            request.getRequestDispatcher("/JSP/admin_orders.jsp").forward(request, response);
        } else {
            try {
                int orderID = Integer.parseInt(orderIDParam);
                OrderDetail detail = daoAdminOrder.getOrderDetail(orderID);
                if (detail == null) {
                    response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    response.getWriter().write("{\"error\":\"Order detail not found\"}");
                    return;
                }
                String json = new Gson().toJson(detail);
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write(json);
            } catch (NumberFormatException e) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write("{\"error\":\"Invalid orderID parameter\"}");
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        int orderId = Integer.parseInt(request.getParameter("orderId"));

        DAOAdminOrder dao = new DAOAdminOrder();
        boolean success = false;
        System.out.println(action);
        if ("confirm".equals(action)) {
            success = dao.updateOrderStatus(orderId, 2);
        } else if ("cancel".equals(action)) {
            success = dao.updateOrderStatus(orderId, 3);
        }

        response.setContentType("application/json");
        response.getWriter().write("{\"success\":" + success + "}");
    }

}