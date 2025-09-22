package controller.admin;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
            case "/delete":
                deleteCustomer(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getPathInfo();
        if (action == null) action = "/list";

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
    }

    private void addCustomer(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String hoTen = request.getParameter("hoTen");
        String email = request.getParameter("email");
        String matKhau = request.getParameter("matKhau");
        String vaiTro = request.getParameter("vaiTro");
        customerService.addCustomer(new Customer(0, hoTen, email, matKhau, vaiTro));
        response.sendRedirect(request.getContextPath() + "/admin/customer/list");
    }

    private void updateCustomer(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int maND = Integer.parseInt(request.getParameter("maND"));
        String hoTen = request.getParameter("hoTen");
        String email = request.getParameter("email");
        String matKhau = request.getParameter("matKhau");
        String vaiTro = request.getParameter("vaiTro");
        customerService.updateCustomer(new Customer(maND, hoTen, email, matKhau, vaiTro));
        response.sendRedirect(request.getContextPath() + "/admin/customer/list");
    }

    private void deleteCustomer(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int maND = Integer.parseInt(request.getParameter("maND"));
        customerService.deleteCustomer(maND);
        response.sendRedirect(request.getContextPath() + "/admin/customer/list");
    }
}
