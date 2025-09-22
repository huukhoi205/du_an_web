package dao.admin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.admin.Order;
import util.DatabaseConnection;

public class OrderDAO {
    private static final String SELECT_ALL_ORDERS = "SELECT * FROM DonHang";
    private static final String SELECT_ORDER_BY_ID = "SELECT * FROM DonHang WHERE MaDH = ?";
    private static final String INSERT_ORDER_SQL = "INSERT INTO DonHang (MaND, TrangThai, TongTien, NgayDat) VALUES (?, ?, ?, ?)";
    private static final String UPDATE_ORDER_SQL = "UPDATE DonHang SET TrangThai = ?, TongTien = ? WHERE MaDH = ?";
    private static final String DELETE_ORDER_SQL = "DELETE FROM DonHang WHERE MaDH = ?";

    protected Connection getConnection() {
        try {
            return DatabaseConnection.getConnection();
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    public List<Order> selectAllOrders() {
        List<Order> list = new ArrayList<>();
        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement(SELECT_ALL_ORDERS);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Order o = new Order();
                o.setMaDH(rs.getInt("MaDH"));
                o.setMaND(rs.getInt("MaND"));
                o.setTrangThai(rs.getString("TrangThai"));
                o.setTongTien(rs.getBigDecimal("TongTien"));
                o.setNgayDat(rs.getTimestamp("NgayDat"));
                list.add(o);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public Order selectOrder(int maDH) {
        Order o = null;
        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement(SELECT_ORDER_BY_ID)) {
            ps.setInt(1, maDH);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    o = new Order();
                    o.setMaDH(rs.getInt("MaDH"));
                    o.setMaND(rs.getInt("MaND"));
                    o.setTrangThai(rs.getString("TrangThai"));
                    o.setTongTien(rs.getBigDecimal("TongTien"));
                    o.setNgayDat(rs.getTimestamp("NgayDat"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return o;
    }

    public boolean insertOrder(Order order) {
        boolean rowInserted = false;
        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement(INSERT_ORDER_SQL, PreparedStatement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, order.getMaND());
            ps.setString(2, order.getTrangThai());
            ps.setBigDecimal(3, order.getTongTien());
            ps.setTimestamp(4, order.getNgayDat());
            rowInserted = ps.executeUpdate() > 0;
            if (rowInserted) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        order.setMaDH(rs.getInt(1));
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rowInserted;
    }

    public boolean updateOrderStatusAndTotal(int maDH, String trangThai, java.math.BigDecimal tongTien) {
        boolean rowUpdated = false;
        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement(UPDATE_ORDER_SQL)) {
            ps.setString(1, trangThai);
            ps.setBigDecimal(2, tongTien);
            ps.setInt(3, maDH);
            rowUpdated = ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rowUpdated;
    }

    public boolean deleteOrder(int maDH) {
        boolean rowDeleted = false;
        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement(DELETE_ORDER_SQL)) {
            ps.setInt(1, maDH);
            rowDeleted = ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rowDeleted;
    }
}
