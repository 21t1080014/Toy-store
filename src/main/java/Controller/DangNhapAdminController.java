package Controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import dangnhapAdminModal.dangnhapAdmin;
import dangnhapAdminModal.dangnhapAdminDAO;

/**
 * Servlet implementation class DangNhapAdminController
 */
@WebServlet("/DangNhapAdminController")
public class DangNhapAdminController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DangNhapAdminController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Lấy thông tin từ form
        String username = request.getParameter("Admin_dn");
        String password = request.getParameter("Admin_mk");

        // Tạo đối tượng DAO để kiểm tra thông tin đăng nhập
        dangnhapAdminDAO dangNhapDao = new dangnhapAdminDAO();
        dangnhapAdmin admin = dangNhapDao.DangNhap(username, password);

        if (admin != null) {
            // Nếu đăng nhập thành công, lưu thông tin vào session
            HttpSession session = request.getSession();
            session.setAttribute("admin", admin);
            session.setAttribute("username",username );
            // Chuyển hướng đến trang quản trị hoặc trang chính
            response.sendRedirect("DashboardController");
        } else {
            // Nếu đăng nhập thất bại, gửi thông báo lỗi về trang đăng nhập
            request.setAttribute("errorMessage", "Sai tên đăng nhập hoặc mật khẩu!");
            request.getRequestDispatcher("DangNhapAD.jsp").forward(request, response);
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
