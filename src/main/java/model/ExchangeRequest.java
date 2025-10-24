package model;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class ExchangeRequest {
    private int maTMC;              // Mã thu mua cũ
    private int maND;               // Mã người dùng
    private String tenMay;          // Tên máy
    private String hangSX;          // Hãng sản xuất
    private String tinhTrang;       // Tình trạng thiết bị
    private BigDecimal giaDeXuat;   // Giá đề xuất
    private BigDecimal giaThoaThuan; // Giá thỏa thuận
    private String trangThai;       // Trạng thái
    private String moTaChiTiet;     // Mô tả chi tiết (thêm vào)
    private String sanPhamLienQuan; // Sản phẩm liên quan (thêm vào)
    private String diaChi;          // Địa chỉ/khu vực
    private String hinhAnh;         // Đường dẫn ảnh thiết bị
    private Timestamp ngayTao;      // Ngày tạo
    private Timestamp ngayCapNhat;  // Ngày cập nhật
    
    // Constructors
    public ExchangeRequest() {}
    
    public ExchangeRequest(int maND, String tenMay, String hangSX, String tinhTrang, 
                          BigDecimal giaDeXuat, String moTaChiTiet, String sanPhamLienQuan) {
        this.maND = maND;
        this.tenMay = tenMay;
        this.hangSX = hangSX;
        this.tinhTrang = tinhTrang;
        this.giaDeXuat = giaDeXuat;
        this.moTaChiTiet = moTaChiTiet;
        this.sanPhamLienQuan = sanPhamLienQuan;
        this.trangThai = "ChoDuyet";
    }
    
    // Getters and Setters
    public int getMaTMC() {
        return maTMC;
    }
    
    public void setMaTMC(int maTMC) {
        this.maTMC = maTMC;
    }
    
    public int getMaND() {
        return maND;
    }
    
    public void setMaND(int maND) {
        this.maND = maND;
    }
    
    public String getTenMay() {
        return tenMay;
    }
    
    public void setTenMay(String tenMay) {
        this.tenMay = tenMay;
    }
    
    public String getHangSX() {
        return hangSX;
    }
    
    public void setHangSX(String hangSX) {
        this.hangSX = hangSX;
    }
    
    public String getTinhTrang() {
        return tinhTrang;
    }
    
    public void setTinhTrang(String tinhTrang) {
        this.tinhTrang = tinhTrang;
    }
    
    public BigDecimal getGiaDeXuat() {
        return giaDeXuat;
    }
    
    public void setGiaDeXuat(BigDecimal giaDeXuat) {
        this.giaDeXuat = giaDeXuat;
    }
    
    public BigDecimal getGiaThoaThuan() {
        return giaThoaThuan;
    }
    
    public void setGiaThoaThuan(BigDecimal giaThoaThuan) {
        this.giaThoaThuan = giaThoaThuan;
    }
    
    public String getTrangThai() {
        return trangThai;
    }
    
    public void setTrangThai(String trangThai) {
        this.trangThai = trangThai;
    }
    
    public Timestamp getNgayTao() {
        return ngayTao;
    }
    
    public void setNgayTao(Timestamp ngayTao) {
        this.ngayTao = ngayTao;
    }
    
    public String getMoTaChiTiet() {
        return moTaChiTiet;
    }
    
    public void setMoTaChiTiet(String moTaChiTiet) {
        this.moTaChiTiet = moTaChiTiet;
    }
    
    public String getSanPhamLienQuan() {
        return sanPhamLienQuan;
    }
    
    public void setSanPhamLienQuan(String sanPhamLienQuan) {
        this.sanPhamLienQuan = sanPhamLienQuan;
    }
    
    public String getDiaChi() {
        return diaChi;
    }
    
    public void setDiaChi(String diaChi) {
        this.diaChi = diaChi;
    }
    
    public String getHinhAnh() {
        return hinhAnh;
    }
    
    public void setHinhAnh(String hinhAnh) {
        this.hinhAnh = hinhAnh;
    }
    
    public Timestamp getNgayCapNhat() {
        return ngayCapNhat;
    }
    
    public void setNgayCapNhat(Timestamp ngayCapNhat) {
        this.ngayCapNhat = ngayCapNhat;
    }
    
    @Override
    public String toString() {
        return "ExchangeRequest{" +
                "maTMC=" + maTMC +
                ", maND=" + maND +
                ", tenMay='" + tenMay + '\'' +
                ", hangSX='" + hangSX + '\'' +
                ", tinhTrang='" + tinhTrang + '\'' +
                ", giaDeXuat=" + giaDeXuat +
                ", giaThoaThuan=" + giaThoaThuan +
                ", trangThai='" + trangThai + '\'' +
                ", ngayTao=" + ngayTao +
                ", moTaChiTiet='" + moTaChiTiet + '\'' +
                ", sanPhamLienQuan='" + sanPhamLienQuan + '\'' +
                ", diaChi='" + diaChi + '\'' +
                ", hinhAnh='" + hinhAnh + '\'' +
                ", ngayCapNhat=" + ngayCapNhat +
                '}';
    }
}
