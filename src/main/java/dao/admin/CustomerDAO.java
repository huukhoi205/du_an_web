package dao.admin;

import model.admin.Customer;
import util.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CustomerDAO {
    private static final String SELECT_ALL = "SELECT n.*, t.MaTK, t.TenDangNhap, t.MatKhau, t.VaiTro, t.TrangThai, t.NgayTao AS NgayTaoTK " +
                                             "FROM nguoidung n LEFT JOIN taikhoan t ON n.MaND = t.MaND";
    private static final String SELECT_BY_ID = "SELECT n.*, t.MaTK, t.TenDangNhap, t.MatKhau, t.VaiTro, t.TrangThai, t.NgayTao AS NgayTaoTK " +
                                               "FROM nguoidung n LEFT JOIN taikhoan t ON n.MaND = t.MaND WHERE n.MaND = ?";
    private static final String BASE_INSERT_NGUOIDUNG = "INSERT INTO nguoidung (HoTen, Email, SoDT, DiaChi, NgayTao) VALUES (?, ?, ?, ?, ?)";
    private static final String BASE_INSERT_TAIKHOAN = "INSERT INTO taikhoan (MaND, TenDangNhap, MatKhau, VaiTro, TrangThai, NgayTao) VALUES (?, ?, ?, ?, ?, ?)";
    private static final String BASE_UPDATE_NGUOIDUNG = "UPDATE nguoidung SET ";
    private static final String BASE_UPDATE_TAIKHOAN = "UPDATE taikhoan SET ";
    private static final String DELETE_SQL = "DELETE FROM nguoidung WHERE MaND = ?";
    private static final String CHECK_EMAIL_EXISTS = "SELECT COUNT(*) FROM nguoidung WHERE Email = ? AND MaND != ?";
    private static final String CHECK_USERNAME_EXISTS = "SELECT COUNT(*) FROM taikhoan WHERE TenDangNhap = ? AND MaTK != ?";

    protected Connection getConnection() throws SQLException {
        Connection conn = DatabaseConnection.getConnection();
        System.out.println("Connected to DB at " + new java.util.Date());
        return conn;
    }

    public List<Customer> selectAll() throws SQLException {
        List<Customer> list = new ArrayList<>();
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(SELECT_ALL);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Customer c = mapResultSetToCustomer(rs);
                list.add(c);
            }
        }
        return list;
    }

    public Customer selectById(int maND) throws SQLException {
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(SELECT_BY_ID)) {
            ps.setInt(1, maND);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToCustomer(rs);
                }
            }
        }
        return null;
    }

    public int insert(Customer c) throws SQLException {
        Connection conn = null;
        try {
            conn = getConnection();
            conn.setAutoCommit(false);

            try (PreparedStatement psNguoiDung = conn.prepareStatement(BASE_INSERT_NGUOIDUNG, Statement.RETURN_GENERATED_KEYS)) {
                System.out.println("Inserting into nguoidung: HoTen=" + c.getHoTen() + ", Email=" + c.getEmail());
                setNguoiDungParameters(psNguoiDung, c);
                int rowsAffected = psNguoiDung.executeUpdate();
                System.out.println("Rows affected in nguoidung: " + rowsAffected);

                try (ResultSet generatedKeys = psNguoiDung.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        int maND = generatedKeys.getInt(1);
                        c.setMaND(maND);
                        System.out.println("Generated MaND: " + maND);

                        try (PreparedStatement psTaiKhoan = conn.prepareStatement(BASE_INSERT_TAIKHOAN, Statement.RETURN_GENERATED_KEYS)) {
                            System.out.println("Inserting into taikhoan: MaND=" + maND + ", TenDangNhap=" + c.getTenDangNhap());
                            setTaiKhoanParameters(psTaiKhoan, c, maND);
                            rowsAffected = psTaiKhoan.executeUpdate();
                            System.out.println("Rows affected in taikhoan: " + rowsAffected);

                            try (ResultSet tkKeys = psTaiKhoan.getGeneratedKeys()) {
                                if (tkKeys.next()) {
                                    c.setMaTK(tkKeys.getInt(1));
                                    System.out.println("Generated MaTK: " + c.getMaTK());
                                }
                            }
                        }
                    }
                }
                conn.commit();
                System.out.println("Transaction committed for MaND: " + c.getMaND());
                return c.getMaND();
            } catch (SQLException e) {
                if (conn != null) conn.rollback();
                System.out.println("Transaction rolled back: " + e.getMessage());
                throw e;
            }
        } catch (SQLException e) {
            if (conn != null) conn.rollback();
            System.out.println("Connection error: " + e.getMessage());
            throw e;
        } finally {
            if (conn != null) {
                conn.setAutoCommit(true);
                conn.close();
            }
        }
    }

    public boolean update(Customer c) throws SQLException {
        Connection conn = getConnection();
        conn.setAutoCommit(false);
        StringBuilder nguoiDungUpdate = new StringBuilder(BASE_UPDATE_NGUOIDUNG);
        StringBuilder taiKhoanUpdate = new StringBuilder(BASE_UPDATE_TAIKHOAN);
        List<Object> params = new ArrayList<>();
        int paramIndex = 1;

        try {
            // Xây dựng truy vấn cho nguoidung
            boolean hasNguoiDungUpdate = false;
            if (c.getHoTen() != null && !c.getHoTen().isEmpty()) {
                nguoiDungUpdate.append("HoTen = ?, ");
                params.add(c.getHoTen());
                hasNguoiDungUpdate = true;
            }
            if (c.getEmail() != null && !c.getEmail().isEmpty()) {
                nguoiDungUpdate.append("Email = ?, ");
                params.add(c.getEmail());
                hasNguoiDungUpdate = true;
            }
            if (c.getSoDT() != null && !c.getSoDT().isEmpty()) {
                nguoiDungUpdate.append("SoDT = ?, ");
                params.add(c.getSoDT());
                hasNguoiDungUpdate = true;
            }
            if (c.getDiaChi() != null && !c.getDiaChi().isEmpty()) {
                nguoiDungUpdate.append("DiaChi = ?, ");
                params.add(c.getDiaChi());
                hasNguoiDungUpdate = true;
            }
            if (c.getNgayTao() != null) {
                nguoiDungUpdate.append("NgayTao = ?, ");
                params.add(new java.sql.Date(c.getNgayTao().getTime()));
                hasNguoiDungUpdate = true;
            }

            if (hasNguoiDungUpdate) {
                nguoiDungUpdate.setLength(nguoiDungUpdate.length() - 2); // Xóa dấu "," cuối
                nguoiDungUpdate.append(" WHERE MaND = ?");
                params.add(c.getMaND());

                try (PreparedStatement psNguoiDung = conn.prepareStatement(nguoiDungUpdate.toString())) {
                    for (int i = 0; i < params.size(); i++) {
                        psNguoiDung.setObject(i + 1, params.get(i));
                    }
                    psNguoiDung.executeUpdate();
                }
            }

            // Xây dựng truy vấn cho taikhoan
            params.clear();
            boolean hasTaiKhoanUpdate = false;
            if (c.getTenDangNhap() != null && !c.getTenDangNhap().isEmpty()) {
                taiKhoanUpdate.append("TenDangNhap = ?, ");
                params.add(c.getTenDangNhap());
                hasTaiKhoanUpdate = true;
            }
            if (c.getMatKhau() != null && !c.getMatKhau().isEmpty()) {
                taiKhoanUpdate.append("MatKhau = ?, ");
                params.add(c.getMatKhau());
                hasTaiKhoanUpdate = true;
            }
            if (c.getVaiTro() != null && !c.getVaiTro().isEmpty()) {
                taiKhoanUpdate.append("VaiTro = ?, ");
                params.add(c.getVaiTro());
                hasTaiKhoanUpdate = true;
            }
            if (c.isTrangThai()) {
                taiKhoanUpdate.append("TrangThai = ?, ");
                params.add(c.isTrangThai());
                hasTaiKhoanUpdate = true;
            }
            if (c.getNgayTaoTK() != null) {
                taiKhoanUpdate.append("NgayTao = ?, ");
                params.add(new java.sql.Date(c.getNgayTaoTK().getTime()));
                hasTaiKhoanUpdate = true;
            }

            if (hasTaiKhoanUpdate && c.getMaTK() > 0) {
                taiKhoanUpdate.setLength(taiKhoanUpdate.length() - 2); // Xóa dấu "," cuối
                taiKhoanUpdate.append(" WHERE MaTK = ?");
                params.add(c.getMaTK());

                try (PreparedStatement psTaiKhoan = conn.prepareStatement(taiKhoanUpdate.toString())) {
                    for (int i = 0; i < params.size(); i++) {
                        psTaiKhoan.setObject(i + 1, params.get(i));
                    }
                    psTaiKhoan.executeUpdate();
                }
            }

            conn.commit();
            return true;
        } catch (SQLException e) {
            conn.rollback();
            System.out.println("Update rolled back: " + e.getMessage());
            throw e;
        } finally {
            conn.setAutoCommit(true);
            conn.close();
        }
    }

    public boolean delete(int maND) throws SQLException {
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(DELETE_SQL)) {
            ps.setInt(1, maND);
            return ps.executeUpdate() > 0;
        }
    }

    public boolean isEmailExists(String email, int maND) throws SQLException {
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(CHECK_EMAIL_EXISTS)) {
            ps.setString(1, email);
            ps.setInt(2, maND);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() && rs.getInt(1) > 0;
            }
        }
    }

    public boolean isUsernameExists(String tenDangNhap, int maTK) throws SQLException {
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(CHECK_USERNAME_EXISTS)) {
            ps.setString(1, tenDangNhap);
            ps.setInt(2, maTK);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() && rs.getInt(1) > 0;
            }
        }
    }

    private Customer mapResultSetToCustomer(ResultSet rs) throws SQLException {
        Customer c = new Customer();
        c.setMaND(rs.getInt("MaND"));
        c.setHoTen(rs.getString("HoTen"));
        c.setEmail(rs.getString("Email"));
        c.setSoDT(rs.getString("SoDT"));
        c.setDiaChi(rs.getString("DiaChi"));
        c.setNgayTao(rs.getDate("NgayTao"));
        c.setMaTK(rs.getInt("MaTK"));
        c.setTenDangNhap(rs.getString("TenDangNhap"));
        c.setMatKhau(rs.getString("MatKhau"));
        c.setVaiTro(rs.getString("VaiTro"));
        c.setTrangThai(rs.getBoolean("TrangThai"));
        c.setNgayTaoTK(rs.getDate("NgayTaoTK"));
        return c;
    }

    private void setNguoiDungParameters(PreparedStatement ps, Customer c) throws SQLException {
        ps.setString(1, c.getHoTen());
        ps.setString(2, c.getEmail());
        ps.setString(3, c.getSoDT());
        ps.setString(4, c.getDiaChi());
        ps.setDate(5, new java.sql.Date(c.getNgayTao().getTime()));
    }

    private void setTaiKhoanParameters(PreparedStatement ps, Customer c, int maND) throws SQLException {
        ps.setInt(1, maND);
        ps.setString(2, c.getTenDangNhap());
        ps.setString(3, c.getMatKhau());
        ps.setString(4, c.getVaiTro());
        ps.setBoolean(5, c.isTrangThai());
        ps.setDate(6, new java.sql.Date(c.getNgayTaoTK().getTime()));
    }
}