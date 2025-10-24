package controller;

import dao.ExchangeDAO;
import model.ExchangeRequest;
import model.UserProfile;
import dao.ProfileDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/exchange-detail")
public class ExchangeDetailServlet extends HttpServlet {
    
    private ExchangeDAO exchangeDAO = new ExchangeDAO();
    private ProfileDAO profileDAO = new ProfileDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession();
        
        // Lấy thông tin user từ session
        String userName = (String) session.getAttribute("userName");
        Integer userId = (Integer) session.getAttribute("userId");
        String userRole = (String) session.getAttribute("userRole");
        
        System.out.println("ExchangeDetailServlet.doGet - Session info:");
        System.out.println("  - userName: " + userName);
        System.out.println("  - userId: " + userId);
        System.out.println("  - userRole: " + userRole);
        
        // Lấy MaTMC từ request parameter
        String maTMCStr = request.getParameter("maTMC");
        if (maTMCStr == null || maTMCStr.trim().isEmpty()) {
            request.setAttribute("error", "Mã đơn thu mua không hợp lệ");
            request.getRequestDispatcher("/views/error.jsp").forward(request, response);
            return;
        }
        
        int maTMC;
        try {
            maTMC = Integer.parseInt(maTMCStr);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Mã đơn thu mua không hợp lệ");
            request.getRequestDispatcher("/views/error.jsp").forward(request, response);
            return;
        }
        
        System.out.println("ExchangeDetailServlet.doGet - Requested MaTMC: " + maTMC);
        
        // Lấy thông tin đơn thu mua từ database
        ExchangeRequest exchangeRequest = exchangeDAO.getExchangeRequestById(maTMC);
        
        if (exchangeRequest == null) {
            request.setAttribute("error", "Không tìm thấy đơn thu mua với mã: " + maTMC);
            request.getRequestDispatcher("/views/error.jsp").forward(request, response);
            return;
        }
        
        System.out.println("ExchangeDetailServlet.doGet - Found exchange request:");
        System.out.println("  - MaTMC: " + exchangeRequest.getMaTMC());
        System.out.println("  - MaND: " + exchangeRequest.getMaND());
        System.out.println("  - TenMay: " + exchangeRequest.getTenMay());
        System.out.println("  - TrangThai: " + exchangeRequest.getTrangThai());
        
        // Kiểm tra quyền truy cập (chỉ user sở hữu đơn hoặc admin mới được xem)
        if (userId == null || (!userId.equals(exchangeRequest.getMaND()) && !"Admin".equals(userRole))) {
            request.setAttribute("error", "Bạn không có quyền xem đơn thu mua này");
            request.getRequestDispatcher("/views/error.jsp").forward(request, response);
            return;
        }
        
        // Lấy thông tin user từ database
        UserProfile userProfile = null;
        if (userId != null) {
            userProfile = profileDAO.getUserById(userId);
            if (userProfile == null) {
                // Fallback: Tạo từ session
                userProfile = new UserProfile();
                userProfile.setMaND(userId);
                userProfile.setHoTen(userName);
                userProfile.setEmail(null);
                userProfile.setSoDT(null);
                userProfile.setDiaChi(null);
                userProfile.setVaiTro(userRole != null ? userRole : "KhachHang");
            }
        }
        
        // Set attributes cho JSP
        request.setAttribute("exchangeRequest", exchangeRequest);
        request.setAttribute("userProfile", userProfile);
        
        // Forward to exchange-detail.jsp
        request.getRequestDispatcher("/views/exchange-detail.jsp").forward(request, response);
    }
}
