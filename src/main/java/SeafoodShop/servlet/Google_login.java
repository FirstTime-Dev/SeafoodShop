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
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json; charset=UTF-8");

        JSONObject jsonResponse = new JSONObject();

        try {
            // Đọc JSON từ body
            StringBuilder sb = new StringBuilder();
            String line;
            BufferedReader reader = req.getReader();
            while ((line = reader.readLine()) != null) {
                sb.append(line);
            }
            System.out.println(">> JSON body: " + sb);

            JSONObject json = new JSONObject(sb.toString());

            String email = json.getString("email");
            String familyName = json.getString("family_name");
            String givenName = json.getString("given_name");

            System.out.println(">> Email: " + email);
            System.out.println(">> Họ tên: " + familyName + " " + givenName);

            DataConnect dao = new DataConnect();
            dao.getConnection();

            int userId = dao.getUserIDByEmail(email);
            if (userId != -1) {
                req.getSession().setAttribute("user_id", userId);
                req.getSession().setAttribute("role", dao.getUserRole(userId));
            } else {
                dao.register(email, familyName + " " + givenName);
                userId = dao.getUserIDByEmail(email);
                req.getSession().setAttribute("user_id", userId);
                req.getSession().setAttribute("role", dao.getUserRole(userId));
            }

            jsonResponse.put("status", "success");
            resp.getWriter().write(jsonResponse.toString());

        } catch (Exception e) {
            e.printStackTrace();  //
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            jsonResponse.put("status", "error");
            jsonResponse.put("message", e.getMessage());
            resp.getWriter().write(jsonResponse.toString());
        }
    }

}