package service.admin;

import dao.admin.CustomerDAO;
import model.admin.Customer;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.List;
import java.util.Objects;

public class CustomerService {
    private CustomerDAO customerDAO = new CustomerDAO();

    public List<Customer> getAllCustomers() throws Exception {
        return customerDAO.selectAll();
    }

    public Customer getCustomerById(int maND) throws Exception {
        return customerDAO.selectById(maND);
    }

    public boolean addCustomer(Customer customer) throws Exception {
        System.out.println("Validating customer: " + customer.getHoTen() + ", Email: " + customer.getEmail());
        validateCustomer(customer, 0, 0);
        customer.setMatKhau(hashPassword(customer.getMatKhau()));
        System.out.println("Hashing password for: " + customer.getTenDangNhap());
        int maND = customerDAO.insert(customer);
        System.out.println("Customer added with MaND: " + maND);
        return maND > 0;
    }

    public boolean updateCustomer(Customer customer) throws Exception {
        System.out.println("Validating update for MaND: " + customer.getMaND());
        Customer existing = getCustomerById(customer.getMaND());
        validatePartialUpdate(customer, existing);

        // Chỉ hash mật khẩu nếu có thay đổi
        if (customer.getMatKhau() != null && !customer.getMatKhau().isEmpty() && !customer.getMatKhau().equals(existing.getMatKhau())) {
            customer.setMatKhau(hashPassword(customer.getMatKhau()));
            System.out.println("Password updated for: " + customer.getTenDangNhap());
        } else {
            customer.setMatKhau(existing.getMatKhau()); // Giữ nguyên mật khẩu cũ
        }

        boolean result = customerDAO.update(customer);
        System.out.println("Update result for MaND " + customer.getMaND() + ": " + result);
        return result;
    }

    public boolean deleteCustomer(int maND) throws Exception {
        return customerDAO.delete(maND);
    }

    private void validateCustomer(Customer customer, int maND, int maTK) throws Exception {
        if (customer.getEmail() == null || customer.getEmail().isEmpty()) {
            throw new IllegalArgumentException("Email không được để trống");
        }
        if (customer.getTenDangNhap() == null || customer.getTenDangNhap().isEmpty()) {
            throw new IllegalArgumentException("Tên đăng nhập không được để trống");
        }
        if (customer.getMatKhau() == null || customer.getMatKhau().isEmpty()) {
            throw new IllegalArgumentException("Mật khẩu không được để trống");
        }
        if (customerDAO.isEmailExists(customer.getEmail(), maND)) {
            throw new IllegalArgumentException("Email đã tồn tại");
        }
        if (customerDAO.isUsernameExists(customer.getTenDangNhap(), maTK)) {
            throw new IllegalArgumentException("Tên đăng nhập đã tồn tại");
        }
    }

    private void validatePartialUpdate(Customer customer, Customer existing) throws Exception {
        // Chỉ validate các trường được gửi lên
        if (customer.getEmail() != null && !customer.getEmail().isEmpty() && !customer.getEmail().equals(existing.getEmail())) {
            if (customerDAO.isEmailExists(customer.getEmail(), customer.getMaND())) {
                throw new IllegalArgumentException("Email đã tồn tại");
            }
        }
        if (customer.getTenDangNhap() != null && !customer.getTenDangNhap().isEmpty() && !customer.getTenDangNhap().equals(existing.getTenDangNhap())) {
            if (customerDAO.isUsernameExists(customer.getTenDangNhap(), customer.getMaTK())) {
                throw new IllegalArgumentException("Tên đăng nhập đã tồn tại");
            }
        }
    }

    private String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            byte[] hash = md.digest(password.getBytes());
            StringBuilder sb = new StringBuilder();
            for (byte b : hash) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Lỗi hash mật khẩu", e);
        }
    }
}