package model.admin;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class Order {
    private int maDH;
    private int maND;
    private String tenNguoiNhan;
    private String soDienThoai;
    private String diaChiGiao;
    private String phuongThucThanhToan;
    private String trangThai;
    private BigDecimal tongTien;
    private Timestamp ngayDat;

    // Fields mới cho info khách hàng
    private String tenKhachHang;
    private String dienThoai;
    private String diaChi;

    public Order() {}

    public Order(int maDH, int maND, String trangThai, BigDecimal tongTien, Timestamp ngayDat) {
        this.maDH = maDH;
        this.maND = maND;
        this.trangThai = trangThai;
        this.tongTien = tongTien;
        this.ngayDat = ngayDat;
    }

    // Getters/Setters hiện có
    public int getMaDH() { return maDH; }
    public void setMaDH(int maDH) { this.maDH = maDH; }
    public int getMaND() { return maND; }
    public void setMaND(int maND) { this.maND = maND; }
    public String getTrangThai() { return trangThai; }
    public void setTrangThai(String trangThai) { this.trangThai = trangThai; }
    public BigDecimal getTongTien() { return tongTien; }
    public void setTongTien(BigDecimal tongTien) { this.tongTien = tongTien; }
<<<<<<< HEAD

    public String getTenNguoiNhan() { return tenNguoiNhan; }
    public void setTenNguoiNhan(String tenNguoiNhan) { this.tenNguoiNhan = tenNguoiNhan; }

    public String getSoDienThoai() { return soDienThoai; }
    public void setSoDienThoai(String soDienThoai) { this.soDienThoai = soDienThoai; }

    public String getDiaChiGiao() { return diaChiGiao; }
    public void setDiaChiGiao(String diaChiGiao) { this.diaChiGiao = diaChiGiao; }

    public String getPhuongThucThanhToan() { return phuongThucThanhToan; }
    public void setPhuongThucThanhToan(String phuongThucThanhToan) { this.phuongThucThanhToan = phuongThucThanhToan; }

=======
>>>>>>> branch 'master' of https://github.com/huukhoi205/du_an_web.git
    public Timestamp getNgayDat() { return ngayDat; }
    public void setNgayDat(Timestamp ngayDat) { this.ngayDat = ngayDat; }

    // Getters/Setters mới
    public String getTenKhachHang() { return tenKhachHang; }
    public void setTenKhachHang(String tenKhachHang) { this.tenKhachHang = tenKhachHang; }
    public String getDienThoai() { return dienThoai; }
    public void setDienThoai(String dienThoai) { this.dienThoai = dienThoai; }
    public String getDiaChi() { return diaChi; }
    public void setDiaChi(String diaChi) { this.diaChi = diaChi; }

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