package Controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import BangGiaModal.BangGia;
import BangGiaModal.banggiaBO;

/**
 * Servlet implementation class QuanLyGiaController
 */
@WebServlet("/QuanLyGiaController")
public class QuanLyGiaController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public QuanLyGiaController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Lấy mã sản phẩm từ tham số URL
        int maSanPham = Integer.parseInt(request.getParameter("maSanPham"));
        
        // Lấy danh sách giá của sản phẩm từ dịch vụ
        banggiaBO bangGiaBO = new banggiaBO();
        ArrayList<BangGia> dsGia = bangGiaBO.layBangGiaTheoSanPham(maSanPham);
        
            request.setAttribute("dsGia", dsGia);
            request.setAttribute("maSanPham", maSanPham);
        
        // Forward tới trang hiển thị giá
        request.getRequestDispatcher("quanlyGia.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
