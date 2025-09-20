package model;

import java.time.LocalDateTime;

public class User {
    private int maND;
    private String hoTen;
    private String email;
    private String soDT;
    private String diaChi;
    private String vaiTro;
    private boolean trangThai;
    private LocalDateTime ngayTao;
    private LocalDateTime ngayCapNhat;
    
    // Default constructor
    public User() {}
    
    // Constructor with essential fields
    public User(String hoTen, String email, String soDT, String diaChi) {
        this.hoTen = hoTen;
        this.email = email;
        this.soDT = soDT;
        this.diaChi = diaChi;
        this.vaiTro = "KhachHang";
        this.trangThai = true;
    }
    
    // Getters and Setters
    public int getMaND() {
        return maND;
    }
    
    public void setMaND(int maND) {
        this.maND = maND;
    }
    
    public String getHoTen() {
        return hoTen;
    }
    
    public void setHoTen(String hoTen) {
        this.hoTen = hoTen;
    }
    
    public String getEmail() {
        return email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    
    public String getSoDT() {
        return soDT;
    }
    
    public void setSoDT(String soDT) {
        this.soDT = soDT;
    }
    
    public String getDiaChi() {
        return diaChi;
    }
    
    public void setDiaChi(String diaChi) {
        this.diaChi = diaChi;
    }
    
    public String getVaiTro() {
        return vaiTro;
    }
    
    public void setVaiTro(String vaiTro) {
        this.vaiTro = vaiTro;
    }
    
    public boolean isTrangThai() {
        return trangThai;
    }
    
    public void setTrangThai(boolean trangThai) {
        this.trangThai = trangThai;
    }
    
    public LocalDateTime getNgayTao() {
        return ngayTao;
    }
    
    public void setNgayTao(LocalDateTime ngayTao) {
        this.ngayTao = ngayTao;
    }
    
    public LocalDateTime getNgayCapNhat() {
        return ngayCapNhat;
    }
    
    public void setNgayCapNhat(LocalDateTime ngayCapNhat) {
        this.ngayCapNhat = ngayCapNhat;
    }
    
    // Utility methods
    public boolean isAdmin() {
        return "Admin".equals(this.vaiTro);
    }
    
    public boolean isCustomer() {
        return "KhachHang".equals(this.vaiTro);
    }
    
    public String getDisplayRole() {
        switch (this.vaiTro) {
            case "Admin":
                return "Quản trị viên";
            case "KhachHang":
                return "Khách hàng";
            default:
                return this.vaiTro;
        }
    }
    
    @Override
    public String toString() {
        return "User{" +
                "maND=" + maND +
                ", hoTen='" + hoTen + '\'' +
                ", email='" + email + '\'' +
                ", vaiTro='" + vaiTro + '\'' +
                ", trangThai=" + trangThai +
                '}';
    }
}