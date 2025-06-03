package SeafoodShop.servlet;

import SeafoodShop.dao.DataConnect;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.json.JSONArray;
import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.IOException;
import java.sql.SQLException;


@WebServlet("/editCart")
public class EditCart extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Đọc dữ liệu JSON từ body request
        StringBuilder sb = new StringBuilder();
        BufferedReader reader = request.getReader();
        String line;
        while ((line = reader.readLine()) != null) {
            sb.append(line);
        }
        String jsonString = sb.toString();

        JSONObject jsonObject = new JSONObject(jsonString);
        JSONArray cartItems = jsonObject.getJSONArray("cartItems");
        DataConnect dataConnect = new DataConnect();
        for (int i = 0; i < cartItems.length(); i++) {
            String item = cartItems.getString(i);
            String[] parts = item.split(",");
            int cartId = Integer.parseInt(parts[0]);
            int quantity = Integer.parseInt(parts[1]);
            System.out.println(cartId);
            System.out.println(quantity);
            try {
                dataConnect.updateCartQuantity(cartId,quantity);
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }
        System.out.println("cart updated");
        response.setStatus(HttpServletResponse.SC_OK);

    }
}
