package ChiTietHoaDon;

import java.sql.Connection;
import java.sql.PreparedStatement;

import DAO.KetNoi;



public class CThoadon {
	public int Them(int MaSach,int SoLuongMua,Long MaHoaDon,Long Gia) {
		KetNoi kn = new KetNoi();
		kn.ketnoi();
		
		String sql ="insert into ChiTietDonHang (MaDonHang,MaSanPham,SoLuong,Gia) values (?,?,?,?)";
		int kq=0;
		PreparedStatement cmd=null;
		try {
			cmd = kn.cn.prepareStatement(sql);
			cmd.setLong(1, MaHoaDon);
			cmd.setInt(2, MaSach);
			cmd.setInt(3, SoLuongMua);
			cmd.setLong(4, Gia);
			kq=cmd.executeUpdate();
			 return kq;
			
		} catch (Exception e) {
			e.printStackTrace();
			
		}finally {
	        try {
	            if (cmd != null) cmd.close();
	            if (kn.cn != null) kn.cn.close();
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	    }
		return 0;
	}
}
