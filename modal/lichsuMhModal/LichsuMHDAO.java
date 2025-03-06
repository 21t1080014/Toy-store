package lichsuMhModal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import DAO.KetNoi;

public class LichsuMHDAO {
	public ArrayList<LichsuMH> getLichSuMuaHang(int maKhachHang) {
        ArrayList<LichsuMH> list = new ArrayList<>();
        KetNoi kn = new KetNoi();
        kn.ketnoi();
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            // Kết nối tới cơ sở dữ liệu
            
            
            // Câu lệnh SQL để lấy dữ liệu từ view vw_LichSuMuaHang
            String sql = "SELECT MaSanPham, TenSanPham, GiaSanPham, SoLuongMua, ThanhTien, NgayMua, TrangThaiDonHang "
                       + "FROM vw_LichSuMuaHang "
                       + "WHERE MaKhachHang = ? "
                       + "ORDER BY NgayMua DESC"; // Sắp xếp theo ngày mua giảm dần (gần nhất trước)
            
            ps = kn.cn.prepareStatement(sql);
            ps.setInt(1, maKhachHang); // Truyền mã khách hàng vào câu truy vấn
            
            rs = ps.executeQuery();
            
            // Duyệt kết quả trả về từ ResultSet
            while (rs.next()) {
                String maSanPham = rs.getString("MaSanPham");
                String tenSanPham = rs.getString("TenSanPham");
                double giaSanPham = rs.getDouble("GiaSanPham");
                int soLuongMua = rs.getInt("SoLuongMua");
                double thanhTien = rs.getDouble("ThanhTien");
                String ngayMua = rs.getString("NgayMua");
                int trangThaiDonHang = rs.getInt("TrangThaiDonHang");

                // Tạo đối tượng LichsuMH và thêm vào danh sách
                LichsuMH lichSu = new LichsuMH(maSanPham, tenSanPham, giaSanPham, soLuongMua, thanhTien, ngayMua, trangThaiDonHang);
                list.add(lichSu);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Đóng kết nối và các tài nguyên
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (kn.cn != null) kn.cn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return list;
    }
}
