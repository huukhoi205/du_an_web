package service.admin;

import dao.admin.UserDAO;
import dao.admin.UserDAO.User;
import java.util.List;

public class UserService {
    private UserDAO dao = new UserDAO();

    public List<User> getAll() {
        return dao.findAll();
    }

    public User getById(int id) {
        return dao.findById(id);
    }

    public boolean userExists(int maND) {
        return dao.userExists(maND);
    }
}