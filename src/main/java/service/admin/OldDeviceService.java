package service.admin;

import dao.admin.OldDeviceDAO;
import model.admin.OldDevice;

import java.util.List;

public class OldDeviceService {
    private OldDeviceDAO dao = new OldDeviceDAO();

    public List<OldDevice> getAll() { return dao.findAll(); }
    public OldDevice getById(int id) { return dao.findById(id); }
    public boolean create(OldDevice o) { return dao.insert(o); }
    public boolean edit(OldDevice o) { return dao.update(o); }
    public boolean remove(int id) { return dao.delete(id); }
}
