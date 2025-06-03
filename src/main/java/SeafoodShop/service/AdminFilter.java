package SeafoodShop.service;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter("*.jsp")
public class AdminFilter implements Filter {
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        String uri = req.getRequestURI();

        String jspName = uri.substring(uri.lastIndexOf("/") + 1);

        if (jspName.startsWith("admin_")) {
            HttpSession session = req.getSession(false);

            if (session == null || session.getAttribute("role") == null) {
                res.sendRedirect(req.getContextPath() + "/login.jsp");
                return;
            }

            int role = (int) session.getAttribute("role");

            if (role != 2 && role != 3) {
                res.sendRedirect(req.getContextPath() + "/login.jsp");
                return;
            }
        }
        chain.doFilter(request, response);
    }
}
