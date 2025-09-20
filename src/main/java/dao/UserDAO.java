package dao;

import model.User;
import util.DatabaseConnection;
import java.sql.*;

public class UserDAO {
    
    public User authenticateUser(String email, String password) {
        User user = null;
        String sql = "SELECT MaND, HoTen, Email, SoDT, DiaChi, VaiTro FROM NguoiDung " +
                    "WHERE Email = ? AND MatKhau = MD5(?)";
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DatabaseConnection.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, email);
            pstmt.setString(2, password);
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                user = new User();
                user.setMaND(rs.getInt("MaND"));
                user.setHoTen(rs.getString("HoTen"));
                user.setEmail(rs.getString("Email"));
                user.setSoDT(rs.getString("SoDT"));
                user.setDiaChi(rs.getString("DiaChi"));
                user.setVaiTro(rs.getString("VaiTro"));
                user.setTrangThai(true);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DatabaseConnection.close(conn, pstmt, rs);
        }
        
        return user;
    }
    
    public boolean registerUser(User user, String password) {
        String sql = "INSERT INTO NguoiDung (HoTen, Email, SoDT, DiaChi, MatKhau, VaiTro) VALUES (?, ?, ?, ?, MD5(?), ?)";
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            if (isEmailExist(user.getEmail())) {
                return false;
            }
            
            conn = DatabaseConnection.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, user.getHoTen());
            pstmt.setString(2, user.getEmail());
            pstmt.setString(3, user.getSoDT());
            pstmt.setString(4, user.getDiaChi());
            pstmt.setString(5, password);
            pstmt.setString(6, user.getVaiTro() != null ? user.getVaiTro() : "KhachHang");
            
            int result = pstmt.executeUpdate();
            return result > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            DatabaseConnection.close(conn, pstmt, null);
        }
    }
    
    public boolean isEmailExist(String email) {
        String sql = "SELECT COUNT(*) FROM NguoiDung WHERE Email = ?";
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DatabaseConnection.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, email);
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DatabaseConnection.close(conn, pstmt, rs);
        }
        
        return false;
    }
    
    public User getUserById(int userId) {
        User user = null;
        String sql = "SELECT * FROM NguoiDung WHERE MaND = ?";
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DatabaseConnection.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userId);
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                user = new User();
                user.setMaND(rs.getInt("MaND"));
                user.setHoTen(rs.getString("HoTen"));
                user.setEmail(rs.getString("Email"));
                user.setSoDT(rs.getString("SoDT"));
                user.setDiaChi(rs.getString("DiaChi"));
                user.setVaiTro(rs.getString("VaiTro"));
                user.setTrangThai(true);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DatabaseConnection.close(conn, pstmt, rs);
        }
        
        return user;
    }
    
    public boolean updateUser(User user) {
        String sql = "UPDATE NguoiDung SET HoTen = ?, SoDT = ?, DiaChi = ? WHERE MaND = ?";
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = DatabaseConnection.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, user.getHoTen());
            pstmt.setString(2, user.getSoDT());
            pstmt.setString(3, user.getDiaChi());
            pstmt.setInt(4, user.getMaND());
            
            int result = pstmt.executeUpdate();
            return result > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            DatabaseConnection.close(conn, pstmt, null);
        }
    }
    
    public boolean changePassword(int userId, String oldPassword, String newPassword) {
        String checkSql = "SELECT COUNT(*) FROM NguoiDung WHERE MaND = ? AND MatKhau = MD5(?)";
        String updateSql = "UPDATE NguoiDung SET MatKhau = MD5(?) WHERE MaND = ?";
        
        Connection conn = null;
        PreparedStatement checkStmt = null;
        PreparedStatement updateStmt = null;
        ResultSet rs = null;
        
        try {
            conn = DatabaseConnection.getConnection();
            
            checkStmt = conn.prepareStatement(checkSql);
            checkStmt.setInt(1, userId);
            checkStmt.setString(2, oldPassword);
            rs = checkStmt.executeQuery();
            
            if (rs.next() && rs.getInt(1) > 0) {
                updateStmt = conn.prepareStatement(updateSql);
                updateStmt.setString(1, newPassword);
                updateStmt.setInt(2, userId);
                
                int result = updateStmt.executeUpdate();
                return result > 0;
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DatabaseConnection.closeResultSet(rs);
            DatabaseConnection.closeStatement(checkStmt);
            DatabaseConnection.closeStatement(updateStmt);
            DatabaseConnection.closeConnection(conn);
        }
        
        return false;
    }
    
    public boolean resetPassword(String email, String newPassword) {
        String sql = "UPDATE NguoiDung SET MatKhau = MD5(?) WHERE Email = ?";
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = DatabaseConnection.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, newPassword);
            pstmt.setString(2, email);
            
            int result = pstmt.executeUpdate();
            return result > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            DatabaseConnection.close(conn, pstmt, null);
        }
    }
}