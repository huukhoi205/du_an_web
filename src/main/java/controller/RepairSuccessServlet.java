package controller;

import dao.RepairDAO;
import model.RepairRequest;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/repair-success")
public class RepairSuccessServlet extends HttpServlet {
    
    private RepairDAO repairDAO = new RepairDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        
        // Lấy MaSC từ session hoặc parameter
        Integer repairMaSC = (Integer) session.getAttribute("repairMaSC");
        if (repairMaSC == null) {
            String maSCParam = request.getParameter("maSC");
            if (maSCParam != null) {
                try {
                    repairMaSC = Integer.parseInt(maSCParam);
                } catch (NumberFormatException e) {
                    System.err.println("Invalid MaSC parameter: " + maSCParam);
                }
            }
        }
        
        System.out.println("RepairSuccessServlet.doGet - repairMaSC: " + repairMaSC);
        
        if (repairMaSC != null) {
            // Lấy thông tin từ database
            RepairRequest repairRequest = repairDAO.getRepairRequestById(repairMaSC);
            
            if (repairRequest != null) {
                System.out.println("RepairSuccessServlet.doGet - Found repair request: " + repairRequest.getTenThietBi());
                
                // Set attributes cho JSP
                request.setAttribute("repairRequest", repairRequest);
                request.setAttribute("repairMaSC", repairRequest.getMaSC());
                request.setAttribute("repairFullName", getFullNameFromSession(session));
                request.setAttribute("repairEmail", getEmailFromSession(session));
                request.setAttribute("repairPhone", getPhoneFromSession(session));
                request.setAttribute("repairTenThietBi", repairRequest.getTenThietBi());
                request.setAttribute("repairLoaiLoi", repairRequest.getMoTaLoi());
                request.setAttribute("repairChiPhiDuKien", repairRequest.getChiPhiDuKien());
                request.setAttribute("repairChiPhiThucTe", repairRequest.getChiPhiThucTe());
                request.setAttribute("repairTrangThai", repairRequest.getTrangThai());
                request.setAttribute("repairNgayTiepNhan", repairRequest.getNgayTiepNhan());
                
                // Không xóa session attributes ngay lập tức
                // Chỉ xóa khi user thực sự rời khỏi trang
                
            } else {
                System.err.println("RepairSuccessServlet.doGet - Repair request not found for MaSC: " + repairMaSC);
                request.setAttribute("error", "Không tìm thấy thông tin đặt lịch sửa chữa");
            }
        } else {
            System.err.println("RepairSuccessServlet.doGet - No MaSC found in session or parameter");
            request.setAttribute("error", "Không tìm thấy mã đặt lịch sửa chữa");
        }
        
        // Forward to repair-success.jsp
        request.getRequestDispatcher("/views/repair-success.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
    
    // Helper method để lấy tên từ session
    private String getFullNameFromSession(HttpSession session) {
        String fullName = (String) session.getAttribute("repairFullName");
        if (fullName == null || fullName.trim().isEmpty()) {
            fullName = (String) session.getAttribute("userName");
        }
        return fullName != null ? fullName : "N/A";
    }
    
    // Helper method để lấy email từ session
    private String getEmailFromSession(HttpSession session) {
        String email = (String) session.getAttribute("repairEmail");
        if (email == null || email.trim().isEmpty()) {
            // Có thể lấy từ user profile nếu cần
            email = "N/A";
        }
        return email;
    }
    
    // Helper method để lấy số điện thoại từ session
    private String getPhoneFromSession(HttpSession session) {
        String phone = (String) session.getAttribute("repairPhone");
        if (phone == null || phone.trim().isEmpty()) {
            // Có thể lấy từ user profile nếu cần
            phone = "N/A";
        }
        return phone;
    }
}
