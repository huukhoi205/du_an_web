package service.admin;

import java.util.List;
import dao.admin.OrderDAO;
import dao.admin.UserDAO;
import model.admin.Order;

public class OrderService {
    private OrderDAO orderDAO = new OrderDAO();
    private UserDAO userDAO = new UserDAO();

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
}