package controller.admin;

import model.admin.RepairSchedule;
import service.admin.RepairScheduleService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "AdminRepairScheduleServlet", urlPatterns = {"/AdminRepairScheduleServlet"})
public class AdminRepairScheduleServlet extends HttpServlet {
    private RepairScheduleService service = new RepairScheduleService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) action = "list";

        try {
            switch (action) {
                case "add":
                    req.getRequestDispatcher("/admin/admin-repair-add.jsp").forward(req, resp);
                    break;
                    
                case "edit":
                    handleEdit(req, resp);
                    break;
                    
                case "delete":
                    handleDelete(req, resp);
                    break;
                    
                case "view":
                    handleView(req, resp);
                    break;
                    
                default:
                    handleList(req, resp);
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("errorMessage", "Có lỗi xảy ra: " + e.getMessage());
            req.getRequestDispatcher("/admin/admin-repair-list.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");

        try {
            if ("create".equals(action)) {
                handleCreate(req, resp);
            } else if ("update".equals(action)) {
                handleUpdate(req, resp);
            } else {
                resp.sendRedirect("AdminRepairScheduleServlet");
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("errorMessage", "Có lỗi xảy ra: " + e.getMessage());
            req.getRequestDispatcher("/admin/admin-repair-add.jsp").forward(req, resp);
        }
    }

    private void handleList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<RepairSchedule> list = service.getAll();
        req.setAttribute("list", list);
        req.getRequestDispatcher("/admin/admin-repair-list.jsp").forward(req, resp);
    }

    private void handleEdit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(req.getParameter("id"));
            RepairSchedule item = service.getById(id);
            
            if (item == null) {
                req.setAttribute("errorMessage", "Không tìm thấy lịch sửa chữa với mã: " + id);
                handleList(req, resp);
                return;
            }
            
            req.setAttribute("item", item);
            req.getRequestDispatcher("/admin/admin-repair-edit.jsp").forward(req, resp);
        } catch (NumberFormatException e) {
            req.setAttribute("errorMessage", "Mã lịch sửa chữa không hợp lệ");
            handleList(req, resp);
        }
    }

    private void handleView(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(req.getParameter("id"));
            RepairSchedule item = service.getById(id);
            
            if (item == null) {
                req.setAttribute("errorMessage", "Không tìm thấy lịch sửa chữa");
                handleList(req, resp);
                return;
            }
            
            req.setAttribute("item", item);
            req.getRequestDispatcher("/admin/admin-repair-view.jsp").forward(req, resp);
        } catch (NumberFormatException e) {
            req.setAttribute("errorMessage", "Mã không hợp lệ");
            handleList(req, resp);
        }
    }

    private void handleDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(req.getParameter("id"));
            boolean success = service.remove(id);
            
            if (success) {
                req.getSession().setAttribute("successMessage", "Xóa lịch sửa chữa thành công");
            } else {
                req.getSession().setAttribute("errorMessage", "Không thể xóa lịch sửa chữa");
            }
        } catch (NumberFormatException e) {
            req.getSession().setAttribute("errorMessage", "Mã không hợp lệ");
        }
        
        resp.sendRedirect("AdminRepairScheduleServlet");
    }

    private void handleCreate(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<String> errors = new ArrayList<>();
        
        // Validation
        String maND = req.getParameter("maND");
        String tenThietBi = req.getParameter("tenThietBi");
        String chiPhiDuKien = req.getParameter("chiPhiDuKien");
        
        if (maND == null || maND.trim().isEmpty()) {
            errors.add("Mã người dùng không được để trống");
        } else {
            try {
                int maNDInt = Integer.parseInt(maND);
                if (maNDInt <= 0) {
                    errors.add("Mã người dùng phải lớn hơn 0");
                }
            } catch (NumberFormatException e) {
                errors.add("Mã người dùng không hợp lệ");
            }
        }
        
        if (tenThietBi == null || tenThietBi.trim().isEmpty()) {
            errors.add("Tên thiết bị không được để trống");
        }
        
        if (!errors.isEmpty()) {
            req.setAttribute("errors", errors);
            req.setAttribute("maND", maND);
            req.setAttribute("tenThietBi", tenThietBi);
            req.setAttribute("moTaLoi", req.getParameter("moTaLoi"));
            req.setAttribute("chiPhiDuKien", chiPhiDuKien);
            req.setAttribute("chiPhiThucTe", req.getParameter("chiPhiThucTe"));
            req.setAttribute("trangThai", req.getParameter("trangThai"));
            req.getRequestDispatcher("/admin/admin-repair-add.jsp").forward(req, resp);
            return;
        }
        
        RepairSchedule r = mapRequest(req);
        boolean success = service.create(r);
        
        if (success) {
            req.getSession().setAttribute("successMessage", "Thêm lịch sửa chữa thành công");
            resp.sendRedirect("AdminRepairScheduleServlet");
        } else {
            req.setAttribute("errorMessage", "Không thể thêm lịch sửa chữa. Vui lòng kiểm tra lại dữ liệu.");
            req.setAttribute("maND", maND);
            req.setAttribute("tenThietBi", tenThietBi);
            req.setAttribute("moTaLoi", req.getParameter("moTaLoi"));
            req.setAttribute("chiPhiDuKien", chiPhiDuKien);
            req.setAttribute("chiPhiThucTe", req.getParameter("chiPhiThucTe"));
            req.setAttribute("trangThai", req.getParameter("trangThai"));
            req.getRequestDispatcher("/admin/admin-repair-add.jsp").forward(req, resp);
        }
    }

    private void handleUpdate(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<String> errors = new ArrayList<>();
        
        String maSC = req.getParameter("maSC");
        String tenThietBi = req.getParameter("tenThietBi");
        
        if (maSC == null || maSC.trim().isEmpty()) {
            errors.add("Mã sửa chữa không hợp lệ");
        }
        if (tenThietBi == null || tenThietBi.trim().isEmpty()) {
            errors.add("Tên thiết bị không được để trống");
        }
        
        if (!errors.isEmpty()) {
            req.setAttribute("errors", errors);
            RepairSchedule item = service.getById(Integer.parseInt(maSC));
            req.setAttribute("item", item);
            req.getRequestDispatcher("/admin/admin-repair-edit.jsp").forward(req, resp);
            return;
        }
        
        RepairSchedule r = mapRequest(req);
        r.setMaSC(Integer.parseInt(maSC));
        
        // Xử lý ngày hoàn tất
        String ngayHoanTat = req.getParameter("ngayHoanTat");
        if (ngayHoanTat != null && !ngayHoanTat.trim().isEmpty()) {
            try {
                r.setNgayHoanTat(Timestamp.valueOf(ngayHoanTat.replace("T", " ") + ":00"));
            } catch (Exception e) {
                errors.add("Định dạng ngày hoàn tất không hợp lệ");
            }
        }
        
        boolean success = service.edit(r);
        
        if (success) {
            req.getSession().setAttribute("successMessage", "Cập nhật lịch sửa chữa thành công");
            resp.sendRedirect("AdminRepairScheduleServlet");
        } else {
            req.setAttribute("errorMessage", "Không thể cập nhật lịch sửa chữa");
            req.setAttribute("item", r);
            req.getRequestDispatcher("/admin/admin-repair-edit.jsp").forward(req, resp);
        }
    }

    private RepairSchedule mapRequest(HttpServletRequest req) {
        RepairSchedule r = new RepairSchedule();
        
        try {
            r.setMaND(Integer.parseInt(req.getParameter("maND")));
        } catch (NumberFormatException e) {
            r.setMaND(0);
        }
        
        r.setTenThietBi(req.getParameter("tenThietBi"));
        r.setMoTaLoi(req.getParameter("moTaLoi"));
        
        try {
            String chiPhiDuKien = req.getParameter("chiPhiDuKien");
            if (chiPhiDuKien != null && !chiPhiDuKien.trim().isEmpty()) {
                r.setChiPhiDuKien(new BigDecimal(chiPhiDuKien));
            }
        } catch (Exception e) {
            r.setChiPhiDuKien(null);
        }
        
        try {
            String chiPhiThucTe = req.getParameter("chiPhiThucTe");
            if (chiPhiThucTe != null && !chiPhiThucTe.trim().isEmpty()) {
                r.setChiPhiThucTe(new BigDecimal(chiPhiThucTe));
            }
        } catch (Exception e) {
            r.setChiPhiThucTe(null);
        }
        
        String trangThai = req.getParameter("trangThai");
        r.setTrangThai(trangThai != null && !trangThai.trim().isEmpty() ? trangThai : "TiepNhan");
        
        return r;
    }
}