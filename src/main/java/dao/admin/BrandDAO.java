package dao.admin;

import model.admin.Brand;
import util.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BrandDAO {
    private static final String SELECT_ALL = "SELECT MaDM, TenDM FROM danhmuc";

    protected Connection getConnection() throws SQLException {
        return DatabaseConnection.getConnection();
    }

    public List<Brand> selectAllBrands() throws SQLException {
        List<Brand> list = new ArrayList<>();
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(SELECT_ALL);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Brand brand = new Brand();
                brand.setMaDM(rs.getInt("MaDM"));
                brand.setTenDM(rs.getString("TenDM"));
                list.add(brand);
            }
        }
        return list;
    }
}