package Controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import danhmuc.danhmucBO;

/**
 * Servlet implementation class DeleteDanhMucController
 */
@WebServlet("/DeleteDanhMucController")
public class DeleteDanhMucController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteDanhMucController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Lấy mã danh mục cần xóa
        int maDanhMuc = Integer.parseInt(request.getParameter("maDanhMuc"));

        // Xử lý xóa danh mục
        danhmucBO dao = new danhmucBO();
        boolean result = dao.xoaDanhMuc(maDanhMuc);

        // Cung cấp thông báo
        if (result) {
            request.setAttribute("message", "Xóa danh mục thành công");
        } else {
            request.setAttribute("error", "Xóa danh mục thất bại");
        }

        // Quay lại trang danh mục
        response.sendRedirect("QuanLyNguoiDungController");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
