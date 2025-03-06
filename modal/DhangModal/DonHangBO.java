package DhangModal;

import java.util.ArrayList;

public class DonHangBO {
	public ArrayList<DHang> getAllDonHang() {
		DonHangDAO dao = new DonHangDAO();
		return dao.getAllDonHang();
	}
	public boolean deleteAll() {
		DonHangDAO dao = new DonHangDAO();
		return dao.deleteAll();
	}
	public ArrayList<DHang> getQuaHan() {
		DonHangDAO dao = new DonHangDAO();
		return dao.getQuaHan();
	}
}
