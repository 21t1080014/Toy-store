package dangnhapAdminModal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import DAO.KetNoi;

public class dangnhapAdminDAO {
	public dangnhapAdmin DangNhap(String use , String pass) {
		dangnhapAdmin ad = null;
        try {
            // Kết nối cơ sở dữ liệu
            KetNoi kn = new KetNoi();
            kn.ketnoi();
            Connection cn = kn.cn;

            // SQL truy vấn
            String sql = "SELECT * FROM DangNhap WHERE Username = ? AND Password = ?";
            PreparedStatement ps = cn.prepareStatement(sql);
            ps.setString(1, use);
            ps.setString(2, pass);

            // Thực thi truy vấn
            ResultSet rs = ps.executeQuery();

            // Xử lý kết quả
            if (rs.next()) {
                ad = new dangnhapAdmin();
                ad.setUsername(rs.getString("Username"));
                ad.setPassword(rs.getString("Password"));
                // Nếu có thêm các thuộc tính khác, set thêm tại đây
            }

            // Đóng các tài nguyên
            rs.close();
            ps.close();
            cn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ad;
	}
}
