package dao;

import controller.CartServlet.CartItem;
import util.DatabaseConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CartDAO {
    
    // Lưu giỏ hàng của user vào database
    public boolean saveCartItems(int userId, List<CartItem> cartItems) {
        Connection conn = null;
        PreparedStatement deleteStmt = null;
        PreparedStatement insertStmt = null;
        
        try {
            conn = DatabaseConnection.getConnection();
            conn.setAutoCommit(false);
            
            // Xóa giỏ hàng cũ của user
            String deleteSql = "DELETE FROM giohangct WHERE MaGH IN (SELECT MaGH FROM giohang WHERE MaND = ?)";
            deleteStmt = conn.prepareStatement(deleteSql);
            deleteStmt.setInt(1, userId);
            deleteStmt.executeUpdate();
            
            // Xóa giỏ hàng cũ
            String deleteGioHangSql = "DELETE FROM giohang WHERE MaND = ?";
            deleteStmt = conn.prepareStatement(deleteGioHangSql);
            deleteStmt.setInt(1, userId);
            deleteStmt.executeUpdate();
            
            if (!cartItems.isEmpty()) {
                // Tạo giỏ hàng mới
                String insertGioHangSql = "INSERT INTO giohang (MaND) VALUES (?)";
                insertStmt = conn.prepareStatement(insertGioHangSql, PreparedStatement.RETURN_GENERATED_KEYS);
                insertStmt.setInt(1, userId);
                insertStmt.executeUpdate();
                
                ResultSet rs = insertStmt.getGeneratedKeys();
                int maGH = 0;
                if (rs.next()) {
                    maGH = rs.getInt(1);
                }
                rs.close();
                insertStmt.close();
                
                // Thêm chi tiết giỏ hàng
                String insertDetailSql = "INSERT INTO giohangct (MaGH, MaSP, SoLuong) VALUES (?, ?, ?)";
                insertStmt = conn.prepareStatement(insertDetailSql);
                
                for (CartItem item : cartItems) {
                    insertStmt.setInt(1, maGH);
                    insertStmt.setInt(2, Integer.parseInt(item.getMaSP()));
                    insertStmt.setInt(3, item.getQuantity());
                    insertStmt.addBatch();
                }
                
                insertStmt.executeBatch();
            }
            
            conn.commit();
            System.out.println("Cart saved successfully for user " + userId + " with " + cartItems.size() + " items");
            return true;
            
        } catch (SQLException e) {
            try {
                if (conn != null) {
                    conn.rollback();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            System.err.println("Error saving cart: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            DatabaseConnection.close(conn, deleteStmt, null);
            DatabaseConnection.close(null, insertStmt, null);
        }
    }
    
    // Load giỏ hàng của user từ database
    public List<CartItem> loadCartItems(int userId) {
        List<CartItem> cartItems = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = DatabaseConnection.getConnection();
            
            // Query để lấy thông tin sản phẩm trong giỏ hàng
            String sql = "SELECT ghct.MaSP, ghct.SoLuong, sp.TenSP, sp.Gia, cct.MauSac, cct.BoNhoTrong " +
                        "FROM giohang gh " +
                        "JOIN giohangct ghct ON gh.MaGH = ghct.MaGH " +
                        "JOIN sanpham sp ON ghct.MaSP = sp.MaSP " +
                        "LEFT JOIN cauhinhchitiet cct ON sp.MaSP = cct.MaSP " +
                        "WHERE gh.MaND = ?";
            
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            rs = stmt.executeQuery();
            
            while (rs.next()) {
                CartItem item = new CartItem();
                item.setId(System.currentTimeMillis() + cartItems.size()); // Generate unique ID
                item.setMaSP(String.valueOf(rs.getInt("MaSP")));
                item.setProductName(rs.getString("TenSP"));
                item.setGia(String.valueOf(rs.getBigDecimal("Gia")));
                item.setQuantity(rs.getInt("SoLuong"));
                
                // Lấy màu sắc và dung lượng từ cấu hình
                String mauSac = rs.getString("MauSac");
                String boNhoTrong = rs.getString("BoNhoTrong");
                
                if (mauSac != null && !mauSac.trim().isEmpty()) {
                    // Lấy màu đầu tiên nếu có nhiều màu
                    String[] colors = mauSac.split(",");
                    item.setColor(colors[0].trim());
                } else {
                    item.setColor("Không xác định");
                }
                
                if (boNhoTrong != null && !boNhoTrong.trim().isEmpty()) {
                    item.setStorage(boNhoTrong.trim());
                } else {
                    item.setStorage("Không xác định");
                }
                
                cartItems.add(item);
            }
            
            System.out.println("Cart loaded successfully for user " + userId + " with " + cartItems.size() + " items");
            
        } catch (SQLException e) {
            System.err.println("Error loading cart: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DatabaseConnection.close(conn, stmt, rs);
        }
        
        return cartItems;
    }
    
    // Xóa giỏ hàng của user
    public boolean clearCart(int userId) {
        Connection conn = null;
        PreparedStatement stmt = null;
        
        try {
            conn = DatabaseConnection.getConnection();
            conn.setAutoCommit(false);
            
            // Xóa chi tiết giỏ hàng
            String deleteDetailSql = "DELETE FROM giohangct WHERE MaGH IN (SELECT MaGH FROM giohang WHERE MaND = ?)";
            stmt = conn.prepareStatement(deleteDetailSql);
            stmt.setInt(1, userId);
            stmt.executeUpdate();
            stmt.close();
            
            // Xóa giỏ hàng
            String deleteGioHangSql = "DELETE FROM giohang WHERE MaND = ?";
            stmt = conn.prepareStatement(deleteGioHangSql);
            stmt.setInt(1, userId);
            stmt.executeUpdate();
            
            conn.commit();
            System.out.println("Cart cleared successfully for user " + userId);
            return true;
            
        } catch (SQLException e) {
            try {
                if (conn != null) {
                    conn.rollback();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            System.err.println("Error clearing cart: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            DatabaseConnection.close(conn, stmt, null);
        }
    }
}
