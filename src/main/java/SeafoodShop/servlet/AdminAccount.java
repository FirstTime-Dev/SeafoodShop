package SeafoodShop.servlet;

import SeafoodShop.dao.DAOAdminAccount;
import SeafoodShop.model.User;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.ServletException;
import org.json.JSONObject;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet(name = "AdminAccount", value = "/AdminAccount")
public class AdminAccount extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DAOAdminAccount daoAdminAccount = new DAOAdminAccount();
        try {
            // Lấy danh sách người dùng từ cơ sở dữ liệu
            List<User> users = daoAdminAccount.getAllUserActive();  // Hàm này cần có trong DAO để lấy danh sách người dùng

            // Truyền danh sách người dùng vào request
            request.setAttribute("users", users);

            // Chuyển tiếp tới trang admin_accounts.jsp để hiển thị danh sách người dùng
            request.getRequestDispatcher("/JSP/admin_accounts.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin_accounts.jsp?status=error");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Lấy userId từ query parameter
            String userId = request.getParameter("userId");

            if (userId != null) {
                // Đọc dữ liệu JSON từ request body
                StringBuilder sb = new StringBuilder();
                String line;
                while ((line = request.getReader().readLine()) != null) {
                    sb.append(line);
                }

                JSONObject json = new JSONObject(sb.toString());
                int banStatus = json.getInt("banStatus");

                // Cập nhật database
                DAOAdminAccount daoAdminAccount = new DAOAdminAccount();
                boolean success = daoAdminAccount.updateBanStatus(userId, banStatus);

                if (success) {
                    response.setStatus(HttpServletResponse.SC_OK);
                    response.getWriter().write("{\"success\": true}");  // Trả về success
                } else {
                    response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                    response.getWriter().write("{\"success\": false}");  // Trả về thất bại
                }
            } else {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("{\"error\": \"Missing userId in query parameter\"}");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"error\": \"" + e.getMessage() + "\"}");  // Lỗi
        }
    }

}