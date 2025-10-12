package dao.admin;

import model.admin.RepairSchedule;
import util.DatabaseConnection;

import java.sql.*;
import java.util.*;
import java.math.BigDecimal;

public class RepairScheduleDAO {

    public List<RepairSchedule> findAll() {
        List<RepairSchedule> list = new ArrayList<>();
        String sql = "SELECT * FROM lichsuachua ORDER BY MaSC DESC";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                RepairSchedule r = new RepairSchedule();
                r.setMaSC(rs.getInt("MaSC"));
                r.setMaND(rs.getInt("MaND"));
                r.setTenThietBi(rs.getString("TenThietBi"));
                r.setMoTaLoi(rs.getString("MoTaLoi"));
                r.setChiPhiDuKien(rs.getBigDecimal("ChiPhiDuKien"));
                r.setChiPhiThucTe(rs.getBigDecimal("ChiPhiThucTe"));
                r.setTrangThai(rs.getString("TrangThai"));
                r.setNgayTiepNhan(rs.getTimestamp("NgayTiepNhan"));
                r.setNgayHoanTat(rs.getTimestamp("NgayHoanTat"));
                list.add(r);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public RepairSchedule findById(int id) {
        String sql = "SELECT * FROM lichsuachua WHERE MaSC = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    RepairSchedule r = new RepairSchedule();
                    r.setMaSC(rs.getInt("MaSC"));
                    r.setMaND(rs.getInt("MaND"));
                    r.setTenThietBi(rs.getString("TenThietBi"));
                    r.setMoTaLoi(rs.getString("MoTaLoi"));
                    r.setChiPhiDuKien(rs.getBigDecimal("ChiPhiDuKien"));
                    r.setChiPhiThucTe(rs.getBigDecimal("ChiPhiThucTe"));
                    r.setTrangThai(rs.getString("TrangThai"));
                    r.setNgayTiepNhan(rs.getTimestamp("NgayTiepNhan"));
                    r.setNgayHoanTat(rs.getTimestamp("NgayHoanTat"));
                    return r;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean insert(RepairSchedule r) {
        String sql = "INSERT INTO lichsuachua (MaND,TenThietBi,MoTaLoi,ChiPhiDuKien,ChiPhiThucTe,TrangThai) VALUES (?,?,?,?,?,?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, r.getMaND());
            ps.setString(2, r.getTenThietBi());
            ps.setString(3, r.getMoTaLoi());
            ps.setBigDecimal(4, r.getChiPhiDuKien());
            ps.setBigDecimal(5, r.getChiPhiThucTe());
            ps.setString(6, r.getTrangThai());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean update(RepairSchedule r) {
        String sql = "UPDATE lichsuachua SET MaND=?, TenThietBi=?, MoTaLoi=?, ChiPhiDuKien=?, ChiPhiThucTe=?, TrangThai=?, NgayHoanTat=? WHERE MaSC=?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, r.getMaND());
            ps.setString(2, r.getTenThietBi());
            ps.setString(3, r.getMoTaLoi());
            ps.setBigDecimal(4, r.getChiPhiDuKien());
            ps.setBigDecimal(5, r.getChiPhiThucTe());
            ps.setString(6, r.getTrangThai());
            ps.setTimestamp(7, r.getNgayHoanTat());
            ps.setInt(8, r.getMaSC());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean delete(int id) {
        String sql = "DELETE FROM lichsuachua WHERE MaSC = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
