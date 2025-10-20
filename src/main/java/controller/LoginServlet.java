package controller;

import dao.LoginDAO;
import util.MD5Util;

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
                session.setAttribute("userId", userData[1]); // MaND
                session.setAttribute("userName", userData[4]); // HoTen
                session.setAttribute("userEmail", userData[5]); // Email
                session.setAttribute("userRole", userData[3]); // VaiTro
                
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