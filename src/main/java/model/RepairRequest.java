package model;

import java.sql.Timestamp;

public class RepairRequest {
    private int maSC;          // ID sửa chữa
    private int maND;          // Mã người dùng
    private String tenThietBi; // Tên thiết bị
    private String moTaLoi;    // Mô tả lỗi
    private double chiPhiDuKien;
    private Double chiPhiThucTe;
    private String trangThai;
    private Timestamp ngayTiepNhan;
    private Timestamp ngayHoanTat;
    
    // Constructors
    public RepairRequest() {}
    
    public RepairRequest(int maND, String tenThietBi, String moTaLoi, double chiPhiDuKien) {
        this.maND = maND;
        this.tenThietBi = tenThietBi;
        this.moTaLoi = moTaLoi;
        this.chiPhiDuKien = chiPhiDuKien;
        this.trangThai = "TiepNhan";
    }
    
    // Getters and Setters
    public int getMaSC() {
        return maSC;
    }
    
    public void setMaSC(int maSC) {
        this.maSC = maSC;
    }
    
    public int getMaND() {
        return maND;
    }
    
    public void setMaND(int maND) {
        this.maND = maND;
    }
    
    public String getTenThietBi() {
        return tenThietBi;
    }
    
    public void setTenThietBi(String tenThietBi) {
        this.tenThietBi = tenThietBi;
    }
    
    public String getMoTaLoi() {
        return moTaLoi;
    }
    
    public void setMoTaLoi(String moTaLoi) {
        this.moTaLoi = moTaLoi;
    }
    
    public double getChiPhiDuKien() {
        return chiPhiDuKien;
    }
    
    public void setChiPhiDuKien(double chiPhiDuKien) {
        this.chiPhiDuKien = chiPhiDuKien;
    }
    
    public Double getChiPhiThucTe() {
        return chiPhiThucTe;
    }
    
    public void setChiPhiThucTe(Double chiPhiThucTe) {
        this.chiPhiThucTe = chiPhiThucTe;
    }
    
    public String getTrangThai() {
        return trangThai;
    }
    
    public void setTrangThai(String trangThai) {
        this.trangThai = trangThai;
    }
    
    public Timestamp getNgayTiepNhan() {
        return ngayTiepNhan;
    }
    
    public void setNgayTiepNhan(Timestamp ngayTiepNhan) {
        this.ngayTiepNhan = ngayTiepNhan;
    }
    
    public Timestamp getNgayHoanTat() {
        return ngayHoanTat;
    }
    
    public void setNgayHoanTat(Timestamp ngayHoanTat) {
        this.ngayHoanTat = ngayHoanTat;
    }
    
    @Override
    public String toString() {
        return "RepairRequest{" +
                "maSC=" + maSC +
                ", maND=" + maND +
                ", tenThietBi='" + tenThietBi + '\'' +
                ", moTaLoi='" + moTaLoi + '\'' +
                ", chiPhiDuKien=" + chiPhiDuKien +
                ", chiPhiThucTe=" + chiPhiThucTe +
                ", trangThai='" + trangThai + '\'' +
                ", ngayTiepNhan=" + ngayTiepNhan +
                ", ngayHoanTat=" + ngayHoanTat +
                '}';
    }
}
