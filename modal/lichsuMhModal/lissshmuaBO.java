package lichsuMhModal;

import java.util.ArrayList;

public class lissshmuaBO {
	public ArrayList<LichsuMH> getLichSuMuaHang(int maKhachHang) {
		LichsuMHDAO dao = new LichsuMHDAO();
		return dao.getLichSuMuaHang(maKhachHang);
	}
}
