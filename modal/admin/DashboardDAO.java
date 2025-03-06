package admin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import DAO.KetNoi;

public class DashboardDAO {
	public int getTotalUsers() {
	    String query = "SELECT COUNT(*) AS count FROM KhachHang";
	    int totalUsers = 0;

	    try {
	        KetNoi kn = new KetNoi();
	        kn.ketnoi();
	        Connection cn = kn.cn;

	        PreparedStatement ps = cn.prepareStatement(query);
	        ResultSet rs = ps.executeQuery();

	        if (rs.next()) {
	            totalUsers = rs.getInt("count");
	        }

	        // Đóng tài nguyên
	        rs.close();
	        ps.close();
	        cn.close();
	    } catch (Exception e) {
	        e.printStackTrace(); // In lỗi ra để tiện debug
	    }

	    return totalUsers;
	}
	public int getTotalProducts() {
	    String query = "SELECT COUNT(*) AS count FROM SanPham";
	    int totalProducts = 0;

	    try {
	        KetNoi kn = new KetNoi();
	        kn.ketnoi();
	        Connection cn = kn.cn;

	        PreparedStatement ps = cn.prepareStatement(query);
	        ResultSet rs = ps.executeQuery();

	        if (rs.next()) {
	        	totalProducts = rs.getInt("count");
	        }

	        // Đóng tài nguyên
	        rs.close();
	        ps.close();
	        cn.close();
	    } catch (Exception e) {
	        e.printStackTrace(); // In lỗi ra để tiện debug
	    }

	    return totalProducts;
	}
	public int getTotalOrder() {
	    String query = "SELECT COUNT(*) AS count FROM DonHang";
	    int totalOrder = 0;

	    try {
	        KetNoi kn = new KetNoi();
	        kn.ketnoi();
	        Connection cn = kn.cn;

	        PreparedStatement ps = cn.prepareStatement(query);
	        ResultSet rs = ps.executeQuery();

	        if (rs.next()) {
	        	totalOrder = rs.getInt("count");
	        }

	        // Đóng tài nguyên
	        rs.close();
	        ps.close();
	        cn.close();
	    } catch (Exception e) {
	        e.printStackTrace(); // In lỗi ra để tiện debug
	    }

	    return totalOrder;
	}
	public int getTotalDanhMuc() {
	    String query = "SELECT COUNT(*) AS count FROM DanhMucSanPham";
	    int totalDanhMuc = 0;

	    try {
	        KetNoi kn = new KetNoi();
	        kn.ketnoi();
	        Connection cn = kn.cn;

	        PreparedStatement ps = cn.prepareStatement(query);
	        ResultSet rs = ps.executeQuery();

	        if (rs.next()) {
	        	totalDanhMuc = rs.getInt("count");
	        }

	        // Đóng tài nguyên
	        rs.close();
	        ps.close();
	        cn.close();
	    } catch (Exception e) {
	        e.printStackTrace(); // In lỗi ra để tiện debug
	    }

	    return totalDanhMuc;
	}
	public List<Map<String, Object>> getDoanhThu30Ngay() {
	    String query = "SELECT CAST(NgayDatHang AS DATE) AS Ngay, SUM(TongTien) AS DoanhThu " +
	                   "FROM DonHang " +
	                   "WHERE NgayDatHang >= DATEADD(DAY, -30, GETDATE()) AND TrangThai = 1" +
	                   "GROUP BY CAST(NgayDatHang AS DATE) " +
	                   "ORDER BY Ngay ASC";
	    List<Map<String, Object>> doanhThuList = new ArrayList();
	    try {
	        KetNoi kn = new KetNoi();
	        kn.ketnoi();
	        Connection cn = kn.cn;

	        PreparedStatement ps = cn.prepareStatement(query);
	        ResultSet rs = ps.executeQuery();

	        while (rs.next()) {
	            Map<String, Object> map = new HashMap<>();
	            map.put("Ngay", rs.getDate("Ngay"));
	            map.put("DoanhThu", rs.getDouble("DoanhThu"));
	            doanhThuList.add(map);
	        }

	        rs.close();
	        ps.close();
	        cn.close();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return doanhThuList;
	}

}
