package controller.admin;

import java.io.IOException;
import java.math.BigDecimal;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.admin.Product;
import service.admin.ProductService;

@WebServlet(name = "AdminProductServlet", urlPatterns = "/admin/product/*")
public class AdminProductServlet extends HttpServlet {
    private ProductService productService = new ProductService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getPathInfo();
        if (action == null) action = "/list";

        switch (action) {
            case "/list":
                listProducts(request, response);
                break;
            case "/add":
                showAddForm(request, response);
                break;
            case "/edit":
                showEditForm(request, response);
                break;
            case "/delete":
                deleteProduct(request, response);
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
                addProduct(request, response);
                break;
            case "/edit":
                updateProduct(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    private void listProducts(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("productList", productService.getAllProducts());
        request.getRequestDispatcher("/admin/admin-product-list.jsp").forward(request, response);
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/admin/admin-product-add.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int maSP = Integer.parseInt(request.getParameter("maSP"));
        Product product = productService.getProductById(maSP);
        request.setAttribute("product", product);
        request.getRequestDispatcher("/admin/admin-product-edit.jsp").forward(request, response);
    }

    private void addProduct(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String tenSP = request.getParameter("tenSP");
        int maHang = Integer.parseInt(request.getParameter("maHang"));
        String tinhTrang = request.getParameter("tinhTrang");
        BigDecimal gia = new BigDecimal(request.getParameter("gia"));
        int soLuong = Integer.parseInt(request.getParameter("soLuong"));
        String hinhAnh = request.getParameter("hinhAnh");
        String moTa = request.getParameter("moTa");

        Product product = new Product(0, tenSP, maHang, tinhTrang, gia, soLuong, hinhAnh, moTa);
        productService.addProduct(product);
        response.sendRedirect(request.getContextPath() + "/admin/product/list");
    }

    private void updateProduct(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int maSP = Integer.parseInt(request.getParameter("maSP"));
        String tenSP = request.getParameter("tenSP");
        int maHang = Integer.parseInt(request.getParameter("maHang"));
        String tinhTrang = request.getParameter("tinhTrang");
        BigDecimal gia = new BigDecimal(request.getParameter("gia"));
        int soLuong = Integer.parseInt(request.getParameter("soLuong"));
        String hinhAnh = request.getParameter("hinhAnh");
        String moTa = request.getParameter("moTa");

        Product product = new Product(maSP, tenSP, maHang, tinhTrang, gia, soLuong, hinhAnh, moTa);
        productService.updateProduct(product);
        response.sendRedirect(request.getContextPath() + "/admin/product/list");
    }

    private void deleteProduct(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int maSP = Integer.parseInt(request.getParameter("maSP"));
        productService.deleteProduct(maSP);
        response.sendRedirect(request.getContextPath() + "/admin/product/list");
    }
}
