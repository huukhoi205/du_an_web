package service.admin;

import dao.admin.RepairScheduleDAO;
import model.admin.RepairSchedule;
import java.util.List;

public class RepairScheduleService {
    private RepairScheduleDAO dao = new RepairScheduleDAO();

    public List<RepairSchedule> getAll() { return dao.findAll(); }
    public RepairSchedule getById(int id) { return dao.findById(id); }
    public boolean create(RepairSchedule r) { return dao.insert(r); }
    public boolean edit(RepairSchedule r) { return dao.update(r); }
    public boolean remove(int id) { return dao.delete(id); }
}
