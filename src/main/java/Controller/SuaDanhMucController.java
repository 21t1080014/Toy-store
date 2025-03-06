package Controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import danhmuc.danhmucBO;

/**
 * Servlet implementation class SuaDanhMucController
 */
@WebServlet("/SuaDanhMucController")
public class SuaDanhMucController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SuaDanhMucController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
		// Lấy dữ liệu từ form
        int maDanhMuc = Integer.parseInt(request.getParameter("maDanhMuc"));
        String tenDanhMuc = request.getParameter("tenDanhMuc");
        String moTa = request.getParameter("moTa");
        byte trangThai = Byte.parseByte(request.getParameter("trangThai"));

        // Kiểm tra dữ liệu đầu vào
        if (tenDanhMuc == null || tenDanhMuc.trim().isEmpty()) {
            request.setAttribute("error", "Tên danh mục không được để trống");
            request.getRequestDispatcher("editCategory.jsp").forward(request, response);
            return;
        }

        // Tạo đối tượng DanhmucDAO và gọi phương thức sửa danh mục
        danhmucBO dao = new danhmucBO();
        boolean result = dao.suaDanhMuc(maDanhMuc, tenDanhMuc, moTa, trangThai);

        // Cung cấp thông báo
        if (result) {
            request.setAttribute("message", "Sửa danh mục thành công");
        } else {
            request.setAttribute("error", "Sửa danh mục thất bại");
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
