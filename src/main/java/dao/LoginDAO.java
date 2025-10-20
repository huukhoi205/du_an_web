package dao;

import java.sql.*;
import util.DatabaseConnection;

public class LoginDAO {
    
    /**
     * Đăng nhập bằng email/tên đăng nhập và mật khẩu
     */
    public Object[] login(String emailOrUsername, String password) {
        // Thử đăng nhập bằng email trước
        String sql = "SELECT tk.MaTK, tk.MaND, tk.TenDangNhap, tk.VaiTro, nd.HoTen, nd.Email, nd.SoDT " +
                     "FROM taikhoan tk " +
                     "INNER JOIN nguoidung nd ON tk.MaND = nd.MaND " +
                     "WHERE nd.Email = ? AND tk.MatKhau = ? AND tk.TrangThai = 1";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, emailOrUsername);
            pstmt.setString(2, password);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return new Object[]{
                        rs.getInt("MaTK"),
                        rs.getInt("MaND"), 
                        rs.getString("TenDangNhap"),
                        rs.getString("VaiTro"),
                        rs.getString("HoTen"),
                        rs.getString("Email"),
                        rs.getString("SoDT")
                    };
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        // Nếu không tìm thấy bằng email, thử bằng tên đăng nhập
        sql = "SELECT tk.MaTK, tk.MaND, tk.TenDangNhap, tk.VaiTro, nd.HoTen, nd.Email, nd.SoDT " +
              "FROM taikhoan tk " +
              "INNER JOIN nguoidung nd ON tk.MaND = nd.MaND " +
              "WHERE tk.TenDangNhap = ? AND tk.MatKhau = ? AND tk.TrangThai = 1";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, emailOrUsername);
            pstmt.setString(2, password);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return new Object[]{
                        rs.getInt("MaTK"),
                        rs.getInt("MaND"), 
                        rs.getString("TenDangNhap"),
                        rs.getString("VaiTro"),
                        rs.getString("HoTen"),
                        rs.getString("Email"),
                        rs.getString("SoDT")
                    };
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }
    
    /**
     * Kiểm tra email đã tồn tại chưa
     */
    public boolean emailExists(String email) {
        String sql = "SELECT COUNT(*) FROM nguoidung WHERE Email = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, email);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    /**
     * Kiểm tra tên đăng nhập đã tồn tại chưa
     */
    public boolean usernameExists(String username) {
        String sql = "SELECT COUNT(*) FROM taikhoan WHERE TenDangNhap = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, username);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}