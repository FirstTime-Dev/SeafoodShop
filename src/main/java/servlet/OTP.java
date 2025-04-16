package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.IOException;

@WebServlet("/otp")
public class OTP extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        StringBuilder jsonBuilder = new StringBuilder();
        BufferedReader reader = req.getReader();
        String line;
        while ((line = reader.readLine()) != null) {
            jsonBuilder.append(line);
        }
        JSONObject jsonObject = new JSONObject(jsonBuilder.toString());
        String otp = jsonObject.getString("otp");

        if (otp.equals(req.getParameter("otp"))) {
            JSONObject jsonResponse = new JSONObject();
            jsonResponse.put("status", "success");
            jsonResponse.put("otp", otp); // nếu frontend cần sử dụng
            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            resp.getWriter().write(jsonResponse.toString());
        }
    }
}
