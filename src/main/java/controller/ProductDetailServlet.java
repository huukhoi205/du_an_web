package controller;

import dao.ProductDAO;
import model.Product;
import util.DatabaseConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/product-detail")
public class ProductDetailServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Set UTF-8 encoding
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        
        String productName = request.getParameter("product");
        String maSP = request.getParameter("maSP");
        
        System.out.println("ProductDetailServlet - productName: " + productName);
        System.out.println("ProductDetailServlet - maSP: " + maSP);
        
        try {
            Product product = null;
            Map<String, String> productSpecs = new HashMap<>();
            
            if (productName != null && !productName.isEmpty()) {
                // Tìm sản phẩm theo tên
                System.out.println("Searching for product by name: " + productName);
                product = getProductByName(productName);
                System.out.println("Found product: " + (product != null ? product.getTenSP() : "null"));
            } else if (maSP != null && !maSP.isEmpty()) {
                // Tìm sản phẩm theo MaSP
                System.out.println("Searching for product by MaSP: " + maSP);
                product = getProductByMaSP(Integer.parseInt(maSP));
                System.out.println("Found product: " + (product != null ? product.getTenSP() : "null"));
            }
            
            if (product != null) {
                // Lấy thông tin chi tiết kỹ thuật
                productSpecs = getProductSpecs(product.getMaSP());
                System.out.println("Product found, setting attributes");
            } else {
                // Nếu không tìm thấy sản phẩm, tạo sản phẩm mặc định
                System.out.println("Product not found, creating default product");
                product = createDefaultProduct();
                productSpecs = createDefaultSpecs();
            }
            
            request.setAttribute("product", product);
            request.setAttribute("productSpecs", productSpecs);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/views/index.jsp");
            return;
        }
        
        request.getRequestDispatcher("/views/product-detail.jsp").forward(request, response);
    }
    
    private Product getProductByName(String productName) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Product product = null;
        
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT s.*, d.TenDM FROM sanpham s " +
                        "LEFT JOIN danhmuc d ON s.MaHang = d.MaDM " +
                        "WHERE s.TenSP LIKE ?";
            System.out.println("SQL: " + sql);
            System.out.println("Searching for: %" + productName + "%");
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, "%" + productName + "%");
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                System.out.println("Found product in database!");
                product = new Product();
                product.setMaSP(rs.getInt("MaSP"));
                product.setTenSP(rs.getString("TenSP"));
                product.setMaHang(rs.getInt("MaHang"));
                product.setTinhTrang(rs.getString("TinhTrang"));
                product.setGia(rs.getBigDecimal("Gia"));
                product.setSoLuong(rs.getInt("SoLuong"));
                product.setHinhAnh(rs.getString("HinhAnh"));
                product.setMoTa(rs.getString("MoTa"));
                product.setBrandName(rs.getString("TenDM"));
                System.out.println("Product details: " + product.getTenSP() + " - " + product.getGia());
            } else {
                System.out.println("No product found in database!");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DatabaseConnection.close(conn, stmt, rs);
        }
        
        return product;
    }
    
    private Product getProductByMaSP(int maSP) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Product product = null;
        
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT s.*, d.TenDM FROM sanpham s " +
                        "LEFT JOIN danhmuc d ON s.MaHang = d.MaDM " +
                        "WHERE s.MaSP = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, maSP);
            rs = stmt.executeQuery();
            
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
                product.setBrandName(rs.getString("TenDM"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DatabaseConnection.close(conn, stmt, rs);
        }
        
        return product;
    }
    
    private Map<String, String> getProductSpecs(int maSP) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Map<String, String> specs = new HashMap<>();
        
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM cauhinhchitiet WHERE MaSP = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, maSP);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                specs.put("ManHinh", rs.getString("ManHinh"));
                specs.put("CPU", rs.getString("CPU"));
                specs.put("GPU", rs.getString("GPU"));
                specs.put("RAM", rs.getString("RAM"));
                specs.put("BoNhoTrong", rs.getString("BoNhoTrong"));
                specs.put("HeDieuHanh", rs.getString("HeDieuHanh"));
                specs.put("CameraTruoc", rs.getString("CameraTruoc"));
                specs.put("CameraSau", rs.getString("CameraSau"));
                specs.put("QuayVideo", rs.getString("QuayVideo"));
                specs.put("DungLuongPin", rs.getString("DungLuongPin"));
                specs.put("SacNhanh", rs.getString("SacNhanh"));
                specs.put("SacKhongDay", rs.getString("SacKhongDay"));
                specs.put("SIM", rs.getString("SIM"));
                specs.put("WiFi", rs.getString("WiFi"));
                specs.put("Bluetooth", rs.getString("Bluetooth"));
                specs.put("GPS", rs.getString("GPS"));
                specs.put("ChatLieu", rs.getString("ChatLieu"));
                specs.put("KichThuoc", rs.getString("KichThuoc"));
                specs.put("TrongLuong", rs.getString("TrongLuong"));
                specs.put("MauSac", rs.getString("MauSac"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DatabaseConnection.close(conn, stmt, rs);
        }
        
        return specs;
    }
    
    private Product createDefaultProduct() {
        Product product = new Product();
        product.setMaSP(0);
        product.setTenSP("Sản phẩm không tìm thấy");
        product.setGia(new java.math.BigDecimal("0"));
        product.setHinhAnh("default-phone.jpg");
        product.setBrandName("Unknown");
        product.setMoTa("Sản phẩm không có trong hệ thống");
        product.setTinhTrang("Moi");
        return product;
    }
    
    private Map<String, String> createDefaultSpecs() {
        Map<String, String> specs = new HashMap<>();
        specs.put("ManHinh", "Không có thông tin");
        specs.put("CPU", "Không có thông tin");
        specs.put("RAM", "Không có thông tin");
        specs.put("BoNhoTrong", "Không có thông tin");
        specs.put("HeDieuHanh", "Không có thông tin");
        specs.put("DungLuongPin", "Không có thông tin");
        return specs;
    }
}
