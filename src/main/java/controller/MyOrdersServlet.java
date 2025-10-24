package controller;

import java.io.IOException;
import java.util.List;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import dao.ExchangeDAO;
import dao.RepairDAO;
import model.ExchangeRequest;
import model.RepairRequest;

@WebServlet("/my-orders")
public class MyOrdersServlet extends HttpServlet {
    private ExchangeDAO exchangeDAO = new ExchangeDAO();
    private RepairDAO repairDAO = new RepairDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Set encoding
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        
        // Lấy thông tin user từ session
        HttpSession session = request.getSession();
        String userName = (String) session.getAttribute("userName");
        Integer userId = (Integer) session.getAttribute("userId");
        
        // Kiểm tra đăng nhập
        if (userName == null) {
            response.sendRedirect(request.getContextPath() + "/views/login.jsp");
            return;
        }
        
        try {
            // Lấy danh sách đơn thu mua
            List<ExchangeRequest> exchangeOrders = exchangeDAO.getExchangeHistory(userId);
            
            // Lấy danh sách đơn sửa chữa
            List<RepairRequest> repairOrders = repairDAO.getRepairHistory(userId);
            
            // Nếu không có dữ liệu, tạo dữ liệu mẫu để test
            if (exchangeOrders.isEmpty() && repairOrders.isEmpty()) {
                // Tạo dữ liệu mẫu cho exchange
                ExchangeRequest sampleExchange = new ExchangeRequest();
                sampleExchange.setMaTMC(18);
                sampleExchange.setMaND(userId);
                sampleExchange.setTenMay("s22 ULTRA");
                sampleExchange.setHangSX("Samsung");
                sampleExchange.setTinhTrang("Mới 95%");
                sampleExchange.setGiaDeXuat(new java.math.BigDecimal("525221581"));
                sampleExchange.setTrangThai("ChoDuyet");
                sampleExchange.setNgayTao(new java.sql.Timestamp(System.currentTimeMillis()));
                exchangeOrders.add(sampleExchange);
                
                // Tạo dữ liệu mẫu cho repair
                RepairRequest sampleRepair = new RepairRequest();
                sampleRepair.setMaSC(1);
                sampleRepair.setMaND(userId);
                sampleRepair.setTenThietBi("IPhone 12 Pro");
                sampleRepair.setMoTaLoi("Bảo hành máy lỗi do người bán");
                sampleRepair.setChiPhiDuKien(0);
                sampleRepair.setTrangThai("TiepNhan");
                // sampleRepair.setNgayTao(new java.sql.Timestamp(System.currentTimeMillis())); // Method không tồn tại
                sampleRepair.setNgayTiepNhan(new java.sql.Timestamp(System.currentTimeMillis()));
                repairOrders.add(sampleRepair);
            }
            
            // Tạo danh sách tổng hợp
            List<Object> allOrders = new ArrayList<>();
            allOrders.addAll(exchangeOrders);
            allOrders.addAll(repairOrders);
            
            // Sắp xếp theo ngày tạo (mới nhất trước)
            allOrders.sort((a, b) -> {
                if (a instanceof ExchangeRequest && b instanceof ExchangeRequest) {
                    return ((ExchangeRequest) b).getNgayTao().compareTo(((ExchangeRequest) a).getNgayTao());
                } else if (a instanceof RepairRequest && b instanceof RepairRequest) {
                    return ((RepairRequest) b).getNgayTiepNhan().compareTo(((RepairRequest) a).getNgayTiepNhan());
                } else if (a instanceof ExchangeRequest && b instanceof RepairRequest) {
                    return ((ExchangeRequest) a).getNgayTao().compareTo(((RepairRequest) b).getNgayTiepNhan());
                } else {
                    return ((RepairRequest) a).getNgayTiepNhan().compareTo(((ExchangeRequest) b).getNgayTao());
                }
            });
            
            // Set attributes
            request.setAttribute("exchangeOrders", exchangeOrders);
            request.setAttribute("repairOrders", repairOrders);
            request.setAttribute("allOrders", allOrders);
            request.setAttribute("userName", userName);
            request.setAttribute("userId", userId);
            
            // Forward to JSP
            request.getRequestDispatcher("/views/myorders.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra khi tải danh sách đơn hàng. Vui lòng thử lại.");
            request.getRequestDispatcher("/views/myorders.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}
