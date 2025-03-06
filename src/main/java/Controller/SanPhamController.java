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

import SanphamGia.sanphamGia;
import SanphamGia.sanphamGiaBO;
import danhmuc.danhmucBO;
import danhmuc.danhmuc_sp;

import sanphamModal.sanphamBO;

/**
 * Servlet implementation class SanPhamController
 */
@WebServlet("/SanPhamController")
public class SanPhamController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SanPhamController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String currentURL =  request.getRequestURI(); 
		HttpSession session = request.getSession();
		session.setAttribute("trang", currentURL);
		danhmucBO lbo = new danhmucBO();
		
//		int trangmacdinh = 1;
		//int trangmacdinh = request.getParameter("currentPage") != null ? Integer.parseInt(request.getParameter("currentPage")) : 1;
		int trangmacdinh = request.getParameter("trangmacdinh") != null ? Integer.parseInt(request.getParameter("trangmacdinh")) : 1;
		ArrayList<danhmuc_sp> listbo = lbo.getAllDanhMuc();
		request.setAttribute("listbo", listbo);
		
		sanphamGiaBO sbo = new sanphamGiaBO();
		ArrayList<sanphamGia> hien = sbo.getAllSanphamGias(trangmacdinh);
		int totalItems = sbo.coutSanpham();
		String ml = request.getParameter("ml");
		String search = request.getParameter("search");
		if(search != null && !search.isEmpty()){
			hien = sbo.Tim(search,trangmacdinh);
			totalItems = sbo.count_Tim(search);
			System.out.println(totalItems);
		}else if(ml!=null){
			hien=sbo.TimLoai(trangmacdinh,ml);
			totalItems = sbo.countSach_loai(ml);
			}
		 // Lấy tổng số sách
	    int tongTrang = (int) Math.ceil((double) totalItems / 6);
	    request.setAttribute("ml", ml);
	    request.setAttribute("search", search);
	    request.setAttribute("tongTrang", tongTrang);
	    request.setAttribute("currentPage", trangmacdinh);
		request.setAttribute("hien", hien);
		RequestDispatcher rd = request.getRequestDispatcher("trangChu.jsp");
        rd.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
