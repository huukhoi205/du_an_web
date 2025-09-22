package controller.admin;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.admin.Category;
import service.admin.CategoryService;

@WebServlet(name = "AdminCategoryServlet", urlPatterns = "/admin/category/*")
public class AdminCategoryServlet extends HttpServlet {
    private CategoryService categoryService = new CategoryService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getPathInfo();
        if (action == null) action = "/list";

        switch (action) {
            case "/list":
                request.setAttribute("categories", categoryService.getAllCategories());
                request.getRequestDispatcher("/admin/admin-category-list.jsp").forward(request, response);
                break;
            case "/add":
                request.getRequestDispatcher("/admin/admin-category-add.jsp").forward(request, response);
                break;
            case "/edit":
                int maDM = Integer.parseInt(request.getParameter("maDM"));
                request.setAttribute("category", categoryService.getCategoryById(maDM));
                request.getRequestDispatcher("/admin/admin-category-edit.jsp").forward(request, response);
                break;
            case "/delete":
                deleteCategory(request, response);
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
                addCategory(request, response);
                break;
            case "/edit":
                updateCategory(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    private void addCategory(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String tenDM = request.getParameter("tenDM");
        categoryService.addCategory(new Category(0, tenDM));
        response.sendRedirect(request.getContextPath() + "/admin/category/list");
    }

    private void updateCategory(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int maDM = Integer.parseInt(request.getParameter("maDM"));
        String tenDM = request.getParameter("tenDM");
        categoryService.updateCategory(new Category(maDM, tenDM));
        response.sendRedirect(request.getContextPath() + "/admin/category/list");
    }

    private void deleteCategory(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int maDM = Integer.parseInt(request.getParameter("maDM"));
        categoryService.deleteCategory(maDM);
        response.sendRedirect(request.getContextPath() + "/admin/category/list");
    }
}
