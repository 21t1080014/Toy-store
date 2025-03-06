package SanphamGia;

import java.util.ArrayList;

public class sanphamGiaBO {
	public ArrayList<sanphamGia> getAllSanphamGias(int trang){
		sanphamGiaDAO dao = new sanphamGiaDAO();
		return dao.getAllSanphamGias(trang);
	}
	public int coutSanpham() {
		sanphamGiaDAO dao = new sanphamGiaDAO();
		return dao.coutSanpham();
	}
	public ArrayList<sanphamGia> TimLoai(int trang , String maloai){
		sanphamGiaDAO dao = new sanphamGiaDAO();
		return dao.TimLoai(trang, maloai);
	}
	public ArrayList<sanphamGia> Tim (String key,int trang){
		sanphamGiaDAO dao = new sanphamGiaDAO();
		return dao.Tim(key, trang);
	}
	public int count_Tim(String key) {
		sanphamGiaDAO dao = new sanphamGiaDAO();
		return dao.count_Tim(key);
	}
	public int countSach_loai(String maloai) {
		sanphamGiaDAO dao = new sanphamGiaDAO();
		return dao.countSach_loai(maloai);
	}
	public sanphamGia getSanPhamById(int maSanPham) {
		sanphamGiaDAO dao = new sanphamGiaDAO();
		return dao.getSanPhamById(maSanPham);
	}
}
