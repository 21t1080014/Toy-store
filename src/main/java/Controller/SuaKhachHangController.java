package Controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import khachhang.khachhangBO;

/**
 * Servlet implementation class SuaKhachHangController
 */
@WebServlet("/SuaKhachHangController")
public class SuaKhachHangController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SuaKhachHangController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
		
            // Lấy thông tin từ request
            int maKhachHang = Integer.parseInt(request.getParameter("maKhachHang"));
            String tenKhachHang = request.getParameter("tenKhachHang");
            String tenDN = request.getParameter("tenDN");
            String email = request.getParameter("email");
            String soDienThoai = request.getParameter("soDienThoai");
            String trangThaiStr = request.getParameter("trangThai");
            String diaChi = request.getParameter("diaCHi");

            // Kiểm tra các giá trị không null hoặc hợp lệ
            if (tenKhachHang == null || email == null || soDienThoai == null
                    || trangThaiStr == null || diaChi == null) {
                request.setAttribute("error", "Dữ liệu không hợp lệ.");
                request.getRequestDispatcher("QuanLyNguoiDungController").forward(request, response);
                return;
            }

            byte trangThai = Byte.parseByte(trangThaiStr);

            // Tạo đối tượng DAO để cập nhật dữ liệu
            khachhangBO khachHangDAO = new khachhangBO();
            boolean isUpdated = khachHangDAO.suaTaiKhoan(maKhachHang, tenKhachHang, email, soDienThoai, diaChi, tenDN, trangThai);

            // Kiểm tra kết quả cập nhật
            if (isUpdated) {
                // Nếu thành công, chuyển hướng về trang danh sách khách hàng
                response.sendRedirect("QuanLyNguoiDungController");
            } else {
                // Nếu thất bại, hiển thị thông báo lỗi
                request.setAttribute("error", "Không thể cập nhật khách hàng.");
                request.getRequestDispatcher("QuanLyNguoiDungController").forward(request, response);
            }
        
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
