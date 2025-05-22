package SeafoodShop.servlet;

import SeafoodShop.dao.DAOAdminAccount;
import SeafoodShop.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Date;

@WebServlet(name = "CreateNewAccount", value = "/CreateNewAccount")
public class CreateNewAccount extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");

        try {
            String fullName = request.getParameter("fullName");
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String birthdayStr = request.getParameter("birthday");
            String address = request.getParameter("address");

            Date birthday = null;
            if (birthdayStr != null && !birthdayStr.isEmpty()) {
                try {
                    birthday = Date.valueOf(birthdayStr);
                } catch (IllegalArgumentException e) {
                    response.getWriter().write("{\"success\": false, \"error\": \"Ngày sinh không hợp lệ (yyyy-MM-dd)\"}");
                    return;
                }
            }

            User u = new User();
            u.setFullName(fullName);
            u.setUsername(username);
            u.setPassword(password);
            u.setEmail(email);
            u.setPhone(phone);
            u.setBirthday(birthday);
            u.setAddress(address);

            DAOAdminAccount dao = new DAOAdminAccount();
            boolean created = dao.createUser(u);

            if (created) {
                response.getWriter().write("{\"success\": true}");
            } else {
                response.getWriter().write("{\"success\": false, \"error\": \"Không thể tạo tài khoản trong DB\"}");
            }

        } catch (Exception e) {
            e.printStackTrace(); // Log lỗi chi tiết
            String safeMessage = e.getMessage() != null ? e.getMessage().replace("\"", "\\\"") : "Lỗi không xác định";
            response.getWriter().write("{\"success\": false, \"error\": \"" + safeMessage + "\"}");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}
