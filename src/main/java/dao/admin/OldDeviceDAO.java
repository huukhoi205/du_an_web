package dao.admin;

import model.admin.OldDevice;
import util.DatabaseConnection;

import java.sql.*;
import java.util.*;
import java.math.BigDecimal;

public class OldDeviceDAO {

    public List<OldDevice> findAll() {
        List<OldDevice> list = new ArrayList<>();
        String sql = "SELECT * FROM thumuacu ORDER BY MaTMC DESC";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                OldDevice o = new OldDevice(
                    rs.getInt("MaTMC"),
                    rs.getInt("MaND"),
                    rs.getString("TenMay"),
                    rs.getString("HangSX"),
                    rs.getString("TinhTrang"),
                    rs.getBigDecimal("GiaDeXuat"),
                    rs.getBigDecimal("GiaThoaThuan"),
                    rs.getString("TrangThai")
                );
                list.add(o);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public OldDevice findById(int id) {
        String sql = "SELECT * FROM thumuacu WHERE MaTMC = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new OldDevice(
                        rs.getInt("MaTMC"),
                        rs.getInt("MaND"),
                        rs.getString("TenMay"),
                        rs.getString("HangSX"),
                        rs.getString("TinhTrang"),
                        rs.getBigDecimal("GiaDeXuat"),
                        rs.getBigDecimal("GiaThoaThuan"),
                        rs.getString("TrangThai")
                    );
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean insert(OldDevice o) {
        String sql = "INSERT INTO thumuacu (MaND,TenMay,HangSX,TinhTrang,GiaDeXuat,GiaThoaThuan,TrangThai) VALUES (?,?,?,?,?,?,?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, o.getMaND());
            ps.setString(2, o.getTenMay());
            ps.setString(3, o.getHangSX());
            ps.setString(4, o.getTinhTrang());
            ps.setBigDecimal(5, o.getGiaDeXuat());
            ps.setBigDecimal(6, o.getGiaThoaThuan());
            ps.setString(7, o.getTrangThai());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean update(OldDevice o) {
        String sql = "UPDATE thumuacu SET MaND=?, TenMay=?, HangSX=?, TinhTrang=?, GiaDeXuat=?, GiaThoaThuan=?, TrangThai=? WHERE MaTMC=?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, o.getMaND());
            ps.setString(2, o.getTenMay());
            ps.setString(3, o.getHangSX());
            ps.setString(4, o.getTinhTrang());
            ps.setBigDecimal(5, o.getGiaDeXuat());
            ps.setBigDecimal(6, o.getGiaThoaThuan());
            ps.setString(7, o.getTrangThai());
            ps.setInt(8, o.getMaTMC());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean delete(int id) {
        String sql = "DELETE FROM thumuacu WHERE MaTMC = ?";
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
