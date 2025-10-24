package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ProductDAO;
import model.Product;

public class IndexServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            ProductDAO productDAO = new ProductDAO();
            
            // Lấy sản phẩm mới cho "Điện thoại mới nổi bật"
            List<Product> newPhones = productDAO.getAllNewProducts();
            if (newPhones.size() > 5) {
                newPhones = newPhones.subList(0, 5);
            }
            
            // Lấy sản phẩm cho "Khuyến mãi hot" (có thể là sản phẩm giảm giá hoặc sản phẩm đặc biệt)
            List<Product> hotDeals = productDAO.getAllNewProducts(); // Tạm thời dùng cùng dữ liệu
            if (hotDeals.size() > 4) {
                hotDeals = hotDeals.subList(0, 4);
            }
            
            // Set attributes
            request.setAttribute("hotDeals", hotDeals);
            request.setAttribute("newPhones", newPhones);
            
        // Forward to index.jsp
        request.getRequestDispatcher("/index.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra khi tải dữ liệu sản phẩm: " + e.getMessage());
            request.getRequestDispatcher("/index.jsp").forward(request, response);
        }
    }
}
