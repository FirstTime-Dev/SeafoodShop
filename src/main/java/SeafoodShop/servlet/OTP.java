package SeafoodShop.servlet;

import SeafoodShop.dao.DataConnect;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.IOException;

@WebServlet("/otp")
public class OTP extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("JSP/otp.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json");

        JSONObject jsonResponse = new JSONObject();

        try {
            // Đọc JSON từ body
            StringBuilder sb = new StringBuilder();
            String line;
            BufferedReader reader = req.getReader();
            while ((line = reader.readLine()) != null) {
                sb.append(line);
            }
            JSONObject jsonRequest = new JSONObject(sb.toString());

            String clientOtp = jsonRequest.getString("otp");

            HttpSession session = req.getSession();
            String serverOtp = (String) session.getAttribute("otp");
            Integer userId = (Integer) session.getAttribute("otpUserId");

            if (clientOtp.equals(serverOtp) && userId != null) {
                // GỌI TỚI DataConnect
                DataConnect dao = new DataConnect();
                int role = dao.getUserRole(userId);  // gọi đúng phương thức bạn đã viết

                jsonResponse.put("status", "success");
                jsonResponse.put("role", role);

                // Clear OTP info
                session.removeAttribute("otp");
                session.removeAttribute("otpUserId");
            } else {
                jsonResponse.put("status", "fail");
            }

        } catch (Exception e) {
            e.printStackTrace();
            jsonResponse.put("status", "error");
            jsonResponse.put("message", e.getMessage());
        }

        resp.getWriter().write(jsonResponse.toString());
    }
}