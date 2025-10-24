package controller;

import dao.LoginDAO;
import dao.CartDAO;
import util.MD5Util;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("/views/login.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        String emailOrUsername = request.getParameter("email");
        String password = request.getParameter("password");
        
        String error = "";
        
        if (emailOrUsername == null || emailOrUsername.trim().isEmpty()) {
            error = "Email/Tên đăng nhập không được để trống!";
        } else if (password == null || password.trim().isEmpty()) {
            error = "Mật khẩu không được để trống!";
        } else {
            // Hash password và đăng nhập
            String hashedPassword = MD5Util.getMD5(password);
            LoginDAO loginDAO = new LoginDAO();
            Object[] userData = loginDAO.login(emailOrUsername, hashedPassword);
            
            if (userData != null) {
                // Đăng nhập thành công
                HttpSession session = request.getSession();
                Integer userId = (Integer) userData[1]; // MaND
                session.setAttribute("userId", userId);
                session.setAttribute("userName", userData[4]); // HoTen
                session.setAttribute("userEmail", userData[5]); // Email
                session.setAttribute("userRole", userData[3]); // VaiTro
                
                // Load giỏ hàng từ database cho user này (chỉ nếu chưa có giỏ hàng trong session)
                List<controller.CartServlet.CartItem> existingCartItems = (List<controller.CartServlet.CartItem>) session.getAttribute("cartItems");
                if (existingCartItems == null || existingCartItems.isEmpty()) {
                    CartDAO cartDAO = new CartDAO();
                    List<controller.CartServlet.CartItem> cartItems = cartDAO.loadCartItems(userId);
                    session.setAttribute("cartItems", cartItems);
                    System.out.println("Loaded cart from database for user " + userId + ": " + cartItems.size() + " items");
                } else {
                    System.out.println("User " + userId + " already has cart in session with " + existingCartItems.size() + " items, keeping session cart");
                }
                
                // Kiểm tra nếu có redirect URL từ "Mua ngay"
                String redirectUrl = request.getParameter("redirect");
                if (redirectUrl != null && !redirectUrl.trim().isEmpty()) {
                    // Thêm thông báo đăng nhập thành công
                    session.setAttribute("loginSuccess", "Đăng nhập thành công! Bạn có thể tiếp tục mua hàng.");
                    response.sendRedirect(redirectUrl);
                } else {
                    // Chuyển hướng theo vai trò (trường hợp bình thường)
                    if ("Admin".equals(userData[3])) {
                        response.sendRedirect(request.getContextPath() + "/admin/index.jsp");
                    } else {
                        response.sendRedirect(request.getContextPath() + "/views/index.jsp");
                    }
                }
                return;
            } else {
                error = "Email/Tên đăng nhập hoặc mật khẩu không đúng!";
            }
        }
        
        // Có lỗi, quay lại trang đăng nhập
        request.setAttribute("error", error);
        request.setAttribute("email", emailOrUsername);
        request.getRequestDispatcher("/views/login.jsp").forward(request, response);
    }
}