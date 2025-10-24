package model;

import java.math.BigDecimal;

/**
 * Model đại diện cho chi tiết đơn hàng
 */
public class OrderItem {
    private int maCTDH;
    private int maDH;
    private int maSP;
    private int soLuong;
    private BigDecimal gia;
    private String mauSac;
    private String dungLuong;
    private Product product; // Thông tin sản phẩm
    
    // Constructors
    public OrderItem() {}
    
    public OrderItem(int maCTDH, int maDH, int maSP, int soLuong, BigDecimal gia, 
                     String mauSac, String dungLuong) {
        this.maCTDH = maCTDH;
        this.maDH = maDH;
        this.maSP = maSP;
        this.soLuong = soLuong;
        this.gia = gia;
        this.mauSac = mauSac;
        this.dungLuong = dungLuong;
    }
    
    // Getters and Setters
    public int getMaCTDH() {
        return maCTDH;
    }
    
    public void setMaCTDH(int maCTDH) {
        this.maCTDH = maCTDH;
    }
    
    public int getMaDH() {
        return maDH;
    }
    
    public void setMaDH(int maDH) {
        this.maDH = maDH;
    }
    
    public int getMaSP() {
        return maSP;
    }
    
    public void setMaSP(int maSP) {
        this.maSP = maSP;
    }
    
    public int getSoLuong() {
        return soLuong;
    }
    
    public void setSoLuong(int soLuong) {
        this.soLuong = soLuong;
    }
    
    public BigDecimal getGia() {
        return gia;
    }
    
    public void setGia(BigDecimal gia) {
        this.gia = gia;
    }
    
    public String getMauSac() {
        return mauSac;
    }
    
    public void setMauSac(String mauSac) {
        this.mauSac = mauSac;
    }
    
    public String getDungLuong() {
        return dungLuong;
    }
    
    public void setDungLuong(String dungLuong) {
        this.dungLuong = dungLuong;
    }
    
    public Product getProduct() {
        return product;
    }
    
    public void setProduct(Product product) {
        this.product = product;
    }
    
    @Override
    public String toString() {
        return "OrderItem{" +
                "maCTDH=" + maCTDH +
                ", maDH=" + maDH +
                ", maSP=" + maSP +
                ", soLuong=" + soLuong +
                ", gia=" + gia +
                ", mauSac='" + mauSac + '\'' +
                ", dungLuong='" + dungLuong + '\'' +
                '}';
    }
}
