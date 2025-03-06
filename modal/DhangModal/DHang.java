package DhangModal;

import java.util.Date;

public class DHang {
	private String TenKhachHang;
	private Long SoLuongMua;
	private Date NgayDatHang;
	private Long TongTien;
	private Long TongGia;
	private int MaDonHang;
	public DHang() {
		super();
		// TODO Auto-generated constructor stub
	}
	public DHang(String tenKhachHang, Long soLuongMua, Date ngayDatHang, Long tongTien, Long tongGia, int maDonHang) {
		super();
		TenKhachHang = tenKhachHang;
		SoLuongMua = soLuongMua;
		NgayDatHang = ngayDatHang;
		TongTien = tongTien;
		TongGia = tongGia;
		MaDonHang = maDonHang;
	}
	public String getTenKhachHang() {
		return TenKhachHang;
	}
	public void setTenKhachHang(String tenKhachHang) {
		TenKhachHang = tenKhachHang;
	}
	public Long getSoLuongMua() {
		return SoLuongMua;
	}
	public void setSoLuongMua(Long soLuongMua) {
		SoLuongMua = soLuongMua;
	}
	public Date getNgayDatHang() {
		return NgayDatHang;
	}
	public void setNgayDatHang(Date ngayDatHang) {
		NgayDatHang = ngayDatHang;
	}
	public Long getTongTien() {
		return TongTien;
	}
	public void setTongTien(Long tongTien) {
		TongTien = tongTien;
	}
	public Long getTongGia() {
		return TongGia;
	}
	public void setTongGia(Long tongGia) {
		TongGia = tongGia;
	}
	public int getMaDonHang() {
		return MaDonHang;
	}
	public void setMaDonHang(int maDonHang) {
		MaDonHang = maDonHang;
	}
	
	
}
