package service.admin;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import dao.admin.OrderDAO;
import dao.admin.OrderDetailDAO;
import dao.admin.UserDAO;
import model.admin.Order;
import model.admin.OrderDetail;

public class OrderService {
    private OrderDAO orderDAO = new OrderDAO();
    private UserDAO userDAO = new UserDAO();
    private OrderDetailDAO orderDetailDAO = new OrderDetailDAO();

    public List<Order> getAllOrders() {
        return orderDAO.selectAllOrders();
    }

    public Order getOrderById(int maDH) {
        return orderDAO.selectOrder(maDH);
    }

    public boolean addOrder(Order order) {
        if (!userDAO.userExists(order.getMaND())) {
            return false;
        }
        return orderDAO.insertOrder(order);
    }

    public boolean updateOrder(int maDH, String trangThai, java.math.BigDecimal tongTien) {
        return orderDAO.updateOrderStatusAndTotal(maDH, trangThai, tongTien);
    }

    public boolean deleteOrder(int maDH) {
        return orderDAO.deleteOrder(maDH);
    }

    // Method mới: Lấy order với info khách hàng
    public Order getOrderByIdWithCustomer(int maDH) {
        Order order = getOrderById(maDH);
        if (order != null) {
            UserDAO.User customer = userDAO.findById(order.getMaND());
            if (customer != null) {
                order.setTenKhachHang(customer.getHoTen());
                order.setDienThoai(customer.getSoDT());
                order.setDiaChi(customer.getDiaChi());
            }
        }
        return order;
    }

    // Method mới: Lấy chi tiết đơn hàng
    public List<OrderDetail> getOrderDetails(int maDH) {
        return orderDetailDAO.selectOrderDetailsByOrderId(maDH);
    }

    // Method mới: Tính tổng tiền từ chi tiết (để verify)
    public BigDecimal calculateTotal(int maDH) {
        List<OrderDetail> details = getOrderDetails(maDH);
        BigDecimal total = BigDecimal.ZERO;
        for (OrderDetail item : details) {
            total = total.add(BigDecimal.valueOf(item.getGia()).multiply(BigDecimal.valueOf(item.getSoLuong())));
        }
        return total;
    }
}