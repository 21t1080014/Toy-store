package Controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import danhmuc.danhmucBO;
import sanphamModal.sanphamBO;

/**
 * Servlet implementation class XoaSanPhamController
 */
@WebServlet("/XoaSanPhamController")
public class XoaSanPhamController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public XoaSanPhamController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int maSanPham = Integer.parseInt(request.getParameter("maSanPham"));

        // Xử lý xóa danh mục
        sanphamBO dao = new sanphamBO();
        boolean result = dao.xoaSanPham(maSanPham);

        // Cung cấp thông báo
        if (result) {
            request.setAttribute("message", "Xóa  thành công");
        } else {
            request.setAttribute("error", "Xóa  thất bại");
        }

        // Quay lại trang danh mục
        response.sendRedirect("QuanLySanPhamController");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
