package danhmuc;

import java.util.ArrayList;

import SanphamGia.sanphamGiaDAO;

public class danhmucBO {
	public ArrayList<danhmuc_sp> getDanhMuc(){
//		ArrayList<danhmuc_sp> ds = new ArrayList<danhmuc_sp>();
		danhmucDAO dao = new danhmucDAO();
		return dao.getDanhMuc();
	}
	
	
	public boolean themDanhMuc(String tenDanhMuc, String moTa) {
		danhmucDAO dao = new danhmucDAO();
		return dao.themDanhMuc(tenDanhMuc, moTa);
	}
	public boolean suaDanhMuc( int maDanhMuc, String tenDanhMuc, String moTa, byte trangThai) {
		danhmucDAO dao = new danhmucDAO();
		return dao.suaDanhMuc(maDanhMuc, tenDanhMuc, moTa, trangThai);
	}
	public boolean xoaDanhMuc(int maDanhMuc) {
		danhmucDAO dao = new danhmucDAO();
		return dao.xoaDanhMuc(maDanhMuc);
	}
	public ArrayList<danhmuc_sp> getAllDanhMuc(){
		danhmucDAO dao = new danhmucDAO();
		return dao.getAllDanhMuc();
	}
}
