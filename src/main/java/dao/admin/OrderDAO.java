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
            System.err.println("OrderDAO: Lỗi kết nối database: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }

    public List<Order> selectAllOrders() {
        List<Order> list = new ArrayList<>();
        Connection connection = null;
        try {
            connection = getConnection();
            if (connection == null) return list;
            
            try (PreparedStatement ps = connection.prepareStatement(SELECT_ALL_ORDERS);
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
            }
        } catch (SQLException e) {
            System.err.println("OrderDAO: Lỗi selectAllOrders: " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeConnection(connection);
        }
        return list;
    }

    public Order selectOrder(int maDH) {
        Order o = null;
        Connection connection = null;
        try {
            connection = getConnection();
            if (connection == null) return null;
            
            try (PreparedStatement ps = connection.prepareStatement(SELECT_ORDER_BY_ID)) {
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
            }
        } catch (SQLException e) {
            System.err.println("OrderDAO: Lỗi selectOrder maDH=" + maDH + ": " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeConnection(connection);
        }
        return o;
    }

    public boolean insertOrder(Order order) {
        Connection connection = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            connection = getConnection();
            if (connection == null) {
                System.err.println("OrderDAO: Không thể kết nối database");
                return false;
            }

            ps = connection.prepareStatement(INSERT_ORDER_SQL, PreparedStatement.RETURN_GENERATED_KEYS);
            ps.setInt(1, order.getMaND());
            ps.setString(2, order.getTrangThai());
            ps.setBigDecimal(3, order.getTongTien());
            ps.setTimestamp(4, order.getNgayDat());
            
            int rowsAffected = ps.executeUpdate();
            boolean rowInserted = rowsAffected > 0;
            
            if (rowInserted) {
                rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    order.setMaDH(rs.getInt(1));
                    System.out.println("OrderDAO: Insert thành công, MaDH=" + order.getMaDH());
                }
            } else {
                System.err.println("OrderDAO: Không có dòng nào được insert (rowsAffected=0)");
            }
            
            return rowInserted;
            
        } catch (SQLException e) {
            System.err.println("OrderDAO: SQLException khi insert order: " + e.getMessage());
            System.err.println("SQL State: " + e.getSQLState());
            System.err.println("Error Code: " + e.getErrorCode());
            e.printStackTrace();
            return false;
        } finally {
            closeResources(ps, rs);
            closeConnection(connection);
        }
    }

    public boolean updateOrderStatusAndTotal(int maDH, String trangThai, java.math.BigDecimal tongTien) {
        Connection connection = null;
        PreparedStatement ps = null;
        try {
            connection = getConnection();
            if (connection == null) return false;
            
            ps = connection.prepareStatement(UPDATE_ORDER_SQL);
            ps.setString(1, trangThai);
            ps.setBigDecimal(2, tongTien);
            ps.setInt(3, maDH);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("OrderDAO: Lỗi updateOrder: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            closeResources(ps, null);
            closeConnection(connection);
        }
    }

    public boolean deleteOrder(int maDH) {
        Connection connection = null;
        PreparedStatement ps = null;
        try {
            connection = getConnection();
            if (connection == null) return false;
            
            ps = connection.prepareStatement(DELETE_ORDER_SQL);
            ps.setInt(1, maDH);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("OrderDAO: Lỗi deleteOrder: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            closeResources(ps, null);
            closeConnection(connection);
        }
    }
    
    private void closeConnection(Connection connection) {
        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException e) {
                System.err.println("Lỗi đóng connection: " + e.getMessage());
            }
        }
    }
    
    private void closeResources(PreparedStatement ps, ResultSet rs) {
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
        } catch (SQLException e) {
            System.err.println("Lỗi đóng resources: " + e.getMessage());
        }
    }
}