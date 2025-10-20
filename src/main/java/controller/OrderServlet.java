package controller;

import dao.DiaChiGiaoHangDAO;
import model.admin.Order;
import model.admin.OrderDetail;
import util.DatabaseConnection;
import util.ShippingCalculator;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/order")
public class OrderServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        
        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/views/login.jsp");
            return;
        }
        
        // Load delivery addresses from database
        DiaChiGiaoHangDAO diaChiDAO = new DiaChiGiaoHangDAO();
        java.util.List<DiaChiGiaoHangDAO.DiaChiGiaoHang> danhSachDiaChi = diaChiDAO.getDiaChiByMaND(userId);
        DiaChiGiaoHangDAO.DiaChiGiaoHang diaChiMacDinh = diaChiDAO.getDiaChiMacDinh(userId);
        
        // Get cart items from session
        @SuppressWarnings("unchecked")
        java.util.List<controller.CartServlet.CartItem> cartItems = 
            (java.util.List<controller.CartServlet.CartItem>) session.getAttribute("cartItems");
        
        System.out.println("OrderServlet doGet - Cart items from session: " + cartItems);
        if (cartItems == null) {
            cartItems = new java.util.ArrayList<>();
            System.out.println("Cart items was null, created empty list");
        } else {
            System.out.println("Cart items count: " + cartItems.size());
        }
        
        // For testing - add sample cart items if cart is empty
        if (cartItems.isEmpty()) {
            System.out.println("Cart is empty, adding sample items for testing");
            controller.CartServlet.CartItem sampleItem = new controller.CartServlet.CartItem();
            sampleItem.setId(System.currentTimeMillis());
            sampleItem.setMaSP("1");
            sampleItem.setProductName("iPhone 15 Pro Max 256GB");
            sampleItem.setGia("25000000");
            sampleItem.setQuantity(1);
            sampleItem.setStorage("256GB");
            sampleItem.setColor("Titan Xanh");
            cartItems.add(sampleItem);
            
            // Update session with sample items
            session.setAttribute("cartItems", cartItems);
            System.out.println("Added sample item to cart for testing");
        }
        
        // Calculate unique products count and total amount
        int uniqueProductsCount = cartItems.size();
        double subtotal = 0.0;
        for (controller.CartServlet.CartItem item : cartItems) {
            if (item.getGia() != null && !item.getGia().isEmpty()) {
                double itemPrice = Double.parseDouble(item.getGia());
                subtotal += itemPrice * item.getQuantity();
            }
        }
        
        // Calculate shipping fee based on default address
        double shippingFee = 0.0;
        String shippingMessage = "Vui lòng nhập địa chỉ để tính phí vận chuyển";
        if (diaChiMacDinh != null && diaChiMacDinh.getDiaChiChiTiet() != null && !diaChiMacDinh.getDiaChiChiTiet().trim().isEmpty()) {
            shippingFee = ShippingCalculator.calculateShippingFee(diaChiMacDinh.getDiaChiChiTiet());
            shippingMessage = ShippingCalculator.getShippingMessage(diaChiMacDinh.getDiaChiChiTiet());
        }
        
        double totalAmount = subtotal + shippingFee;
        
        // Set attributes for JSP
        request.setAttribute("danhSachDiaChi", danhSachDiaChi);
        request.setAttribute("diaChiMacDinh", diaChiMacDinh);
        request.setAttribute("cartItems", cartItems);
        request.setAttribute("uniqueProductsCount", uniqueProductsCount);
        request.setAttribute("subtotal", subtotal);
        request.setAttribute("shippingFee", shippingFee);
        request.setAttribute("shippingMessage", shippingMessage);
        request.setAttribute("totalAmount", totalAmount);
        
        // Forward to order.jsp
        request.getRequestDispatcher("/views/order.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        System.out.println("OrderServlet doPost called");
        
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        
        HttpSession session = request.getSession();
        
        // Check if user is logged in
        String userName = (String) session.getAttribute("userName");
        Integer userId = (Integer) session.getAttribute("userId");
        
        if (userName == null || userId == null) {
            response.sendRedirect(request.getContextPath() + "/views/login.jsp");
            return;
        }
        
        // Get form data
        String recipientName = request.getParameter("recipientName");
        String phoneNumber = request.getParameter("phoneNumber");
        String deliveryAddress = request.getParameter("deliveryAddress");
        String paymentMethod = request.getParameter("paymentMethod");
        
        System.out.println("OrderServlet - Form data received:");
        System.out.println("Recipient: " + recipientName);
        System.out.println("Phone: " + phoneNumber);
        System.out.println("Address: " + deliveryAddress);
        System.out.println("Payment: " + paymentMethod);
        
        // Get cart items from session
        @SuppressWarnings("unchecked")
        List<controller.CartServlet.CartItem> cartItems = (List<controller.CartServlet.CartItem>) session.getAttribute("cartItems");
        
        if (cartItems == null || cartItems.isEmpty()) {
            System.out.println("Cart is empty, redirecting back to order page");
            request.setAttribute("error", "Giỏ hàng trống!");
            request.getRequestDispatcher("/views/order.jsp").forward(request, response);
            return;
        }
        
        System.out.println("Cart items count: " + cartItems.size());
        
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            conn.setAutoCommit(false); // Start transaction
            
            // Create order - only basic fields that exist in donhang table
            Order order = new Order();
            order.setMaND(userId);
            order.setTrangThai("ChoXacNhan"); // Use enum value from database
            order.setNgayDat(new java.sql.Timestamp(System.currentTimeMillis()));
            
            // Calculate total amount
            double totalAmount = 0.0;
            for (controller.CartServlet.CartItem item : cartItems) {
                if (item.getGia() != null && !item.getGia().isEmpty()) {
                    double itemPrice = Double.parseDouble(item.getGia());
                    totalAmount += itemPrice * item.getQuantity();
                    System.out.println("Item: " + item.getProductName() + ", Price: " + itemPrice + ", Qty: " + item.getQuantity() + ", Total: " + (itemPrice * item.getQuantity()));
                }
            }
            System.out.println("Total order amount: " + totalAmount);
            order.setTongTien(new java.math.BigDecimal(totalAmount));
            
            // Insert order directly using connection
            System.out.println("Attempting to insert order...");
            boolean orderInserted = false;
            try {
                orderInserted = insertOrder(conn, order);
                System.out.println("Order insert result: " + orderInserted);
            } catch (Exception e) {
                System.err.println("Error inserting order: " + e.getMessage());
                e.printStackTrace();
                orderInserted = false;
            }
            
            if (orderInserted) {
                int orderId = order.getMaDH();
                System.out.println("Order inserted successfully with ID: " + orderId);
                
                // Insert order details
                for (controller.CartServlet.CartItem item : cartItems) {
                    OrderDetail orderDetail = new OrderDetail();
                    orderDetail.setMaDH(orderId);
                    orderDetail.setMaSP(Integer.parseInt(item.getMaSP()));
                    orderDetail.setSoLuong(item.getQuantity());
                    if (item.getGia() != null && !item.getGia().isEmpty()) {
                        orderDetail.setGia(Double.parseDouble(item.getGia()));
                    } else {
                        orderDetail.setGia(0.0);
                    }
                    orderDetail.setTenSanPham(item.getProductName());
                    
                    System.out.println("Inserting order detail: OrderID=" + orderId + ", ProductID=" + item.getMaSP() + ", Qty=" + item.getQuantity() + ", Price=" + item.getGia());
                    insertOrderDetail(conn, orderDetail);
                }
                
                // Insert delivery address record for this order (not necessarily default)
                try {
                    insertOrderAddress(conn, userId, recipientName, phoneNumber, deliveryAddress);
                } catch (SQLException e) {
                    System.err.println("Warning: could not insert delivery address record: " + e.getMessage());
                }

                // Insert payment record
                try {
                    insertPaymentRecord(conn, orderId, paymentMethod, new java.math.BigDecimal(totalAmount));
                } catch (SQLException e) {
                    System.err.println("Warning: could not insert payment record: " + e.getMessage());
                }

                // Save delivery address as default address for user
                saveDefaultAddress(conn, userId, recipientName, phoneNumber, deliveryAddress);
                
                conn.commit(); // Commit transaction
                
                // Clear cart
                session.removeAttribute("cartItems");
                
                // Set success message and order details
                session.setAttribute("orderSuccess", "Đặt hàng thành công! Mã đơn hàng: " + orderId);
                session.setAttribute("orderId", orderId);
                session.setAttribute("recipientName", recipientName);
                session.setAttribute("phoneNumber", phoneNumber);
                session.setAttribute("deliveryAddress", deliveryAddress);
                session.setAttribute("paymentMethod", paymentMethod);
                session.setAttribute("totalAmount", totalAmount);
                session.setAttribute("orderDate", new java.sql.Timestamp(System.currentTimeMillis()));
                
                // Redirect to success page
                System.out.println("Redirecting to order-success.jsp");
                response.sendRedirect(request.getContextPath() + "/views/order-success.jsp");
                
            } else {
                conn.rollback(); // Rollback transaction
                request.setAttribute("error", "Có lỗi xảy ra khi đặt hàng. Vui lòng thử lại!");
                request.getRequestDispatcher("/views/order.jsp").forward(request, response);
            }
            
        } catch (SQLException e) {
            try {
                if (conn != null) {
                    conn.rollback();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra khi đặt hàng. Vui lòng thử lại!");
            request.getRequestDispatcher("/views/order.jsp").forward(request, response);
        } finally {
            DatabaseConnection.close(conn, null, null);
        }
    }
    
    private boolean insertOrder(Connection conn, Order order) throws SQLException {
        String sql = "INSERT INTO donhang (MaND, TrangThai, TongTien, NgayDat) VALUES (?, ?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, order.getMaND());
            ps.setString(2, order.getTrangThai());
            ps.setBigDecimal(3, order.getTongTien());
            ps.setTimestamp(4, order.getNgayDat());
            
            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        order.setMaDH(rs.getInt(1));
                        System.out.println("Order inserted successfully with ID: " + order.getMaDH());
                    }
                }
                return true;
            }
        }
        return false;
    }
    
    
    private void insertOrderDetail(Connection conn, OrderDetail orderDetail) throws SQLException {
        String sql = "INSERT INTO ChiTietDH (MaDH, MaSP, SoLuong, Gia) VALUES (?, ?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderDetail.getMaDH());
            ps.setInt(2, orderDetail.getMaSP());
            ps.setInt(3, orderDetail.getSoLuong());
            ps.setDouble(4, orderDetail.getGia());
            ps.executeUpdate();
        }
    }
    
    // Insert a non-default delivery address row to track the address used for this order
    private void insertOrderAddress(Connection conn, int userId, String recipientName, String phoneNumber, String deliveryAddress) throws SQLException {
        String sql = "INSERT INTO diachigiaohang (MaND, HoTenNguoiNhan, SoDTNguoiNhan, DiaChiChiTiet, MacDinh) VALUES (?, ?, ?, ?, 0)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setString(2, recipientName);
            ps.setString(3, phoneNumber);
            ps.setString(4, deliveryAddress);
            ps.executeUpdate();
        }
    }

    // Insert payment record into thanhtoan table
    private void insertPaymentRecord(Connection conn, int orderId, String paymentMethod, java.math.BigDecimal amount) throws SQLException {
        // Map payment method to enum values from database
        String phuongThuc;
        if ("cash".equalsIgnoreCase(paymentMethod) || "cod".equalsIgnoreCase(paymentMethod)) {
            phuongThuc = "COD";
        } else if ("credit".equalsIgnoreCase(paymentMethod)) {
            phuongThuc = "The";
        } else if ("momo".equalsIgnoreCase(paymentMethod)) {
            phuongThuc = "ViDienTu";
        } else {
            phuongThuc = "COD"; // Default to COD
        }

        String sql = "INSERT INTO thanhtoan (MaDH, PhuongThuc, SoTien, NgayThanhToan) VALUES (?, ?, ?, NOW())";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            ps.setString(2, phuongThuc);
            ps.setBigDecimal(3, amount);
            ps.executeUpdate();
        }
    }
    
    // Method to save delivery address as default address for user
    private void saveDefaultAddress(Connection conn, int userId, String recipientName, String phoneNumber, String deliveryAddress) throws SQLException {
        // Check if user already has a default address
        String checkSql = "SELECT COUNT(*) FROM diachigiaohang WHERE MaND = ? AND MacDinh = 1";
        PreparedStatement checkPs = conn.prepareStatement(checkSql);
        checkPs.setInt(1, userId);
        ResultSet rs = checkPs.executeQuery();
        
        boolean hasDefaultAddress = false;
        if (rs.next()) {
            hasDefaultAddress = rs.getInt(1) > 0;
        }
        rs.close();
        checkPs.close();
        
        if (!hasDefaultAddress) {
            // Insert new default address
            String insertSql = "INSERT INTO diachigiaohang (MaND, HoTenNguoiNhan, SoDTNguoiNhan, DiaChiChiTiet, MacDinh) VALUES (?, ?, ?, ?, 1)";
            PreparedStatement insertPs = conn.prepareStatement(insertSql);
            insertPs.setInt(1, userId);
            insertPs.setString(2, recipientName);
            insertPs.setString(3, phoneNumber);
            insertPs.setString(4, deliveryAddress);
            insertPs.executeUpdate();
            insertPs.close();
            
            System.out.println("Saved default address for user " + userId + ": " + deliveryAddress);
        } else {
            System.out.println("User " + userId + " already has a default address, skipping save");
        }
    }
}

