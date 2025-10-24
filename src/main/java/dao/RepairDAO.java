package dao;

import model.RepairRequest;
import util.DatabaseConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RepairDAO {
    
    // Lưu yêu cầu sửa chữa và trả về MaSC (ID)
    public int saveRepairRequest(RepairRequest request) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "INSERT INTO lichsuachua (MaND, TenThietBi, MoTaLoi, ChiPhiDuKien, TrangThai, NgayTiepNhan) " +
                        "VALUES (?, ?, ?, ?, 'TiepNhan', NOW())";
            
            System.out.println("RepairDAO.saveRepairRequest - SQL: " + sql);
            System.out.println("RepairDAO.saveRepairRequest - MaND: " + request.getMaND());
            System.out.println("RepairDAO.saveRepairRequest - TenThietBi: " + request.getTenThietBi());
            System.out.println("RepairDAO.saveRepairRequest - MoTaLoi: " + request.getMoTaLoi());
            System.out.println("RepairDAO.saveRepairRequest - ChiPhiDuKien: " + request.getChiPhiDuKien());
            
            stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            stmt.setInt(1, request.getMaND());
            stmt.setString(2, request.getTenThietBi());
            stmt.setString(3, request.getMoTaLoi());
            stmt.setDouble(4, request.getChiPhiDuKien());
            
            int result = stmt.executeUpdate();
            System.out.println("RepairDAO.saveRepairRequest - Result: " + result);
            
            if (result > 0) {
                rs = stmt.getGeneratedKeys();
                if (rs.next()) {
                    int maSC = rs.getInt(1);
                    System.out.println("RepairDAO.saveRepairRequest - Generated MaSC: " + maSC);
                    return maSC;
                }
            }
            
            return -1; // Lỗi
            
        } catch (SQLException e) {
            System.err.println("Error saving repair request: " + e.getMessage());
            e.printStackTrace();
            return -1;
        } finally {
            DatabaseConnection.close(conn, stmt, rs);
        }
    }
    
    // Lấy lịch sử sửa chữa của user
    public List<RepairRequest> getRepairHistory(int maND) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<RepairRequest> history = new ArrayList<>();
        
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM lichsuachua WHERE MaND = ? ORDER BY NgayTiepNhan DESC";
            
            System.out.println("RepairDAO.getRepairHistory - SQL: " + sql);
            System.out.println("RepairDAO.getRepairHistory - MaND: " + maND);
            
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, maND);
            rs = stmt.executeQuery();
            
            while (rs.next()) {
                RepairRequest request = new RepairRequest();
                request.setMaSC(rs.getInt("MaSC"));
                request.setMaND(rs.getInt("MaND"));
                request.setTenThietBi(rs.getString("TenThietBi"));
                request.setMoTaLoi(rs.getString("MoTaLoi"));
                request.setChiPhiDuKien(rs.getDouble("ChiPhiDuKien"));
                request.setChiPhiThucTe((Double) rs.getObject("ChiPhiThucTe"));
                request.setTrangThai(rs.getString("TrangThai"));
                request.setNgayTiepNhan(rs.getTimestamp("NgayTiepNhan"));
                request.setNgayHoanTat(rs.getTimestamp("NgayHoanTat"));
                
                System.out.println("RepairDAO.getRepairHistory - Found repair request: MaSC=" + request.getMaSC() + 
                                 ", TenThietBi=" + request.getTenThietBi() + 
                                 ", TrangThai=" + request.getTrangThai());
                
                history.add(request);
            }
            
            System.out.println("RepairDAO.getRepairHistory - Total records found: " + history.size());
            
        } catch (SQLException e) {
            System.err.println("Error getting repair history: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DatabaseConnection.close(conn, stmt, rs);
        }
        
        return history;
    }
    
    // Lấy thông tin repair request theo MaSC
    public RepairRequest getRepairRequestById(int maSC) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        RepairRequest request = null;
        
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM lichsuachua WHERE MaSC = ?";
            
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, maSC);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                request = new RepairRequest();
                request.setMaSC(rs.getInt("MaSC"));
                request.setMaND(rs.getInt("MaND"));
                request.setTenThietBi(rs.getString("TenThietBi"));
                request.setMoTaLoi(rs.getString("MoTaLoi"));
                request.setChiPhiDuKien(rs.getDouble("ChiPhiDuKien"));
                request.setChiPhiThucTe((Double) rs.getObject("ChiPhiThucTe"));
                request.setTrangThai(rs.getString("TrangThai"));
                request.setNgayTiepNhan(rs.getTimestamp("NgayTiepNhan"));
                request.setNgayHoanTat(rs.getTimestamp("NgayHoanTat"));
            }
            
        } catch (SQLException e) {
            System.err.println("Error getting repair request: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DatabaseConnection.close(conn, stmt, rs);
        }
        
        return request;
    }
}