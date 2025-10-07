
package service.admin;

import dao.admin.BrandDAO;
import model.admin.Brand;

import java.util.List;

public class BrandService {
    private BrandDAO brandDAO = new BrandDAO();

    public List<Brand> getAllBrands() throws Exception {
        return brandDAO.selectAllBrands();
    }
}