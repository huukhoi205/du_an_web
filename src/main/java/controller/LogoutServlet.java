package controller;

import dao.CartDAO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session != null) {
            // Lưu giỏ hàng trước khi đăng xuất
            Integer userId = (Integer) session.getAttribute("userId");
            if (userId != null) {
                List<controller.CartServlet.CartItem> cartItems = 
                    (List<controller.CartServlet.CartItem>) session.getAttribute("cartItems");
                if (cartItems != null) {
                    CartDAO cartDAO = new CartDAO();
                    cartDAO.saveCartItems(userId, cartItems);
                    System.out.println("Saved cart before logout for user " + userId);
                }
            }
            
            session.invalidate();
        }
        
        response.sendRedirect(request.getContextPath() + "/views/index.jsp");
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}