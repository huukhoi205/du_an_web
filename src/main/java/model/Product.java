package model;

import java.math.BigDecimal;

/**
 * Model đại diện cho sản phẩm điện thoại
 */
public class Product {
    private int maSP;
    private String tenSP;
    private int maHang;
    private String tinhTrang;  // "Moi" hoặc "Cu"
    private BigDecimal gia;
    private int soLuong;
    private String hinhAnh;
    private String moTa;
    
    // Thông tin từ bảng danhmuc (JOIN)
    private String brandName;
    
    // Thông tin từ bảng cauhinhchitiet (JOIN)
    private String ram;
    private String boNhoTrong;
    private String dungLuongPin;
    private String manHinh;
    private String cpu;
    
    // Constructors
    public Product() {
    }
    
    public Product(int maSP, String tenSP, int maHang, String tinhTrang, 
                   BigDecimal gia, int soLuong, String hinhAnh, String moTa) {
        this.maSP = maSP;
        this.tenSP = tenSP;
        this.maHang = maHang;
        this.tinhTrang = tinhTrang;
        this.gia = gia;
        this.soLuong = soLuong;
        this.hinhAnh = hinhAnh;
        this.moTa = moTa;
    }
    
    // Getters and Setters
    public int getMaSP() {
        return maSP;
    }
    
    public void setMaSP(int maSP) {
        this.maSP = maSP;
    }
    
    public String getTenSP() {
        return tenSP;
    }
    
    public void setTenSP(String tenSP) {
        this.tenSP = tenSP;
    }
    
    public int getMaHang() {
        return maHang;
    }
    
    public void setMaHang(int maHang) {
        this.maHang = maHang;
    }
    
    public String getTinhTrang() {
        return tinhTrang;
    }
    
    public void setTinhTrang(String tinhTrang) {
        this.tinhTrang = tinhTrang;
    }
    
    public BigDecimal getGia() {
        return gia;
    }
    
    public void setGia(BigDecimal gia) {
        this.gia = gia;
    }
    
    public int getSoLuong() {
        return soLuong;
    }
    
    public void setSoLuong(int soLuong) {
        this.soLuong = soLuong;
    }
    
    public String getHinhAnh() {
        return hinhAnh;
    }
    
    public void setHinhAnh(String hinhAnh) {
        this.hinhAnh = hinhAnh;
    }
    
    public String getMoTa() {
        return moTa;
    }
    
    public void setMoTa(String moTa) {
        this.moTa = moTa;
    }
    
    public String getBrandName() {
        return brandName;
    }
    
    public void setBrandName(String brandName) {
        this.brandName = brandName;
    }
    
    public String getRam() {
        return ram;
    }
    
    public void setRam(String ram) {
        this.ram = ram;
    }
    
    public String getBoNhoTrong() {
        return boNhoTrong;
    }
    
    public void setBoNhoTrong(String boNhoTrong) {
        this.boNhoTrong = boNhoTrong;
    }
    
    public String getDungLuongPin() {
        return dungLuongPin;
    }
    
    public void setDungLuongPin(String dungLuongPin) {
        this.dungLuongPin = dungLuongPin;
    }
    
    public String getManHinh() {
        return manHinh;
    }
    
    public void setManHinh(String manHinh) {
        this.manHinh = manHinh;
    }
    
    public String getCpu() {
        return cpu;
    }
    
    public void setCpu(String cpu) {
        this.cpu = cpu;
    }
    
    // Helper methods
    public boolean isNew() {
        return "Moi".equalsIgnoreCase(this.tinhTrang);
    }
    
    public boolean isUsed() {
        return "Cu".equalsIgnoreCase(this.tinhTrang);
    }
    
    @Override
    public String toString() {
        return "Product{" +
                "maSP=" + maSP +
                ", tenSP='" + tenSP + '\'' +
                ", brandName='" + brandName + '\'' +
                ", tinhTrang='" + tinhTrang + '\'' +
                ", gia=" + gia +
                ", soLuong=" + soLuong +
                '}';
    }
}