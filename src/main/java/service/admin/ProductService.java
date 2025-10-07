package service.admin;

import dao.admin.ProductDAO;
import model.admin.Product;

import java.math.BigDecimal;
import java.util.List;

public class ProductService {
    private ProductDAO productDAO = new ProductDAO();

    public List<Product> getAllProducts() throws Exception {
        return productDAO.selectAllProducts();
    }

    public Product getProductById(int maSP) throws Exception {
        Product product = productDAO.selectProduct(maSP);
        if (product == null) {
            throw new IllegalArgumentException("Sản phẩm không tồn tại");
        }
        return product;
    }

    public boolean addProduct(Product product) throws Exception {
        validateProduct(product);
        return productDAO.insertProduct(product);
    }

    public boolean updateProduct(Product product) throws Exception {
        validatePartialProduct(product);
        return productDAO.updateProduct(product);
    }

    public boolean deleteProduct(int maSP) throws Exception {
        Product product = productDAO.selectProduct(maSP);
        if (product == null) {
            throw new IllegalArgumentException("Sản phẩm không tồn tại");
        }
        return productDAO.deleteProduct(maSP);
    }

    public List<Product> searchProducts(String keyword, Integer maHang, String tinhTrang,
                                       int limit, int offset, String sortBy) throws Exception {
        return productDAO.searchWithPaging(keyword, maHang, tinhTrang, limit, offset, sortBy);
    }

    private void validateProduct(Product product) throws Exception {
        if (product.getTenSP() == null || product.getTenSP().trim().isEmpty()) {
            throw new IllegalArgumentException("Tên sản phẩm không được để trống");
        }
        if (product.getMaHang() <= 0 || !productDAO.isBrandExists(product.getMaHang())) {
            throw new IllegalArgumentException("Hãng sản xuất không hợp lệ hoặc không tồn tại");
        }
        if (product.getTinhTrang() == null || 
            !(product.getTinhTrang().equals("Moi") || product.getTinhTrang().equals("Cu"))) {
            throw new IllegalArgumentException("Tình trạng phải là 'Moi' hoặc 'Cu'");
        }
        if (product.getGia() == null || product.getGia().compareTo(BigDecimal.ZERO) <= 0) {
            throw new IllegalArgumentException("Giá sản phẩm phải lớn hơn 0");
        }
        if (product.getSoLuong() < 0) {
            throw new IllegalArgumentException("Số lượng không được âm");
        }
    }

    private void validatePartialProduct(Product product) throws Exception {
        if (product.getTenSP() != null && product.getTenSP().trim().isEmpty()) {
            throw new IllegalArgumentException("Tên sản phẩm không được để trống");
        }
        if (product.getMaHang() > 0 && !productDAO.isBrandExists(product.getMaHang())) {
            throw new IllegalArgumentException("Hãng sản xuất không tồn tại");
        }
        if (product.getTinhTrang() != null && 
            !(product.getTinhTrang().equals("Moi") || product.getTinhTrang().equals("Cu"))) {
            throw new IllegalArgumentException("Tình trạng phải là 'Moi' hoặc 'Cu'");
        }
        if (product.getGia() != null && product.getGia().compareTo(BigDecimal.ZERO) <= 0) {
            throw new IllegalArgumentException("Giá sản phẩm phải lớn hơn 0");
        }
        if (product.getSoLuong() < 0) {
            throw new IllegalArgumentException("Số lượng không được âm");
        }
    }
}