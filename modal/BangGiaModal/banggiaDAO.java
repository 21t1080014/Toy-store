package BangGiaModal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import DAO.KetNoi;

public class banggiaDAO {
	public ArrayList<BangGia> layBangGiaTheoSanPham(int maSanPham) {
	    String sql = "SELECT * FROM BangGia WHERE MaSanPham = ?";
	    ArrayList<BangGia> bangGiaList = new ArrayList<BangGia>();
	    KetNoi kn = new KetNoi();
	    kn.ketnoi();
	    PreparedStatement stm;
	    
	    ResultSet rs ;
	    try  {
	    	stm = kn.cn.prepareStatement(sql);
	    	stm.setInt(1, maSanPham);
	    	rs = stm.executeQuery();

	        while (rs.next()) {
	            int maGia = rs.getInt("MaGia");
	            Long gia = rs.getLong("Gia");
	            Date ngayApDung = rs.getDate("NgayApDung");

	            BangGia bangGia = new BangGia(maGia, maSanPham, gia, ngayApDung);
	            bangGiaList.add(bangGia);
	        }
	        rs.close();
	        stm.close();
	        kn.cn.close();
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return bangGiaList;
	}
	public boolean ThemGiachoSanPham( int maSanPham, Long gia) {
	    String sql = "INSERT INTO BangGia ( MaSanPham, Gia, NgayApDung) VALUES ( ?, ?, ?)";
	    KetNoi kn = new KetNoi();
	    kn.ketnoi();
	    PreparedStatement stm = null;
	    boolean isSuccess = false;

	    try {
	        stm = kn.cn.prepareStatement(sql);
	       
	        stm.setInt(1, maSanPham); // Set MaSanPham
	        stm.setLong(2, gia); // Set Gia
	        Date d = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); 
			String dd = sdf.format(d);
			Date d1 = new Date();
			try {
				d1 = sdf.parse(dd);
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	        stm.setDate(3, new java.sql.Date(d1.getTime())); // Set NgayApDung

	        int rowsAffected = stm.executeUpdate();
	        if (rowsAffected > 0) {
	            isSuccess = true; // If the query is successful
	        }
	        stm.close();
	        kn.cn.close();
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } 

	    return isSuccess;
	}
	public boolean SuaGiaSanPham(int maGia, Long gia) {
	    String sql = "UPDATE BangGia SET Gia = ? WHERE MaGia = ?";
	    KetNoi kn = new KetNoi();
	    kn.ketnoi();
	    PreparedStatement stm = null;
	    boolean isSuccess = false;

	    try {
	        stm = kn.cn.prepareStatement(sql);
	        stm.setLong(1, gia); // Set Gia
	        
	        stm.setInt(2, maGia); // Set MaGia

	        int rowsAffected = stm.executeUpdate();
	        if (rowsAffected > 0) {
	            isSuccess = true; // If the query is successful
	        }
	        stm.close();
	        kn.cn.close();
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } 

	    return isSuccess;
	}
	public boolean XoaGiaSanPham(int maGia) {
	    String sql = "DELETE FROM BangGia WHERE MaGia = ?";
	    KetNoi kn = new KetNoi();
	    kn.ketnoi();
	    PreparedStatement stm = null;
	    boolean isSuccess = false;

	    try {
	        stm = kn.cn.prepareStatement(sql);
	        stm.setInt(1, maGia); // Set MaGia

	        int rowsAffected = stm.executeUpdate();
	        if (rowsAffected > 0) {
	            isSuccess = true; // If the query is successful
	        }
	        stm.close();
	        kn.cn.close();
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return isSuccess;
	}


}
