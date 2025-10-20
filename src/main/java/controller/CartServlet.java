package controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Set UTF-8 encoding
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        
        // Set response headers for UTF-8
        response.setHeader("Content-Type", "text/html; charset=UTF-8");
        
        HttpSession session = request.getSession();
        
        // Get cart items from session
        List<CartItem> cartItems = (List<CartItem>) session.getAttribute("cartItems");
        if (cartItems == null) {
            cartItems = new ArrayList<>();
            session.setAttribute("cartItems", cartItems);
        }
        
        // Handle add to cart action
        String action = request.getParameter("action");
        if ("add".equals(action)) {
            addToCart(request, session, cartItems);
        } else if ("remove".equals(action)) {
            removeFromCart(request, session, cartItems);
        } else if ("update".equals(action)) {
            updateQuantity(request, session, cartItems);
        }
        
        // Calculate total amount
        java.math.BigDecimal totalAmount = java.math.BigDecimal.ZERO;
        for (CartItem item : cartItems) {
            if (item.getGia() != null && !item.getGia().isEmpty()) {
                java.math.BigDecimal itemPrice = new java.math.BigDecimal(item.getGia());
                java.math.BigDecimal itemTotal = itemPrice.multiply(new java.math.BigDecimal(item.getQuantity()));
                totalAmount = totalAmount.add(itemTotal);
            }
        }
        
        // Set total amount as request attribute
        request.setAttribute("totalAmount", totalAmount);
        
        // Forward to cart.jsp
        request.getRequestDispatcher("/views/cart.jsp").forward(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
    
    private void addToCart(HttpServletRequest request, HttpSession session, List<CartItem> cartItems) {
        String productName = request.getParameter("product");
        String maSP = request.getParameter("maSP");
        String gia = request.getParameter("gia");
        String storage = request.getParameter("storage");
        String color = request.getParameter("color");
        
        // If no color specified, get random color from database
        if (color == null || color.isEmpty()) {
            color = getRandomColorFromDatabase(maSP);
        }
        
        // If no storage specified, get default storage from database
        if (storage == null || storage.isEmpty()) {
            storage = getDefaultStorageFromDatabase(maSP);
        }
        
        System.out.println("Adding to cart: " + productName + ", storage: " + storage + ", color: " + color);
        
        // Create new cart item
        CartItem newItem = new CartItem();
        newItem.setId(System.currentTimeMillis()); // Unique ID
        newItem.setProductName(productName);
        newItem.setMaSP(maSP);
        newItem.setGia(gia);
        newItem.setStorage(storage);
        newItem.setColor(color);
        newItem.setQuantity(1);
        
        // Check if item already exists (same product, storage, color)
        boolean itemExists = false;
        for (CartItem item : cartItems) {
            if (item.getProductName().equals(productName) && 
                ((item.getStorage() == null && storage == null) || 
                 (item.getStorage() != null && item.getStorage().equals(storage))) &&
                ((item.getColor() == null && color == null) || 
                 (item.getColor() != null && item.getColor().equals(color)))) {
                item.setQuantity(item.getQuantity() + 1);
                itemExists = true;
                System.out.println("Item exists, increasing quantity to: " + item.getQuantity());
                break;
            }
        }
        
        if (!itemExists) {
            cartItems.add(newItem);
            System.out.println("New item added to cart. Total items: " + cartItems.size());
        }
    }
    
    private String getRandomColorFromDatabase(String maSP) {
        java.sql.Connection conn = null;
        java.sql.PreparedStatement stmt = null;
        java.sql.ResultSet rs = null;
        
        try {
            conn = util.DatabaseConnection.getConnection();
            String sql = "SELECT MauSac FROM cauhinhchitiet WHERE MaSP = ? AND MauSac IS NOT NULL AND MauSac != ''";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, maSP);
            rs = stmt.executeQuery();
            
            java.util.List<String> colors = new java.util.ArrayList<>();
            while (rs.next()) {
                String mauSac = rs.getString("MauSac");
                System.out.println("Raw color from database: " + mauSac);
                if (mauSac != null && !mauSac.trim().isEmpty()) {
                    // Split by comma and add individual colors
                    String[] colorArray = mauSac.split(",");
                    for (String color : colorArray) {
                        String trimmedColor = color.trim();
                        if (!trimmedColor.isEmpty()) {
                            // Log the color for debugging
                            System.out.println("Processing color: " + trimmedColor);
                            colors.add(trimmedColor);
                        }
                    }
                }
            }
            
            if (!colors.isEmpty()) {
                // Return random color
                java.util.Random random = new java.util.Random();
                String randomColor = colors.get(random.nextInt(colors.size()));
                System.out.println("Random color selected for " + maSP + ": " + randomColor);
                return randomColor;
            }
            
        } catch (Exception e) {
            System.err.println("Error getting random color: " + e.getMessage());
            e.printStackTrace();
        } finally {
            util.DatabaseConnection.close(conn, stmt, rs);
        }
        
        return "Không xác định";
    }
    
    private String getDefaultStorageFromDatabase(String maSP) {
        java.sql.Connection conn = null;
        java.sql.PreparedStatement stmt = null;
        java.sql.ResultSet rs = null;
        
        try {
            conn = util.DatabaseConnection.getConnection();
            String sql = "SELECT DungLuong FROM cauhinhchitiet WHERE MaSP = ? AND DungLuong IS NOT NULL AND DungLuong != '' LIMIT 1";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, maSP);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                String dungLuong = rs.getString("DungLuong");
                if (dungLuong != null && !dungLuong.trim().isEmpty()) {
                    System.out.println("Default storage for " + maSP + ": " + dungLuong);
                    return dungLuong;
                }
            }
            
        } catch (Exception e) {
            System.err.println("Error getting default storage: " + e.getMessage());
            e.printStackTrace();
        } finally {
            util.DatabaseConnection.close(conn, stmt, rs);
        }
        
        return "Không xác định";
    }
    
    private void removeFromCart(HttpServletRequest request, HttpSession session, List<CartItem> cartItems) {
        String itemId = request.getParameter("itemId");
        if (itemId != null) {
            try {
                long id = Long.parseLong(itemId);
                cartItems.removeIf(item -> item.getId() == id);
                System.out.println("Item removed from cart. Remaining items: " + cartItems.size());
            } catch (NumberFormatException e) {
                System.err.println("Invalid item ID: " + itemId);
            }
        }
    }
    
    private void updateQuantity(HttpServletRequest request, HttpSession session, List<CartItem> cartItems) {
        String itemId = request.getParameter("itemId");
        String quantity = request.getParameter("quantity");
        
        if (itemId != null && quantity != null) {
            try {
                long id = Long.parseLong(itemId);
                int qty = Integer.parseInt(quantity);
                
                for (CartItem item : cartItems) {
                    if (item.getId() == id) {
                        if (qty <= 0) {
                            cartItems.remove(item);
                        } else {
                            item.setQuantity(qty);
                        }
                        break;
                    }
                }
                System.out.println("Quantity updated for item " + itemId + " to " + quantity);
            } catch (NumberFormatException e) {
                System.err.println("Invalid item ID or quantity: " + itemId + ", " + quantity);
            }
        }
    }
    
    // Inner class for cart items
    public static class CartItem {
        private long id;
        private String productName;
        private String maSP;
        private String gia;
        private String storage;
        private String color;
        private int quantity;
        
        // Getters and setters
        public long getId() { return id; }
        public void setId(long id) { this.id = id; }
        
        public String getProductName() { return productName; }
        public void setProductName(String productName) { this.productName = productName; }
        
        public String getMaSP() { return maSP; }
        public void setMaSP(String maSP) { this.maSP = maSP; }
        
        public String getGia() { return gia; }
        public void setGia(String gia) { this.gia = gia; }
        
        public String getStorage() { return storage; }
        public void setStorage(String storage) { this.storage = storage; }
        
        public String getColor() { return color; }
        public void setColor(String color) { this.color = color; }
        
        public int getQuantity() { return quantity; }
        public void setQuantity(int quantity) { this.quantity = quantity; }
    }
}
