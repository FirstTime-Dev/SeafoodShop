package SeafoodShop.service;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter(urlPatterns = {"/JSP/cart.jsp", "/JSP/userInfo.jsp", "/JSP/payment.jsp","/JSP/purchase,jsp"})
public class AuthFilter implements Filter {
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        HttpSession session = req.getSession(false);
        String role = (session != null) ? (String) session.getAttribute("role") : null;

//        String uri = req.getRequestURI();

        // Bỏ qua trang public hoặc login
//        if (uri.contains("/login") || uri.contains("/otp")) {
//            chain.doFilter(request, response);
//            return;
//        }

        // Kiểm tra vai trò
        if (role == null ) {
            res.sendRedirect(req.getContextPath() +"/JSP/login.jsp");
        } else{
            chain.doFilter(request, response);
        }
    }
}
