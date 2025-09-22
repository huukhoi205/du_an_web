package model.admin;

public class Customer {
    private int maND;
    private String hoTen;
    private String email;
    private String matKhau;
    private String vaiTro;

    public Customer() {}

    public Customer(int maND, String hoTen, String email, String matKhau, String vaiTro) {
        this.maND = maND;
        this.hoTen = hoTen;
        this.email = email;
        this.matKhau = matKhau;
        this.vaiTro = vaiTro;
    }

    public int getMaND() { return maND; }
    public void setMaND(int maND) { this.maND = maND; }

    public String getHoTen() { return hoTen; }
    public void setHoTen(String hoTen) { this.hoTen = hoTen; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getMatKhau() { return matKhau; }
    public void setMatKhau(String matKhau) { this.matKhau = matKhau; }

    public String getVaiTro() { return vaiTro; }
    public void setVaiTro(String vaiTro) { this.vaiTro = vaiTro; }

    @Override
    public String toString() {
        return "Customer{" +
                "maND=" + maND +
                ", hoTen='" + hoTen + '\'' +
                ", email='" + email + '\'' +
                ", vaiTro='" + vaiTro + '\'' +
                '}';
    }
}
