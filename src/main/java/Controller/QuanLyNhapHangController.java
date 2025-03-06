package Controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import PhieuNhapModal.phieuNhap;
import PhieuNhapModal.phieunhapBO;
import dangnhapAdminModal.dangnhapAdmin;
import danhmuc.danhmucBO;
import danhmuc.danhmuc_sp;
import sanphamModal.sanpham;
import sanphamModal.sanphamBO;

/**
 * Servlet implementation class QuanLyNhapHangController
 */
@WebServlet("/QuanLyNhapHangController")
public class QuanLyNhapHangController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public QuanLyNhapHangController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		dangnhapAdmin userad = (dangnhapAdmin) request.getSession().getAttribute("admin");
//		danhmucBO dmBO = new danhmucBO();
		phieunhapBO pnBO = new phieunhapBO();
        if (userad != null) {
            // Nếu userad không phải null, truyền giá trị vào JSP
            request.setAttribute("admin", userad);
//            ArrayList<danhmuc_sp> categories = dmBO.getDanhMuc();
            ArrayList<phieuNhap> dsphieu = pnBO.getAllPhieuNhap();
//            request.setAttribute("categories", categories);
            request.setAttribute("dsphieu", dsphieu);
            sanphamBO spBO = new sanphamBO();
            ArrayList<sanpham> dsSpham = spBO.getAllsanpham();
            request.setAttribute("dsSpham", dsSpham);
            // Chuyển hướng tới trang quản lý danh mục
            //request.getRequestDispatcher("quanlyDanhMuc.jsp").forward(request, response);
        } else {
            // Nếu userad là null, có thể chuyển hướng đến trang đăng nhập
            response.sendRedirect("DangNhapAdminController");
            return;
        }
        request.getRequestDispatcher("quanlyphieuNhap.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
