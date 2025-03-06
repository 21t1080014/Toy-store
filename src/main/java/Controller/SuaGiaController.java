package Controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import BangGiaModal.banggiaBO;

/**
 * Servlet implementation class SuaGiaController
 */
@WebServlet("/SuaGiaController")
public class SuaGiaController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SuaGiaController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Lấy thông tin từ form
        String maGiaStr = request.getParameter("maGia");
        String giaStr = request.getParameter("gia");
        String maSanPhamStr = request.getParameter("maSanPham1"); // Lấy mã sản phẩm từ request
        int maSanPham = 0;
        // Kiểm tra đầu vào hợp lệ
        if (maGiaStr == null || maGiaStr.isEmpty() || giaStr == null || giaStr.isEmpty()) {
            request.setAttribute("errorMessage", "Thông tin không được để trống!");
            request.getRequestDispatcher("QuanLyGia.jsp").forward(request, response);
            return;
        }

        // Chuyển đổi kiểu dữ liệu
        int maGia = Integer.parseInt(maGiaStr);
        Long gia = Long.parseLong(giaStr);
        maSanPham = Integer.parseInt(maSanPhamStr);

        // Gọi DAO để cập nhật giá
        banggiaBO dao = new banggiaBO();
        boolean result = dao.SuaGiaSanPham(maGia, gia);

        if (result) {
            // Nếu cập nhật thành công, chuyển hướng lại trang quản lý giá
        	response.sendRedirect("QuanLyGiaController?maSanPham=" + maSanPham);
        } else {
            // Nếu thất bại, thông báo lỗi
            request.setAttribute("errorMessage", "Cập nhật giá thất bại!");
            response.sendRedirect("QuanLyGiaController?maSanPham=" + maSanPham);
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
