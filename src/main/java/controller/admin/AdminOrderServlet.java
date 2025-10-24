package controller.admin;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.admin.Order;
import model.admin.OrderDetail;
import service.admin.OrderService;
import dao.admin.UserDAO; // Thêm import

@WebServlet(name = "AdminOrderServlet", urlPatterns = "/admin/order/*")
public class AdminOrderServlet extends HttpServlet {
    private OrderService orderService = new OrderService();
    private UserDAO userDAO = new UserDAO(); // Thêm instance

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getPathInfo();
        if (action == null) action = "/list";

        switch (action) {
            case "/list":
                listOrders(request, response);
                break;
            case "/add":
                showAddForm(request, response);
                break;
            case "/delete":
                deleteOrder(request, response);
                break;
            case "/detail":
                showOrderDetail(request, response);
                break;
            // Thêm các case mới
            case "/confirm":
                confirmOrder(request, response);
                break;
            case "/confirm-payment":
                confirmPayment(request, response);
                break;
            case "/complete":
                completeOrder(request, response);
                break;
            case "/cancel":
                cancelOrder(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getPathInfo();
        if (action == null) action = "/list";

        switch (action) {
            case "/edit":
                showEditForm(request, response);
                break;
            case "/update":
                updateOrder(request, response);
                break;
            case "/add":
                addOrder(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    private void listOrders(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            List<Order> orders = orderService.getAllOrders();
            for (Order order : orders) {
                // Lấy thông tin khách hàng từ maND
                UserDAO.User user = userDAO.findById(order.getMaND());
                if (user != null) {
                    order.setTenKhachHang(user.getHoTen());
                    order.setDienThoai(user.getSoDT());
                }
            }
            request.setAttribute("orders", orders);
            request.getRequestDispatcher("/admin/admin-order-list.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/order/list?error=serverError");
        }
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            String maDHParam = request.getParameter("maDH");
            if (maDHParam == null || maDHParam.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/admin/order/list?error=invalidMaDH");
                return;
            }

            int maDH = Integer.parseInt(maDHParam);
            Order order = orderService.getOrderById(maDH);
            if (order == null) {
                response.sendRedirect(request.getContextPath() + "/admin/order/list?error=orderNotFound");
                return;
            }

            request.setAttribute("order", order);
            request.getRequestDispatcher("/admin/admin-order-edit.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/order/list?error=invalidMaDH");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/order/list?error=serverError");
        }
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("/admin/admin-order-add.jsp").forward(request, response);
    }

    private void addOrder(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        String error = null;
        try {
            String maNDParam = request.getParameter("maND");
            String trangThai = request.getParameter("trangThai");
            String tongTienParam = request.getParameter("tongTien");

            if (maNDParam == null || maNDParam.trim().isEmpty()) {
                error = "invalidMaND";
            } else if (trangThai == null || trangThai.trim().isEmpty()) {
                error = "invalidTrangThai";
            } else if (tongTienParam == null || tongTienParam.trim().isEmpty()) {
                error = "invalidTongTien";
            } else {
                int maND = Integer.parseInt(maNDParam);
                BigDecimal tongTien = new BigDecimal(tongTienParam).setScale(0, BigDecimal.ROUND_DOWN);
                
                if (tongTien.compareTo(BigDecimal.ZERO) < 0) {
                    error = "negativeTongTien";
                } else {
                    String[] validStatuses = {"ChoXacNhan", "DaThanhToan", "DangGiao", "HoanTat", "Huy"};
                    boolean isValidStatus = false;
                    for (String status : validStatuses) {
                        if (status.equals(trangThai)) {
                            isValidStatus = true;
                            break;
                        }
                    }
                    
                    if (!isValidStatus) {
                        error = "invalidTrangThai";
                    } else {
                        java.sql.Timestamp ngayDat = new java.sql.Timestamp(System.currentTimeMillis());
                        Order order = new Order(0, maND, trangThai, tongTien, ngayDat);
                        
                        boolean inserted = orderService.addOrder(order);
                        if (!inserted) {
                            error = "insertFailed-MaND=" + maND + " - Kiểm tra mã khách hàng có tồn tại không";
                        } else {
                            response.sendRedirect(request.getContextPath() + "/admin/order/list?success=added");
                            return;
                        }
                    }
                }
            }
            
            if (error != null) {
                response.sendRedirect(request.getContextPath() + "/admin/order/add?error=" + error);
            }
            
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/order/add?error=invalidInput");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/order/add?error=serverError");
        }
    }

    private void updateOrder(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        try {
            int maDH = Integer.parseInt(request.getParameter("maDH"));
            String trangThai = request.getParameter("trangThai");
            BigDecimal tongTien = new BigDecimal(request.getParameter("tongTien"));
            
            orderService.updateOrder(maDH, trangThai, tongTien);
            
            response.sendRedirect(request.getContextPath() + "/admin/order/list");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/order/list?error=update");
        }
    }

    private void deleteOrder(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        try {
            int maDH = Integer.parseInt(request.getParameter("maDH"));
            orderService.deleteOrder(maDH);
            
            response.sendRedirect(request.getContextPath() + "/admin/order/list");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/order/list?error=delete");
        }
    }

    private void showOrderDetail(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            String maDHParam = request.getParameter("maDH");
            if (maDHParam == null || maDHParam.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/admin/order/list?error=invalidMaDH");
                return;
            }

            int maDH = Integer.parseInt(maDHParam);
            Order order = orderService.getOrderByIdWithCustomer(maDH);
            if (order == null) {
                response.sendRedirect(request.getContextPath() + "/admin/order/list?error=orderNotFound");
                return;
            }

            List<OrderDetail> orderDetails = orderService.getOrderDetails(maDH);
            BigDecimal totalAmount = orderService.calculateTotal(maDH);

            request.setAttribute("order", order);
            request.setAttribute("orderDetails", orderDetails);
            request.setAttribute("totalAmount", totalAmount);
            request.getRequestDispatcher("/admin/admin-order-details.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/order/list?error=invalidMaDH");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/order/list?error=serverError");
        }
    }

    // Các method mới cho xử lý trạng thái đơn hàng
    private void confirmOrder(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        try {
            String maDHParam = request.getParameter("maDH");
            if (maDHParam == null || maDHParam.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/admin/order/list?error=invalidMaDH");
                return;
            }

            int maDH = Integer.parseInt(maDHParam);
            boolean success = orderService.updateOrderStatus(maDH, "DangGiao");
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/admin/order/list?success=confirmed");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/order/list?error=confirmFailed");
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/order/list?error=invalidMaDH");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/order/list?error=serverError");
        }
    }

    private void confirmPayment(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        try {
            String maDHParam = request.getParameter("maDH");
            if (maDHParam == null || maDHParam.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/admin/order/list?error=invalidMaDH");
                return;
            }

            int maDH = Integer.parseInt(maDHParam);
            boolean success = orderService.updateOrderStatus(maDH, "DaThanhToan");
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/admin/order/list?success=paymentConfirmed");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/order/list?error=paymentConfirmFailed");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/order/list?error=serverError");
        }
    }

    private void completeOrder(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        try {
            String maDHParam = request.getParameter("maDH");
            if (maDHParam == null || maDHParam.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/admin/order/list?error=invalidMaDH");
                return;
            }

            int maDH = Integer.parseInt(maDHParam);
            boolean success = orderService.updateOrderStatus(maDH, "HoanTat");
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/admin/order/list?success=completed");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/order/list?error=completeFailed");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/order/list?error=serverError");
        }
    }

    private void cancelOrder(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        try {
            String maDHParam = request.getParameter("maDH");
            if (maDHParam == null || maDHParam.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/admin/order/list?error=invalidMaDH");
                return;
            }

            int maDH = Integer.parseInt(maDHParam);
            boolean success = orderService.updateOrderStatus(maDH, "Huy");
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/admin/order/list?success=cancelled");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/order/list?error=cancelFailed");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/order/list?error=serverError");
        }
    }
}