package sanphamModal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import DAO.KetNoi;

public class sanphamDAO {

    // Lấy tất cả sản phẩm
    public ArrayList<sanpham> getAllsanpham() {
        ArrayList<sanpham> ds = new ArrayList<sanpham>();
        String sql = "SELECT * FROM SanPham";
        try {
            KetNoi kn = new KetNoi();
            kn.ketnoi();
            PreparedStatement stm = kn.cn.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                sanpham sp = new sanpham(
                        rs.getInt("MaSanPham"),
                        rs.getString("TenSanPham"),
                        rs.getInt("MaDanhMuc"),
                        rs.getString("MoTa"),
                        rs.getString("HinhAnh"),
                        rs.getByte("TrangThai"),
                        rs.getDate("NgayTao"),
                        rs.getInt("SoLuong")
                );
                ds.add(sp);
            }
            rs.close();
            stm.close();
            kn.cn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ds;
    }

    // Thêm sản phẩm
    public boolean themSanPham(String tenSanPham, int maDanhMuc, String moTa, String hinhAnh, byte trangThai,
             int soLuong) {
        String sql = "INSERT INTO SanPham (TenSanPham, MaDanhMuc, MoTa, HinhAnh, TrangThai, NgayTao, SoLuong) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try {
            KetNoi kn = new KetNoi();
            kn.ketnoi();
            PreparedStatement stm = kn.cn.prepareStatement(sql);
            stm.setString(1, tenSanPham);
            stm.setInt(2, maDanhMuc);
            stm.setString(3, moTa);
            stm.setString(4, hinhAnh);
            stm.setByte(5, trangThai);
            Date d = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); 
			String dd = sdf.format(d);
			Date d1 = new Date();
			try {
				d1 = sdf.parse(dd);
			} catch (ParseException e) {
				
				e.printStackTrace();
			}
            stm.setDate(6, new java.sql.Date(d1.getTime()));
            stm.setInt(7, soLuong);

            int rowsInserted = stm.executeUpdate();
            stm.close();
            kn.cn.close();
            return rowsInserted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Sửa sản phẩm
    public boolean suaSanPham(int maSanPham, String tenSanPham, int maDanhMuc, String moTa, String hinhAnh, byte trangThai,
             int soLuong) {
        String sql = "UPDATE SanPham SET TenSanPham = ?, MaDanhMuc = ?, MoTa = ?, HinhAnh = ?, TrangThai = ?, NgayTao = ?, SoLuong = ? WHERE MaSanPham = ?";
        try {
            KetNoi kn = new KetNoi();
            kn.ketnoi();
            PreparedStatement stm = kn.cn.prepareStatement(sql);
            stm.setString(1, tenSanPham);
            stm.setInt(2, maDanhMuc);
            stm.setString(3, moTa);
            stm.setString(4, hinhAnh);
            stm.setByte(5, trangThai);
            Date d = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); 
			String dd = sdf.format(d);
			Date d1 = new Date();
			try {
				d1 = sdf.parse(dd);
			} catch (ParseException e) {
				
				e.printStackTrace();
			}
            stm.setDate(6, new java.sql.Date(d1.getTime()));
            stm.setInt(7, soLuong);
            stm.setInt(8, maSanPham);

            int rowsUpdated = stm.executeUpdate();
            stm.close();
            kn.cn.close();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Xóa sản phẩm
    public boolean xoaSanPham(int maSanPham) {
        String sql = "DELETE FROM SanPham WHERE MaSanPham = ?";
        try {
            KetNoi kn = new KetNoi();
            kn.ketnoi();
            PreparedStatement stm = kn.cn.prepareStatement(sql);
            stm.setInt(1, maSanPham);

            int rowsDeleted = stm.executeUpdate();
            stm.close();
            kn.cn.close();
            return rowsDeleted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
