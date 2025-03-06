package Controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import SanphamGia.sanphamGia;
import SanphamGia.sanphamGiaDAO;
import danhmuc.danhmucBO;
import danhmuc.danhmuc_sp;

/**
 * Servlet implementation class XemChiTietController
 */
@WebServlet("/XemChiTietController")
public class XemChiTietController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public XemChiTietController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
int maSanPham = Integer.parseInt(request.getParameter("ms"));
 danhmucBO lbo = new danhmucBO();
ArrayList<danhmuc_sp> listbo = lbo.getAllDanhMuc();
request.setAttribute("listbo", listbo);
        sanphamGiaDAO dao = new sanphamGiaDAO();
        sanphamGia sanPham = dao.getSanPhamById(maSanPham);
        
        request.setAttribute("sanPham", sanPham);
        request.getRequestDispatcher("XemChiTiet.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
