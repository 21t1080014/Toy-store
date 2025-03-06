package Controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import BangGiaModal.banggiaBO;

/**
 * Servlet implementation class ThemGiaController
 */
@WebServlet("/ThemGiaController")
public class ThemGiaController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ThemGiaController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 // Lấy dữ liệu từ form
        int maSanPham = Integer.parseInt(request.getParameter("maSanPham"));
        Long gia = Long.parseLong(request.getParameter("gia"));

        // Gọi lớp BO để thêm giá
        banggiaBO bangGiaBO = new banggiaBO();
        boolean isAdded = bangGiaBO.ThemGiachoSanPham(maSanPham, gia);

        // Kiểm tra kết quả thêm
        if (isAdded) {
            // Thêm thành công, chuyển hướng về trang quản lý giá
            response.sendRedirect("QuanLyGiaController?maSanPham=" + maSanPham);
        } else {
            // Thêm thất bại, thông báo lỗi và quay lại trang hiện tại
            request.setAttribute("error", "Thêm giá thất bại. Vui lòng thử lại.");
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
