package controller;

import dao.ExchangeDAO;
import dao.ProfileDAO;
import model.ExchangeRequest;
import model.UserProfile;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

@WebServlet("/exchange")
public class ExchangeServlet extends HttpServlet {
    
    private ExchangeDAO exchangeDAO = new ExchangeDAO();
    private ProfileDAO profileDAO = new ProfileDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        String userName = (String) session.getAttribute("userName");
        String userRole = (String) session.getAttribute("userRole");
        
        System.out.println("ExchangeServlet.doGet - Session info:");
        System.out.println("  - userId: " + userId);
        System.out.println("  - userName: " + userName);
        System.out.println("  - userRole: " + userRole);
        
        // Lấy thông tin user từ database (sử dụng ProfileDAO giống như RepairServlet)
        UserProfile userProfile = null;
        if (userId != null) {
            System.out.println("=== ExchangeServlet.doGet - START FETCHING USER INFO ===");
            System.out.println("ExchangeServlet.doGet - Using ProfileDAO.getUserById() for userId: " + userId);
            userProfile = profileDAO.getUserById(userId);
            System.out.println("ExchangeServlet.doGet - ProfileDAO.getUserById() returned: " + (userProfile != null ? "NOT NULL" : "NULL"));
            
            if (userProfile != null) {
                System.out.println("ExchangeServlet.doGet - SUCCESS! Loaded user from database:");
                System.out.println("  - MaND: " + userProfile.getMaND());
                System.out.println("  - HoTen: " + userProfile.getHoTen());
                System.out.println("  - Email: " + userProfile.getEmail());
                System.out.println("  - SoDT: " + userProfile.getSoDT());
                System.out.println("  - DiaChi: " + userProfile.getDiaChi());
            } else {
                System.out.println("ExchangeServlet.doGet - FALLBACK! User not found in database, creating from session");
                userProfile = new UserProfile();
                userProfile.setMaND(userId);
                userProfile.setHoTen(userName);
                userProfile.setEmail(null);
                userProfile.setSoDT(null);
                userProfile.setDiaChi(null);
                userProfile.setVaiTro(userRole != null ? userRole : "KhachHang");
                System.out.println("ExchangeServlet.doGet - Created fallback profile: " + userName);
            }
            System.out.println("=== ExchangeServlet.doGet - END FETCHING USER INFO ===");
        } else {
            System.out.println("ExchangeServlet.doGet - ERROR! No userId in session, cannot load user info");
            userProfile = new UserProfile();
        }
        
        // Lấy lịch sử thu mua nếu user đã đăng nhập
        if (userId != null) {
            List<ExchangeRequest> exchangeHistory = exchangeDAO.getExchangeHistory(userId);
            request.setAttribute("exchangeHistory", exchangeHistory);
            System.out.println("ExchangeServlet.doGet - Loaded " + exchangeHistory.size() + " exchange records");
        }
        
        request.setAttribute("userProfile", userProfile);
        
        // Forward to exchange.jsp
        request.getRequestDispatcher("/views/exchange.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        
        if (userId == null) {
            request.setAttribute("error", "Vui lòng đăng nhập để đăng ký thu mua");
            doGet(request, response);
            return;
        }
        
        // Lấy dữ liệu từ form
        String fullName = request.getParameter("fullName");
        String phoneNumber = request.getParameter("phoneNumber");
        String location = request.getParameter("location");
        String productName = request.getParameter("productName");
        String deviceCondition = request.getParameter("deviceCondition");
        String upgradeProduct = request.getParameter("upgradeProduct");
        String hangSX = request.getParameter("hangSX");
        String otherBrand = request.getParameter("otherBrand");
        String giaDeXuatStr = request.getParameter("giaDeXuat");
        String uploadedImageNames = request.getParameter("uploadedImageNames"); // Danh sách ảnh từ frontend
        
        // Xử lý danh sách ảnh
        String hinhAnh = null;
        if (uploadedImageNames != null && !uploadedImageNames.trim().isEmpty()) {
            // Tạm thời lưu danh sách tên ảnh, sẽ implement upload thật sau
            hinhAnh = uploadedImageNames; // Lưu danh sách tên ảnh cách nhau bởi dấu phẩy
        }
        
        System.out.println("ExchangeServlet.doPost - Form data:");
        System.out.println("  - fullName: " + fullName);
        System.out.println("  - phoneNumber: " + phoneNumber);
        System.out.println("  - location: " + location);
        System.out.println("  - productName: " + productName);
        System.out.println("  - deviceCondition: " + deviceCondition);
        System.out.println("  - upgradeProduct: " + upgradeProduct);
        System.out.println("  - hangSX: " + hangSX);
        System.out.println("  - otherBrand: " + otherBrand);
        System.out.println("  - giaDeXuatStr: " + giaDeXuatStr);
        System.out.println("  - uploadedImageNames: " + uploadedImageNames);
        
        // Validation
        if (fullName == null || fullName.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập họ và tên");
            doGet(request, response);
            return;
        }
        
        if (phoneNumber == null || phoneNumber.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập số điện thoại");
            doGet(request, response);
            return;
        }
        
        if (productName == null || productName.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập tên sản phẩm");
            doGet(request, response);
            return;
        }
        
        // Xử lý hãng sản xuất
        String finalHangSX = hangSX;
        if ("Khác".equals(hangSX)) {
            if (otherBrand == null || otherBrand.trim().isEmpty()) {
                request.setAttribute("error", "Vui lòng nhập tên hãng điện thoại khác");
                doGet(request, response);
                return;
            }
            finalHangSX = otherBrand.trim();
        } else if (hangSX == null || hangSX.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng chọn hãng sản xuất");
            doGet(request, response);
            return;
        }
        
        // Parse giá đề xuất
        BigDecimal giaDeXuat = BigDecimal.ZERO;
        if (giaDeXuatStr != null && !giaDeXuatStr.trim().isEmpty()) {
            try {
                // Remove thousand separators
                String cleanPrice = giaDeXuatStr.replaceAll("\\.", "");
                giaDeXuat = new BigDecimal(cleanPrice);
            } catch (NumberFormatException e) {
                System.err.println("Error parsing giaDeXuat: " + e.getMessage());
                request.setAttribute("error", "Giá đề xuất không hợp lệ");
                doGet(request, response);
                return;
            }
        }
        
        // Xử lý sản phẩm liên quan (upgradeProduct)
        String sanPhamLienQuan = "";
        if (upgradeProduct != null && !upgradeProduct.trim().isEmpty()) {
            sanPhamLienQuan = upgradeProduct.trim();
        } else {
            sanPhamLienQuan = "không";
        }
        
        // Tạo ExchangeRequest với cấu trúc đúng theo database
        ExchangeRequest exchangeRequest = new ExchangeRequest();
        exchangeRequest.setMaND(userId);
        exchangeRequest.setTenMay(productName.trim());
        exchangeRequest.setHangSX(finalHangSX);
        exchangeRequest.setTinhTrang(deviceCondition != null ? deviceCondition.trim() : "");
        exchangeRequest.setGiaDeXuat(giaDeXuat);
        exchangeRequest.setMoTaChiTiet(""); // Để trống, có thể thêm mô tả chi tiết sau
        exchangeRequest.setSanPhamLienQuan(sanPhamLienQuan);
        exchangeRequest.setDiaChi(location != null ? location.trim() : ""); // Lưu vào cột DiaChi
        exchangeRequest.setHinhAnh(hinhAnh);
        
        // Lưu vào database và lấy MaTMC
        int maTMC = exchangeDAO.saveExchangeRequest(exchangeRequest);
        
        if (maTMC > 0) {
            // Lưu thông tin vào session để hiển thị ở trang success
            session.setAttribute("exchangeMaTMC", maTMC);
            session.setAttribute("exchangeFullName", fullName);
            session.setAttribute("exchangePhoneNumber", phoneNumber);
            session.setAttribute("exchangeLocation", location);
            session.setAttribute("exchangeProductName", productName);
            session.setAttribute("exchangeDeviceCondition", deviceCondition);
            session.setAttribute("exchangeUpgradeProduct", upgradeProduct);
            session.setAttribute("exchangeHangSX", finalHangSX);
            session.setAttribute("exchangeGiaDeXuat", giaDeXuat);
            
            System.out.println("ExchangeServlet.doPost - Exchange request saved successfully with MaTMC: " + maTMC);
            
            // Redirect to success page
            response.sendRedirect(request.getContextPath() + "/exchange-success?maTMC=" + maTMC);
        } else {
            request.setAttribute("error", "Có lỗi xảy ra khi đăng ký thu mua. Vui lòng thử lại.");
            System.err.println("ExchangeServlet.doPost - Failed to save exchange request");
            doGet(request, response);
        }
    }
}
