package controller.admin;

import model.admin.RepairSchedule;
import service.admin.RepairScheduleService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Timestamp;

@WebServlet(name = "AdminRepairScheduleServlet", urlPatterns = {"/AdminRepairScheduleServlet"})
public class AdminRepairScheduleServlet extends HttpServlet {
    private RepairScheduleService service = new RepairScheduleService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "add":
                req.getRequestDispatcher("/admin/admin-repair-add.jsp").forward(req, resp);
                break;
            case "edit":
                int id = Integer.parseInt(req.getParameter("id"));
                RepairSchedule item = service.getById(id);
                req.setAttribute("item", item);
                req.getRequestDispatcher("/admin/admin-repair-edit.jsp").forward(req, resp);
                break;
            case "delete":
                service.remove(Integer.parseInt(req.getParameter("id")));
                resp.sendRedirect("AdminRepairScheduleServlet");
                break;
            default:
                req.setAttribute("list", service.getAll());
                req.getRequestDispatcher("/admin/admin-repair-list.jsp").forward(req, resp);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");

        if ("create".equals(action)) {
            RepairSchedule r = mapRequest(req);
            service.create(r);
            resp.sendRedirect("AdminRepairScheduleServlet");
            return;
        }

        if ("update".equals(action)) {
            RepairSchedule r = mapRequest(req);
            r.setMaSC(Integer.parseInt(req.getParameter("maSC")));
            String ngayHoanTat = req.getParameter("ngayHoanTat");
            if (ngayHoanTat != null && !ngayHoanTat.isEmpty()) {
                try {
                    r.setNgayHoanTat(Timestamp.valueOf(ngayHoanTat));
                } catch (Exception ignored) {}
            }
            service.edit(r);
            resp.sendRedirect("AdminRepairScheduleServlet");
            return;
        }

        resp.sendRedirect("AdminRepairScheduleServlet");
    }

    private RepairSchedule mapRequest(HttpServletRequest req) {
        RepairSchedule r = new RepairSchedule();
        r.setMaND(Integer.parseInt(req.getParameter("maND")));
        r.setTenThietBi(req.getParameter("tenThietBi"));
        r.setMoTaLoi(req.getParameter("moTaLoi"));
        try { r.setChiPhiDuKien(new BigDecimal(req.getParameter("chiPhiDuKien"))); } catch (Exception e) { r.setChiPhiDuKien(null); }
        try { r.setChiPhiThucTe(new BigDecimal(req.getParameter("chiPhiThucTe"))); } catch (Exception e) { r.setChiPhiThucTe(null); }
        r.setTrangThai(req.getParameter("trangThai"));
        return r;
    }
}
