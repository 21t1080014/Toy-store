package PhieuNhapModal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import DAO.KetNoi;

public class phieunhapDAO {
	public ArrayList<phieuNhap> getAllPhieuNhap() {
        ArrayList<phieuNhap> phieuNhaps = new ArrayList<phieuNhap>();
        String sql = "SELECT * FROM PhieuNhap";
        KetNoi kn = new KetNoi();
        kn.ketnoi();
        PreparedStatement stmt;
        ResultSet rs;
        try {
        	stmt = kn.cn.prepareStatement(sql);
            rs = stmt.executeQuery();
            while (rs.next()) {
                phieuNhap phieu = new phieuNhap(
                    rs.getInt("MaPhieuNhap"),
                    rs.getInt("MaSanPham"),
                    rs.getInt("SoLuongNhap"),
                    rs.getDate("NgayNhap"),
                    rs.getLong("GiaNhap")
                );
                phieuNhaps.add(phieu);
            }kn.cn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return phieuNhaps;
    }
	public boolean addPhieuNhap(int maSanPham, int soLuongNhap, Long giaNhap) {
	    boolean isAdded = false;
	    String sqlInsert = "INSERT INTO PhieuNhap (MaSanPham, SoLuongNhap, NgayNhap, GiaNhap) VALUES (?, ?, ?, ?)";
	    String sqlUpdateProduct = "UPDATE SanPham SET SoLuong = SoLuong + ? WHERE MaSanPham = ?";
	    KetNoi kn = new KetNoi();
	    kn.ketnoi();
	    PreparedStatement stmtInsert;
        PreparedStatement stmtUpdate;
	    try  {
	    	stmtInsert = kn.cn.prepareStatement(sqlInsert);
	    	stmtUpdate = kn.cn.prepareStatement(sqlUpdateProduct);
	        // Thêm phiếu nhập
	        stmtInsert.setInt(1, maSanPham);
	        stmtInsert.setInt(2, soLuongNhap);
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
	        stmtInsert.setDate(3, new java.sql.Date(d1.getTime()));
	        stmtInsert.setLong(4, giaNhap);
	        int rowsInserted = stmtInsert.executeUpdate();

	        // Cập nhật số lượng sản phẩm
	        stmtUpdate.setInt(1, soLuongNhap);
	        stmtUpdate.setInt(2, maSanPham);
	        int rowsUpdated = stmtUpdate.executeUpdate();

	        if (rowsInserted > 0 && rowsUpdated > 0) {
	            isAdded = true;
	        }kn.cn.close();
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return isAdded;
	}
	public boolean updatePhieuNhap(int maPhieuNhap, int maSanPham, int soLuongNhap, Long giaNhap) {
	    boolean isUpdated = false;
	    String sqlUpdatePhieu = "UPDATE PhieuNhap SET MaSanPham = ?, SoLuongNhap = ?, NgayNhap = ?, GiaNhap = ? WHERE MaPhieuNhap = ?";
	    String sqlUpdateProduct = "UPDATE SanPham SET SoLuong = SoLuong - ? + ? WHERE MaSanPham = ?";
	    KetNoi kn = new KetNoi();
	    kn.ketnoi();
	    
	    try (PreparedStatement stmtUpdatePhieu = kn.cn.prepareStatement(sqlUpdatePhieu);
	         PreparedStatement stmtUpdateProduct = kn.cn.prepareStatement(sqlUpdateProduct)) {

	        // Lấy số lượng cũ để cập nhật vào bảng sản phẩm
	        String sqlGetOldQuantity = "SELECT SoLuongNhap FROM PhieuNhap WHERE MaPhieuNhap = ?";
	        try (PreparedStatement stmtOldQuantity = kn.cn.prepareStatement(sqlGetOldQuantity)) {
	            stmtOldQuantity.setInt(1, maPhieuNhap);
	            ResultSet rs = stmtOldQuantity.executeQuery();
	            int oldQuantity = 0;
	            if (rs.next()) {
	                oldQuantity = rs.getInt("SoLuongNhap");
	            }

	            // Cập nhật phiếu nhập
	            stmtUpdatePhieu.setInt(1, maSanPham);
	            stmtUpdatePhieu.setInt(2, soLuongNhap);
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
	            stmtUpdatePhieu.setDate(3, new java.sql.Date(d1.getTime()));
	            stmtUpdatePhieu.setLong(4, giaNhap);
	            stmtUpdatePhieu.setInt(5, maPhieuNhap);
	            int rowsUpdatedPhieu = stmtUpdatePhieu.executeUpdate();

	            // Cập nhật số lượng sản phẩm
	            stmtUpdateProduct.setInt(1, oldQuantity); // Giảm số lượng cũ
	            stmtUpdateProduct.setInt(2, soLuongNhap); // Tăng số lượng mới
	            stmtUpdateProduct.setInt(3, maSanPham);
	            int rowsUpdatedProduct = stmtUpdateProduct.executeUpdate();

	            if (rowsUpdatedPhieu > 0 && rowsUpdatedProduct > 0) {
	                isUpdated = true;
	            }
	        } kn.cn.close();
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return isUpdated;
	}
	public boolean deletePhieuNhap(int maPhieuNhap) {
	    boolean isDeleted = false;
	    String sqlDelete = "DELETE FROM PhieuNhap WHERE MaPhieuNhap = ?";
	    String sqlUpdateProduct = "UPDATE SanPham SET SoLuong = SoLuong - ? WHERE MaSanPham = ?";
	    KetNoi kn = new KetNoi();
	    kn.ketnoi();

	    // Câu lệnh để lấy thông tin số lượng nhập
	    String sqlGetQuantity = "SELECT MaSanPham, SoLuongNhap FROM PhieuNhap WHERE MaPhieuNhap = ?";

	    try (PreparedStatement stmtDelete = kn.cn.prepareStatement(sqlDelete);
	         PreparedStatement stmtUpdateProduct = kn.cn.prepareStatement(sqlUpdateProduct);
	         PreparedStatement stmtGetQuantity = kn.cn.prepareStatement(sqlGetQuantity)) {

	        // Đặt giá trị cho câu lệnh lấy thông tin số lượng
	        stmtGetQuantity.setInt(1, maPhieuNhap);

	        try (ResultSet rs = stmtGetQuantity.executeQuery()) {
	            if (rs.next()) {
	                int maSanPham = rs.getInt("MaSanPham");
	                int soLuongNhap = rs.getInt("SoLuongNhap");

	                // Cập nhật số lượng sản phẩm
	                stmtUpdateProduct.setInt(1, soLuongNhap); // Số lượng nhập
	                stmtUpdateProduct.setInt(2, maSanPham);   // Mã sản phẩm
	                stmtUpdateProduct.executeUpdate(); // Thực thi câu lệnh cập nhật
	            }

	            // Đặt giá trị cho câu lệnh xóa phiếu nhập
	            stmtDelete.setInt(1, maPhieuNhap);

	            // Xóa phiếu nhập
	            int rowsDeleted = stmtDelete.executeUpdate();
	            if (rowsDeleted > 0) {
	                isDeleted = true;
	            }

	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        // Đảm bảo đóng kết nối nếu không sử dụng try-with-resources
	        try {
	            if (kn.cn != null && !kn.cn.isClosed()) {
	                kn.cn.close();
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }

	    return isDeleted;
	}




}
