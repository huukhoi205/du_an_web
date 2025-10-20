package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import util.DatabaseConnection;

public class DiaChiGiaoHangDAO {
    
    public List<DiaChiGiaoHang> getDiaChiByMaND(int maND) {
        List<DiaChiGiaoHang> danhSachDiaChi = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM diachigiaohang WHERE MaND = ? ORDER BY MacDinh DESC";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, maND);
            rs = stmt.executeQuery();
            
            while (rs.next()) {
                DiaChiGiaoHang diaChi = new DiaChiGiaoHang();
                diaChi.setMaDC(rs.getInt("MaDC"));
                diaChi.setMaND(rs.getInt("MaND"));
                diaChi.setHoTenNguoiNhan(rs.getString("HoTenNguoiNhan"));
                diaChi.setSoDTNguoiNhan(rs.getString("SoDTNguoiNhan"));
                diaChi.setDiaChiChiTiet(rs.getString("DiaChiChiTiet"));
                diaChi.setMacDinh(rs.getBoolean("MacDinh"));
                danhSachDiaChi.add(diaChi);
            }
            
        } catch (SQLException e) {
            System.err.println("Error getting delivery addresses: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DatabaseConnection.close(conn, stmt, rs);
        }
        
        return danhSachDiaChi;
    }
    
    public DiaChiGiaoHang getDiaChiMacDinh(int maND) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM diachigiaohang WHERE MaND = ? AND MacDinh = 1 LIMIT 1";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, maND);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                DiaChiGiaoHang diaChi = new DiaChiGiaoHang();
                diaChi.setMaDC(rs.getInt("MaDC"));
                diaChi.setMaND(rs.getInt("MaND"));
                diaChi.setHoTenNguoiNhan(rs.getString("HoTenNguoiNhan"));
                diaChi.setSoDTNguoiNhan(rs.getString("SoDTNguoiNhan"));
                diaChi.setDiaChiChiTiet(rs.getString("DiaChiChiTiet"));
                diaChi.setMacDinh(rs.getBoolean("MacDinh"));
                return diaChi;
            }
            
        } catch (SQLException e) {
            System.err.println("Error getting default delivery address: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DatabaseConnection.close(conn, stmt, rs);
        }
        
        return null;
    }
    
    public boolean insertDiaChi(DiaChiGiaoHang diaChi) {
        Connection conn = null;
        PreparedStatement stmt = null;
        
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "INSERT INTO diachigiaohang (MaND, HoTenNguoiNhan, SoDTNguoiNhan, DiaChiChiTiet, MacDinh) VALUES (?, ?, ?, ?, ?)";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, diaChi.getMaND());
            stmt.setString(2, diaChi.getHoTenNguoiNhan());
            stmt.setString(3, diaChi.getSoDTNguoiNhan());
            stmt.setString(4, diaChi.getDiaChiChiTiet());
            stmt.setBoolean(5, diaChi.isMacDinh());
            
            int result = stmt.executeUpdate();
            return result > 0;
            
        } catch (SQLException e) {
            System.err.println("Error inserting delivery address: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            DatabaseConnection.close(conn, stmt, null);
        }
    }
    
    // Inner class để đại diện cho địa chỉ giao hàng
    public static class DiaChiGiaoHang {
        private int maDC;
        private int maND;
        private String hoTenNguoiNhan;
        private String soDTNguoiNhan;
        private String diaChiChiTiet;
        private boolean macDinh;
        
        // Constructors
        public DiaChiGiaoHang() {}
        
        public DiaChiGiaoHang(int maND, String hoTenNguoiNhan, String soDTNguoiNhan, String diaChiChiTiet, boolean macDinh) {
            this.maND = maND;
            this.hoTenNguoiNhan = hoTenNguoiNhan;
            this.soDTNguoiNhan = soDTNguoiNhan;
            this.diaChiChiTiet = diaChiChiTiet;
            this.macDinh = macDinh;
        }
        
        // Getters and Setters
        public int getMaDC() { return maDC; }
        public void setMaDC(int maDC) { this.maDC = maDC; }
        
        public int getMaND() { return maND; }
        public void setMaND(int maND) { this.maND = maND; }
        
        public String getHoTenNguoiNhan() { return hoTenNguoiNhan; }
        public void setHoTenNguoiNhan(String hoTenNguoiNhan) { this.hoTenNguoiNhan = hoTenNguoiNhan; }
        
        public String getSoDTNguoiNhan() { return soDTNguoiNhan; }
        public void setSoDTNguoiNhan(String soDTNguoiNhan) { this.soDTNguoiNhan = soDTNguoiNhan; }
        
        public String getDiaChiChiTiet() { return diaChiChiTiet; }
        public void setDiaChiChiTiet(String diaChiChiTiet) { this.diaChiChiTiet = diaChiChiTiet; }
        
        public boolean isMacDinh() { return macDinh; }
        public void setMacDinh(boolean macDinh) { this.macDinh = macDinh; }
    }
}
