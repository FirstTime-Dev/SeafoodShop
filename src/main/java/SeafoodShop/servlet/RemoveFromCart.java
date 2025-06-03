package SeafoodShop.servlet;

import SeafoodShop.dao.DataConnect;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.json.JSONArray;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/removeFromCart")
public class RemoveFromCart extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        int userID = (Integer) session.getAttribute("userID");
        if (session.getAttribute("role") == null) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
        String deletedIdsJson = request.getParameter("deletedIds");
        if (deletedIdsJson == null || deletedIdsJson.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        try {
            JSONArray jsonArray = new JSONArray(deletedIdsJson);
            List<Integer> cartIdList = new ArrayList<>();

            for (int i = 0; i < jsonArray.length(); i++) {
                cartIdList.add(jsonArray.getInt(i));
            }

            DataConnect dc = new DataConnect();
            for (Integer cartId : cartIdList) {
                dc.removeProductFromCart(cartId);
            }
            System.out.println("Removed " + cartIdList.size() + " from cart");
            // Trả về phản hồi OK
            response.setStatus(HttpServletResponse.SC_OK);

        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}
