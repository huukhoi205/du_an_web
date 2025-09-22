package dao.admin;
import model.admin.Product;
import util.DatabaseConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Cleaned and standardized ProductDAO.
 * - Uses DatabaseConnection.getConnection()
 * - Uses try-with-resources everywhere
 * - Provides basic CRUD and a flexible searchWithPaging method
 */
public class ProductDAO {

    private static final String SELECT_ALL = "SELECT sp.*, cch.ManHinh, cch.RAM, cch.BoNhoTrong, cch.DungLuongPin, cch.CameraSau FROM SanPham sp LEFT JOIN CauHinhChiTiet cch ON sp.MaSP = cch.MaSP";
    private static final String SELECT_BY_ID = "SELECT sp.*, cch.ManHinh, cch.RAM, cch.BoNhoTrong, cch.DungLuongPin, cch.CameraSau FROM SanPham sp LEFT JOIN CauHinhChiTiet cch ON sp.MaSP = cch.MaSP WHERE sp.MaSP = ?";
    private static final String INSERT_PRODUCT = "INSERT INTO SanPham (TenSP, MaHang, TinhTrang, Gia, SoLuong, HinhAnh, MoTa) VALUES (?, ?, ?, ?, ?, ?, ?)";
    private static final String UPDATE_PRODUCT = "UPDATE SanPham SET TenSP = ?, MaHang = ?, TinhTrang = ?, Gia = ?, SoLuong = ?, HinhAnh = ?, MoTa = ? WHERE MaSP = ?";
    private static final String DELETE_PRODUCT = "DELETE FROM SanPham WHERE MaSP = ?";
    private static final String COUNT_ALL = "SELECT COUNT(*) FROM SanPham";

    protected Connection getConnection() {
        try {
            return DatabaseConnection.getConnection();
        } catch (SQLException e) {
            throw new RuntimeException("Unable to get DB connection", e);
        }
    }

    public List<Product> selectAllProducts() {
        List<Product> list = new ArrayList<>();
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(SELECT_ALL);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(mapRowToProduct(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public Product selectProduct(int maSP) {
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(SELECT_BY_ID)) {
            ps.setInt(1, maSP);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapRowToProduct(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean insertProduct(Product p) {
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(INSERT_PRODUCT, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, p.getTenSP());
            ps.setInt(2, p.getMaHang());
            ps.setString(3, p.getTinhTrang());
            ps.setBigDecimal(4, p.getGia());
            ps.setInt(5, p.getSoLuong());
            ps.setString(6, p.getHinhAnh());
            ps.setString(7, p.getMoTa());
            int affected = ps.executeUpdate();
            if (affected > 0) {
                try (ResultSet keys = ps.getGeneratedKeys()) {
                    if (keys.next()) p.setMaSP(keys.getInt(1));
                }
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateProduct(Product p) {
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(UPDATE_PRODUCT)) {
            ps.setString(1, p.getTenSP());
            ps.setInt(2, p.getMaHang());
            ps.setString(3, p.getTinhTrang());
            ps.setBigDecimal(4, p.getGia());
            ps.setInt(5, p.getSoLuong());
            ps.setString(6, p.getHinhAnh());
            ps.setString(7, p.getMoTa());
            ps.setInt(8, p.getMaSP());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteProduct(int maSP) {
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(DELETE_PRODUCT)) {
            ps.setInt(1, maSP);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public int countAll() {
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(COUNT_ALL);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    /**
     * Flexible search with pagination and optional filters.
     * If a filter is null or empty it will be ignored.
     */
    public List<Product> searchWithPaging(String keyword, Integer maHang, String tinhTrang, int limit, int offset, String sortBy) {
        List<Product> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder(SELECT_ALL);
        List<Object> params = new ArrayList<>();
        boolean whereAdded = false;

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(whereAdded ? " AND " : " WHERE ").append("sp.TenSP LIKE ?");
            params.add("%" + keyword.trim() + "%");
            whereAdded = true;
        }
        if (maHang != null && maHang > 0) {
            sql.append(whereAdded ? " AND " : " WHERE ").append("sp.MaHang = ?");
            params.add(maHang);
            whereAdded = true;
        }
        if (tinhTrang != null && !tinhTrang.trim().isEmpty()) {
            sql.append(whereAdded ? " AND " : " WHERE ").append("sp.TinhTrang = ?");
            params.add(tinhTrang);
            whereAdded = true;
        }

        // sort
        if ("price_asc".equalsIgnoreCase(sortBy)) sql.append(" ORDER BY sp.Gia ASC");
        else if ("price_desc".equalsIgnoreCase(sortBy)) sql.append(" ORDER BY sp.Gia DESC");
        else sql.append(" ORDER BY sp.MaSP DESC");

        sql.append(" LIMIT ? OFFSET ?");
        params.add(limit);
        params.add(offset);

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapRowToProduct(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    private Product mapRowToProduct(ResultSet rs) throws SQLException {
        Product p = new Product();
        p.setMaSP(rs.getInt("MaSP"));
        p.setTenSP(rs.getString("TenSP"));
        p.setMaHang(rs.getInt("MaHang"));
        p.setTinhTrang(rs.getString("TinhTrang"));
        p.setGia(rs.getBigDecimal("Gia"));
        p.setSoLuong(rs.getInt("SoLuong"));
        p.setHinhAnh(rs.getString("HinhAnh"));
        p.setMoTa(rs.getString("MoTa"));
        // config
        try {
            p.setManHinh(rs.getString("ManHinh"));
            p.setRam(rs.getString("RAM"));
            p.setBoNhoTrong(rs.getString("BoNhoTrong"));
            p.setDungLuongPin(rs.getString("DungLuongPin"));
            p.setCameraSau(rs.getString("CameraSau"));
        } catch (SQLException ignored) {}
        return p;
    }
}
