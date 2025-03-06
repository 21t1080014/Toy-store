package BangGiaModal;

import java.util.Date;

public class BangGia {
	private int MaGia;
	private int MaSanPham;
	private Long Gia;
	private Date NgayApDung;
	public BangGia() {
		super();
		// TODO Auto-generated constructor stub
	}
	public BangGia(int maGia, int maSanPham, Long gia, Date ngayApDung) {
		super();
		MaGia = maGia;
		MaSanPham = maSanPham;
		Gia = gia;
		NgayApDung = ngayApDung;
	}
	public int getMaGia() {
		return MaGia;
	}
	public void setMaGia(int maGia) {
		MaGia = maGia;
	}
	public int getMaSanPham() {
		return MaSanPham;
	}
	public void setMaSanPham(int maSanPham) {
		MaSanPham = maSanPham;
	}
	public Long getGia() {
		return Gia;
	}
	public void setGia(Long gia) {
		Gia = gia;
	}
	public Date getNgayApDung() {
		return NgayApDung;
	}
	public void setNgayApDung(Date ngayApDung) {
		NgayApDung = ngayApDung;
	}
	
	
}
