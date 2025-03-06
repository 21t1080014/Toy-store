package HoaDon;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

import DAO.KetNoi;

public class HoadonDAO {
    public int Them(int makh, double tongTien) {
        // Câu lệnh SQL để thêm dữ liệu vào bảng DonHang
        String sql = "INSERT INTO DonHang (MaKhachHang, NgayDatHang, TongTien, TrangThai) VALUES (?, ?, ?, 0)";
        
        // Kết nối đến cơ sở dữ liệu
        KetNoi kn = new KetNoi();
        kn.ketnoi(); // Mở kết nối

        if (kn.cn == null) {
            System.err.println("Kết nối không thành công.");
            return 0; // Nếu kết nối không thành công, trả về 0
        }

        int kq = 0;
        PreparedStatement sm = null;
        try {
            sm = kn.cn.prepareStatement(sql);
            sm.setInt(1, makh); // Cài đặt MaKhachHang
//            sm.setDate(2, new java.sql.Date(new Date().getTime())); // Cài đặt NgayDatHang
            sm.setTimestamp(2, new java.sql.Timestamp(new Date().getTime()));
            sm.setDouble(3, tongTien); // Cài đặt TongTien

            kq = sm.executeUpdate(); // Thực thi câu lệnh SQL để thêm dữ liệu vào bảng
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (sm != null) sm.close(); // Đóng PreparedStatement
                if (kn.cn != null) kn.cn.close(); // Đóng kết nối
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return kq; // Trả về kết quả thực thi câu lệnh
    }
    public Long getMaDonHangMax() {
        KetNoi kn = new KetNoi(); // Lấy kết nối từ lớp KetNoi
        kn.ketnoi();
        String sql = "SELECT MAX(MaDonHang) AS maxDonHang FROM DonHang"; // Truy vấn để lấy MaDonHang lớn nhất
        long maxDonHang = 0;
        try (PreparedStatement sm = kn.cn.prepareStatement(sql);
             ResultSet rs = sm.executeQuery()) {
            if (rs.next()) {
                maxDonHang = rs.getLong("maxDonHang"); // Lấy giá trị max(MaDonHang)
            } else {
                System.out.println("Không có giá trị max(MaDonHang).");
            }kn.cn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return maxDonHang; // Trả về mã đơn hàng lớn nhất
    }
}
