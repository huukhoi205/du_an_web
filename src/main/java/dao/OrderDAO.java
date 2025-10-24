package dao;

import model.Order;
import model.OrderItem;
import model.Product;
import util.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {
    
    /**
     * Lấy tất cả đơn hàng của một người dùng
     */
    public List<Order> getOrdersByUserId(int userId) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT dh.*, COUNT(ctdh.MaSP) as SoLuongSanPham " +
                     "FROM donhang dh " +
                     "LEFT JOIN chitietdonhang ctdh ON dh.MaDH = ctdh.MaDH " +
                     "WHERE dh.MaND = ? " +
                     "GROUP BY dh.MaDH " +
                     "ORDER BY dh.NgayDat DESC";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, userId);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Order order = new Order();
                    order.setMaDH(rs.getInt("MaDH"));
                    order.setMaND(rs.getInt("MaND"));
                    order.setNgayDat(rs.getDate("NgayDat"));
                    order.setTrangThai(rs.getString("TrangThai"));
                    order.setTongTien(rs.getBigDecimal("TongTien"));
                    order.setDiaChiGiaoHang(rs.getString("DiaChiGiaoHang"));
                    order.setSoDienThoai(rs.getString("SoDienThoai"));
                    order.setGhiChu(rs.getString("GhiChu"));
                    order.setSoLuongSanPham(rs.getInt("SoLuongSanPham"));
                    
                    orders.add(order);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return orders;
    }
    
    /**
     * Lấy chi tiết đơn hàng theo ID
     */
    public Order getOrderById(int orderId) {
        Order order = null;
        String sql = "SELECT dh.*, COUNT(ctdh.MaSP) as SoLuongSanPham " +
                     "FROM donhang dh " +
                     "LEFT JOIN chitietdonhang ctdh ON dh.MaDH = ctdh.MaDH " +
                     "WHERE dh.MaDH = ? " +
                     "GROUP BY dh.MaDH";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, orderId);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    order = new Order();
                    order.setMaDH(rs.getInt("MaDH"));
                    order.setMaND(rs.getInt("MaND"));
                    order.setNgayDat(rs.getDate("NgayDat"));
                    order.setTrangThai(rs.getString("TrangThai"));
                    order.setTongTien(rs.getBigDecimal("TongTien"));
                    order.setDiaChiGiaoHang(rs.getString("DiaChiGiaoHang"));
                    order.setSoDienThoai(rs.getString("SoDienThoai"));
                    order.setGhiChu(rs.getString("GhiChu"));
                    order.setSoLuongSanPham(rs.getInt("SoLuongSanPham"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return order;
    }
    
    /**
     * Lấy chi tiết sản phẩm trong đơn hàng
     */
    public List<OrderItem> getOrderItemsByOrderId(int orderId) {
        List<OrderItem> orderItems = new ArrayList<>();
        String sql = "SELECT ctdh.*, sp.TenSP, sp.HinhAnh " +
                     "FROM chitietdonhang ctdh " +
                     "JOIN sanpham sp ON ctdh.MaSP = sp.MaSP " +
                     "WHERE ctdh.MaDH = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, orderId);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    OrderItem orderItem = new OrderItem();
                    orderItem.setMaCTDH(rs.getInt("MaCTDH"));
                    orderItem.setMaDH(rs.getInt("MaDH"));
                    orderItem.setMaSP(rs.getInt("MaSP"));
                    orderItem.setSoLuong(rs.getInt("SoLuong"));
                    orderItem.setGia(rs.getBigDecimal("Gia"));
                    orderItem.setMauSac(rs.getString("MauSac"));
                    orderItem.setDungLuong(rs.getString("DungLuong"));
                    
                    // Tạo thông tin sản phẩm
                    Product product = new Product();
                    product.setMaSP(rs.getInt("MaSP"));
                    product.setTenSP(rs.getString("TenSP"));
                    product.setHinhAnh(rs.getString("HinhAnh"));
                    orderItem.setProduct(product);
                    
                    orderItems.add(orderItem);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return orderItems;
    }
    
    /**
     * Kiểm tra quyền truy cập đơn hàng
     */
    public boolean hasAccessToOrder(int orderId, int userId) {
        String sql = "SELECT COUNT(*) FROM donhang WHERE MaDH = ? AND MaND = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, orderId);
            pstmt.setInt(2, userId);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return false;
    }
}