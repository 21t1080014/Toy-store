package khachhang;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import DAO.KetNoi;
//import khachhangModal.khachhang;

public class khachhangDAO {
	public ArrayList<khachhang> getDSKhachHang(){
		ArrayList<khachhang> ds = new ArrayList<khachhang>();
		String sql = "select * from KhachHang";
		try {
			KetNoi kn = new KetNoi();
			kn.ketnoi();
			PreparedStatement stm = kn.cn.prepareStatement(sql);
			ResultSet rs = stm.executeQuery();
			while(rs.next()) {
				khachhang kh = new khachhang(
						rs.getInt("MaKhachHang"),
						rs.getString("TenKhachHang"),
						rs.getString("Email"),
						rs.getString("MatKhau"),
						rs.getString("SoDienThoai"),
						rs.getString("DiaChi"),
						rs.getDate("NgayDangKy"),
						rs.getByte("TrangThai"),
						rs.getString("TenDangNhap")
					);
				ds.add(kh);
			}
			rs.close();
			stm.close();
			kn.cn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ds;
	}
	// Đăng nhập
    public khachhang dangNhap(String email, String matKhau) {
        khachhang kh = null;
        String sql = "select * from KhachHang where TenDangNhap = ? and MatKhau = ?";
        try {
            KetNoi kn = new KetNoi();
            kn.ketnoi();
            PreparedStatement stm = kn.cn.prepareStatement(sql);
            stm.setString(1, email);
            stm.setString(2, matKhau);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                kh = new khachhang(
                        rs.getInt("MaKhachHang"),
                        rs.getString("TenKhachHang"),
                        rs.getString("Email"),
                        rs.getString("MatKhau"),
                        rs.getString("SoDienThoai"),
                        rs.getString("DiaChi"),
                        rs.getDate("NgayDangKy"),
                        rs.getByte("TrangThai"),
                        rs.getString("TenDangNhap")
                );
            }
            rs.close();
            stm.close();
            kn.cn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return kh;
    }

    // Thêm tài khoản
    public boolean themTaiKhoan(String tenKhachHang, String email, String matKhau, String soDienThoai,
			String diaChi, String tenDangNhap) {
        String sql = "insert into KhachHang (TenKhachHang, Email, MatKhau, SoDienThoai, DiaChi, NgayDangKy, TrangThai,TenDangNhap) values (?, ?, ?, ?, ?, ? ,1 , ?)";
        try {
            KetNoi kn = new KetNoi();
            kn.ketnoi();
            PreparedStatement stm = kn.cn.prepareStatement(sql);
            stm.setString(1, tenKhachHang);
            stm.setString(2, email);
            stm.setString(3, matKhau);
            stm.setString(4, soDienThoai);
            stm.setString(5, diaChi);
            Date d = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); 
			String dd = sdf.format(d);
			Date d1 = sdf.parse(dd);
			stm.setDate(6, new java.sql.Date(d1.getTime()));
//            stm.setByte(7, trangThai);
            stm.setString(7,tenDangNhap);
            int rows = stm.executeUpdate();
            stm.close();
            kn.cn.close();
            return rows > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Sửa tài khoản
    public boolean suaTaiKhoan(int maKhachHang,String tenKhachHang, String email, String soDienThoai,
			String diaChi, String tenDangNhap,byte trangThai) {
        String sql = "update KhachHang set TenKhachHang = ?, Email = ?, SoDienThoai = ?, DiaChi = ?, TrangThai = ?,TenDangNhap= ? where MaKhachHang = ?";
        try {
            KetNoi kn = new KetNoi();
            kn.ketnoi();
            PreparedStatement stm = kn.cn.prepareStatement(sql);
            stm.setString(1, tenKhachHang);
            stm.setString(2, email);
            stm.setString(3, soDienThoai);
            stm.setString(4, diaChi);
            stm.setByte(5, trangThai);
            stm.setString(6, tenDangNhap);
            stm.setInt(7, maKhachHang);
            int rows = stm.executeUpdate();
            stm.close();
            kn.cn.close();
            return rows > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Xóa tài khoản
    public boolean xoaTaiKhoan(int maKhachHang) {
        String sql = "delete from KhachHang where MaKhachHang = ?";
        try {
            KetNoi kn = new KetNoi();
            kn.ketnoi();
            PreparedStatement stm = kn.cn.prepareStatement(sql);
            stm.setInt(1, maKhachHang);
            int rows = stm.executeUpdate();
            stm.close();
            kn.cn.close();
            return rows > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    public khachhang LayThongTinKhachHang(String tendn) {
	    khachhang kh = null;
	    String sql = "SELECT * FROM KhachHang WHERE TenDangNhap = ?";
	    KetNoi kn = new KetNoi();
	    kn.ketnoi();
	    try {
	        PreparedStatement sm = kn.cn.prepareStatement(sql);
	        sm.setString(1, tendn);  // Đặt giá trị cho tên đăng nhập
	        ResultSet rs = sm.executeQuery();

	        if (rs.next()) {
	            // Lấy thông tin khách hàng từ ResultSet
	        	kh = new khachhang(
                        rs.getInt("MaKhachHang"),
                        rs.getString("TenKhachHang"),
                        rs.getString("Email"),
                        rs.getString("MatKhau"),
                        rs.getString("SoDienThoai"),
                        rs.getString("DiaChi"),
                        rs.getDate("NgayDangKy"),
                        rs.getByte("TrangThai"),
                        rs.getString("TenDangNhap")
                );
	        }
	        rs.close();
	        sm.close();
	        kn.cn.close();
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return kh;
	}
}
