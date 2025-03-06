package Controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dangnhapAdminModal.dangnhapAdmin;
import danhmuc.danhmucBO;
import danhmuc.danhmuc_sp;

/**
 * Servlet implementation class QuanLyDanhMucController
 */
@WebServlet("/QuanLyDanhMucController")
public class QuanLyDanhMucController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public QuanLyDanhMucController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		dangnhapAdmin userad = (dangnhapAdmin) request.getSession().getAttribute("admin");
		danhmucBO dmBO = new danhmucBO();
        if (userad != null) {
            // Nếu userad không phải null, truyền giá trị vào JSP
            request.setAttribute("admin", userad);
            ArrayList<danhmuc_sp> categories = dmBO.getDanhMuc();
            request.setAttribute("categories", categories);
            
            // Chuyển hướng tới trang quản lý danh mục
            //request.getRequestDispatcher("quanlyDanhMuc.jsp").forward(request, response);
        } else {
            // Nếu userad là null, có thể chuyển hướng đến trang đăng nhập
            response.sendRedirect("DangNhapAdminController");
            return;
        }
        request.getRequestDispatcher("quanlyDanhMuc.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
