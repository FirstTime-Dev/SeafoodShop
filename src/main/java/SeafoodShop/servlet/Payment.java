package SeafoodShop.servlet;

import SeafoodShop.dao.DataConnect;
import SeafoodShop.model.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet(name = "PaymentServlet", urlPatterns = {"/Payment"})
public class Payment extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String productIdStr = request.getParameter("product_id");
        if (productIdStr == null) {
            response.sendRedirect(request.getContextPath() + "/JSP/home.jsp");
            return;
        }
        int productId;
        try {
            productId = Integer.parseInt(productIdStr);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/JSP/home.jsp");
            return;
        }

        DataConnect dao = new DataConnect();
        Product product;
        try {
            product = dao.getProductByID(productId);
            if (product == null) {
                response.sendRedirect(request.getContextPath() + "/JSP/home.jsp");
                return;
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/JSP/home.jsp");
            return;
        }

        request.setAttribute("product", product);
        request.getRequestDispatcher("/JSP/payment.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/JSP/login.jsp");
            return;
        }
        int userId = (int) session.getAttribute("userId");

        // 2. Lấy productId và quantity từ form
        String productIdParam = request.getParameter("productId");
        String quantityParam  = request.getParameter("quantity");

        int productId = 0;
        int quantity  = 1;
        try {
            productId = Integer.parseInt(productIdParam);
            quantity  = Integer.parseInt(quantityParam);
            if (quantity < 1) quantity = 1;
        } catch (NumberFormatException e) {
            // Nếu parse lỗi, giữ mặc định quantity=1
        }

        // 3. Lấy giá sản phẩm (price) → nếu bạn đã set sẵn Product vào request trước khi show JSP,
        //    bạn có thể cast từ attribute. Hoặc bạn gọi DAO/ProductDAO để truy vấn giá từ DB.
        //    Ví dụ, product đã được đính kèm request = (Product) request.getAttribute("product"):
        Product product = (Product) request.getAttribute("product");
        BigDecimal price;
        if (product != null && product.getProductID() == productId) {
            price = product.getPrice();
        } else {
            // Trường hợp sản phẩm không nằm trong request, bạn có thể truy vấn DB:
            price = fetchPriceFromDB(productId);
        }

        // 4. Tính tổng đơn giá (tạm gọi là subtotal)
        BigDecimal totalAmount = price.multiply(new BigDecimal(quantity));

        // 5. Gọi DAO để lưu Order → OrderDetails
        DataConnect dao = new DataConnect();

        Connection conn = null;
        try {
            // Muốn gộp chung transaction, bạn có thể lấy Connection rồi setAutoCommit(false),
            // nhưng vì DAO của mình mỗi lần tự mở đóng Connection, ta xử lý riêng lẻ.
            // Nếu cần bắt buộc transaction, hãy sửa lại DAO để truyền Connection từ ngoài vào.

            int orderId = dao.insertOrder(userId, totalAmount);

            dao.insertOrderDetail(orderId, productId, quantity, price);

            // session.removeAttribute("cart");
            // Nếu bạn lưu cart, hãy sửa lại cho phù hợp.

            response.sendRedirect(request.getContextPath() + "/JSP/orderSuccess.jsp?orderId=" + orderId);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Đặt hàng thất bại: " + e.getMessage());
            request.getRequestDispatcher("/JSP/error.jsp").forward(request, response);
        }
    }

    private BigDecimal fetchPriceFromDB(int productId) {
        BigDecimal price = BigDecimal.ZERO;
        String sql = "SELECT Price FROM Products WHERE ProductID = ?";
        try (Connection conn = new DataConnect().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, productId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    price = rs.getBigDecimal("Price");
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return price;
    }
}
