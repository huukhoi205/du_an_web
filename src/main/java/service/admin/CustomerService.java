package service.admin;

import java.util.List;
import dao.admin.CustomerDAO;
import model.admin.Customer;

public class CustomerService {
    private CustomerDAO customerDAO = new CustomerDAO();

    public List<Customer> getAllCustomers() {
        return customerDAO.selectAll();
    }

    public Customer getCustomerById(int maND) {
        return customerDAO.selectById(maND);
    }

    public boolean addCustomer(Customer customer) {
        return customerDAO.insert(customer);
    }

    public boolean updateCustomer(Customer customer) {
        return customerDAO.update(customer);
    }

    public boolean deleteCustomer(int maND) {
        return customerDAO.delete(maND);
    }
}
