package model.admin;

import java.math.BigDecimal;
import java.util.Objects;

public class Product {
    private int maSP;
    private String tenSP;
    private int maHang;
    private String tinhTrang;
    private BigDecimal gia;
    private int soLuong;
    private String hinhAnh;
    private String moTa;

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
        setMaSP(maSP);
        setTenSP(tenSP);
        setMaHang(maHang);
        setTinhTrang(tinhTrang);
        setGia(gia);
        setSoLuong(soLuong);
        setHinhAnh(hinhAnh);
        setMoTa(moTa);
    }

    public int getMaSP() { return maSP; }
    public void setMaSP(int maSP) { this.maSP = maSP; }

    public String getTenSP() { return tenSP; }
    public void setTenSP(String tenSP) {
        if (tenSP == null || tenSP.trim().isEmpty()) {
            throw new IllegalArgumentException("Tên sản phẩm không được để trống");
        }
        this.tenSP = tenSP.trim();
    }

    public int getMaHang() { return maHang; }
    public void setMaHang(int maHang) {
        if (maHang <= 0) {
            throw new IllegalArgumentException("Hãng sản xuất không hợp lệ");
        }
        this.maHang = maHang;
    }

    public String getTinhTrang() { return tinhTrang; }
    public void setTinhTrang(String tinhTrang) {
        if (tinhTrang == null || !(tinhTrang.equals("Moi") || tinhTrang.equals("Cu"))) {
            throw new IllegalArgumentException("Tình trạng phải là 'Moi' hoặc 'Cu'");
        }
        this.tinhTrang = tinhTrang;
    }

    public BigDecimal getGia() { return gia; }
    public void setGia(BigDecimal gia) {
        if (gia == null || gia.compareTo(BigDecimal.ZERO) <= 0) {
            throw new IllegalArgumentException("Giá sản phẩm phải lớn hơn 0");
        }
        this.gia = gia;
    }

    public int getSoLuong() { return soLuong; }
    public void setSoLuong(int soLuong) {
        if (soLuong < 0) {
            throw new IllegalArgumentException("Số lượng không được âm");
        }
        this.soLuong = soLuong;
    }

    public String getHinhAnh() { return hinhAnh; }
    public void setHinhAnh(String hinhAnh) { this.hinhAnh = hinhAnh != null ? hinhAnh.trim() : null; }

    public String getMoTa() { return moTa; }
    public void setMoTa(String moTa) { this.moTa = moTa != null ? moTa.trim() : null; }

    public String getManHinh() { return manHinh; }
    public void setManHinh(String manHinh) { this.manHinh = manHinh != null ? manHinh.trim() : null; }

    public String getCpu() { return cpu; }
    public void setCpu(String cpu) { this.cpu = cpu != null ? cpu.trim() : null; }

    public String getGpu() { return gpu; }
    public void setGpu(String gpu) { this.gpu = gpu != null ? gpu.trim() : null; }

    public String getRam() { return ram; }
    public void setRam(String ram) { this.ram = ram != null ? ram.trim() : null; }

    public String getBoNhoTrong() { return boNhoTrong; }
    public void setBoNhoTrong(String boNhoTrong) { this.boNhoTrong = boNhoTrong != null ? boNhoTrong.trim() : null; }

    public String getHeDieuHanh() { return heDieuHanh; }
    public void setHeDieuHanh(String heDieuHanh) { this.heDieuHanh = heDieuHanh != null ? heDieuHanh.trim() : null; }

    public String getCameraTruoc() { return cameraTruoc; }
    public void setCameraTruoc(String cameraTruoc) { this.cameraTruoc = cameraTruoc != null ? cameraTruoc.trim() : null; }

    public String getCameraSau() { return cameraSau; }
    public void setCameraSau(String cameraSau) { this.cameraSau = cameraSau != null ? cameraSau.trim() : null; }

    public String getQuayVideo() { return quayVideo; }
    public void setQuayVideo(String quayVideo) { this.quayVideo = quayVideo != null ? quayVideo.trim() : null; }

    public String getDungLuongPin() { return dungLuongPin; }
    public void setDungLuongPin(String dungLuongPin) { this.dungLuongPin = dungLuongPin != null ? dungLuongPin.trim() : null; }

    public String getSacNhanh() { return sacNhanh; }
    public void setSacNhanh(String sacNhanh) { this.sacNhanh = sacNhanh != null ? sacNhanh.trim() : null; }

    public String getSacKhongDay() { return sacKhongDay; }
    public void setSacKhongDay(String sacKhongDay) { this.sacKhongDay = sacKhongDay != null ? sacKhongDay.trim() : null; }

    public String getSim() { return sim; }
    public void setSim(String sim) { this.sim = sim != null ? sim.trim() : null; }

    public String getWifi() { return wifi; }
    public void setWifi(String wifi) { this.wifi = wifi != null ? wifi.trim() : null; }

    public String getBluetooth() { return bluetooth; }
    public void setBluetooth(String bluetooth) { this.bluetooth = bluetooth != null ? bluetooth.trim() : null; }

    public String getGps() { return gps; }
    public void setGps(String gps) { this.gps = gps != null ? gps.trim() : null; }

    public String getChatLieu() { return chatLieu; }
    public void setChatLieu(String chatLieu) { this.chatLieu = chatLieu != null ? chatLieu.trim() : null; }

    public String getKichThuoc() { return kichThuoc; }
    public void setKichThuoc(String kichThuoc) { this.kichThuoc = kichThuoc != null ? kichThuoc.trim() : null; }

    public String getTrongLuong() { return trongLuong; }
    public void setTrongLuong(String trongLuong) { this.trongLuong = trongLuong != null ? trongLuong.trim() : null; }

    public String getMauSac() { return mauSac; }
    public void setMauSac(String mauSac) { this.mauSac = mauSac != null ? mauSac.trim() : null; }

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

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Product product = (Product) o;
        return maSP == product.maSP;
    }

    @Override
    public int hashCode() {
        return Objects.hash(maSP);
    }
}