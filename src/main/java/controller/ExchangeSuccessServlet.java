package controller;

import dao.ExchangeDAO;
import model.ExchangeRequest;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/exchange-success")
public class ExchangeSuccessServlet extends HttpServlet {
    
    private ExchangeDAO exchangeDAO = new ExchangeDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        
        // Lấy MaTMC từ session hoặc parameter
        Integer exchangeMaTMC = (Integer) session.getAttribute("exchangeMaTMC");
        if (exchangeMaTMC == null) {
            String maTMCParam = request.getParameter("maTMC");
            if (maTMCParam != null) {
                try {
                    exchangeMaTMC = Integer.parseInt(maTMCParam);
                } catch (NumberFormatException e) {
                    System.err.println("Invalid MaTMC parameter: " + maTMCParam);
                }
            }
        }
        
        System.out.println("ExchangeSuccessServlet.doGet - exchangeMaTMC: " + exchangeMaTMC);
        
        if (exchangeMaTMC != null) {
            // Lấy thông tin từ database
            ExchangeRequest exchangeRequest = exchangeDAO.getExchangeRequestById(exchangeMaTMC);
            
            if (exchangeRequest != null) {
                System.out.println("ExchangeSuccessServlet.doGet - Found exchange request: " + exchangeRequest.getTenMay());
                
                // Set attributes cho JSP
                request.setAttribute("exchangeRequest", exchangeRequest);
                request.setAttribute("exchangeMaTMC", exchangeRequest.getMaTMC());
                request.setAttribute("exchangeFullName", getFullNameFromSession(session));
                request.setAttribute("exchangePhoneNumber", getPhoneNumberFromSession(session));
                request.setAttribute("exchangeLocation", exchangeRequest.getDiaChi() != null ? exchangeRequest.getDiaChi() : "N/A");
                request.setAttribute("exchangeProductName", exchangeRequest.getTenMay());
                request.setAttribute("exchangeDeviceCondition", exchangeRequest.getTinhTrang());
                request.setAttribute("exchangeUpgradeProduct", exchangeRequest.getSanPhamLienQuan());
                request.setAttribute("exchangeHangSX", exchangeRequest.getHangSX());
                request.setAttribute("exchangeGiaDeXuat", exchangeRequest.getGiaDeXuat());
                request.setAttribute("exchangeGiaThoaThuan", exchangeRequest.getGiaThoaThuan());
                request.setAttribute("exchangeTrangThai", exchangeRequest.getTrangThai());
                request.setAttribute("exchangeNgayTao", exchangeRequest.getNgayTao());
                
                // Không xóa session attributes ngay lập tức
                // Chỉ xóa khi user thực sự rời khỏi trang
                
            } else {
                System.err.println("ExchangeSuccessServlet.doGet - Exchange request not found for MaTMC: " + exchangeMaTMC);
                request.setAttribute("error", "Không tìm thấy thông tin đăng ký thu mua");
            }
        } else {
            System.err.println("ExchangeSuccessServlet.doGet - No MaTMC found in session or parameter");
            request.setAttribute("error", "Không tìm thấy mã đăng ký thu mua");
        }
        
        // Forward to exchange-success.jsp
        request.getRequestDispatcher("/views/exchange-success.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
    
    // Helper method để lấy tên từ session
    private String getFullNameFromSession(HttpSession session) {
        String fullName = (String) session.getAttribute("exchangeFullName");
        if (fullName == null || fullName.trim().isEmpty()) {
            fullName = (String) session.getAttribute("userName");
        }
        return fullName != null ? fullName : "N/A";
    }
    
    // Helper method để lấy số điện thoại từ session
    private String getPhoneNumberFromSession(HttpSession session) {
        String phoneNumber = (String) session.getAttribute("exchangePhoneNumber");
        if (phoneNumber == null || phoneNumber.trim().isEmpty()) {
            // Có thể lấy từ user profile nếu cần
            phoneNumber = "N/A";
        }
        return phoneNumber;
    }
    
}
