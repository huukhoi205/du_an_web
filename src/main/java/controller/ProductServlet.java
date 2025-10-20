package controller;

import dao.ProductDAO;
import model.Product;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/products")
public class ProductServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        ProductDAO productDAO = new ProductDAO();
        
        // Lấy tham số bộ lọc
        String brand = request.getParameter("brand");
        String minPriceStr = request.getParameter("minPrice");
        String maxPriceStr = request.getParameter("maxPrice");
        String storage = request.getParameter("storage");
        
        double minPrice = 0;
        double maxPrice = 0;
        
        try {
            if (minPriceStr != null && !minPriceStr.isEmpty()) {
                minPrice = Double.parseDouble(minPriceStr);
            }
            if (maxPriceStr != null && !maxPriceStr.isEmpty()) {
                maxPrice = Double.parseDouble(maxPriceStr);
            }
        } catch (NumberFormatException e) {
            // Giữ giá trị mặc định
        }
        
        List<Product> products;
        
        // Nếu có bộ lọc, sử dụng filter, ngược lại lấy tất cả
        if ((brand != null && !brand.isEmpty()) || minPrice > 0 || maxPrice > 0) {
            products = productDAO.getProductsByFilter(brand, minPrice, maxPrice, storage);
        } else {
            products = productDAO.getAllNewProducts();
        }
        
        // Lấy danh sách hãng để hiển thị trong bộ lọc
        List<String> brands = productDAO.getAllBrands();
        
        // Set attributes
        request.setAttribute("products", products);
        request.setAttribute("brands", brands);
        request.setAttribute("selectedBrand", brand);
        request.setAttribute("minPrice", minPrice);
        request.setAttribute("maxPrice", maxPrice);
        request.setAttribute("selectedStorage", storage);
        
        // Forward to JSP
        request.getRequestDispatcher("/views/new-phones.jsp").forward(request, response);
    }
}
