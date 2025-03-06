package sanphamModal;

import java.util.ArrayList;

public class sanphamBO {
	public ArrayList<sanpham> getAllsanpham() {
		//ArrayList<sanpham> ds = new ArrayList<sanpham>();
		sanphamDAO dao = new sanphamDAO();
		return dao.getAllsanpham();
	}
	public boolean suaSanPham(int maSanPham, String tenSanPham, int maDanhMuc, String moTa, String hinhAnh, byte trangThai,
            int soLuong) {
		sanphamDAO dao = new sanphamDAO();
		return dao.suaSanPham(maSanPham, tenSanPham, maDanhMuc, moTa, hinhAnh, trangThai, soLuong);
	}
	public boolean themSanPham(String tenSanPham, int maDanhMuc, String moTa, String hinhAnh, byte trangThai,
            int soLuong) {
		sanphamDAO dao = new sanphamDAO();
		return dao.themSanPham( tenSanPham, maDanhMuc, moTa, hinhAnh, trangThai, soLuong);
	}
	public boolean xoaSanPham(int maSanPham) {
		sanphamDAO dao = new sanphamDAO();
		return dao.xoaSanPham(maSanPham);
	}
}
