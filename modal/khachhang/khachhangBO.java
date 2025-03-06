package khachhang;

import java.util.ArrayList;

public class khachhangBO {
	public ArrayList<khachhang> getDSKhachHang(){
		
		khachhangDAO dao = new khachhangDAO();
		return dao.getDSKhachHang();
	}
	public boolean themTaiKhoan(String tenKhachHang, String email, String matKhau, String soDienThoai,
			String diaChi, String tenDangNhap) {
		 khachhangDAO dao = new khachhangDAO();
		 return dao.themTaiKhoan(tenKhachHang, email, matKhau, soDienThoai, diaChi, tenDangNhap);
	 }
	public boolean xoaTaiKhoan(int maKhachHang) {
		khachhangDAO dao = new khachhangDAO();
		return dao.xoaTaiKhoan(maKhachHang);
	}
	public khachhang dangNhap(String email, String matKhau) {
		khachhangDAO dao = new khachhangDAO();
		return dao.dangNhap(email, matKhau);
	}
	public boolean suaTaiKhoan(int maKhachHang,String tenKhachHang, String email, String soDienThoai,
			String diaChi, String tenDangNhap,byte trangThai) {
		khachhangDAO dao = new khachhangDAO();
		return dao.suaTaiKhoan(maKhachHang, tenKhachHang, email, soDienThoai, diaChi, tenDangNhap, trangThai);
	}
	public khachhang LayThongTinKhachHang(String tendn) {
		khachhangDAO dao = new khachhangDAO();
		return dao.LayThongTinKhachHang(tendn);
	}
}
