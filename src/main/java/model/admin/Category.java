package model.admin;

public class Category {
    private int maDM;
    private String tenDM;

    public Category() {}

    public Category(int maDM, String tenDM) {
        this.maDM = maDM;
        this.tenDM = tenDM;
    }

    public int getMaDM() {
        return maDM;
    }

    public void setMaDM(int maDM) {
        this.maDM = maDM;
    }

    public String getTenDM() {
        return tenDM;
    }

    public void setTenDM(String tenDM) {
        this.tenDM = tenDM;
    }

    @Override
    public String toString() {
        return "Category{" +
                "maDM=" + maDM +
                ", tenDM='" + tenDM + '\'' +
                '}';
    }
}
