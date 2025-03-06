package Controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import danhmuc.danhmucBO;
import danhmuc.danhmucDAO;

/**
 * Servlet implementation class ThemDanhMucController
 */
@WebServlet("/ThemDanhMucController")
public class ThemDanhMucController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ThemDanhMucController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Lấy dữ liệu từ form (hoặc từ modal)
		request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        String tenDanhMuc = request.getParameter("tenDanhMuc");
        String moTa = request.getParameter("moTa");

        // Kiểm tra dữ liệu đầu vào
        if (tenDanhMuc == null || tenDanhMuc.trim().isEmpty()) {
            request.setAttribute("error", "Tên danh mục không được để trống");
            request.getRequestDispatcher("addCategory.jsp").forward(request, response);
            return;
        }

        // Tạo đối tượng DanhMucDAO và gọi phương thức thêm danh mục
        danhmucBO dao = new danhmucBO();
        boolean result = dao.themDanhMuc(tenDanhMuc, moTa);

        // Cung cấp thông báo
        if (result) {
            request.setAttribute("message", "Thêm danh mục thành công");
        } else {
            request.setAttribute("error", "Thêm danh mục thất bại");
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
