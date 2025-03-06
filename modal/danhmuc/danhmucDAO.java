package danhmuc;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import DAO.KetNoi;

public class danhmucDAO {
	public ArrayList<danhmuc_sp> getDanhMuc(){
		ArrayList<danhmuc_sp> ds = new ArrayList<>();
        String sql = "SELECT * FROM DanhMucSanPham";
        try {
            KetNoi kn = new KetNoi();
            kn.ketnoi();
            PreparedStatement ps = kn.cn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                danhmuc_sp dm = new danhmuc_sp(
                    rs.getInt("MaDanhMuc"),
                    rs.getString("TenDanhMuc"),
                    rs.getString("MoTa"),
                    rs.getByte("TrangThai")
                );
                ds.add(dm);
            }
            rs.close();
            ps.close();
            kn.cn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ds;
	}
	
	public ArrayList<danhmuc_sp> getAllDanhMuc(){
		ArrayList<danhmuc_sp> ds = new ArrayList<>();
        String sql = "SELECT * FROM DanhMucSanPham WHERE TrangThai=1";
        try {
            KetNoi kn = new KetNoi();
            kn.ketnoi();
            PreparedStatement ps = kn.cn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                danhmuc_sp dm = new danhmuc_sp(
                    rs.getInt("MaDanhMuc"),
                    rs.getString("TenDanhMuc"),
                    rs.getString("MoTa"),
                    rs.getByte("TrangThai")
                );
                ds.add(dm);
            }
            rs.close();
            ps.close();
            kn.cn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ds;
	}
	
	public boolean themDanhMuc(String tenDanhMuc, String moTa) {
        String sql = "INSERT INTO DanhMucSanPham (TenDanhMuc, MoTa, TrangThai) VALUES (?, ?, 1)";
        try {
            KetNoi kn = new KetNoi();
            kn.ketnoi();
            PreparedStatement ps = kn.cn.prepareStatement(sql);
            ps.setString(1, tenDanhMuc);
            ps.setString(2, moTa);
//            ps.setByte(3, dm.getTrangThai());
            ps.executeUpdate();
            ps.close();
            kn.cn.close();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean suaDanhMuc( int maDanhMuc, String tenDanhMuc, String moTa, byte trangThai) {
        String sql = "UPDATE DanhMucSanPham SET TenDanhMuc = ?, MoTa = ?, TrangThai = ? WHERE MaDanhMuc = ?";
        try {
            KetNoi kn = new KetNoi();
            kn.ketnoi();
            PreparedStatement ps = kn.cn.prepareStatement(sql);
            ps.setString(1, tenDanhMuc);
            ps.setString(2, moTa);
            ps.setByte(3, trangThai);
            ps.setInt(4, maDanhMuc);
            ps.executeUpdate();
            ps.close();
            kn.cn.close();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean xoaDanhMuc(int maDanhMuc) {
        String sql = "DELETE FROM DanhMucSanPham WHERE MaDanhMuc = ?";
        try {
            KetNoi kn = new KetNoi();
            kn.ketnoi();
            PreparedStatement ps = kn.cn.prepareStatement(sql);
            ps.setInt(1, maDanhMuc);
            ps.executeUpdate();
            ps.close();
            kn.cn.close();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
