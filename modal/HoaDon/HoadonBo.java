package HoaDon;

public class HoadonBo {
	public int Them(int makh, double tongTien) {
		HoadonDAO dao = new HoadonDAO();
		return dao.Them(makh, tongTien);
	}
	public Long getMaDonHangMax() {
		HoadonDAO dao = new HoadonDAO();
		return dao.getMaDonHangMax();
	}
}
