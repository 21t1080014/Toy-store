package SanphamGia;

import java.sql.Connection;
//import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import DAO.KetNoi;
//import sachModal.sach;

//import dao.KetNoi;
//import sachModal.sach;

public class sanphamGiaDAO {
	public ArrayList<sanphamGia> getAllSanphamGias(int trang){
		ArrayList<sanphamGia> ds = new ArrayList<sanphamGia>();
		String sql = "SELECT * FROM vw_SanPhamGia WHERE TrangThai=1 ORDER BY MaSanPham OFFSET ? ROWS FETCH NEXT 6 ROWS ONLY";
		KetNoi kn = new KetNoi();
		kn.ketnoi();
		
//		Connection cn = KetNoi.getConnection();
		PreparedStatement sm;
		try {
			int ofset = 6*trang-6;
			sm = kn.cn.prepareStatement(sql);
			sm.setInt(1, ofset);
			ResultSet rs = sm.executeQuery();
			while(rs.next()) {
;
				int MaSanPham = rs.getInt("MaSanPham");
				String tenSanPham = rs.getString("TenSanPham");
				String hinhAnh = rs.getString("HinhAnh");
				String moTa = rs.getString("MoTa");
				byte trangThai = rs.getByte("TrangThai");
				int soLuong = rs.getInt("SoLuong");
				Long gia = rs.getLong("Gia");
				int MaDanhMuc = rs.getInt("MaDanhMuc");
				ds.add(new sanphamGia(MaSanPham, tenSanPham, hinhAnh, moTa, trangThai, soLuong, gia,MaDanhMuc));
				
			}
			rs.close(); 
			sm.close();
			kn.cn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ds;
	}
	
	public sanphamGia getSanPhamById(int maSanPham) {
	    sanphamGia sanPham = null;
	    String sql = "SELECT * FROM vw_SanPhamGia WHERE MaSanPham = ? AND TrangThai = 1";
	    
	    KetNoi kn = new KetNoi();
	    kn.ketnoi();
	    
	    PreparedStatement sm;
	    try {
	        sm = kn.cn.prepareStatement(sql);
	        sm.setInt(1, maSanPham);  // Thiết lập mã sản phẩm cần tìm
	        ResultSet rs = sm.executeQuery();
	        
	        if (rs.next()) {
	            int MaSanPham = rs.getInt("MaSanPham");
	            String tenSanPham = rs.getString("TenSanPham");
	            String hinhAnh = rs.getString("HinhAnh");
	            String moTa = rs.getString("MoTa");
	            byte trangThai = rs.getByte("TrangThai");
	            int soLuong = rs.getInt("SoLuong");
	            Long gia = rs.getLong("Gia");
	            int MaDanhMuc = rs.getInt("MaDanhMuc");
	            
	            // Tạo đối tượng sanphamGia với dữ liệu truy vấn được
	            sanPham = new sanphamGia(MaSanPham, tenSanPham, hinhAnh, moTa, trangThai, soLuong, gia, MaDanhMuc);
	        }
	        
	        rs.close();
	        sm.close();
	        kn.cn.close();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    
	    return sanPham;  // Trả về đối tượng sản phẩm
	}

	
	public ArrayList<sanphamGia> TimLoai(int trang , String maloai){
		ArrayList< sanphamGia> ds = new ArrayList<sanphamGia>();
		//String sql ="SELECT * FROM sach WHERE maloai = ?ORDER BY masach OFFSET 6 * ? - 6 ROWS FETCH NEXT 6 ROWS ONLY";
		String sql ="SELECT * FROM vw_SanPhamGia WHERE MaDanhMuc = ? AND TrangThai=1 ORDER BY MaSanPham OFFSET 6 * ? - 6 ROWS FETCH NEXT 6 ROWS ONLY";

		KetNoi kn = new KetNoi();
		kn.ketnoi();
		PreparedStatement sm;
		try {
			sm = kn.cn.prepareStatement(sql);
			sm.setString(1, maloai);
			sm.setInt(2, trang);
			ResultSet rs = sm.executeQuery();
			while(rs.next()) {
				int MaSanPham = rs.getInt("MaSanPham");
				String tenSanPham = rs.getString("TenSanPham");
				String hinhAnh = rs.getString("HinhAnh");
				String moTa = rs.getString("MoTa");
				byte trangThai = rs.getByte("TrangThai");
				int soLuong = rs.getInt("SoLuong");
				Long gia = rs.getLong("Gia");
//				int MaDanhMuc = rs.getInt("MaDanhMuc");
				//String maloai = rs.getString("maloai");
				ds.add(new sanphamGia(MaSanPham, tenSanPham, hinhAnh, moTa, trangThai, soLuong, gia, soLuong));
				
			}
			rs.close();
			sm.close();
			kn.cn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ds;
	}
	public ArrayList<sanphamGia> Tim (String key,int trang){
		ArrayList<sanphamGia> ds = new ArrayList<sanphamGia>();
//		String sql ="SELECT * FROM sach WHERE tenSach LIKE ? OR tacgia LIKE ? ORDER BY masach OFFSET 6* ? - 6 ROWS FETCH NEXT 6 ROWS ONLY";
		String sql = "SELECT * FROM vw_SanPhamGia WHERE LOWER(TenSanPham) LIKE LOWER(?) AND TrangThai=1 ORDER BY MaSanPham OFFSET 6 * ? - 6 ROWS FETCH NEXT 6 ROWS ONLY";
		String kytu_Timkiem = "%"+key.toLowerCase()+"%";
		KetNoi kn = new KetNoi();
		kn.ketnoi();
		PreparedStatement sm;
		try {
			sm = kn.cn.prepareStatement(sql);
			sm.setString(1, kytu_Timkiem);
//			sm.setString(2, kytu_Timkiem);
			sm.setInt(2, trang);
			ResultSet rs = sm.executeQuery();
			while(rs.next()) {
				int MaSanPham = rs.getInt("MaSanPham");
				String tenSanPham = rs.getString("TenSanPham");
				String hinhAnh = rs.getString("HinhAnh");
				String moTa = rs.getString("MoTa");
				byte trangThai = rs.getByte("TrangThai");
				int soLuong = rs.getInt("SoLuong");
				Long gia = rs.getLong("Gia");
				int MaDanhMuc = rs.getInt("MaDanhMuc");
				ds.add(new sanphamGia(MaSanPham, tenSanPham, hinhAnh, moTa, trangThai, soLuong, gia, MaDanhMuc));
				
			}
			rs.close();
			sm.close();
			kn.cn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ds;
	}
	
	public int coutSanpham() {
		String sql=" select count(*) from vw_SanPhamGia where TrangThai=1";
		int dem=0;
		KetNoi kn = new KetNoi();
		try{
			kn.ketnoi();
			PreparedStatement sm= kn.cn.prepareStatement(sql);
			ResultSet rs = sm.executeQuery();
			if(rs.next()) dem=rs.getInt(1);
			rs.close();
			sm.close();
			kn.cn.close();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return dem;
	}
	public int count_Tim(String key) {
		String sql="SELECT COUNT(*) FROM vw_SanPhamGia WHERE LOWER(TenSanPham) LIKE LOWER(?) AND TrangThai=1";
		String kytu_Timkiem = "%"+key.toLowerCase()+"%";
		int dem=0;
		KetNoi kn = new KetNoi();
		kn.ketnoi();
		PreparedStatement sm;
		try{
			sm=kn.cn.prepareStatement(sql);
			sm.setString(1, kytu_Timkiem);
//			sm.setString(2,kytu_Timkiem );
				ResultSet rs = sm.executeQuery();
			if(rs.next()) dem=rs.getInt(1);
			rs.close();
			sm.close();
			kn.cn.close();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return dem;
	}
	public int countSach_loai(String maloai) {
		String sql ="SELECT COUNT(*) FROM vw_SanPhamGia WHERE MaDanhMuc = ? AND TrangThai=1 ";
		int dem=0;
		KetNoi kn = new KetNoi();
		kn.ketnoi();
		
		PreparedStatement sm;
		try{
			sm= kn.cn.prepareStatement(sql);
			sm.setString(1, maloai);
				ResultSet rs = sm.executeQuery();
			if(rs.next()) dem=rs.getInt(1);
			rs.close();
			sm.close();
			kn.cn.close();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return dem;
	}
}
