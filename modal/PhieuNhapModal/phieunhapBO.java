package PhieuNhapModal;

import java.util.ArrayList;

public class phieunhapBO {
	public ArrayList<phieuNhap> getAllPhieuNhap() {
		phieunhapDAO dao = new phieunhapDAO();
		return dao.getAllPhieuNhap();
	}
	public boolean addPhieuNhap(int maSanPham, int soLuongNhap, Long giaNhap) {
		phieunhapDAO dao = new phieunhapDAO();
		return dao.addPhieuNhap(maSanPham, soLuongNhap, giaNhap);
	}
	public boolean updatePhieuNhap(int maPhieuNhap, int maSanPham, int soLuongNhap, Long giaNhap) {
		phieunhapDAO dao = new phieunhapDAO();
		return dao.updatePhieuNhap(maPhieuNhap, maSanPham, soLuongNhap, giaNhap);
	}
	public boolean deletePhieuNhap(int maPhieuNhap) {
		phieunhapDAO dao = new phieunhapDAO();
		return dao.deletePhieuNhap(maPhieuNhap);
	}
}
