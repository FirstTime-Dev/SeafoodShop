package SeafoodShop.servlet;

import SeafoodShop.dao.DAOAdminAccount;
import SeafoodShop.model.User;
import com.google.gson.Gson;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Map;

@MultipartConfig
@WebServlet(name = "EditUserInformation", value = "/EditUserInformation")
public class EditUserInformation extends HttpServlet {

    // Utility: parse integer or return null
    private Integer tryParseInt(String s) {
        try {
            return (s != null ? Integer.parseInt(s) : null);
        } catch (NumberFormatException e) {
            return null;
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");

        String userIDStr = request.getParameter("userID");
        Integer userID = tryParseInt(userIDStr);
        if (userID == null) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"error\":\"Missing or invalid userID\"}");
            return;
        }

        DAOAdminAccount dao = new DAOAdminAccount();
        User u = dao.getUserbyID(userID);
        if (u == null) {
            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
            response.getWriter().write("{\"error\":\"User not found\"}");
            return;
        }
        // Build a simple DTO map to control date format
        Map<String, Object> dto = new HashMap<>();
        dto.put("userID", u.getUserID());
        dto.put("fullName", u.getFullName());
        dto.put("username", u.getUsername());
        dto.put("password", u.getPassword());
        dto.put("email", u.getEmail());
        dto.put("phone", u.getPhone());
        dto.put("address", u.getAddress());
        dto.put("role", u.getRole());
        dto.put("ban", u.getBan());
        dto.put("state", u.getState());
        dto.put("birthday", u.getBirthday() != null
                ? new SimpleDateFormat("yyyy-MM-dd").format(u.getBirthday())
                : null);
        dto.put("editCreatedAt", u.getEditCreatedAt() != null
                ? new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss").format(u.getEditCreatedAt())
                : null);

        new Gson().toJson(dto, response.getWriter());
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");

        try {
            // read params
            Integer userID = tryParseInt(request.getParameter("userID"));
            String fullName = request.getParameter("fullName");
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String birthDateS = request.getParameter("birthDate");
            String address = request.getParameter("address");
            Integer role = tryParseInt(request.getParameter("role"));
            Integer ban = tryParseInt(request.getParameter("ban"));

            // validate
            if (userID == null) {
                response.setStatus(400);
                response.getWriter().write("{\"error\":\"Missing userID\"}");
                return;
            }
            if (fullName == null || username == null || password == null || email == null || phone == null
                    || role == null || ban == null) {
                response.setStatus(400);
                response.getWriter().write("{\"error\":\"One or more required fields missing\"}");
                return;
            }

            // parse birthDate
            Date birthDate = null;
            if (birthDateS != null && !birthDateS.isEmpty()) {
                try {
                    birthDate = Date.valueOf(birthDateS);
                } catch (IllegalArgumentException ex) {
                    response.setStatus(400);
                    response.getWriter().write("{\"error\":\"birthDate must be yyyy-MM-dd\"}");
                    return;
                }
            }

            // build user
            User u = new User();
            u.setUserID(userID);
            u.setFullName(fullName);
            u.setUsername(username);
            u.setPassword(password);
            u.setEmail(email);
            u.setPhone(phone);
            u.setBirthday(birthDate);
            u.setAddress(address);
            u.setRole(role);
            u.setBan(ban);
            u.setState(1); // always active

            // update
            boolean ok = new DAOAdminAccount().updateUser(u);
            response.getWriter().write("{\"status\":\"" + (ok ? "success" : "error") + "\"}");

        } catch (Exception ex) {
            ex.printStackTrace();
            response.setStatus(500);
            response.getWriter().write("{\"status\":\"error\",\"message\":\"" + ex.getMessage() + "\"}");
        }
    }
}
