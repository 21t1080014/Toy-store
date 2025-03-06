package BangGiaModal;

import java.util.ArrayList;
import java.util.Date;

public class banggiaBO {
	public ArrayList<BangGia> layBangGiaTheoSanPham(int maSanPham) {
		banggiaDAO dao = new banggiaDAO();
		return dao.layBangGiaTheoSanPham(maSanPham);
	}
	public boolean ThemGiachoSanPham( int maSanPham, Long gia) {
		banggiaDAO dao = new banggiaDAO();
		return dao.ThemGiachoSanPham( maSanPham, gia);
	}
	public boolean SuaGiaSanPham(int maGia, Long gia) {
		banggiaDAO dao = new banggiaDAO();
		return dao.SuaGiaSanPham(maGia, gia);
	}
	public boolean XoaGiaSanPham(int maGia) {
		banggiaDAO dao = new banggiaDAO();
		return dao.XoaGiaSanPham(maGia);
	}
}
