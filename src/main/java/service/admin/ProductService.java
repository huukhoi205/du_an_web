package service.admin;

import java.util.List;
import dao.admin.ProductDAO;
import model.admin.Product;

public class ProductService {
    private ProductDAO productDAO = new ProductDAO();

    public List<Product> getAllProducts() {
        return productDAO.selectAllProducts();
    }

    public Product getProductById(int maSP) {
        return productDAO.selectProduct(maSP);
    }

    public boolean addProduct(Product product) {
        return productDAO.insertProduct(product);
    }

    public boolean updateProduct(Product product) {
        return productDAO.updateProduct(product);
    }

    public boolean deleteProduct(int maSP) {
        return productDAO.deleteProduct(maSP);
    }

    public List<Product> searchProducts(String keyword, Integer maHang, String tinhTrang,
                                        int limit, int offset, String sortBy) {
        return productDAO.searchWithPaging(keyword, maHang, tinhTrang, limit, offset, sortBy);
    }
}
