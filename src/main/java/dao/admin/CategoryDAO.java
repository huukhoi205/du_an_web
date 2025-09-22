package dao.admin;
import model.admin.Category;
import util.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CategoryDAO {
    private static final String SELECT_ALL = "SELECT * FROM DanhMuc";
    private static final String SELECT_BY_ID = "SELECT * FROM DanhMuc WHERE MaDM = ?";
    private static final String INSERT_SQL = "INSERT INTO DanhMuc (TenDM) VALUES (?)";
    private static final String UPDATE_SQL = "UPDATE DanhMuc SET TenDM = ? WHERE MaDM = ?";
    private static final String DELETE_SQL = "DELETE FROM DanhMuc WHERE MaDM = ?";

    protected Connection getConnection() throws SQLException {
        return DatabaseConnection.getConnection();
    }

    public List<Category> selectAll() {
        List<Category> list = new ArrayList<>();
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(SELECT_ALL);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Category c = new Category();
                c.setMaDM(rs.getInt("MaDM"));
                c.setTenDM(rs.getString("TenDM"));
                list.add(c);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public Category selectById(int maDM) {
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(SELECT_BY_ID)) {
            ps.setInt(1, maDM);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Category c = new Category();
                    c.setMaDM(rs.getInt("MaDM"));
                    c.setTenDM(rs.getString("TenDM"));
                    return c;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean insert(Category c) {
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(INSERT_SQL)) {
            ps.setString(1, c.getTenDM());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean update(Category c) {
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(UPDATE_SQL)) {
            ps.setString(1, c.getTenDM());
            ps.setInt(2, c.getMaDM());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean delete(int maDM) {
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(DELETE_SQL)) {
            ps.setInt(1, maDM);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
