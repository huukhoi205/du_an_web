package service.admin;

import java.util.List;
import dao.admin.CategoryDAO;
import model.admin.Category;

public class CategoryService {
    private CategoryDAO categoryDAO = new CategoryDAO();

    public List<Category> getAllCategories() {
        return categoryDAO.selectAll();
    }

    public Category getCategoryById(int maDM) {
        return categoryDAO.selectById(maDM);
    }

    public boolean addCategory(Category category) {
        return categoryDAO.insert(category);
    }

    public boolean updateCategory(Category category) {
        return categoryDAO.update(category);
    }

    public boolean deleteCategory(int maDM) {
        return categoryDAO.delete(maDM);
    }
}
