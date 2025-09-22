package controller.admin;

import java.io.IOException;
import java.math.BigDecimal;
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
                request.setAttribute("orders", orderService.getAllOrders());
                request.getRequestDispatcher("/admin/admin-order-list.jsp").forward(request, response);
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

    private void addOrder(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int maND = Integer.parseInt(request.getParameter("maND"));
        String trangThai = request.getParameter("trangThai");
        BigDecimal tongTien = new BigDecimal(request.getParameter("tongTien"));
        java.sql.Timestamp ngayDat = new java.sql.Timestamp(System.currentTimeMillis());
        orderService.addOrder(new Order(0, maND, trangThai, tongTien, ngayDat));
        response.sendRedirect(request.getContextPath() + "/admin/order/list");
    }

    private void updateOrder(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int maDH = Integer.parseInt(request.getParameter("maDH"));
        String trangThai = request.getParameter("trangThai");
        BigDecimal tongTien = new BigDecimal(request.getParameter("tongTien"));
        orderService.updateOrder(maDH, trangThai, tongTien);
        response.sendRedirect(request.getContextPath() + "/admin/order/list");
    }

    private void deleteOrder(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int maDH = Integer.parseInt(request.getParameter("maDH"));
        orderService.deleteOrder(maDH);
        response.sendRedirect(request.getContextPath() + "/admin/order/list");
    }
}
