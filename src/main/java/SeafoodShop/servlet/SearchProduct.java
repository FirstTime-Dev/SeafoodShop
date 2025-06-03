package SeafoodShop.servlet;

import SeafoodShop.dao.DataConnect;
import SeafoodShop.model.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "SearchProduct", urlPatterns = {"/searchProduct"})
public class SearchProduct extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String query = request.getParameter("query");
        String catIdStr = request.getParameter("catId");

        DataConnect dao = new DataConnect();
        List<Product> results = null;

        try {
            if (catIdStr != null && !catIdStr.isEmpty()) {
                int catId = Integer.parseInt(catIdStr);
                results = dao.getProductsByCategory(catId);
                request.setAttribute("selectedCatId", catId);
            } else {
                String keyword = (query == null) ? "" : query.trim();
                results = dao.searchProductsWithImage(keyword);
                request.setAttribute("searchQuery", keyword);
            }
        } catch (NumberFormatException ex) {
            results = dao.searchProductsWithImage("");
        }

        request.setAttribute("searchResults", results);
        request.getRequestDispatcher("/JSP/searchProducts.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        doGet(req, resp);
    }
}
