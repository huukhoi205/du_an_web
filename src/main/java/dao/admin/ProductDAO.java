package dao.admin;

import model.admin.Product;
import util.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {
    private static final String SELECT_ALL = "SELECT sp.*, cch.ManHinh, cch.RAM, cch.BoNhoTrong, cch.DungLuongPin, cch.CameraSau, cch.CPU, cch.GPU, cch.HeDieuHanh, cch.CameraTruoc, cch.QuayVideo, cch.SacNhanh, cch.SacKhongDay, cch.SIM, cch.WiFi, cch.Bluetooth, cch.GPS, cch.ChatLieu, cch.KichThuoc, cch.TrongLuong, cch.MauSac FROM sanpham sp LEFT JOIN cauhinhchitiet cch ON sp.MaSP = cch.MaSP";
    private static final String SELECT_BY_ID = "SELECT sp.*, cch.ManHinh, cch.RAM, cch.BoNhoTrong, cch.DungLuongPin, cch.CameraSau, cch.CPU, cch.GPU, cch.HeDieuHanh, cch.CameraTruoc, cch.QuayVideo, cch.SacNhanh, cch.SacKhongDay, cch.SIM, cch.WiFi, cch.Bluetooth, cch.GPS, cch.ChatLieu, cch.KichThuoc, cch.TrongLuong, cch.MauSac FROM sanpham sp LEFT JOIN cauhinhchitiet cch ON sp.MaSP = cch.MaSP WHERE sp.MaSP = ?";
    private static final String INSERT_PRODUCT = "INSERT INTO sanpham (TenSP, MaHang, TinhTrang, Gia, SoLuong, HinhAnh, MoTa) VALUES (?, ?, ?, ?, ?, ?, ?)";
    private static final String INSERT_CONFIG = "INSERT INTO cauhinhchitiet (MaSP, ManHinh, CPU, GPU, RAM, BoNhoTrong, HeDieuHanh, CameraTruoc, CameraSau, QuayVideo, DungLuongPin, SacNhanh, SacKhongDay, SIM, WiFi, Bluetooth, GPS, ChatLieu, KichThuoc, TrongLuong, MauSac) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    private static final String BASE_UPDATE_PRODUCT = "UPDATE sanpham SET ";
    private static final String BASE_UPDATE_CONFIG = "UPDATE cauhinhchitiet SET ";
    private static final String CHECK_CONFIG_EXISTS = "SELECT COUNT(*) FROM cauhinhchitiet WHERE MaSP = ?";
    private static final String DELETE_PRODUCT = "DELETE FROM sanpham WHERE MaSP = ?";
    private static final String COUNT_ALL = "SELECT COUNT(*) FROM sanpham";
    private static final String CHECK_BRAND = "SELECT COUNT(*) FROM danhmuc WHERE MaDM = ?";
    private static final String CHECK_PRODUCT_EXISTS = "SELECT COUNT(*) FROM sanpham WHERE MaSP = ?";

    protected Connection getConnection() throws SQLException {
        return DatabaseConnection.getConnection();
    }

    public List<Product> selectAllProducts() throws SQLException {
        List<Product> list = new ArrayList<>();
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(SELECT_ALL);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(mapRowToProduct(rs));
            }
        }
        return list;
    }

    public Product selectProduct(int maSP) throws SQLException {
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(SELECT_BY_ID)) {
            ps.setInt(1, maSP);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapRowToProduct(rs);
                }
            }
        }
        return null;
    }

    public boolean insertProduct(Product p) throws SQLException {
        try (Connection conn = getConnection()) {
            conn.setAutoCommit(false);
            try {
                try (PreparedStatement psProduct = conn.prepareStatement(INSERT_PRODUCT, Statement.RETURN_GENERATED_KEYS)) {
                    setProductParameters(psProduct, p);
                    psProduct.executeUpdate();
                    try (ResultSet generatedKeys = psProduct.getGeneratedKeys()) {
                        if (generatedKeys.next()) {
                            int maSP = generatedKeys.getInt(1);
                            p.setMaSP(maSP);
                            if (hasConfig(p)) {
                                try (PreparedStatement psConfig = conn.prepareStatement(INSERT_CONFIG)) {
                                    setConfigParameters(psConfig, p, maSP);
                                    psConfig.executeUpdate();
                                }
                            }
                        }
                    }
                }
                conn.commit();
                return true;
            } catch (SQLException e) {
                conn.rollback();
                throw e;
            }
        }
    }

    public boolean updateProduct(Product p) throws SQLException {
        if (p.getMaSP() <= 0) {
            throw new IllegalArgumentException("Mã sản phẩm không hợp lệ");
        }

        try (Connection conn = getConnection()) {
            conn.setAutoCommit(false);
            try {
                // Update sanpham
                StringBuilder sbProduct = new StringBuilder(BASE_UPDATE_PRODUCT);
                List<Object> params = new ArrayList<>();
                boolean hasChanges = false;

                if (p.getTenSP() != null) {
                    sbProduct.append("TenSP = ?, ");
                    params.add(p.getTenSP());
                    hasChanges = true;
                }
                if (p.getMaHang() > 0) {
                    sbProduct.append("MaHang = ?, ");
                    params.add(p.getMaHang());
                    hasChanges = true;
                }
                if (p.getTinhTrang() != null) {
                    sbProduct.append("TinhTrang = ?, ");
                    params.add(p.getTinhTrang());
                    hasChanges = true;
                }
                if (p.getGia() != null) {
                    sbProduct.append("Gia = ?, ");
                    params.add(p.getGia());
                    hasChanges = true;
                }
                if (p.getSoLuong() >= 0) {
                    sbProduct.append("SoLuong = ?, ");
                    params.add(p.getSoLuong());
                    hasChanges = true;
                }
                if (p.getHinhAnh() != null) {
                    sbProduct.append("HinhAnh = ?, ");
                    params.add(p.getHinhAnh());
                    hasChanges = true;
                }
                if (p.getMoTa() != null) {
                    sbProduct.append("MoTa = ?, ");
                    params.add(p.getMoTa());
                    hasChanges = true;
                }

                if (hasChanges) {
                    sbProduct.setLength(sbProduct.length() - 2); // Remove trailing comma
                    sbProduct.append(" WHERE MaSP = ?");
                    params.add(p.getMaSP());

                    try (PreparedStatement psProduct = conn.prepareStatement(sbProduct.toString())) {
                        for (int i = 0; i < params.size(); i++) {
                            psProduct.setObject(i + 1, params.get(i));
                        }
                        int rowsAffected = psProduct.executeUpdate();
                        if (rowsAffected == 0) {
                            throw new SQLException("Không thể cập nhật sản phẩm, có thể mã sản phẩm không tồn tại");
                        }
                    }
                }

                // Update cauhinhchitiet
                boolean configHasChanges = false; // Khởi tạo biến ngoài khối if
                if (hasConfig(p)) {
                    boolean configExists = isConfigExists(p.getMaSP());
                    StringBuilder sbConfig = new StringBuilder(BASE_UPDATE_CONFIG);
                    List<Object> configParams = new ArrayList<>();

                    if (p.getManHinh() != null) {
                        sbConfig.append("ManHinh = ?, ");
                        configParams.add(p.getManHinh());
                        configHasChanges = true;
                    }
                    if (p.getCpu() != null) {
                        sbConfig.append("CPU = ?, ");
                        configParams.add(p.getCpu());
                        configHasChanges = true;
                    }
                    if (p.getGpu() != null) {
                        sbConfig.append("GPU = ?, ");
                        configParams.add(p.getGpu());
                        configHasChanges = true;
                    }
                    if (p.getRam() != null) {
                        sbConfig.append("RAM = ?, ");
                        configParams.add(p.getRam());
                        configHasChanges = true;
                    }
                    if (p.getBoNhoTrong() != null) {
                        sbConfig.append("BoNhoTrong = ?, ");
                        configParams.add(p.getBoNhoTrong());
                        configHasChanges = true;
                    }
                    if (p.getHeDieuHanh() != null) {
                        sbConfig.append("HeDieuHanh = ?, ");
                        configParams.add(p.getHeDieuHanh());
                        configHasChanges = true;
                    }
                    if (p.getCameraTruoc() != null) {
                        sbConfig.append("CameraTruoc = ?, ");
                        configParams.add(p.getCameraTruoc());
                        configHasChanges = true;
                    }
                    if (p.getCameraSau() != null) {
                        sbConfig.append("CameraSau = ?, ");
                        configParams.add(p.getCameraSau());
                        configHasChanges = true;
                    }
                    if (p.getQuayVideo() != null) {
                        sbConfig.append("QuayVideo = ?, ");
                        configParams.add(p.getQuayVideo());
                        configHasChanges = true;
                    }
                    if (p.getDungLuongPin() != null) {
                        sbConfig.append("DungLuongPin = ?, ");
                        configParams.add(p.getDungLuongPin());
                        configHasChanges = true;
                    }
                    if (p.getSacNhanh() != null) {
                        sbConfig.append("SacNhanh = ?, ");
                        configParams.add(p.getSacNhanh());
                        configHasChanges = true;
                    }
                    if (p.getSacKhongDay() != null) {
                        sbConfig.append("SacKhongDay = ?, ");
                        configParams.add(p.getSacKhongDay());
                        configHasChanges = true;
                    }
                    if (p.getSim() != null) {
                        sbConfig.append("SIM = ?, ");
                        configParams.add(p.getSim());
                        configHasChanges = true;
                    }
                    if (p.getWifi() != null) {
                        sbConfig.append("WiFi = ?, ");
                        configParams.add(p.getWifi());
                        configHasChanges = true;
                    }
                    if (p.getBluetooth() != null) {
                        sbConfig.append("Bluetooth = ?, ");
                        configParams.add(p.getBluetooth());
                        configHasChanges = true;
                    }
                    if (p.getGps() != null) {
                        sbConfig.append("GPS = ?, ");
                        configParams.add(p.getGps());
                        configHasChanges = true;
                    }
                    if (p.getChatLieu() != null) {
                        sbConfig.append("ChatLieu = ?, ");
                        configParams.add(p.getChatLieu());
                        configHasChanges = true;
                    }
                    if (p.getKichThuoc() != null) {
                        sbConfig.append("KichThuoc = ?, ");
                        configParams.add(p.getKichThuoc());
                        configHasChanges = true;
                    }
                    if (p.getTrongLuong() != null) {
                        sbConfig.append("TrongLuong = ?, ");
                        configParams.add(p.getTrongLuong());
                        configHasChanges = true;
                    }
                    if (p.getMauSac() != null) {
                        sbConfig.append("MauSac = ?, ");
                        configParams.add(p.getMauSac());
                        configHasChanges = true;
                    }

                    if (configHasChanges) {
                        if (configExists) {
                            sbConfig.setLength(sbConfig.length() - 2);
                            sbConfig.append(" WHERE MaSP = ?");
                            configParams.add(p.getMaSP());
                            try (PreparedStatement psConfig = conn.prepareStatement(sbConfig.toString())) {
                                for (int i = 0; i < configParams.size(); i++) {
                                    psConfig.setObject(i + 1, configParams.get(i));
                                }
                                psConfig.executeUpdate();
                            }
                        } else {
                            try (PreparedStatement psConfig = conn.prepareStatement(INSERT_CONFIG)) {
                                setConfigParameters(psConfig, p, p.getMaSP());
                                psConfig.executeUpdate();
                            }
                        }
                    }
                }

                conn.commit();
                return hasChanges || configHasChanges;
            } catch (SQLException e) {
                conn.rollback();
                throw e;
            }
        }
    }

    public boolean deleteProduct(int maSP) throws SQLException {
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(DELETE_PRODUCT)) {
            ps.setInt(1, maSP);
            return ps.executeUpdate() > 0;
        }
    }

    public boolean isConfigExists(int maSP) throws SQLException {
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(CHECK_CONFIG_EXISTS)) {
            ps.setInt(1, maSP);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() && rs.getInt(1) > 0;
            }
        }
    }

    public boolean isBrandExists(int maHang) throws SQLException {
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(CHECK_BRAND)) {
            ps.setInt(1, maHang);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() && rs.getInt(1) > 0;
            }
        }
    }

    public boolean isProductExists(int maSP) throws SQLException {
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(CHECK_PRODUCT_EXISTS)) {
            ps.setInt(1, maSP);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() && rs.getInt(1) > 0;
            }
        }
    }

    public List<Product> searchWithPaging(String keyword, Integer maHang, String tinhTrang, int limit, int offset, String sortBy) throws SQLException {
        StringBuilder sql = new StringBuilder("SELECT sp.*, cch.ManHinh, cch.RAM, cch.BoNhoTrong, cch.DungLuongPin, cch.CameraSau, cch.CPU, cch.GPU, cch.HeDieuHanh, cch.CameraTruoc, cch.QuayVideo, cch.SacNhanh, cch.SacKhongDay, cch.SIM, cch.WiFi, cch.Bluetooth, cch.GPS, cch.ChatLieu, cch.KichThuoc, cch.TrongLuong, cch.MauSac FROM sanpham sp LEFT JOIN cauhinhchitiet cch ON sp.MaSP = cch.MaSP WHERE 1=1");
        List<Object> params = new ArrayList<>();
        if (keyword != null && !keyword.isEmpty()) {
            sql.append(" AND sp.TenSP LIKE ?");
            params.add("%" + keyword + "%");
        }
        if (maHang != null) {
            sql.append(" AND sp.MaHang = ?");
            params.add(maHang);
        }
        if (tinhTrang != null && !tinhTrang.isEmpty()) {
            sql.append(" AND sp.TinhTrang = ?");
            params.add(tinhTrang);
        }
        if (sortBy != null && !sortBy.isEmpty()) {
            sql.append(" ORDER BY ").append(sortBy);
        }
        sql.append(" LIMIT ? OFFSET ?");
        params.add(limit);
        params.add(offset);

        List<Product> list = new ArrayList<>();
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
        }
        return list;
    }

    public int countAllProducts() throws SQLException {
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(COUNT_ALL);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
            return 0;
        }
    }

    public int countProducts(String keyword, Integer maHang, String tinhTrang) throws SQLException {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM sanpham WHERE 1=1");
        List<Object> params = new ArrayList<>();
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND TenSP LIKE ?");
            params.add("%" + keyword.trim() + "%");
        }
        if (maHang != null) {
            sql.append(" AND MaHang = ?");
            params.add(maHang);
        }
        if (tinhTrang != null && !tinhTrang.trim().isEmpty()) {
            sql.append(" AND TinhTrang = ?");
            params.add(tinhTrang.trim());
        }
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return 0;
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
        try {
            p.setManHinh(rs.getString("ManHinh"));
            p.setRam(rs.getString("RAM"));
            p.setBoNhoTrong(rs.getString("BoNhoTrong"));
            p.setDungLuongPin(rs.getString("DungLuongPin"));
            p.setCameraSau(rs.getString("CameraSau"));
            p.setCpu(rs.getString("CPU"));
            p.setGpu(rs.getString("GPU"));
            p.setHeDieuHanh(rs.getString("HeDieuHanh"));
            p.setCameraTruoc(rs.getString("CameraTruoc"));
            p.setQuayVideo(rs.getString("QuayVideo"));
            p.setSacNhanh(rs.getString("SacNhanh"));
            p.setSacKhongDay(rs.getString("SacKhongDay"));
            p.setSim(rs.getString("SIM"));
            p.setWifi(rs.getString("WiFi"));
            p.setBluetooth(rs.getString("Bluetooth"));
            p.setGps(rs.getString("GPS"));
            p.setChatLieu(rs.getString("ChatLieu"));
            p.setKichThuoc(rs.getString("KichThuoc"));
            p.setTrongLuong(rs.getString("TrongLuong"));
            p.setMauSac(rs.getString("MauSac"));
        } catch (SQLException ignored) {}
        return p;
    }

    private boolean hasConfig(Product p) {
        return p.getManHinh() != null || p.getCpu() != null || p.getGpu() != null ||
               p.getRam() != null || p.getBoNhoTrong() != null || p.getHeDieuHanh() != null ||
               p.getCameraTruoc() != null || p.getCameraSau() != null || p.getQuayVideo() != null ||
               p.getDungLuongPin() != null || p.getSacNhanh() != null || p.getSacKhongDay() != null ||
               p.getSim() != null || p.getWifi() != null || p.getBluetooth() != null ||
               p.getGps() != null || p.getChatLieu() != null || p.getKichThuoc() != null ||
               p.getTrongLuong() != null || p.getMauSac() != null;
    }

    private void setConfigParameters(PreparedStatement ps, Product p, int maSP) throws SQLException {
        ps.setInt(1, maSP);
        ps.setString(2, p.getManHinh());
        ps.setString(3, p.getCpu());
        ps.setString(4, p.getGpu());
        ps.setString(5, p.getRam());
        ps.setString(6, p.getBoNhoTrong());
        ps.setString(7, p.getHeDieuHanh());
        ps.setString(8, p.getCameraTruoc());
        ps.setString(9, p.getCameraSau());
        ps.setString(10, p.getQuayVideo());
        ps.setString(11, p.getDungLuongPin());
        ps.setString(12, p.getSacNhanh());
        ps.setString(13, p.getSacKhongDay());
        ps.setString(14, p.getSim());
        ps.setString(15, p.getWifi());
        ps.setString(16, p.getBluetooth());
        ps.setString(17, p.getGps());
        ps.setString(18, p.getChatLieu());
        ps.setString(19, p.getKichThuoc());
        ps.setString(20, p.getTrongLuong());
        ps.setString(21, p.getMauSac());
    }

    private void setProductParameters(PreparedStatement ps, Product p) throws SQLException {
        ps.setString(1, p.getTenSP());
        ps.setInt(2, p.getMaHang());
        ps.setString(3, p.getTinhTrang());
        ps.setBigDecimal(4, p.getGia());
        ps.setInt(5, p.getSoLuong());
        ps.setString(6, p.getHinhAnh());
        ps.setString(7, p.getMoTa());
    }
}