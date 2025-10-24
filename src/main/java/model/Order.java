package model;

import java.math.BigDecimal;
import java.sql.Date;

/**
 * Model đại diện cho đơn hàng
 */
public class Order {
    private int maDH;
    private int maND;
    private Date ngayDat;
    private String trangThai;
    private BigDecimal tongTien;
    private String diaChiGiaoHang;
    private String soDienThoai;
    private String ghiChu;
    private int soLuongSanPham;
    
    // Constructors
    public Order() {}
    
    public Order(int maDH, int maND, Date ngayDat, String trangThai, BigDecimal tongTien, 
                 String diaChiGiaoHang, String soDienThoai, String ghiChu, int soLuongSanPham) {
        this.maDH = maDH;
        this.maND = maND;
        this.ngayDat = ngayDat;
        this.trangThai = trangThai;
        this.tongTien = tongTien;
        this.diaChiGiaoHang = diaChiGiaoHang;
        this.soDienThoai = soDienThoai;
        this.ghiChu = ghiChu;
        this.soLuongSanPham = soLuongSanPham;
    }
    
    // Getters and Setters
    public int getMaDH() {
        return maDH;
    }
    
    public void setMaDH(int maDH) {
        this.maDH = maDH;
    }
    
    public int getMaND() {
        return maND;
    }
    
    public void setMaND(int maND) {
        this.maND = maND;
    }
    
    public Date getNgayDat() {
        return ngayDat;
    }
    
    public void setNgayDat(Date ngayDat) {
        this.ngayDat = ngayDat;
    }
    
    public String getTrangThai() {
        return trangThai;
    }
    
    public void setTrangThai(String trangThai) {
        this.trangThai = trangThai;
    }
    
    public BigDecimal getTongTien() {
        return tongTien;
    }
    
    public void setTongTien(BigDecimal tongTien) {
        this.tongTien = tongTien;
    }
    
    public String getDiaChiGiaoHang() {
        return diaChiGiaoHang;
    }
    
    public void setDiaChiGiaoHang(String diaChiGiaoHang) {
        this.diaChiGiaoHang = diaChiGiaoHang;
    }
    
    public String getSoDienThoai() {
        return soDienThoai;
    }
    
    public void setSoDienThoai(String soDienThoai) {
        this.soDienThoai = soDienThoai;
    }
    
    public String getGhiChu() {
        return ghiChu;
    }
    
    public void setGhiChu(String ghiChu) {
        this.ghiChu = ghiChu;
    }
    
    public int getSoLuongSanPham() {
        return soLuongSanPham;
    }
    
    public void setSoLuongSanPham(int soLuongSanPham) {
        this.soLuongSanPham = soLuongSanPham;
    }
    
    @Override
    public String toString() {
        return "Order{" +
                "maDH=" + maDH +
                ", maND=" + maND +
                ", ngayDat=" + ngayDat +
                ", trangThai='" + trangThai + '\'' +
                ", tongTien=" + tongTien +
                ", diaChiGiaoHang='" + diaChiGiaoHang + '\'' +
                ", soDienThoai='" + soDienThoai + '\'' +
                ", ghiChu='" + ghiChu + '\'' +
                ", soLuongSanPham=" + soLuongSanPham +
                '}';
    }
}