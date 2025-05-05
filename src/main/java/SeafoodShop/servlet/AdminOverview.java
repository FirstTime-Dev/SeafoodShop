package SeafoodShop.servlet;

import SeafoodShop.dao.DAOAdminOverview;

import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.ServletException;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "AdminOverview", value = "/AdminOverview")
public class AdminOverview extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DAOAdminOverview daoAdminOverview = new DAOAdminOverview();

        double revenueMonth = daoAdminOverview.getMonthlyRevenue();
        double revenueYear = daoAdminOverview.getYearlyRevenue();
        String topMonthProduct = daoAdminOverview.getTopProductOfMonth();
        String topYearProduct = daoAdminOverview.getTopProductOfYear();
        int ordersMonth = 0;
        int ordersYear = 0;
        int expiringProductCount = 0;
        int outOfStockProducts = 0;
        int expiredProductCount = 0;
        int totalIventory = 0;
        int almostOutOfStockProducts = 0;
        int activeAccounts = 0;
        int disableAccounts = 0;
        int totalSuppliers = 0;
        int totalCategory = 0;
        int totalDiscount = 0;
        int totalAvailableDiscount = 0;
        double avgRating = 0.0;
        int totalReview = 0;
        try {
            totalReview = daoAdminOverview.getTotalReviews();
            avgRating = daoAdminOverview.getAvgRating();
            totalAvailableDiscount = daoAdminOverview.getDiscountIsAvailable();
            totalDiscount = daoAdminOverview.getDiscountCount();
            totalCategory = daoAdminOverview.getTotalCategories();
            totalSuppliers = daoAdminOverview.getNumberOfSuppliers();
            activeAccounts = daoAdminOverview.getActiveAccounts();
            disableAccounts = daoAdminOverview.getDisableAccounts();
            totalIventory = daoAdminOverview.getTotalIventory();
            expiredProductCount = daoAdminOverview.getExpiredProducts();
            expiringProductCount = daoAdminOverview.getExpiringProducts();
            almostOutOfStockProducts = daoAdminOverview.getAlmostOutOfStockProducts();
            outOfStockProducts = daoAdminOverview.getOutOfStockProducts();
            ordersMonth = daoAdminOverview.getDeliveredOrdersOfMonth();
            ordersYear = daoAdminOverview.getDeliveredOrdersOfYear();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        request.setAttribute("totalReview", totalReview);
        request.setAttribute("avgRating", avgRating);
        request.setAttribute("totalAvailableDiscount", totalAvailableDiscount);
        request.setAttribute("totalDiscount", totalDiscount);
        request.setAttribute("totalCategory", totalCategory);
        request.setAttribute("totalSuppliers", totalSuppliers);
        request.setAttribute("activeAccounts", activeAccounts);
        request.setAttribute("disableAccounts", disableAccounts);
        request.setAttribute("almostOutOfStockProducts", almostOutOfStockProducts);
        request.setAttribute("outOfStockProducts", outOfStockProducts);
        request.setAttribute("totalIventory", totalIventory);
        request.setAttribute("expiredProductCount", expiredProductCount);
        request.setAttribute("expiringProductCount", expiringProductCount);
        request.setAttribute("ordersMonth", ordersMonth);
        request.setAttribute("ordersYear", ordersYear);
        request.setAttribute("revenueMonth", revenueMonth);
        request.setAttribute("revenueYear", revenueYear);
        request.setAttribute("topMonthProduct", topMonthProduct);
        request.setAttribute("topYearProduct", topYearProduct);

        request.getRequestDispatcher("/JSP/admin_overview.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}