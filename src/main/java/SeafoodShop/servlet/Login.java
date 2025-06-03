package SeafoodShop.servlet;

import SeafoodShop.dao.DataConnect;
import SeafoodShop.service.EmailService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.IOException;

@WebServlet("/login")
public class Login extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json; charset=UTF-8");

        JSONObject jsonResponse = new JSONObject();

        try {
            // Đọc JSON từ body
            StringBuilder sb = new StringBuilder();
            BufferedReader reader = req.getReader();
            String line;
            while ((line = reader.readLine()) != null) {
                sb.append(line);
            }

            JSONObject json = new JSONObject(sb.toString());
            String username = json.getString("username");
            String password = json.getString("password");

            DataConnect dao = new DataConnect();
            int userId = dao.getUserID(username, password);
            int role = dao.getUserRole(username, password);
            String email = dao.getEmailByUsername(username);

            if (userId != -1 && role != -1 && email != null) {
                // Gửi OTP và lưu trong session
                String otp = EmailService.generateOTP();
                EmailService.sendEmail(email, otp);

                HttpSession session = req.getSession();
                session.setAttribute("otpUserId", userId);
                session.setAttribute("otp", otp); // dùng trực tiếp trong OTP.java
                session.setAttribute("otp_type", "normalLogin");

                jsonResponse.put("status", "success");
            } else {
                jsonResponse.put("status", "invalid");
                jsonResponse.put("message", "Sai username hoặc password");
            }

        } catch (Exception e) {
            e.printStackTrace();
            jsonResponse.put("status", "error");
            jsonResponse.put("message", e.getMessage());
        }

        resp.getWriter().write(jsonResponse.toString());
    }
}
