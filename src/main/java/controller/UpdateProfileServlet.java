package controller;

import util.DatabaseConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/update-profile")
public class UpdateProfileServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/views/login.jsp");
            return;
        }
        
        String hoTen = request.getParameter("hoTen");
        String soDT = request.getParameter("soDT");
        Integer userId = (Integer) session.getAttribute("userId");
        
        String error = "";
        
        if (hoTen == null || hoTen.trim().isEmpty()) {
            error = "Họ tên không được để trống!";
        } else {
            // Cập nhật thông tin
            String sql = "UPDATE nguoidung SET HoTen = ?, SoDT = ? WHERE MaND = ?";
            
            try (Connection conn = DatabaseConnection.getConnection();
                 PreparedStatement pstmt = conn.prepareStatement(sql)) {
                
                pstmt.setString(1, hoTen);
                pstmt.setString(2, soDT);
                pstmt.setInt(3, userId);
                
                int rowsUpdated = pstmt.executeUpdate();
                
                if (rowsUpdated > 0) {
                    // Cập nhật session
                    session.setAttribute("userName", hoTen);
                    request.setAttribute("message", "Cập nhật thông tin thành công!");
                } else {
                    error = "Không thể cập nhật thông tin!";
                }
                
            } catch (SQLException e) {
                error = "Có lỗi xảy ra khi cập nhật thông tin!";
                e.printStackTrace();
            }
        }
        
        if (!error.isEmpty()) {
            request.setAttribute("error", error);
        }
        
        request.getRequestDispatcher("/views/profile.jsp").forward(request, response);
    }
}