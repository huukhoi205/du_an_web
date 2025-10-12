package model.admin;

import java.math.BigDecimal;

public class OldDevice {
    private int maTMC;
    private int maND;
    private String tenMay;
    private String hangSX;
    private String tinhTrang;
    private BigDecimal giaDeXuat;
    private BigDecimal giaThoaThuan;
    private String trangThai;

    public OldDevice() {}

    public OldDevice(int maTMC, int maND, String tenMay, String hangSX, String tinhTrang,
                     BigDecimal giaDeXuat, BigDecimal giaThoaThuan, String trangThai) {
        this.maTMC = maTMC;
        this.maND = maND;
        this.tenMay = tenMay;
        this.hangSX = hangSX;
        this.tinhTrang = tinhTrang;
        this.giaDeXuat = giaDeXuat;
        this.giaThoaThuan = giaThoaThuan;
        this.trangThai = trangThai;
    }

    public int getMaTMC() { return maTMC; }
    public void setMaTMC(int maTMC) { this.maTMC = maTMC; }

    public int getMaND() { return maND; }
    public void setMaND(int maND) { this.maND = maND; }

    public String getTenMay() { return tenMay; }
    public void setTenMay(String tenMay) { this.tenMay = tenMay; }

    public String getHangSX() { return hangSX; }
    public void setHangSX(String hangSX) { this.hangSX = hangSX; }

    public String getTinhTrang() { return tinhTrang; }
    public void setTinhTrang(String tinhTrang) { this.tinhTrang = tinhTrang; }

    public BigDecimal getGiaDeXuat() { return giaDeXuat; }
    public void setGiaDeXuat(BigDecimal giaDeXuat) { this.giaDeXuat = giaDeXuat; }

    public BigDecimal getGiaThoaThuan() { return giaThoaThuan; }
    public void setGiaThoaThuan(BigDecimal giaThoaThuan) { this.giaThoaThuan = giaThoaThuan; }

    public String getTrangThai() { return trangThai; }
    public void setTrangThai(String trangThai) { this.trangThai = trangThai; }
}
