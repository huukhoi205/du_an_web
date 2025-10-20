package dao;

import model.Product;
import util.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {
    
    /**
     * Lấy tất cả sản phẩm mới
     */
    public List<Product> getAllNewProducts() {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT sp.*, dm.TenDM as TenHang " +
                     "FROM sanpham sp " +
                     "LEFT JOIN danhmuc dm ON sp.MaHang = dm.MaDM " +
                     "WHERE sp.TinhTrang = 'Moi' " +
                     "ORDER BY sp.MaSP DESC";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            
            while (rs.next()) {
                Product product = new Product();
                product.setMaSP(rs.getInt("MaSP"));
                product.setTenSP(rs.getString("TenSP"));
                product.setMaHang(rs.getInt("MaHang"));
                product.setTinhTrang(rs.getString("TinhTrang"));
                product.setGia(rs.getBigDecimal("Gia"));
                product.setSoLuong(rs.getInt("SoLuong"));
                product.setHinhAnh(rs.getString("HinhAnh"));
                product.setMoTa(rs.getString("MoTa"));
                product.setBrandName(rs.getString("TenHang"));
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }
    
    /**
     * Lấy sản phẩm theo bộ lọc
     */
    public List<Product> getProductsByFilter(String brand, double minPrice, double maxPrice, String storage) {
        List<Product> products = new ArrayList<>();
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT sp.*, dm.TenDM as TenHang ");
        sql.append("FROM sanpham sp ");
        sql.append("LEFT JOIN danhmuc dm ON sp.MaHang = dm.MaDM ");
        sql.append("WHERE sp.TinhTrang = 'Moi' ");
        
        List<Object> params = new ArrayList<>();
        
        if (brand != null && !brand.isEmpty()) {
            sql.append("AND dm.TenDM = ? ");
            params.add(brand);
        }
        
        if (minPrice > 0) {
            sql.append("AND sp.Gia >= ? ");
            params.add(minPrice);
        }
        
        if (maxPrice > 0) {
            sql.append("AND sp.Gia <= ? ");
            params.add(maxPrice);
        }
        
        sql.append("ORDER BY sp.MaSP DESC");
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql.toString())) {
            
            for (int i = 0; i < params.size(); i++) {
                pstmt.setObject(i + 1, params.get(i));
            }
            
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Product product = new Product();
                    product.setMaSP(rs.getInt("MaSP"));
                    product.setTenSP(rs.getString("TenSP"));
                    product.setMaHang(rs.getInt("MaHang"));
                    product.setTinhTrang(rs.getString("TinhTrang"));
                    product.setGia(rs.getBigDecimal("Gia"));
                    product.setSoLuong(rs.getInt("SoLuong"));
                    product.setHinhAnh(rs.getString("HinhAnh"));
                    product.setMoTa(rs.getString("MoTa"));
                    product.setBrandName(rs.getString("TenHang"));
                    products.add(product);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }
    
    /**
     * Lấy tất cả sản phẩm cũ
     */
    public List<Product> getAllUsedProducts() {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT sp.*, dm.TenDM as TenHang " +
                     "FROM sanpham sp " +
                     "LEFT JOIN danhmuc dm ON sp.MaHang = dm.MaDM " +
                     "WHERE sp.TinhTrang = 'Cu' " +
                     "ORDER BY sp.MaSP DESC";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            
            while (rs.next()) {
                Product product = new Product();
                product.setMaSP(rs.getInt("MaSP"));
                product.setTenSP(rs.getString("TenSP"));
                product.setMaHang(rs.getInt("MaHang"));
                product.setTinhTrang(rs.getString("TinhTrang"));
                product.setGia(rs.getBigDecimal("Gia"));
                product.setSoLuong(rs.getInt("SoLuong"));
                product.setHinhAnh(rs.getString("HinhAnh"));
                product.setMoTa(rs.getString("MoTa"));
                product.setBrandName(rs.getString("TenHang"));
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }
    
    /**
     * Lấy tất cả danh mục (hãng)
     */
    public List<String> getAllBrands() {
        List<String> brands = new ArrayList<>();
        String sql = "SELECT DISTINCT TenDM FROM danhmuc ORDER BY TenDM";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            
            while (rs.next()) {
                brands.add(rs.getString("TenDM"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return brands;
    }
}