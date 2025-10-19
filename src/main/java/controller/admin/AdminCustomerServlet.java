package controller.admin;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.admin.Customer;
import service.admin.CustomerService;

@WebServlet(name = "AdminCustomerServlet", urlPatterns = "/admin/customer/*")
public class AdminCustomerServlet extends HttpServlet {
    private CustomerService customerService = new CustomerService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getPathInfo();
        if (action == null) action = "/list";

        try {
            switch (action) {
                case "/list":
                    request.setAttribute("customers", customerService.getAllCustomers());
                    request.getRequestDispatcher("/admin/admin-customer-list.jsp").forward(request, response);
                    break;
                case "/add":
                    request.getRequestDispatcher("/admin/admin-customer-add.jsp").forward(request, response);
                    break;
                case "/edit":
                    int maND = Integer.parseInt(request.getParameter("maND"));
                    request.setAttribute("customer", customerService.getCustomerById(maND));
                    request.getRequestDispatcher("/admin/admin-customer-edit.jsp").forward(request, response);
                    break;
                case "/view": // THÊM CASE NÀY
                    int viewMaND = Integer.parseInt(request.getParameter("maND"));
                    request.setAttribute("customer", customerService.getCustomerById(viewMaND));
                    request.getRequestDispatcher("/admin/admin-customer-view.jsp").forward(request, response);
                    break;
                case "/delete":
                    deleteCustomer(request, response);
                    break;
                default:
                    response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (Exception e) {
            handleError(request, response, e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getPathInfo();
        if (action == null) action = "/list";

        try {
            switch (action) {
                case "/add":
                    addCustomer(request, response);
                    break;
                case "/edit":
                    updateCustomer(request, response);
                    break;
                default:
                    response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (Exception e) {
            handleError(request, response, e);
        }
    }

    private void addCustomer(HttpServletRequest request, HttpServletResponse response) throws Exception {
        Customer customer = extractPartialCustomerFromRequest(request, null, 0, 0); // Sử dụng null cho existing khi thêm mới
        System.out.println("Adding customer: " + customer.getHoTen() + ", Email: " + customer.getEmail());
        customerService.addCustomer(customer);
        setSuccessMessage(request, "Thêm khách hàng thành công");
        response.sendRedirect(request.getContextPath() + "/admin/customer/list");
    }

    private void updateCustomer(HttpServletRequest request, HttpServletResponse response) throws Exception {
        int maND = Integer.parseInt(request.getParameter("maND"));
        int maTK = Integer.parseInt(request.getParameter("maTK"));
        Customer existing = customerService.getCustomerById(maND);
        Customer customer = extractPartialCustomerFromRequest(request, existing, maND, maTK);
        System.out.println("Updating customer MaND: " + maND + ", MaTK: " + maTK);
        customerService.updateCustomer(customer);
        setSuccessMessage(request, "Cập nhật khách hàng thành công");
        response.sendRedirect(request.getContextPath() + "/admin/customer/list");
    }

    private void deleteCustomer(HttpServletRequest request, HttpServletResponse response) throws Exception {
        int maND = Integer.parseInt(request.getParameter("maND"));
        customerService.deleteCustomer(maND);
        setSuccessMessage(request, "Xóa khách hàng thành công");
        response.sendRedirect(request.getContextPath() + "/admin/customer/list");
    }

    private Customer extractPartialCustomerFromRequest(HttpServletRequest request, Customer existing, int maND, int maTK) throws ParseException {
        Customer customer = new Customer();
        customer.setMaND(maND);
        customer.setMaTK(maTK);

        // Lấy giá trị mặc định từ existing nếu null
        if (existing != null) {
            customer.setHoTen(existing.getHoTen());
            customer.setEmail(existing.getEmail());
            customer.setSoDT(existing.getSoDT());
            customer.setDiaChi(existing.getDiaChi());
            customer.setNgayTao(existing.getNgayTao());
            customer.setTenDangNhap(existing.getTenDangNhap());
            customer.setMatKhau(existing.getMatKhau());
            customer.setVaiTro(existing.getVaiTro());
            customer.setTrangThai(existing.isTrangThai());
            customer.setNgayTaoTK(existing.getNgayTaoTK());
        } else {
            // Thiết lập giá trị mặc định cho thêm mới
            customer.setNgayTao(new Date());
            customer.setNgayTaoTK(new Date());
            customer.setTrangThai(true); // Mặc định hoạt động
        }

        // Chỉ cập nhật các trường có giá trị mới
        String hoTen = request.getParameter("hoTen");
        if (hoTen != null && !hoTen.isEmpty()) customer.setHoTen(hoTen);

        String email = request.getParameter("email");
        if (email != null && !email.isEmpty()) customer.setEmail(email);

        String soDT = request.getParameter("soDT");
        if (soDT != null && !soDT.isEmpty()) customer.setSoDT(soDT);

        String diaChi = request.getParameter("diaChi");
        if (diaChi != null && !diaChi.isEmpty()) customer.setDiaChi(diaChi);

        String ngayTaoStr = request.getParameter("ngayTao");
        if (ngayTaoStr != null && !ngayTaoStr.isEmpty()) {
            customer.setNgayTao(parseDate(ngayTaoStr, customer.getNgayTao()));
        }

        String tenDangNhap = request.getParameter("tenDangNhap");
        if (tenDangNhap != null && !tenDangNhap.isEmpty()) customer.setTenDangNhap(tenDangNhap);

        String matKhau = request.getParameter("matKhau");
        if (matKhau != null && !matKhau.isEmpty()) customer.setMatKhau(matKhau);

        String vaiTro = request.getParameter("vaiTro");
        if (vaiTro != null && !vaiTro.isEmpty()) customer.setVaiTro(vaiTro);

        String trangThaiStr = request.getParameter("trangThai");
        if (trangThaiStr != null) customer.setTrangThai("on".equals(trangThaiStr));

        String ngayTaoTKStr = request.getParameter("ngayTaoTK");
        if (ngayTaoTKStr != null && !ngayTaoTKStr.isEmpty()) {
            customer.setNgayTaoTK(parseDate(ngayTaoTKStr, customer.getNgayTaoTK()));
        }

        return customer;
    }

    private Date parseDate(String dateStr, Date defaultValue) {
        if (dateStr == null || dateStr.trim().isEmpty()) {
            return defaultValue;
        }
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
        sdf.setLenient(false);
        try {
            return sdf.parse(dateStr);
        } catch (ParseException e) {
            System.out.println("Date parse error for: " + dateStr + ", using default: " + defaultValue);
            return defaultValue;
        }
    }

    private void handleError(HttpServletRequest request, HttpServletResponse response, Exception e) throws IOException {
        HttpSession session = request.getSession();
        session.setAttribute("error", e.getMessage());
        e.printStackTrace();
        response.sendRedirect(request.getContextPath() + "/admin/customer/list");
    }

    private void setSuccessMessage(HttpServletRequest request, String message) {
        HttpSession session = request.getSession();
        session.setAttribute("success", message);
    }
}