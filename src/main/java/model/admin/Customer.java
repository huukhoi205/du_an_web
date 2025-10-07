package model.admin;

import java.util.Date;
import java.util.Objects;

public class Customer {
    private int maND;
    private String hoTen;
    private String email;
    private String soDT;
    private String diaChi;
    private Date ngayTao; // Từ nguoidung

    // Thêm từ taikhoan
    private int maTK; // MaTK từ taikhoan (nếu tồn tại)
    private String tenDangNhap;
    private String matKhau;
    private String vaiTro;
    private boolean trangThai;
    private Date ngayTaoTK; // NgayTao từ taikhoan

    public Customer() {}

    public Customer(int maND, String hoTen, String email, String soDT, String diaChi, Date ngayTao,
                    int maTK, String tenDangNhap, String matKhau, String vaiTro, boolean trangThai, Date ngayTaoTK) {
        this.maND = maND;
        this.hoTen = hoTen;
        this.email = email;
        this.soDT = soDT;
        this.diaChi = diaChi;
        this.ngayTao = ngayTao;
        this.maTK = maTK;
        this.tenDangNhap = tenDangNhap;
        this.matKhau = matKhau;
        this.vaiTro = vaiTro;
        this.trangThai = trangThai;
        this.ngayTaoTK = ngayTaoTK;
    }

    // Getters và Setters cho các trường cũ
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

    public Date getNgayTao() { return ngayTao; }
    public void setNgayTao(Date ngayTao) { this.ngayTao = ngayTao; }

    // Getters và Setters cho các trường từ taikhoan
    public int getMaTK() { return maTK; }
    public void setMaTK(int maTK) { this.maTK = maTK; }

    public String getTenDangNhap() { return tenDangNhap; }
    public void setTenDangNhap(String tenDangNhap) { this.tenDangNhap = tenDangNhap; }

    public String getMatKhau() { return matKhau; }
    public void setMatKhau(String matKhau) { this.matKhau = matKhau; }

    public String getVaiTro() { return vaiTro; }
    public void setVaiTro(String vaiTro) { this.vaiTro = vaiTro; }

    public boolean isTrangThai() { return trangThai; }
    public void setTrangThai(boolean trangThai) { this.trangThai = trangThai; }

    public Date getNgayTaoTK() { return ngayTaoTK; }
    public void setNgayTaoTK(Date ngayTaoTK) { this.ngayTaoTK = ngayTaoTK; }

    @Override
    public String toString() {
        return "Customer{" +
                "maND=" + maND +
                ", hoTen='" + hoTen + '\'' +
                ", email='" + email + '\'' +
                ", soDT='" + soDT + '\'' +
                ", diaChi='" + diaChi + '\'' +
                ", ngayTao=" + ngayTao +
                ", maTK=" + maTK +
                ", tenDangNhap='" + tenDangNhap + '\'' +
                ", vaiTro='" + vaiTro + '\'' +
                ", trangThai=" + trangThai +
                ", ngayTaoTK=" + ngayTaoTK +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Customer customer = (Customer) o;
        return maND == customer.maND && Objects.equals(email, customer.email);
    }

    @Override
    public int hashCode() {
        return Objects.hash(maND, email);
    }
}