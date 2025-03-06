package ChiTietHoaDon;

public class CThoadoBO {
	public int Them(int MaSach,int SoLuongMua,Long MaHoaDon,Long Gia) {
		CThoadon dao = new CThoadon();
		return dao.Them(MaSach, SoLuongMua, MaHoaDon, Gia);
	}
}
