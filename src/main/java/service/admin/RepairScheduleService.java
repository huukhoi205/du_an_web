package service.admin;

import dao.admin.RepairScheduleDAO;
import model.admin.RepairSchedule;
import java.util.List;

public class RepairScheduleService {
    private RepairScheduleDAO dao = new RepairScheduleDAO();

    public List<RepairSchedule> getAll() { 
        return dao.findAll(); 
    }
    
    public RepairSchedule getById(int id) { 
        return dao.findById(id); 
    }
    
    public boolean create(RepairSchedule r) { 
        // Validation
        if (r.getMaND() <= 0) {
            System.err.println("Validation failed: MaND invalid");
            return false;
        }
        if (r.getTenThietBi() == null || r.getTenThietBi().trim().isEmpty()) {
            System.err.println("Validation failed: TenThietBi empty");
            return false;
        }
        
        // Set default trạng thái nếu null hoặc rỗng
        if (r.getTrangThai() == null || r.getTrangThai().trim().isEmpty()) {
            r.setTrangThai("TiepNhan");
        }
        
        return dao.insert(r); 
    }
    
    public boolean edit(RepairSchedule r) { 
        // Validation
        if (r.getMaSC() <= 0) {
            System.err.println("Validation failed: MaSC invalid");
            return false;
        }
        if (r.getTenThietBi() == null || r.getTenThietBi().trim().isEmpty()) {
            System.err.println("Validation failed: TenThietBi empty");
            return false;
        }
        
        return dao.update(r); 
    }
    
    public boolean remove(int id) { 
        return dao.delete(id); 
    }
}