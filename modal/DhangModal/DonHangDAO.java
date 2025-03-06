package DhangModal;


import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;

import DAO.KetNoi;



public class DonHangDAO {
	public ArrayList<DHang> getAllDonHang() {
	//String maSach, String tenSach, String tacgia, Long soluong, Long gia, String anh, String maLoai
			ArrayList<DHang> ds = new ArrayList<DHang>();
//			ds.add(new sach("s1", "CSDL1", "le nam",(long)10,

			String sql = " SELECT * FROM vw_xacnhan ";
			KetNoi kn = new KetNoi();
			kn.ketnoi();
			PreparedStatement sm;
			try {
				sm = kn.cn.prepareStatement(sql);
				ResultSet rs = sm.executeQuery();
				while(rs.next()) {
//					String tenKhachHang, Long soLuongMua, Date ngayDatHang, Long tongTien, Long tongGia, int maDonHang
					String tenKhachHang = rs.getString("TenKhachHang");
					Long soLuongMua = rs.getLong("SoLuongMua");
					Date ngayDatHang = rs.getDate("NgayDatHang");
					Long tongTien = rs.getLong("TongTien");
					Long tongGia = rs.getLong("TongGia");
					int maDonHang = rs.getInt("MaDonHang");
					ds.add(new DHang(tenKhachHang, soLuongMua, ngayDatHang, tongTien, tongGia, maDonHang));
//					ds.add(new sach( masach, tensach, tacgia, soluong,gia, anh,  maloai));
					
				}
				rs.close(); 
				sm.close();
				kn.cn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			return ds;
		}
	public boolean deleteAll() {
	    // Truy vấn xóa chi tiết đơn hàng trước
	    String sqlDetails = "DELETE FROM ChiTietDonHang WHERE MaDonHang IN (SELECT MaDonHang FROM DonHang WHERE TrangThai = 0 AND DATEDIFF(DAY, NgayDatHang, GETDATE()) > 30)";
	    // Truy vấn xóa đơn hàng sau
	    String sqlOrders = "DELETE FROM DonHang WHERE TrangThai = 0 AND DATEDIFF(DAY, NgayDatHang, GETDATE()) > 30";

	    KetNoi kn = new KetNoi();
	    kn.ketnoi();

	    try {
	         // Bắt đầu giao dịch
// Xóa đơn hàng
	        try (PreparedStatement smOrders = kn.cn.prepareStatement(sqlOrders)) {
	            smOrders.executeUpdate();
	        }
	        // Xóa chi tiết đơn hàng
	        try (PreparedStatement smDetails = kn.cn.prepareStatement(sqlDetails)) {
	            smDetails.executeUpdate();
	        }

	        

	        kn.cn.commit(); // Cam kết giao dịch
	        return true;
	    } catch (SQLException e) {
	        e.printStackTrace();
	        try {
	            if (kn.cn != null) {
	                kn.cn.rollback(); // Rollback nếu có lỗi
	            }
	        } catch (SQLException rollbackEx) {
	            rollbackEx.printStackTrace();
	        }
	        return false;
	    } finally {
	        try {
	            if (kn.cn != null) {
	                kn.cn.setAutoCommit(true); // Đặt lại chế độ tự động cam kết
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
	}


	public ArrayList<DHang> getQuaHan() {
	    ArrayList<DHang> ds = new ArrayList<>();

	    // Truy vấn các đơn hàng đã quá hạn
	    String sql = "SELECT * FROM vw_xacnhan WHERE DATEDIFF(day, NgayDatHang, GETDATE()) > 30 ";
//	    Connection cn = KetNoi.getConnection();
	    KetNoi kn = new KetNoi();
	    kn.ketnoi();
	    try (PreparedStatement sm = kn.cn.prepareStatement(sql)) {
	        ResultSet rs = sm.executeQuery();
	        while (rs.next()) {
	            // Lấy dữ liệu từ bảng DonHang
	        	String tenKhachHang = rs.getString("TenKhachHang");
				Long soLuongMua = rs.getLong("SoLuongMua");
				Date ngayDatHang = rs.getDate("NgayDatHang");
				Long tongTien = rs.getLong("TongTien");
				Long tongGia = rs.getLong("TongGia");
				int maDonHang = rs.getInt("MaDonHang");
				ds.add(new DHang(tenKhachHang, soLuongMua, ngayDatHang, tongTien, tongGia, maDonHang));
	        }
	        rs.close();
	        sm.close();
	        kn.cn.close();
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return ds;
	}

		
	public boolean XacNhanDH(String maDonHang) {
	    // Truy vấn cập nhật trạng thái đơn hàng
	    String sql = "UPDATE DonHang SET TrangThai = 1 WHERE MaDonHang = ?";
//	    Connection cn = KetNoi.getConnection();
	    KetNoi kn = new KetNoi();
	    kn.ketnoi();
	    try (PreparedStatement sm = kn.cn.prepareStatement(sql)) {
	        sm.setString(1, maDonHang);
	        int rowsAffected = sm.executeUpdate();
	        kn.cn.close();
	        return rowsAffected > 0; // Trả về true nếu có ít nhất một dòng được cập nhật
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return false;
	}

}
