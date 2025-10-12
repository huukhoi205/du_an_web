package controller.admin;

import model.admin.OldDevice;
import service.admin.OldDeviceService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;

@WebServlet(name = "AdminOldDeviceServlet", urlPatterns = {"/AdminOldDeviceServlet"})
public class AdminOldDeviceServlet extends HttpServlet {
    private OldDeviceService service = new OldDeviceService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "add":
                req.getRequestDispatcher("/admin/admin-olddevice-add.jsp").forward(req, resp);
                break;
            case "edit":
                int id = Integer.parseInt(req.getParameter("id"));
                OldDevice item = service.getById(id);
                req.setAttribute("item", item);
                req.getRequestDispatcher("/admin/admin-olddevice-edit.jsp").forward(req, resp);
                break;
            case "delete":
                service.remove(Integer.parseInt(req.getParameter("id")));
                resp.sendRedirect("AdminOldDeviceServlet");
                break;
            default:
                req.setAttribute("list", service.getAll());
                req.getRequestDispatcher("/admin/admin-olddevice-list.jsp").forward(req, resp);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");

        if ("create".equals(action)) {
            OldDevice o = mapRequestToOldDevice(req);
            service.create(o);
            resp.sendRedirect("AdminOldDeviceServlet");
            return;
        }

        if ("update".equals(action)) {
            OldDevice o = mapRequestToOldDevice(req);
            o.setMaTMC(Integer.parseInt(req.getParameter("maTMC")));
            service.edit(o);
            resp.sendRedirect("AdminOldDeviceServlet");
            return;
        }
        resp.sendRedirect("AdminOldDeviceServlet");
    }

    private OldDevice mapRequestToOldDevice(HttpServletRequest req) {
        OldDevice o = new OldDevice();
        o.setMaND(Integer.parseInt(req.getParameter("maND")));
        o.setTenMay(req.getParameter("tenMay"));
        o.setHangSX(req.getParameter("hangSX"));
        o.setTinhTrang(req.getParameter("tinhTrang"));
        try {
            o.setGiaDeXuat(new BigDecimal(req.getParameter("giaDeXuat")));
        } catch (Exception e) { o.setGiaDeXuat(null); }
        try {
            o.setGiaThoaThuan(new BigDecimal(req.getParameter("giaThoaThuan")));
        } catch (Exception e) { o.setGiaThoaThuan(null); }
        o.setTrangThai(req.getParameter("trangThai"));
        return o;
    }
}
