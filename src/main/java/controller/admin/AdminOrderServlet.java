package controller.admin;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.admin.Order;
import service.admin.OrderService;

@WebServlet(name = "AdminOrderServlet", urlPatterns = "/admin/order/*")
public class AdminOrderServlet extends HttpServlet {
    private OrderService orderService = new OrderService();

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
        request.setAttribute("orders", orderService.getAllOrders());
        request.getRequestDispatcher("/admin/admin-order-list.jsp").forward(request, response);
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

            // Validate inputs
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
                    // Kiểm tra trạng thái có hợp lệ không (phải khớp với ENUM trong database)
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
                        System.out.println("AdminOrderServlet: Thử thêm order - maND=" + maND + 
                                         ", trangThai=" + trangThai + ", tongTien=" + tongTien);
                        
                        java.sql.Timestamp ngayDat = new java.sql.Timestamp(System.currentTimeMillis());
                        Order order = new Order(0, maND, trangThai, tongTien, ngayDat);
                        
                        boolean inserted = orderService.addOrder(order);
                        if (!inserted) {
                            error = "insertFailed-MaND=" + maND + " - Kiểm tra mã khách hàng có tồn tại không";
                            System.err.println("AdminOrderServlet: Không thể thêm order, có thể do MaND=" + maND + " không tồn tại");
                        } else {
                            System.out.println("AdminOrderServlet: Thêm order thành công, maDH=" + order.getMaDH());
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
            System.err.println("AdminOrderServlet: NumberFormatException: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/order/add?error=invalidInput");
        } catch (Exception e) {
            System.err.println("AdminOrderServlet: Exception khi addOrder: " + e.getMessage());
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
}