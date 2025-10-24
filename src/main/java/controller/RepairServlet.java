package controller;

import dao.RepairDAO;
import dao.ProfileDAO;
import model.RepairRequest;
import model.UserProfile;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/repair")
public class RepairServlet extends HttpServlet {
    
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
        
        System.out.println("RepairServlet.doGet - Session info:");
        System.out.println("  - userName: " + userName);
        System.out.println("  - userId: " + userId);
        System.out.println("  - userRole: " + userRole);
        
        // Lấy thông tin user từ database (sử dụng ProfileDAO giống như ProfileServlet)
        UserProfile userProfile = null;
        if (userId != null) {
            System.out.println("=== RepairServlet.doGet - START FETCHING USER INFO ===");
            System.out.println("RepairServlet.doGet - Using ProfileDAO.getUserById() for userId: " + userId);
            userProfile = profileDAO.getUserById(userId);
            System.out.println("RepairServlet.doGet - ProfileDAO.getUserById() returned: " + (userProfile != null ? "NOT NULL" : "NULL"));
            
            if (userProfile != null) {
                System.out.println("RepairServlet.doGet - SUCCESS! Loaded user from database:");
                System.out.println("  - MaND: " + userProfile.getMaND());
                System.out.println("  - HoTen: " + userProfile.getHoTen());
                System.out.println("  - Email: " + userProfile.getEmail());
                System.out.println("  - SoDT: " + userProfile.getSoDT());
                System.out.println("  - DiaChi: " + userProfile.getDiaChi());
            } else {
                System.out.println("RepairServlet.doGet - FALLBACK! User not found in database, creating from session");
                // Fallback: Tạo từ session nếu không tìm thấy trong database
                userProfile = new UserProfile();
                userProfile.setMaND(userId);
                userProfile.setHoTen(userName);
                userProfile.setEmail(null);
                userProfile.setSoDT(null);
                userProfile.setDiaChi(null);
                userProfile.setVaiTro(userRole != null ? userRole : "KhachHang");
                System.out.println("RepairServlet.doGet - Created fallback profile: " + userName);
            }
            System.out.println("=== RepairServlet.doGet - END FETCHING USER INFO ===");
        } else {
            System.out.println("RepairServlet.doGet - ERROR! No userId in session, cannot load user info");
            userProfile = new UserProfile();
        }
        
        // Lấy lịch sử sửa chữa nếu có userId
        if (userId != null) {
            var repairHistory = repairDAO.getRepairHistory(userId);
            request.setAttribute("repairHistory", repairHistory);
            System.out.println("RepairServlet.doGet - Loaded " + repairHistory.size() + " repair records");
        }
        
        request.setAttribute("userProfile", userProfile);
        
        // Forward to repair.jsp
        request.getRequestDispatcher("/views/repair.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        
        if (userId == null) {
            request.setAttribute("error", "Vui lòng đăng nhập để đặt lịch sửa chữa");
            doGet(request, response);
            return;
        }
        
        // Lấy dữ liệu từ form
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String tenThietBi = request.getParameter("tenThietBi");
        String loaiLoi = request.getParameter("loaiLoi");
        String moTaLoiKhac = request.getParameter("moTaLoiKhac");
        String chiPhiDuKienStr = request.getParameter("chiPhiDuKien");
        
        System.out.println("RepairServlet.doPost - Form data:");
        System.out.println("  - fullName: " + fullName);
        System.out.println("  - email: " + email);
        System.out.println("  - phone: " + phone);
        System.out.println("  - tenThietBi: " + tenThietBi);
        System.out.println("  - loaiLoi: " + loaiLoi);
        System.out.println("  - moTaLoiKhac: " + moTaLoiKhac);
        System.out.println("  - chiPhiDuKienStr: " + chiPhiDuKienStr);
        
        // Validation
        if (fullName == null || fullName.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập họ và tên");
            doGet(request, response);
            return;
        }
        
        if (phone == null || phone.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập số điện thoại");
            doGet(request, response);
            return;
        }
        
        if (tenThietBi == null || tenThietBi.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập tên thiết bị");
            doGet(request, response);
            return;
        }
        
        if (loaiLoi == null || loaiLoi.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng chọn loại lỗi");
            doGet(request, response);
            return;
        }
        
        if ("Khác".equals(loaiLoi) && (moTaLoiKhac == null || moTaLoiKhac.trim().isEmpty())) {
            request.setAttribute("error", "Vui lòng mô tả chi tiết lỗi khi chọn 'Khác'");
            doGet(request, response);
            return;
        }
        
        // Parse chi phí dự kiến
        double chiPhiDuKien = 0.0;
        if (chiPhiDuKienStr != null && !chiPhiDuKienStr.trim().isEmpty()) {
            try {
                // Remove thousand separators
                String cleanPrice = chiPhiDuKienStr.replaceAll("\\.", "");
                chiPhiDuKien = Double.parseDouble(cleanPrice);
            } catch (NumberFormatException e) {
                System.err.println("Error parsing chiPhiDuKien: " + e.getMessage());
                request.setAttribute("error", "Chi phí dự kiến không hợp lệ");
                doGet(request, response);
                return;
            }
        }
        
        // Tạo mô tả lỗi: Kết hợp loại lỗi + mô tả chi tiết
        String moTaLoi = loaiLoi;
        if ("Khác".equals(loaiLoi) && moTaLoiKhac != null && !moTaLoiKhac.trim().isEmpty()) {
            moTaLoi = moTaLoiKhac.trim();
        }
        
        // Tạo RepairRequest
        RepairRequest repairRequest = new RepairRequest();
        repairRequest.setMaND(userId);
        repairRequest.setTenThietBi(tenThietBi.trim());
        repairRequest.setMoTaLoi(moTaLoi);
        repairRequest.setChiPhiDuKien(chiPhiDuKien);
        
        // Lưu vào database và lấy MaSC
        int maSC = repairDAO.saveRepairRequest(repairRequest);
        
        if (maSC > 0) {
            // Lưu thông tin vào session để hiển thị ở trang success
            session.setAttribute("repairMaSC", maSC);
            session.setAttribute("repairFullName", fullName);
            session.setAttribute("repairEmail", email);
            session.setAttribute("repairPhone", phone);
            session.setAttribute("repairTenThietBi", tenThietBi);
            session.setAttribute("repairLoaiLoi", loaiLoi);
            session.setAttribute("repairMoTaLoiKhac", moTaLoiKhac);
            session.setAttribute("repairChiPhiDuKien", chiPhiDuKien);
            
            System.out.println("RepairServlet.doPost - Repair request saved successfully with MaSC: " + maSC);
            
            // Redirect to success page
            response.sendRedirect(request.getContextPath() + "/repair-success?maSC=" + maSC);
        } else {
            request.setAttribute("error", "Có lỗi xảy ra khi đặt lịch sửa chữa. Vui lòng thử lại.");
            System.err.println("RepairServlet.doPost - Failed to save repair request");
            doGet(request, response);
        }
    }
}