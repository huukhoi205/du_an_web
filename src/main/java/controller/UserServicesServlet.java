package controller;

import dao.ExchangeDAO;
import dao.RepairDAO;
import model.ExchangeRequest;
import model.RepairRequest;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/user-services")
public class UserServicesServlet extends HttpServlet {
    
    private ExchangeDAO exchangeDAO = new ExchangeDAO();
    private RepairDAO repairDAO = new RepairDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        String userName = (String) session.getAttribute("userName");
        String userRole = (String) session.getAttribute("userRole");
        
        System.out.println("UserServicesServlet.doGet - Session info:");
        System.out.println("  - userId: " + userId);
        System.out.println("  - userName: " + userName);
        System.out.println("  - userRole: " + userRole);
        
        if (userId == null) {
            // Redirect to login if not logged in
            response.sendRedirect(request.getContextPath() + "/views/login.jsp");
            return;
        }
        
        // Lấy lịch sử thu mua
        List<ExchangeRequest> exchangeHistory = exchangeDAO.getExchangeHistory(userId);
        System.out.println("UserServicesServlet.doGet - Loaded " + exchangeHistory.size() + " exchange records");
        
        // Lấy lịch sử sửa chữa
        List<RepairRequest> repairHistory = repairDAO.getRepairHistory(userId);
        System.out.println("UserServicesServlet.doGet - Loaded " + repairHistory.size() + " repair records");
        
        // Set attributes for JSP
        request.setAttribute("userName", userName);
        request.setAttribute("userRole", userRole);
        request.setAttribute("exchangeHistory", exchangeHistory);
        request.setAttribute("repairHistory", repairHistory);
        
        // Forward to user-services.jsp
        request.getRequestDispatcher("/views/user-services.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}
