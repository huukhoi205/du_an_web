package dao;

import model.ExchangeRequest;
import util.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ExchangeDAO {
    
    // Lưu yêu cầu thu mua và trả về MaTMC (ID)
    public int saveExchangeRequest(ExchangeRequest request) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "INSERT INTO thumuacu (MaND, TenMay, HangSX, TinhTrang, GiaDeXuat, TrangThai, HinhAnh, MoTaChiTiet, SanPhamLienQuan, DiaChi) " +
                        "VALUES (?, ?, ?, ?, ?, 'ChoDuyet', ?, ?, ?, ?)";
            
            System.out.println("ExchangeDAO.saveExchangeRequest - SQL: " + sql);
            System.out.println("ExchangeDAO.saveExchangeRequest - MaND: " + request.getMaND());
            System.out.println("ExchangeDAO.saveExchangeRequest - TenMay: " + request.getTenMay());
            System.out.println("ExchangeDAO.saveExchangeRequest - HangSX: " + request.getHangSX());
            System.out.println("ExchangeDAO.saveExchangeRequest - TinhTrang: " + request.getTinhTrang());
            System.out.println("ExchangeDAO.saveExchangeRequest - GiaDeXuat: " + request.getGiaDeXuat());
            System.out.println("ExchangeDAO.saveExchangeRequest - MoTaChiTiet: " + request.getMoTaChiTiet());
            System.out.println("ExchangeDAO.saveExchangeRequest - SanPhamLienQuan: " + request.getSanPhamLienQuan());
            System.out.println("ExchangeDAO.saveExchangeRequest - DiaChi: " + request.getDiaChi());
            
            stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            stmt.setInt(1, request.getMaND());
            stmt.setString(2, request.getTenMay());
            stmt.setString(3, request.getHangSX());
            stmt.setString(4, request.getTinhTrang());
            stmt.setBigDecimal(5, request.getGiaDeXuat());
            stmt.setString(6, request.getHinhAnh());
            stmt.setString(7, request.getMoTaChiTiet());
            stmt.setString(8, request.getSanPhamLienQuan());
            stmt.setString(9, request.getDiaChi());
            
            int result = stmt.executeUpdate();
            System.out.println("ExchangeDAO.saveExchangeRequest - Result: " + result);
            
            if (result > 0) {
                rs = stmt.getGeneratedKeys();
                if (rs.next()) {
                    int maTMC = rs.getInt(1);
                    System.out.println("ExchangeDAO.saveExchangeRequest - Generated MaTMC: " + maTMC);
                    return maTMC;
                }
            }
            
            return -1; // Lỗi
            
        } catch (SQLException e) {
            System.err.println("Error saving exchange request: " + e.getMessage());
            e.printStackTrace();
            return -1;
        } finally {
            DatabaseConnection.close(conn, stmt, rs);
        }
    }
    
    // Lấy lịch sử thu mua của user
    public List<ExchangeRequest> getExchangeHistory(int maND) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<ExchangeRequest> history = new ArrayList<>();
        
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM thumuacu WHERE MaND = ? ORDER BY MaTMC DESC";
            
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, maND);
            rs = stmt.executeQuery();
            
            while (rs.next()) {
                ExchangeRequest request = new ExchangeRequest();
                request.setMaTMC(rs.getInt("MaTMC"));
                request.setMaND(rs.getInt("MaND"));
                request.setTenMay(rs.getString("TenMay"));
                request.setHangSX(rs.getString("HangSX"));
                request.setTinhTrang(rs.getString("TinhTrang"));
                request.setGiaDeXuat(rs.getBigDecimal("GiaDeXuat"));
                request.setGiaThoaThuan(rs.getBigDecimal("GiaThoaThuan"));
                request.setTrangThai(rs.getString("TrangThai"));
                request.setHinhAnh(rs.getString("HinhAnh"));
                request.setMoTaChiTiet(rs.getString("MoTaChiTiet"));
                request.setSanPhamLienQuan(rs.getString("SanPhamLienQuan"));
                request.setDiaChi(rs.getString("DiaChi"));
                request.setNgayTao(rs.getTimestamp("NgayTao"));
                request.setNgayCapNhat(rs.getTimestamp("NgayCapNhat"));
                
                history.add(request);
            }
            
        } catch (SQLException e) {
            System.err.println("Error getting exchange history: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DatabaseConnection.close(conn, stmt, rs);
        }
        
        return history;
    }
    
    // Lấy thông tin exchange request theo MaTMC
    public ExchangeRequest getExchangeRequestById(int maTMC) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        ExchangeRequest request = null;
        
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM thumuacu WHERE MaTMC = ?";
            
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, maTMC);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                request = new ExchangeRequest();
                request.setMaTMC(rs.getInt("MaTMC"));
                request.setMaND(rs.getInt("MaND"));
                request.setTenMay(rs.getString("TenMay"));
                request.setHangSX(rs.getString("HangSX"));
                request.setTinhTrang(rs.getString("TinhTrang"));
                request.setGiaDeXuat(rs.getBigDecimal("GiaDeXuat"));
                request.setGiaThoaThuan(rs.getBigDecimal("GiaThoaThuan"));
                request.setTrangThai(rs.getString("TrangThai"));
                request.setHinhAnh(rs.getString("HinhAnh"));
                request.setMoTaChiTiet(rs.getString("MoTaChiTiet"));
                request.setSanPhamLienQuan(rs.getString("SanPhamLienQuan"));
                request.setDiaChi(rs.getString("DiaChi"));
                request.setNgayTao(rs.getTimestamp("NgayTao"));
                request.setNgayCapNhat(rs.getTimestamp("NgayCapNhat"));
            }
            
        } catch (SQLException e) {
            System.err.println("Error getting exchange request: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DatabaseConnection.close(conn, stmt, rs);
        }
        
        return request;
    }
}
