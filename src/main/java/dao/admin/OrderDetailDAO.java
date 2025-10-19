package dao.admin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.admin.OrderDetail;
import util.DatabaseConnection;

public class OrderDetailDAO {
    private static final String SELECT_BY_ORDER_ID = 
        "SELECT c.MaCTDH, c.MaDH, c.MaSP, c.SoLuong, c.Gia, s.TenSP " +
        "FROM ChiTietDH c JOIN SanPham s ON c.MaSP = s.MaSP " +
        "WHERE c.MaDH = ?";

    protected Connection getConnection() {
        try {
            return DatabaseConnection.getConnection();
        } catch (SQLException e) {
            System.err.println("OrderDetailDAO: Lỗi kết nối database: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }

    public List<OrderDetail> selectOrderDetailsByOrderId(int maDH) {
        List<OrderDetail> list = new ArrayList<>();
        Connection connection = null;
        try {
            connection = getConnection();
            if (connection == null) return list;
            
            try (PreparedStatement ps = connection.prepareStatement(SELECT_BY_ORDER_ID)) {
                ps.setInt(1, maDH);
                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        OrderDetail detail = new OrderDetail(
                            rs.getInt("MaDH"),
                            rs.getInt("MaSP"),
                            rs.getInt("SoLuong"),
                            rs.getDouble("Gia") // Giả sử gia là double, nếu decimal thì dùng BigDecimal
                        );
                        detail.setTenSanPham(rs.getString("TenSP"));
                        list.add(detail);
                    }
                }
            }
        } catch (SQLException e) {
            System.err.println("OrderDetailDAO: Lỗi selectOrderDetailsByOrderId: " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeConnection(connection);
        }
        return list;
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
}