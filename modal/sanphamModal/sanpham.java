package sanphamModal;

import java.util.Date;

public class sanpham {
	private int MaSanPham;
	private String TenSanPham;
	private int MaDanhMuc;
	private String MoTa;
	private String HinhAnh;
	private byte TrangThai;
	private Date NgayTao;
	private int SoLuong;
	public sanpham() {
		super();
		// TODO Auto-generated constructor stub
	}
	public sanpham(int maSanPham, String tenSanPham, int maDanhMuc, String moTa, String hinhAnh, byte trangThai,
			Date ngayTao, int soLuong) {
		super();
		MaSanPham = maSanPham;
		TenSanPham = tenSanPham;
		MaDanhMuc = maDanhMuc;
		MoTa = moTa;
		HinhAnh = hinhAnh;
		TrangThai = trangThai;
		NgayTao = ngayTao;
		SoLuong = soLuong;
	}
	public int getMaSanPham() {
		return MaSanPham;
	}
	public void setMaSanPham(int maSanPham) {
		MaSanPham = maSanPham;
	}
	public String getTenSanPham() {
		return TenSanPham;
	}
	public void setTenSanPham(String tenSanPham) {
		TenSanPham = tenSanPham;
	}
	public int getMaDanhMuc() {
		return MaDanhMuc;
	}
	public void setMaDanhMuc(int maDanhMuc) {
		MaDanhMuc = maDanhMuc;
	}
	public String getMoTa() {
		return MoTa;
	}
	public void setMoTa(String moTa) {
		MoTa = moTa;
	}
	public String getHinhAnh() {
		return HinhAnh;
	}
	public void setHinhAnh(String hinhAnh) {
		HinhAnh = hinhAnh;
	}
	public byte getTrangThai() {
		return TrangThai;
	}
	public void setTrangThai(byte trangThai) {
		TrangThai = trangThai;
	}
	public Date getNgayTao() {
		return NgayTao;
	}
	public void setNgayTao(Date ngayTao) {
		NgayTao = ngayTao;
	}
	public int getSoLuong() {
		return SoLuong;
	}
	public void setSoLuong(int soLuong) {
		SoLuong = soLuong;
	}
	
	
}
//[MaSanPham]
//	      ,[TenSanPham]
//	      ,[MaDanhMuc]
//	      ,[MoTa]
//	      ,[HinhAnh]
//	      ,[TrangThai]
//	      ,[NgayTao]
//	      ,[SoLuong]