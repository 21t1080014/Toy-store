package khachhang;

import java.util.Date;

public class khachhang {
	private int MaKhachHang;
	private String TenKhachHang;
	private String Email;
	private String MatKhau;
	private String SoDienThoai;
	private String DiaChi;
	private Date NgayDangKy;
	private byte TrangThai;
	private String TenDangNhap;
	public khachhang() {
		super();
		// TODO Auto-generated constructor stub
	}
	public khachhang(int maKhachHang, String tenKhachHang, String email, String matKhau, String soDienThoai,
			String diaChi, Date ngayDangKy, byte trangThai, String tenDangNhap) {
		super();
		MaKhachHang = maKhachHang;
		TenKhachHang = tenKhachHang;
		Email = email;
		MatKhau = matKhau;
		SoDienThoai = soDienThoai;
		DiaChi = diaChi;
		NgayDangKy = ngayDangKy;
		TrangThai = trangThai;
		TenDangNhap = tenDangNhap;
	}
	public int getMaKhachHang() {
		return MaKhachHang;
	}
	public void setMaKhachHang(int maKhachHang) {
		MaKhachHang = maKhachHang;
	}
	public String getTenKhachHang() {
		return TenKhachHang;
	}
	public void setTenKhachHang(String tenKhachHang) {
		TenKhachHang = tenKhachHang;
	}
	public String getEmail() {
		return Email;
	}
	public void setEmail(String email) {
		Email = email;
	}
	public String getMatKhau() {
		return MatKhau;
	}
	public void setMatKhau(String matKhau) {
		MatKhau = matKhau;
	}
	public String getSoDienThoai() {
		return SoDienThoai;
	}
	public void setSoDienThoai(String soDienThoai) {
		SoDienThoai = soDienThoai;
	}
	public String getDiaChi() {
		return DiaChi;
	}
	public void setDiaChi(String diaChi) {
		DiaChi = diaChi;
	}
	public Date getNgayDangKy() {
		return NgayDangKy;
	}
	public void setNgayDangKy(Date ngayDangKy) {
		NgayDangKy = ngayDangKy;
	}
	public byte getTrangThai() {
		return TrangThai;
	}
	public void setTrangThai(byte trangThai) {
		TrangThai = trangThai;
	}
	public String getTenDangNhap() {
		return TenDangNhap;
	}
	public void setTenDangNhap(String tenDangNhap) {
		TenDangNhap = tenDangNhap;
	}
	
	
	
}
/***
[MaKhachHang]
      ,[TenKhachHang]
      ,[Email]
      ,[MatKhau]
      ,[SoDienThoai]
      ,[DiaChi]
      ,[NgayDangKy]
      ,[TrangThai]
***/