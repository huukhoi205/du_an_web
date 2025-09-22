package model.admin;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class Order {
    private int maDH;
    private int maND;
    private String trangThai;
    private BigDecimal tongTien;
    private Timestamp ngayDat;

    public Order() {}

    public Order(int maDH, int maND, String trangThai, BigDecimal tongTien, Timestamp ngayDat) {
        this.maDH = maDH;
        this.maND = maND;
        this.trangThai = trangThai;
        this.tongTien = tongTien;
        this.ngayDat = ngayDat;
    }

    public int getMaDH() { return maDH; }
    public void setMaDH(int maDH) { this.maDH = maDH; }

    public int getMaND() { return maND; }
    public void setMaND(int maND) { this.maND = maND; }

    public String getTrangThai() { return trangThai; }
    public void setTrangThai(String trangThai) { this.trangThai = trangThai; }

    public BigDecimal getTongTien() { return tongTien; }
    public void setTongTien(BigDecimal tongTien) { this.tongTien = tongTien; }

    public Timestamp getNgayDat() { return ngayDat; }
    public void setNgayDat(Timestamp ngayDat) { this.ngayDat = ngayDat; }

    @Override
    public String toString() {
        return "Order{" +
                "maDH=" + maDH +
                ", maND=" + maND +
                ", trangThai='" + trangThai + '\'' +
                ", tongTien=" + tongTien +
                ", ngayDat=" + ngayDat +
                '}';
    }
}
