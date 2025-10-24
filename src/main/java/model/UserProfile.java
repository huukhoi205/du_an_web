package model;

import java.sql.Timestamp;

public class UserProfile {
    private int maND;
    private String hoTen;
    private String email;
    private String soDT;
    private String diaChi;
    private Timestamp ngayTao;
    private String ngaySinh;
    private String gioiTinh;
    private String vaiTro;
    
    public UserProfile() {}
    
    public UserProfile(int maND, String hoTen, String email, String soDT, String diaChi) {
        this.maND = maND;
        this.hoTen = hoTen;
        this.email = email;
        this.soDT = soDT;
        this.diaChi = diaChi;
    }
    
    // Getters and setters
    public int getMaND() { return maND; }
    public void setMaND(int maND) { this.maND = maND; }
    
    public String getHoTen() { return hoTen; }
    public void setHoTen(String hoTen) { this.hoTen = hoTen; }
    
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    
    public String getSoDT() { return soDT; }
    public void setSoDT(String soDT) { this.soDT = soDT; }
    
    public String getDiaChi() { return diaChi; }
    public void setDiaChi(String diaChi) { this.diaChi = diaChi; }
    
    public Timestamp getNgayTao() { return ngayTao; }
    public void setNgayTao(Timestamp ngayTao) { this.ngayTao = ngayTao; }
    
    public String getNgaySinh() { return ngaySinh; }
    public void setNgaySinh(String ngaySinh) { this.ngaySinh = ngaySinh; }
    
    public String getGioiTinh() { return gioiTinh; }
    public void setGioiTinh(String gioiTinh) { this.gioiTinh = gioiTinh; }
    
    public String getVaiTro() { return vaiTro; }
    public void setVaiTro(String vaiTro) { this.vaiTro = vaiTro; }
    
    @Override
    public String toString() {
        return "UserProfile{" +
                "maND=" + maND +
                ", hoTen='" + hoTen + '\'' +
                ", email='" + email + '\'' +
                ", soDT='" + soDT + '\'' +
                ", diaChi='" + diaChi + '\'' +
                ", ngayTao=" + ngayTao +
                '}';
    }
}
