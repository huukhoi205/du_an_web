package controller;

import dao.ProfileDAO;
import model.UserProfile;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        
        System.out.println("ProfileServlet doGet - userId from session: " + userId);
        
        if (userId == null) {
            System.out.println("ProfileServlet doGet - userId is null, redirecting to login");
            response.sendRedirect(request.getContextPath() + "/views/login.jsp");
            return;
        }
        
        // Lấy thông tin user từ database
        ProfileDAO profileDAO = new ProfileDAO();
        UserProfile userProfile = profileDAO.getUserById(userId);
        
        System.out.println("ProfileServlet doGet - userProfile from database: " + userProfile);
        
        if (userProfile == null) {
            System.out.println("ProfileServlet doGet - userProfile is null, creating from session");
            // Fallback: Tạo userProfile từ session data
            String userName = (String) session.getAttribute("userName");
            String userEmail = (String) session.getAttribute("userEmail");
            
            if (userName != null && userEmail != null) {
                userProfile = new UserProfile();
                userProfile.setMaND(userId);
                userProfile.setHoTen(userName);
                userProfile.setEmail(userEmail);
                userProfile.setSoDT(null);
                userProfile.setDiaChi(null);
                userProfile.setNgaySinh(null);
                userProfile.setGioiTinh(null);
                userProfile.setVaiTro("KhachHang");
                
                System.out.println("ProfileServlet doGet - Created userProfile from session: " + userName + ", " + userEmail);
                request.setAttribute("userProfile", userProfile);
            } else {
                System.out.println("ProfileServlet doGet - No session data available, setting error");
                request.setAttribute("error", "Không tìm thấy thông tin người dùng!");
            }
        } else {
            System.out.println("ProfileServlet doGet - userProfile found: " + userProfile.getHoTen() + ", " + userProfile.getEmail());
            request.setAttribute("userProfile", userProfile);
        }
        
        // Forward to profile.jsp
        request.getRequestDispatcher("/views/profile.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        
        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/views/login.jsp");
            return;
        }
        
        // Lấy dữ liệu từ form
        String hoTen = request.getParameter("hoTen");
        String email = request.getParameter("email");
        String soDT = request.getParameter("soDT");
        String diaChi = request.getParameter("diaChi");
        
        // Validation
        String errorMessage = validateInput(hoTen, email, soDT, diaChi);
        if (errorMessage != null) {
            request.setAttribute("error", errorMessage);
            // Reload user profile để hiển thị lại form
            ProfileDAO profileDAO = new ProfileDAO();
            UserProfile userProfile = profileDAO.getUserById(userId);
            request.setAttribute("userProfile", userProfile);
            request.getRequestDispatcher("/views/profile.jsp").forward(request, response);
            return;
        }
        
        // Kiểm tra email và số điện thoại trùng lặp
        ProfileDAO profileDAO = new ProfileDAO();
        if (profileDAO.isEmailExists(email, userId)) {
            request.setAttribute("error", "Email này đã được sử dụng bởi tài khoản khác!");
            UserProfile userProfile = profileDAO.getUserById(userId);
            request.setAttribute("userProfile", userProfile);
            request.getRequestDispatcher("/views/profile.jsp").forward(request, response);
            return;
        }
        
        if (profileDAO.isPhoneExists(soDT, userId)) {
            request.setAttribute("error", "Số điện thoại này đã được sử dụng bởi tài khoản khác!");
            UserProfile userProfile = profileDAO.getUserById(userId);
            request.setAttribute("userProfile", userProfile);
            request.getRequestDispatcher("/views/profile.jsp").forward(request, response);
            return;
        }
        
        // Tạo UserProfile object
        UserProfile userProfile = new UserProfile();
        userProfile.setMaND(userId);
        userProfile.setHoTen(hoTen);
        userProfile.setEmail(email);
        userProfile.setSoDT(soDT);
        userProfile.setDiaChi(diaChi);
        
        // Cập nhật thông tin
        boolean success = profileDAO.updateUserProfile(userProfile);
        
        if (success) {
            // Cập nhật session với thông tin mới
            session.setAttribute("userName", hoTen);
            
            request.setAttribute("success", "Cập nhật thông tin thành công!");
            request.setAttribute("userProfile", userProfile);
        } else {
            request.setAttribute("error", "Có lỗi xảy ra khi cập nhật thông tin. Vui lòng thử lại!");
            // Reload user profile
            UserProfile currentProfile = profileDAO.getUserById(userId);
            request.setAttribute("userProfile", currentProfile);
        }
        
        // Forward to profile.jsp
        request.getRequestDispatcher("/views/profile.jsp").forward(request, response);
    }
    
    /**
     * Validate input data
     */
    private String validateInput(String hoTen, String email, String soDT, String diaChi) {
        if (hoTen == null || hoTen.trim().isEmpty()) {
            return "Họ tên không được để trống!";
        }
        
        if (email == null || email.trim().isEmpty()) {
            return "Email không được để trống!";
        }
        
        if (!isValidEmail(email)) {
            return "Email không hợp lệ!";
        }
        
        // Số điện thoại có thể để trống, nhưng nếu có thì phải đúng format
        if (soDT != null && !soDT.trim().isEmpty() && !isValidPhone(soDT)) {
            return "Số điện thoại phải có 10 số!";
        }
        
        // Địa chỉ có thể để trống
        
        return null; // Valid
    }
    
    /**
     * Validate email format
     */
    private boolean isValidEmail(String email) {
        String emailRegex = "^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$";
        return email.matches(emailRegex);
    }
    
    /**
     * Validate phone number (10 digits)
     */
    private boolean isValidPhone(String phone) {
        String phoneDigits = phone.replaceAll("\\D", "");
        return phoneDigits.length() == 10;
    }
}
