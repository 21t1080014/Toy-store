package Controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import danhmuc.danhmucBO;
import danhmuc.danhmuc_sp;
import khachhang.khachhang;
import lichsuMhModal.LichsuMH;
import lichsuMhModal.lissshmuaBO;


/**
 * Servlet implementation class lichsumhController
 */
@WebServlet("/lichsumhController")
public class lichsumhController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public lichsumhController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		danhmucBO lbo = new danhmucBO();
		ArrayList<danhmuc_sp> listbo = lbo.getAllDanhMuc();
		request.setAttribute("listbo", listbo);
		lissshmuaBO ls = new lissshmuaBO();
		if(session.getAttribute("kh")!= null) {
			khachhang kh = (khachhang) session.getAttribute("kh");
			ArrayList<LichsuMH> ds = ls.getLichSuMuaHang(kh.getMaKhachHang());
			session.setAttribute("lichsudonhang", ds);
			RequestDispatcher rd = request.getRequestDispatcher("lichsumua.jsp");
			rd.forward(request, response);
			
		}else {
			response.sendRedirect("DangNhapController");
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
