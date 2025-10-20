package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import util.DatabaseConnection;

public class ProfileDAO {
    
    /**
     * Lấy thông tin người dùng theo ID
     */
    public UserProfile getUserById(int userId) {
        UserProfile user = null;
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM nguoidung WHERE MaND = ?";
            System.out.println("ProfileDAO.getUserById - SQL: " + sql + ", userId: " + userId);
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                user = new UserProfile();
                user.setMaND(rs.getInt("MaND"));
                user.setHoTen(rs.getString("HoTen"));
                user.setEmail(rs.getString("Email"));
                user.setSoDT(rs.getString("SoDT"));
                user.setDiaChi(rs.getString("DiaChi"));
                // NgaySinh, GioiTinh, VaiTro không có trong bảng nguoidung
                user.setNgaySinh(null);
                user.setGioiTinh(null);
                user.setVaiTro("KhachHang"); // Default role
                System.out.println("ProfileDAO.getUserById - User found: " + user.getHoTen() + ", " + user.getEmail());
            } else {
                System.out.println("ProfileDAO.getUserById - No user found with MaND: " + userId);
            }
            
        } catch (SQLException e) {
            System.err.println("Error getting user profile: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DatabaseConnection.close(conn, stmt, rs);
        }
        
        return user;
    }
    
    /**
     * Cập nhật thông tin người dùng
     */
    public boolean updateUserProfile(UserProfile user) {
        Connection conn = null;
        PreparedStatement stmt = null;
        
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "UPDATE nguoidung SET HoTen = ?, Email = ?, SoDT = ?, DiaChi = ? WHERE MaND = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, user.getHoTen());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getSoDT());
            stmt.setString(4, user.getDiaChi());
            stmt.setInt(5, user.getMaND());
            
            int result = stmt.executeUpdate();
            return result > 0;
            
        } catch (SQLException e) {
            System.err.println("Error updating user profile: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            DatabaseConnection.close(conn, stmt, null);
        }
    }
    
    /**
     * Kiểm tra email đã tồn tại chưa (trừ user hiện tại)
     */
    public boolean isEmailExists(String email, int currentUserId) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT COUNT(*) FROM nguoidung WHERE Email = ? AND MaND != ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            stmt.setInt(2, currentUserId);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
            
        } catch (SQLException e) {
            System.err.println("Error checking email: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DatabaseConnection.close(conn, stmt, rs);
        }
        
        return false;
    }
    
    /**
     * Kiểm tra số điện thoại đã tồn tại chưa (trừ user hiện tại)
     */
    public boolean isPhoneExists(String phone, int currentUserId) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT COUNT(*) FROM nguoidung WHERE SoDT = ? AND MaND != ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, phone);
            stmt.setInt(2, currentUserId);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
            
        } catch (SQLException e) {
            System.err.println("Error checking phone: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DatabaseConnection.close(conn, stmt, rs);
        }
        
        return false;
    }
    
    /**
     * Model class cho thông tin người dùng
     */
    public static class UserProfile {
        private int maND;
        private String hoTen;
        private String email;
        private String soDT;
        private String diaChi;
        private java.sql.Date ngaySinh;
        private String gioiTinh;
        private String vaiTro;
        
        // Constructors
        public UserProfile() {}
        
        public UserProfile(int maND, String hoTen, String email, String soDT, String diaChi, 
                          java.sql.Date ngaySinh, String gioiTinh, String vaiTro) {
            this.maND = maND;
            this.hoTen = hoTen;
            this.email = email;
            this.soDT = soDT;
            this.diaChi = diaChi;
            this.ngaySinh = ngaySinh;
            this.gioiTinh = gioiTinh;
            this.vaiTro = vaiTro;
        }
        
        // Getters and Setters
        public int getMaND() { return maND; }
        public void setMaND(int maND) { this.maND = maND; }
        
        public String getHoTen() { return hoTen; }
        public void setHoTen(String hoTen) { this.hoTen = hoTen; }
        
        public String getEmail() { return email; }
        public void setEmail(String email) { this.email = email; }
        
        public String getSoDT() { return soDT; }
        public void setSoDT(String soDT) { this.soDT = soDT; }
        
        public String getDiaChi() { return diaChi; }
        public void setDiaChi(String diaChi) { this.diaChi = diaChi; }
        
        public java.sql.Date getNgaySinh() { return ngaySinh; }
        public void setNgaySinh(java.sql.Date ngaySinh) { this.ngaySinh = ngaySinh; }
        
        public String getGioiTinh() { return gioiTinh; }
        public void setGioiTinh(String gioiTinh) { this.gioiTinh = gioiTinh; }
        
        public String getVaiTro() { return vaiTro; }
        public void setVaiTro(String vaiTro) { this.vaiTro = vaiTro; }
    }
}
