package SeafoodShop.servlet;

import SeafoodShop.dao.DataConnect;
import jakarta.mail.MessagingException;
import jakarta.servlet.http.HttpSession;
import org.json.JSONObject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import SeafoodShop.service.EmailService;

import java.io.BufferedReader;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/Google_login")
public class Google_login extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession();
        StringBuilder jsonBuilder = new StringBuilder();
        BufferedReader reader = req.getReader();
        String line;
        while ((line = reader.readLine()) != null) {
            jsonBuilder.append(line);
        }
        JSONObject jsonObject = new JSONObject(jsonBuilder.toString());
        String email = jsonObject.getString("email");
        DataConnect dao = new DataConnect();
        try {
            dao.getConnection();
            int userId = dao.getUserIDByEmail(email);
            System.out.println(userId);
            if(userId != -1){
                session.setAttribute("user_id", userId);
                session.setAttribute("role",dao.getUserRole(userId));
            }else{
                String familyName = jsonObject.getString("family_name");
                String givenName = jsonObject.getString("given_name");
                dao.register(email, familyName + " " + givenName);
                userId = dao.getUserIDByEmail(email);
                if(userId != -1){
                    session.setAttribute("user_id", userId);
                    session.setAttribute("role",dao.getUserRole(userId));
                    System.out.println("User registered with google successfully");
                }
            }
        }catch (SQLException e){
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error: " + e.getMessage());
        }
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
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Email sending failed: " + e.getMessage());
        }
    }
}
