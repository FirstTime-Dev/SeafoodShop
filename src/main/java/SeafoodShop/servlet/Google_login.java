package SeafoodShop.servlet;

import jakarta.mail.MessagingException;
import org.json.JSONObject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import SeafoodShop.service.EmailService;

import java.io.BufferedReader;
import java.io.IOException;

@WebServlet("/Google_login")
public class Google_login extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        StringBuilder jsonBuilder = new StringBuilder();
        BufferedReader reader = req.getReader();
        String line;
        while ((line = reader.readLine()) != null) {
            jsonBuilder.append(line);
        }
        JSONObject jsonObject = new JSONObject(jsonBuilder.toString());
        String email = jsonObject.getString("email");
        System.out.println(email);
        try {
            EmailService emailService = new EmailService();
            String otp = emailService.generateOTP();
            EmailService.sendEmail(email, otp);

            JSONObject jsonResponse = new JSONObject();
            jsonResponse.put("status", "success");
            jsonResponse.put("otp", otp); // nếu frontend cần sử dụng
            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            resp.getWriter().write(jsonResponse.toString());
        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }
    }
}
