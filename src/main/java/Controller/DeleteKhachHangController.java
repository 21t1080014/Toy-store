package Controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import danhmuc.danhmucBO;
import khachhang.khachhangBO;

/**
 * Servlet implementation class DeleteKhachHangController
 */
@WebServlet("/DeleteKhachHangController")
public class DeleteKhachHangController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteKhachHangController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int maKhachHang = Integer.parseInt(request.getParameter("maKhachHang"));
		// Xử lý xóa danh mục
        khachhangBO dao = new khachhangBO();
        boolean result = dao.xoaTaiKhoan(maKhachHang);

        // Cung cấp thông báo
        if (result) {
            request.setAttribute("message", "Xóa danh mục thành công");
        } else {
            request.setAttribute("error", "Xóa danh mục thất bại");
        }

        // Quay lại trang danh mục
        response.sendRedirect("QuanLyDanhMucController");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
