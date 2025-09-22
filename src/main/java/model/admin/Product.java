package model.admin;

import java.math.BigDecimal;

public class Product {
    private int maSP;
    private String tenSP;
    private int maHang;
    private String tinhTrang;
    private BigDecimal gia;
    private int soLuong;
    private String hinhAnh;
    private String moTa;

    // Cấu hình chi tiết
    private int maCHCT;
    private String manHinh;
    private String cpu;
    private String gpu;
    private String ram;
    private String boNhoTrong;
    private String heDieuHanh;
    private String cameraTruoc;
    private String cameraSau;
    private String quayVideo;
    private String dungLuongPin;
    private String sacNhanh;
    private String sacKhongDay;
    private String sim;
    private String wifi;
    private String bluetooth;
    private String gps;
    private String chatLieu;
    private String kichThuoc;
    private String trongLuong;
    private String mauSac;

    public Product() {}

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

    // Getters & Setters
    public int getMaSP() { return maSP; }
    public void setMaSP(int maSP) { this.maSP = maSP; }

    public String getTenSP() { return tenSP; }
    public void setTenSP(String tenSP) { this.tenSP = tenSP; }

    public int getMaHang() { return maHang; }
    public void setMaHang(int maHang) { this.maHang = maHang; }

    public String getTinhTrang() { return tinhTrang; }
    public void setTinhTrang(String tinhTrang) { this.tinhTrang = tinhTrang; }

    public BigDecimal getGia() { return gia; }
    public void setGia(BigDecimal gia) { this.gia = gia; }

    public int getSoLuong() { return soLuong; }
    public void setSoLuong(int soLuong) { this.soLuong = soLuong; }

    public String getHinhAnh() { return hinhAnh; }
    public void setHinhAnh(String hinhAnh) { this.hinhAnh = hinhAnh; }

    public String getMoTa() { return moTa; }
    public void setMoTa(String moTa) { this.moTa = moTa; }

    public int getMaCHCT() { return maCHCT; }
    public void setMaCHCT(int maCHCT) { this.maCHCT = maCHCT; }

    public String getManHinh() { return manHinh; }
    public void setManHinh(String manHinh) { this.manHinh = manHinh; }

    public String getCpu() { return cpu; }
    public void setCpu(String cpu) { this.cpu = cpu; }

    public String getGpu() { return gpu; }
    public void setGpu(String gpu) { this.gpu = gpu; }

    public String getRam() { return ram; }
    public void setRam(String ram) { this.ram = ram; }

    public String getBoNhoTrong() { return boNhoTrong; }
    public void setBoNhoTrong(String boNhoTrong) { this.boNhoTrong = boNhoTrong; }

    public String getHeDieuHanh() { return heDieuHanh; }
    public void setHeDieuHanh(String heDieuHanh) { this.heDieuHanh = heDieuHanh; }

    public String getCameraTruoc() { return cameraTruoc; }
    public void setCameraTruoc(String cameraTruoc) { this.cameraTruoc = cameraTruoc; }

    public String getCameraSau() { return cameraSau; }
    public void setCameraSau(String cameraSau) { this.cameraSau = cameraSau; }

    public String getQuayVideo() { return quayVideo; }
    public void setQuayVideo(String quayVideo) { this.quayVideo = quayVideo; }

    public String getDungLuongPin() { return dungLuongPin; }
    public void setDungLuongPin(String dungLuongPin) { this.dungLuongPin = dungLuongPin; }

    public String getSacNhanh() { return sacNhanh; }
    public void setSacNhanh(String sacNhanh) { this.sacNhanh = sacNhanh; }

    public String getSacKhongDay() { return sacKhongDay; }
    public void setSacKhongDay(String sacKhongDay) { this.sacKhongDay = sacKhongDay; }

    public String getSim() { return sim; }
    public void setSim(String sim) { this.sim = sim; }

    public String getWifi() { return wifi; }
    public void setWifi(String wifi) { this.wifi = wifi; }

    public String getBluetooth() { return bluetooth; }
    public void setBluetooth(String bluetooth) { this.bluetooth = bluetooth; }

    public String getGps() { return gps; }
    public void setGps(String gps) { this.gps = gps; }

    public String getChatLieu() { return chatLieu; }
    public void setChatLieu(String chatLieu) { this.chatLieu = chatLieu; }

    public String getKichThuoc() { return kichThuoc; }
    public void setKichThuoc(String kichThuoc) { this.kichThuoc = kichThuoc; }

    public String getTrongLuong() { return trongLuong; }
    public void setTrongLuong(String trongLuong) { this.trongLuong = trongLuong; }

    public String getMauSac() { return mauSac; }
    public void setMauSac(String mauSac) { this.mauSac = mauSac; }

    // Helpers
    public String getFormattedPrice() {
        return gia != null ? String.format("%,.0f", gia) + "₫" : "0₫";
    }

    public String getConditionText() {
        return "Cu".equals(tinhTrang) ? " (Cũ)" : "";
    }

    public boolean isUsed() {
        return "Cu".equals(tinhTrang);
    }

    public boolean isNew() {
        return "Moi".equals(tinhTrang);
    }

    public String getBrandName() {
        switch (maHang) {
            case 1: return "Samsung";
            case 2: return "Apple";
            case 3: return "Xiaomi";
            case 4: return "OPPO";
            case 5: return "Vivo";
            case 6: return "Google";
            case 7: return "Huawei";
            case 8: return "Realme";
            case 9: return "OnePlus";
            case 10: return "Sony";
            default: return "Unknown";
        }
    }

    @Override
    public String toString() {
        return "Product{" +
                "maSP=" + maSP +
                ", tenSP='" + tenSP + '\'' +
                ", maHang=" + maHang +
                ", tinhTrang='" + tinhTrang + '\'' +
                ", gia=" + gia +
                ", soLuong=" + soLuong +
                '}';
    }
}
