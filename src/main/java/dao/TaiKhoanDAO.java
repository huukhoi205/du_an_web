package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import util.DatabaseConnection;

public class TaiKhoanDAO {
    private Connection conn = null;
    
    public TaiKhoanDAO() throws SQLException {
        this.conn = DatabaseConnection.getConnection();
    }
    
    public boolean isUsernameExists(String username) throws SQLException {
        String sql = "SELECT COUNT(*) FROM TaiKhoan WHERE username = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        }
        return false;
    }
    
    public boolean insertTaiKhoan(int maND, String username, String password) throws SQLException {
        String sql = "INSERT INTO TaiKhoan (maND, username, password) VALUES (?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, maND);
            stmt.setString(2, username);
            stmt.setString(3, password);
            
            int affectedRows = stmt.executeUpdate();
            return affectedRows > 0;
        }
    }
}