package dao.admin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import util.DatabaseConnection;

public class UserDAO {
    private static final String CHECK_USER_EXISTS = "SELECT MaND FROM NguoiDung WHERE MaND = ?";
    private static final String GET_ALL_USERS = "SELECT MaND, HoTen, Email, SoDT, DiaChi, NgayTao FROM nguoidung ORDER BY HoTen ASC";
    private static final String GET_USER_BY_ID = "SELECT MaND, HoTen, Email, SoDT, DiaChi, NgayTao FROM nguoidung WHERE MaND = ?";

    protected Connection getConnection() {
        try {
            return DatabaseConnection.getConnection();
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    public boolean userExists(int maND) {
        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement(CHECK_USER_EXISTS)) {
            ps.setInt(1, maND);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Thêm method lấy tất cả người dùng
    public List<User> findAll() {
        List<User> list = new ArrayList<>();
        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement(GET_ALL_USERS);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                User user = new User();
                user.setMaND(rs.getInt("MaND"));
                user.setHoTen(rs.getString("HoTen"));
                user.setEmail(rs.getString("Email"));
                user.setSoDT(rs.getString("SoDT"));
                user.setDiaChi(rs.getString("DiaChi"));
                user.setNgayTao(rs.getTimestamp("NgayTao"));
                list.add(user);
            }
        } catch (SQLException e) {
            System.err.println("Error in UserDAO.findAll: " + e.getMessage());
            e.printStackTrace();
        }
        return list;
    }

    // Thêm method lấy người dùng theo ID
    public User findById(int maND) {
        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement(GET_USER_BY_ID)) {
            
            ps.setInt(1, maND);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    User user = new User();
                    user.setMaND(rs.getInt("MaND"));
                    user.setHoTen(rs.getString("HoTen"));
                    user.setEmail(rs.getString("Email"));
                    user.setSoDT(rs.getString("SoDT"));
                    user.setDiaChi(rs.getString("DiaChi"));
                    user.setNgayTao(rs.getTimestamp("NgayTao"));
                    return user;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error in UserDAO.findById: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    // Inner class User để không cần tạo file riêng
    public static class User {
        private int maND;
        private String hoTen;
        private String email;
        private String soDT;
        private String diaChi;
        private java.sql.Timestamp ngayTao;

        public User() {}

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

        public java.sql.Timestamp getNgayTao() { return ngayTao; }
        public void setNgayTao(java.sql.Timestamp ngayTao) { this.ngayTao = ngayTao; }
    }
}