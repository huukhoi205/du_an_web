package controller;

import dao.LoginDAO;
import util.DatabaseConnection;
import util.MD5Util;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("/views/register.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
            String hoTen = request.getParameter("hoTen");
            String email = request.getParameter("email");
            String soDT = request.getParameter("soDT");
            String tenDangNhap = request.getParameter("tenDangNhap");
            String password = request.getParameter("password");
            String confirmPassword = request.getParameter("confirmPassword");
        
        String error = "";
        
        // Validation
        if (hoTen == null || hoTen.trim().isEmpty()) {
            error = "Họ tên không được để trống!";
        } else if (email == null || email.trim().isEmpty()) {
            error = "Email không được để trống!";
        } else if (soDT == null || soDT.trim().isEmpty()) {
            error = "Số điện thoại không được để trống!";
        } else if (tenDangNhap == null || tenDangNhap.trim().isEmpty()) {
            error = "Tên đăng nhập không được để trống!";
        } else if (password == null || password.trim().isEmpty()) {
            error = "Mật khẩu không được để trống!";
        } else if (confirmPassword == null || confirmPassword.trim().isEmpty()) {
            error = "Xác nhận mật khẩu không được để trống!";
        } else if (!password.equals(confirmPassword)) {
            error = "Mật khẩu và xác nhận mật khẩu không khớp!";
        } else if (password.length() < 6) {
            error = "Mật khẩu phải có ít nhất 6 ký tự!";
        } else if (tenDangNhap.length() < 3) {
            error = "Tên đăng nhập phải có ít nhất 3 ký tự!";
        } else if (!isValidEmail(email)) {
            error = "Email không hợp lệ!";
        } else if (!isValidPhone(soDT)) {
            error = "Số điện thoại phải có 10 số!";
        }
        
        if (!error.isEmpty()) {
            request.setAttribute("error", error);
            request.setAttribute("hoTen", hoTen);
            request.setAttribute("email", email);
            request.setAttribute("soDT", soDT);
            request.setAttribute("tenDangNhap", tenDangNhap);
            request.getRequestDispatcher("/views/register.jsp").forward(request, response);
            return;
        }
        
        // Kiểm tra email và username đã tồn tại
        LoginDAO loginDAO = new LoginDAO();
        if (loginDAO.emailExists(email)) {
            error = "Email này đã được sử dụng!";
        } else if (loginDAO.usernameExists(tenDangNhap)) {
            error = "Tên đăng nhập này đã được sử dụng!";
        }
        
        if (!error.isEmpty()) {
            request.setAttribute("error", error);
            request.setAttribute("hoTen", hoTen);
            request.setAttribute("email", email);
            request.setAttribute("soDT", soDT);
            request.setAttribute("tenDangNhap", tenDangNhap);
            request.getRequestDispatcher("/views/register.jsp").forward(request, response);
            return;
        }
        
        // Đăng ký tài khoản
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            conn.setAutoCommit(false);
            
            // Thêm vào bảng nguoidung
            String sqlNguoiDung = "INSERT INTO nguoidung (HoTen, Email, SoDT) VALUES (?, ?, ?)";
            PreparedStatement pstmtNguoiDung = conn.prepareStatement(sqlNguoiDung, Statement.RETURN_GENERATED_KEYS);
            pstmtNguoiDung.setString(1, hoTen);
            pstmtNguoiDung.setString(2, email);
            pstmtNguoiDung.setString(3, soDT);
            pstmtNguoiDung.executeUpdate();
            
            ResultSet generatedKeys = pstmtNguoiDung.getGeneratedKeys();
            int maND = -1;
            if (generatedKeys.next()) {
                maND = generatedKeys.getInt(1);
            }
            pstmtNguoiDung.close();
            generatedKeys.close();
            
            if (maND == -1) {
                throw new SQLException("Không thể lấy MaND được tạo");
            }
            
            // Thêm vào bảng taikhoan
            String sqlTaiKhoan = "INSERT INTO taikhoan (MaND, TenDangNhap, MatKhau, VaiTro, TrangThai) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement pstmtTaiKhoan = conn.prepareStatement(sqlTaiKhoan);
            pstmtTaiKhoan.setInt(1, maND);
            pstmtTaiKhoan.setString(2, tenDangNhap);
            pstmtTaiKhoan.setString(3, MD5Util.getMD5(password));
            pstmtTaiKhoan.setString(4, "KhachHang");
            pstmtTaiKhoan.setBoolean(5, true);
            pstmtTaiKhoan.executeUpdate();
            pstmtTaiKhoan.close();
            
            conn.commit();
            
            // Đăng ký thành công - hiển thị modal
            request.setAttribute("success", "Đăng ký thành công! Bạn sẽ được chuyển đến trang đăng nhập sau 3 giây.");
            request.getRequestDispatcher("/views/register.jsp").forward(request, response);
            
        } catch (SQLException e) {
            try {
                if (conn != null) {
                    conn.rollback();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            error = "Có lỗi xảy ra khi đăng ký. Vui lòng thử lại!";
            request.setAttribute("error", error);
            request.setAttribute("hoTen", hoTen);
            request.setAttribute("email", email);
            request.setAttribute("soDT", soDT);
            request.setAttribute("tenDangNhap", tenDangNhap);
            request.getRequestDispatcher("/views/register.jsp").forward(request, response);
        } finally {
            try {
                if (conn != null) {
                    conn.setAutoCommit(true);
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    
    /**
     * Validate email format
     */
    private boolean isValidEmail(String email) {
        String emailRegex = "^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$";
        return email.matches(emailRegex);
    }
    
    /**
     * Validate phone number (10 digits)
     */
    private boolean isValidPhone(String phone) {
        String phoneDigits = phone.replaceAll("\\D", "");
        return phoneDigits.length() == 10;
    }
}