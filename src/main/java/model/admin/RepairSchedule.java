package model.admin;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class RepairSchedule {
    private int maSC;
    private int maND;
    private String tenThietBi;
    private String moTaLoi;
    private BigDecimal chiPhiDuKien;
    private BigDecimal chiPhiThucTe;
    private String trangThai;
    private Timestamp ngayTiepNhan;
    private Timestamp ngayHoanTat;

    public RepairSchedule() {}

    public int getMaSC() { return maSC; }
    public void setMaSC(int maSC) { this.maSC = maSC; }

    public int getMaND() { return maND; }
    public void setMaND(int maND) { this.maND = maND; }

    public String getTenThietBi() { return tenThietBi; }
    public void setTenThietBi(String tenThietBi) { this.tenThietBi = tenThietBi; }

    public String getMoTaLoi() { return moTaLoi; }
    public void setMoTaLoi(String moTaLoi) { this.moTaLoi = moTaLoi; }

    public BigDecimal getChiPhiDuKien() { return chiPhiDuKien; }
    public void setChiPhiDuKien(BigDecimal chiPhiDuKien) { this.chiPhiDuKien = chiPhiDuKien; }

    public BigDecimal getChiPhiThucTe() { return chiPhiThucTe; }
    public void setChiPhiThucTe(BigDecimal chiPhiThucTe) { this.chiPhiThucTe = chiPhiThucTe; }

    public String getTrangThai() { return trangThai; }
    public void setTrangThai(String trangThai) { this.trangThai = trangThai; }

    public Timestamp getNgayTiepNhan() { return ngayTiepNhan; }
    public void setNgayTiepNhan(Timestamp ngayTiepNhan) { this.ngayTiepNhan = ngayTiepNhan; }

    public Timestamp getNgayHoanTat() { return ngayHoanTat; }
    public void setNgayHoanTat(Timestamp ngayHoanTat) { this.ngayHoanTat = ngayHoanTat; }
}
