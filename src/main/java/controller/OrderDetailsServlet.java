package controller;

import dao.OrderDAO;
import model.Order;
import model.OrderItem;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class OrderDetailsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private OrderDAO orderDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        orderDAO = new OrderDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Kiểm tra đăng nhập
        Integer userId = (Integer) request.getSession().getAttribute("userId");
        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/views/login.jsp");
            return;
        }
        
        try {
            // Lấy orderId từ parameter
            String orderIdStr = request.getParameter("orderId");
            if (orderIdStr == null || orderIdStr.isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/orders");
                return;
            }
            
            int orderId = Integer.parseInt(orderIdStr);
            
            // Kiểm tra quyền truy cập
            if (!orderDAO.hasAccessToOrder(orderId, userId)) {
                request.setAttribute("error", "Bạn không có quyền xem đơn hàng này.");
                request.getRequestDispatcher("/views/order-details.jsp").forward(request, response);
                return;
            }
            
            // Lấy thông tin đơn hàng
            Order order = orderDAO.getOrderById(orderId);
            if (order == null) {
                request.setAttribute("error", "Không tìm thấy đơn hàng.");
                request.getRequestDispatcher("/views/order-details.jsp").forward(request, response);
                return;
            }
            
            // Lấy chi tiết sản phẩm trong đơn hàng
            List<OrderItem> orderItems = orderDAO.getOrderItemsByOrderId(orderId);
            
            // Set attributes
            request.setAttribute("order", order);
            request.setAttribute("orderItems", orderItems);
            
            // Forward to order-details.jsp
            request.getRequestDispatcher("/views/order-details.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/orders");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra khi tải chi tiết đơn hàng: " + e.getMessage());
            request.getRequestDispatcher("/views/order-details.jsp").forward(request, response);
        }
    }
}
