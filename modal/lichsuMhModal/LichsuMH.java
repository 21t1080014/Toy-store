package lichsuMhModal;

public class LichsuMH {
    private String maSanPham;
    private String tenSanPham;
    private double giaSanPham;
    private int soLuongMua;
    private double thanhTien;
    private String ngayMua;
    private int trangThaiDonHang;

    // Constructor không tham số
    public LichsuMH() {}

    // Constructor đầy đủ tham số
    public LichsuMH(String maSanPham, String tenSanPham, double giaSanPham, int soLuongMua, double thanhTien, String ngayMua, int trangThaiDonHang) {
        this.maSanPham = maSanPham;
        this.tenSanPham = tenSanPham;
        this.giaSanPham = giaSanPham;
        this.soLuongMua = soLuongMua;
        this.thanhTien = thanhTien;
        this.ngayMua = ngayMua;
        this.trangThaiDonHang = trangThaiDonHang;
    }

    // Getter và Setter cho từng thuộc tính
    public String getMaSanPham() {
        return maSanPham;
    }

    public void setMaSanPham(String maSanPham) {
        this.maSanPham = maSanPham;
    }

    public String getTenSanPham() {
        return tenSanPham;
    }

    public void setTenSanPham(String tenSanPham) {
        this.tenSanPham = tenSanPham;
    }

    public double getGiaSanPham() {
        return giaSanPham;
    }

    public void setGiaSanPham(double giaSanPham) {
        this.giaSanPham = giaSanPham;
    }

    public int getSoLuongMua() {
        return soLuongMua;
    }

    public void setSoLuongMua(int soLuongMua) {
        this.soLuongMua = soLuongMua;
    }

    public double getThanhTien() {
        return thanhTien;
    }

    public void setThanhTien(double thanhTien) {
        this.thanhTien = thanhTien;
    }

    public String getNgayMua() {
        return ngayMua;
    }

    public void setNgayMua(String ngayMua) {
        this.ngayMua = ngayMua;
    }

    public int getTrangThaiDonHang() {
        return trangThaiDonHang;
    }

    public void setTrangThaiDonHang(int trangThaiDonHang) {
        this.trangThaiDonHang = trangThaiDonHang;
    }

    // Phương thức hiển thị thông tin
    @Override
    public String toString() {
        return "LichsuMH{" +
                "maSanPham='" + maSanPham + '\'' +
                ", tenSanPham='" + tenSanPham + '\'' +
                ", giaSanPham=" + giaSanPham +
                ", soLuongMua=" + soLuongMua +
                ", thanhTien=" + thanhTien +
                ", ngayMua='" + ngayMua + '\'' +
                ", trangThaiDonHang=" + trangThaiDonHang +
                '}';
    }
}
