package controller;

import dao.RepairDAO;
import model.RepairRequest;
import model.UserProfile;
import dao.ProfileDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/repair-detail")
public class RepairDetailServlet extends HttpServlet {
    
    private RepairDAO repairDAO = new RepairDAO();
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
        
        System.out.println("RepairDetailServlet.doGet - Session info:");
        System.out.println("  - userName: " + userName);
        System.out.println("  - userId: " + userId);
        System.out.println("  - userRole: " + userRole);
        
        // Lấy MaSC từ request parameter
        String maSCStr = request.getParameter("maSC");
        if (maSCStr == null || maSCStr.trim().isEmpty()) {
            request.setAttribute("error", "Mã đơn sửa chữa không hợp lệ");
            request.getRequestDispatcher("/views/error.jsp").forward(request, response);
            return;
        }
        
        int maSC;
        try {
            maSC = Integer.parseInt(maSCStr);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Mã đơn sửa chữa không hợp lệ");
            request.getRequestDispatcher("/views/error.jsp").forward(request, response);
            return;
        }
        
        System.out.println("RepairDetailServlet.doGet - Requested MaSC: " + maSC);
        
        // Lấy thông tin đơn sửa chữa từ database
        RepairRequest repairRequest = repairDAO.getRepairRequestById(maSC);
        
        if (repairRequest == null) {
            request.setAttribute("error", "Không tìm thấy đơn sửa chữa với mã: " + maSC);
            request.getRequestDispatcher("/views/error.jsp").forward(request, response);
            return;
        }
        
        System.out.println("RepairDetailServlet.doGet - Found repair request:");
        System.out.println("  - MaSC: " + repairRequest.getMaSC());
        System.out.println("  - MaND: " + repairRequest.getMaND());
        System.out.println("  - TenThietBi: " + repairRequest.getTenThietBi());
        System.out.println("  - TrangThai: " + repairRequest.getTrangThai());
        
        // Kiểm tra quyền truy cập (chỉ user sở hữu đơn hoặc admin mới được xem)
        if (userId == null || (!userId.equals(repairRequest.getMaND()) && !"Admin".equals(userRole))) {
            request.setAttribute("error", "Bạn không có quyền xem đơn sửa chữa này");
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
        request.setAttribute("repairRequest", repairRequest);
        request.setAttribute("userProfile", userProfile);
        
        // Forward to repair-detail.jsp
        request.getRequestDispatcher("/views/repair-detail.jsp").forward(request, response);
    }
}
