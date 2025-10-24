package controller;

import dao.OrderDAO;
import dao.ProfileDAO;
import model.Order;
import model.UserProfile;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

public class OrdersServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private OrderDAO orderDAO;
    private ProfileDAO profileDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        orderDAO = new OrderDAO();
        profileDAO = new ProfileDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession();
        
        // Lấy thông tin user từ session
        String userName = (String) session.getAttribute("userName");
        Integer userId = (Integer) session.getAttribute("userId");
        String userRole = (String) session.getAttribute("userRole");
        
        System.out.println("OrdersServlet.doGet - Session info:");
        System.out.println("  - userName: " + userName);
        System.out.println("  - userId: " + userId);
        System.out.println("  - userRole: " + userRole);
        
        // Lấy thông tin user từ database (sử dụng ProfileDAO giống như RepairServlet)
        UserProfile userProfile = null;
        if (userId != null) {
            System.out.println("=== OrdersServlet.doGet - START FETCHING USER INFO ===");
            System.out.println("OrdersServlet.doGet - Using ProfileDAO.getUserById() for userId: " + userId);
            userProfile = profileDAO.getUserById(userId);
            System.out.println("OrdersServlet.doGet - ProfileDAO.getUserById() returned: " + (userProfile != null ? "NOT NULL" : "NULL"));
            
            if (userProfile != null) {
                System.out.println("OrdersServlet.doGet - SUCCESS! Loaded user from database:");
                System.out.println("  - MaND: " + userProfile.getMaND());
                System.out.println("  - HoTen: " + userProfile.getHoTen());
                System.out.println("  - Email: " + userProfile.getEmail());
                System.out.println("  - SoDT: " + userProfile.getSoDT());
                System.out.println("  - DiaChi: " + userProfile.getDiaChi());
            } else {
                System.out.println("OrdersServlet.doGet - FALLBACK! User not found in database, creating from session");
                // Fallback: Tạo từ session nếu không tìm thấy trong database
                userProfile = new UserProfile();
                userProfile.setMaND(userId);
                userProfile.setHoTen(userName);
                userProfile.setEmail(null);
                userProfile.setSoDT(null);
                userProfile.setDiaChi(null);
                userProfile.setVaiTro(userRole != null ? userRole : "KhachHang");
                System.out.println("OrdersServlet.doGet - Created fallback profile: " + userName);
            }
            System.out.println("=== OrdersServlet.doGet - END FETCHING USER INFO ===");
        } else {
            System.out.println("OrdersServlet.doGet - ERROR! No userId in session, cannot load user info");
            userProfile = new UserProfile();
        }
        
        // Lấy danh sách đơn hàng nếu có userId
        List<Order> orders = null;
        if (userId != null) {
            try {
                orders = orderDAO.getOrdersByUserId(userId);
                System.out.println("OrdersServlet.doGet - Loaded " + (orders != null ? orders.size() : 0) + " orders");
            } catch (Exception e) {
                System.out.println("OrdersServlet.doGet - Error loading orders: " + e.getMessage());
                e.printStackTrace();
                orders = new java.util.ArrayList<Order>();
            }
        } else {
            orders = new java.util.ArrayList<Order>();
        }
        
        // Set attributes
        request.setAttribute("userProfile", userProfile);
        request.setAttribute("orders", orders);
        
        // Forward to orders.jsp
        request.getRequestDispatcher("/views/orders.jsp").forward(request, response);
    }
}