package dao.admin;

import model.admin.Customer;
import util.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CustomerDAO {
    private static final String SELECT_ALL = "SELECT * FROM NguoiDung";
    private static final String SELECT_BY_ID = "SELECT * FROM NguoiDung WHERE MaND = ?";
    private static final String INSERT_SQL = "INSERT INTO NguoiDung (HoTen, Email, MatKhau, VaiTro) VALUES (?, ?, ?, ?)";
    private static final String UPDATE_SQL = "UPDATE NguoiDung SET HoTen = ?, Email = ?, MatKhau = ?, VaiTro = ? WHERE MaND = ?";
    private static final String DELETE_SQL = "DELETE FROM NguoiDung WHERE MaND = ?";

    protected Connection getConnection() throws SQLException {
        return DatabaseConnection.getConnection();
    }

    public List<Customer> selectAll() {
        List<Customer> list = new ArrayList<>();
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(SELECT_ALL);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Customer c = new Customer();
                c.setMaND(rs.getInt("MaND"));
                c.setHoTen(rs.getString("HoTen"));
                c.setEmail(rs.getString("Email"));
                c.setMatKhau(rs.getString("MatKhau"));
                c.setVaiTro(rs.getString("VaiTro"));
                list.add(c);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public Customer selectById(int maND) {
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(SELECT_BY_ID)) {
            ps.setInt(1, maND);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Customer c = new Customer();
                    c.setMaND(rs.getInt("MaND"));
                    c.setHoTen(rs.getString("HoTen"));
                    c.setEmail(rs.getString("Email"));
                    c.setMatKhau(rs.getString("MatKhau"));
                    c.setVaiTro(rs.getString("VaiTro"));
                    return c;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean insert(Customer c) {
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(INSERT_SQL)) {
            ps.setString(1, c.getHoTen());
            ps.setString(2, c.getEmail());
            ps.setString(3, c.getMatKhau());
            ps.setString(4, c.getVaiTro());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean update(Customer c) {
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(UPDATE_SQL)) {
            ps.setString(1, c.getHoTen());
            ps.setString(2, c.getEmail());
            ps.setString(3, c.getMatKhau());
            ps.setString(4, c.getVaiTro());
            ps.setInt(5, c.getMaND());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean delete(int maND) {
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(DELETE_SQL)) {
            ps.setInt(1, maND);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
