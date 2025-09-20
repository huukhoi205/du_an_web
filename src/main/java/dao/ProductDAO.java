package com.ktstore.dao;

import com.ktstore.model.Product;
import com.ktstore.util.DatabaseConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;

public class ProductDAO {
    
    public List<Product> getAllNewPhones() {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT sp.*, cch.ManHinh, cch.RAM, cch.BoNhoTrong, " +
                    "cch.DungLuongPin, cch.CameraSau FROM SanPham sp " +
                    "LEFT JOIN CauHinhChiTiet cch ON sp.MaSP = cch.MaSP " +
                    "WHERE sp.TinhTrang = 'Moi' AND sp.SoLuong > 0 " +
                    "ORDER BY sp.MaSP DESC";
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DatabaseConnection.getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            
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
                
                // Cấu hình chi tiết
                product.setManHinh(rs.getString("ManHinh"));
                product.setRam(rs.getString("RAM"));
                product.setBoNhoTrong(rs.getString("BoNhoTrong"));
                product.setDungLuongPin(rs.getString("DungLuongPin"));
                product.setCameraSau(rs.getString("CameraSau"));
                
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DatabaseConnection.close(conn, pstmt, rs);
        }
        
        return products;
    }
    
    public List<Product> getAllUsedPhones() {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT sp.*, cch.ManHinh, cch.RAM, cch.BoNhoTrong, " +
                    "cch.DungLuongPin, cch.CameraSau FROM SanPham sp " +
                    "LEFT JOIN CauHinhChiTiet cch ON sp.MaSP = cch.MaSP " +
                    "WHERE sp.TinhTrang = 'Cu' AND sp.SoLuong > 0 " +
                    "ORDER BY sp.MaSP DESC";
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DatabaseConnection.getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            
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
                
                // Cấu hình chi tiết
                product.setManHinh(rs.getString("ManHinh"));
                product.setRam(rs.getString("RAM"));
                product.setBoNhoTrong(rs.getString("BoNhoTrong"));
                product.setDungLuongPin(rs.getString("DungLuongPin"));
                product.setCameraSau(rs.getString("CameraSau"));
                
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DatabaseConnection.close(conn, pstmt, rs);
        }
        
        return products;
    }
    
    public List<Product> getHotDeals(int limit) {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT sp.*, cch.ManHinh, cch.RAM, cch.BoNhoTrong FROM SanPham sp " +
                    "LEFT JOIN CauHinhChiTiet cch ON sp.MaSP = cch.MaSP " +
                    "WHERE sp.SoLuong > 0 " +
                    "ORDER BY sp.Gia DESC LIMIT ?";
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DatabaseConnection.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, limit);
            rs = pstmt.executeQuery();
            
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
                
                // Cấu hình chi tiết
                product.setManHinh(rs.getString("ManHinh"));
                product.setRam(rs.getString("RAM"));
                product.setBoNhoTrong(rs.getString("BoNhoTrong"));
                
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DatabaseConnection.close(conn, pstmt, rs);
        }
        
        return products;
    }
    
    public List<Product> getUsedPhonesByFilters(Integer brand, String priceRange, 
                                               String sortBy, int limit, int offset) {
        List<Product> products = new ArrayList<>();
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT sp.*, cch.ManHinh, cch.RAM, cch.BoNhoTrong, ");
        sql.append("cch.DungLuongPin, cch.CameraSau FROM SanPham sp ");
        sql.append("LEFT JOIN CauHinhChiTiet cch ON sp.MaSP = cch.MaSP ");
        sql.append("WHERE sp.TinhTrang = 'Cu' AND sp.SoLuong > 0 ");
        
        List<Object> parameters = new ArrayList<>();
        
        // Brand filter
        if (brand != null && brand > 0) {
            sql.append("AND sp.MaHang = ? ");
            parameters.add(brand);
        }
        
        // Price range filter
        if (priceRange != null && !priceRange.isEmpty()) {
            switch (priceRange) {
                case "2-4":
                    sql.append("AND sp.Gia BETWEEN 2000000 AND 4000000 ");
                    break;
                case "4-7":
                    sql.append("AND sp.Gia BETWEEN 4000000 AND 7000000 ");
                    break;
                case "7-13":
                    sql.append("AND sp.Gia BETWEEN 7000000 AND 13000000 ");
                    break;
                case "13-20":
                    sql.append("AND sp.Gia BETWEEN 13000000 AND 20000000 ");
                    break;
                case "20+":
                    sql.append("AND sp.Gia > 20000000 ");
                    break;
            }
        }
        
        // Sorting
        switch (sortBy != null ? sortBy : "popular") {
            case "price-asc":
                sql.append("ORDER BY sp.Gia ASC ");
                break;
            case "price-desc":
                sql.append("ORDER BY sp.Gia DESC ");
                break;
            case "newest":
                sql.append("ORDER BY sp.MaSP DESC ");
                break;
            default:
                sql.append("ORDER BY sp.MaSP DESC ");
                break;
        }
        
        sql.append("LIMIT ? OFFSET ?");
        parameters.add(limit);
        parameters.add(offset);
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DatabaseConnection.getConnection();
            pstmt = conn.prepareStatement(sql.toString());
            
            for (int i = 0; i < parameters.size(); i++) {
                pstmt.setObject(i + 1, parameters.get(i));
            }
            
            rs = pstmt.executeQuery();
            
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
                
                // Cấu hình chi tiết
                product.setManHinh(rs.getString("ManHinh"));
                product.setRam(rs.getString("RAM"));
                product.setBoNhoTrong(rs.getString("BoNhoTrong"));
                product.setDungLuongPin(rs.getString("DungLuongPin"));
                product.setCameraSau(rs.getString("CameraSau"));
                
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DatabaseConnection.close(conn, pstmt, rs);
        }
        
        return products;
    }
    
    public List<String> getAllBrands() {
        List<String> brands = new ArrayList<>();
        // Since we don't have a Hang table, we'll create a static list based on MaHang values
        brands.add("Samsung");
        brands.add("Apple");
        brands.add("Xiaomi");
        brands.add("OPPO");
        brands.add("Vivo");
        brands.add("Google");
        brands.add("Huawei");
        brands.add("Realme");
        brands.add("OnePlus");
        brands.add("Sony");
        
        return brands;
    }
    
    public Product getProductById(int productId) {
        Product product = null;
        String sql = "SELECT sp.*, cch.* FROM SanPham sp " +
                    "LEFT JOIN CauHinhChiTiet cch ON sp.MaSP = cch.MaSP " +
                    "WHERE sp.MaSP = ?";
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DatabaseConnection.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, productId);
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                product = new Product();
                product.setMaSP(rs.getInt("MaSP"));
                product.setTenSP(rs.getString("TenSP"));
                product.setMaHang(rs.getInt("MaHang"));
                product.setTinhTrang(rs.getString("TinhTrang"));
                product.setGia(rs.getBigDecimal("Gia"));
                product.setSoLuong(rs.getInt("SoLuong"));
                product.setHinhAnh(rs.getString("HinhAnh"));
                product.setMoTa(rs.getString("MoTa"));
                
                // Cấu hình chi tiết
                product.setMaCHCT(rs.getInt("MaCHCT"));
                product.setManHinh(rs.getString("ManHinh"));
                product.setCpu(rs.getString("CPU"));
                product.setGpu(rs.getString("GPU"));
                product.setRam(rs.getString("RAM"));
                product.setBoNhoTrong(rs.getString("BoNhoTrong"));
                product.setHeDieuHanh(rs.getString("HeDieuHanh"));
                product.setCameraTruoc(rs.getString("CameraTruoc"));
                product.setCameraSau(rs.getString("CameraSau"));
                product.setQuayVideo(rs.getString("QuayVideo"));
                product.setDungLuongPin(rs.getString("DungLuongPin"));
                product.setSacNhanh(rs.getString("SacNhanh"));
                product.setSacKhongDay(rs.getString("SacKhongDay"));
                product.setSim(rs.getString("SIM"));
                product.setWifi(rs.getString("WiFi"));
                product.setBluetooth(rs.getString("Bluetooth"));
                product.setGps(rs.getString("GPS"));
                product.setChatLieu(rs.getString("ChatLieu"));
                product.setKichThuoc(rs.getString("KichThuoc"));
                product.setTrongLuong(rs.getString("TrongLuong"));
                product.setMauSac(rs.getString("MauSac"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DatabaseConnection.close(conn, pstmt, rs);
        }
        
        return product;
    }
    
    public int getTotalUsedPhonesCount() {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM SanPham WHERE TinhTrang = 'Cu' AND SoLuong > 0";
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DatabaseConnection.getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DatabaseConnection.close(conn, pstmt, rs);
        }
        
        return count;
    }
    
    public List<Product> searchProducts(String keyword) {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT sp.*, cch.ManHinh, cch.RAM, cch.BoNhoTrong FROM SanPham sp " +
                    "LEFT JOIN CauHinhChiTiet cch ON sp.MaSP = cch.MaSP " +
                    "WHERE sp.SoLuong > 0 AND (sp.TenSP LIKE ? OR sp.MoTa LIKE ?) " +
                    "ORDER BY sp.MaSP DESC";
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DatabaseConnection.getConnection();
            pstmt = conn.prepareStatement(sql);
            String searchPattern = "%" + keyword + "%";
            pstmt.setString(1, searchPattern);
            pstmt.setString(2, searchPattern);
            rs = pstmt.executeQuery();
            
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
                
                // Cấu hình chi tiết
                product.setManHinh(rs.getString("ManHinh"));
                product.setRam(rs.getString("RAM"));
                product.setBoNhoTrong(rs.getString("BoNhoTrong"));
                
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DatabaseConnection.close(conn, pstmt, rs);
        }
        
        return products;
    }
    
    public int getBrandIdByName(String brandName) {
        // Map brand names to IDs based on the sample data
        switch (brandName.toLowerCase()) {
            case "samsung": return 1;
            case "apple": return 2;
            case "xiaomi": return 3;
            case "oppo": return 4;
            case "vivo": return 5;
            case "google": return 6;
            case "huawei": return 7;
            case "realme": return 8;
            case "oneplus": return 9;
            case "sony": return 10;
            default: return 0;
        }
    }
}