package PhieuNhapModal;

import java.util.Date;

public class phieuNhap {
	private int MaPhieuNhap;
	private int MaSanPham;
	private int SoLuongNhap;
	private Date NgayNhap;
	private Long GiaNhap;
	public phieuNhap() {
		super();
		// TODO Auto-generated constructor stub
	}
	public phieuNhap(int maPhieuNhap, int maSanPham, int soLuongNhap, Date ngayNhap, Long giaNhap) {
		super();
		MaPhieuNhap = maPhieuNhap;
		MaSanPham = maSanPham;
		SoLuongNhap = soLuongNhap;
		NgayNhap = ngayNhap;
		GiaNhap = giaNhap;
	}
	public int getMaPhieuNhap() {
		return MaPhieuNhap;
	}
	public void setMaPhieuNhap(int maPhieuNhap) {
		MaPhieuNhap = maPhieuNhap;
	}
	public int getMaSanPham() {
		return MaSanPham;
	}
	public void setMaSanPham(int maSanPham) {
		MaSanPham = maSanPham;
	}
	public int getSoLuongNhap() {
		return SoLuongNhap;
	}
	public void setSoLuongNhap(int soLuongNhap) {
		SoLuongNhap = soLuongNhap;
	}
	public Date getNgayNhap() {
		return NgayNhap;
	}
	public void setNgayNhap(Date ngayNhap) {
		NgayNhap = ngayNhap;
	}
	public Long getGiaNhap() {
		return GiaNhap;
	}
	public void setGiaNhap(Long giaNhap) {
		GiaNhap = giaNhap;
	}
	
	
}
