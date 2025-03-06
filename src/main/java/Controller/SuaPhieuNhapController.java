package Controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import PhieuNhapModal.phieunhapBO;

/**
 * Servlet implementation class SuaPhieuNhapController
 */
@WebServlet("/SuaPhieuNhapController")
public class SuaPhieuNhapController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SuaPhieuNhapController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String maPhieu = request.getParameter("maPhieu");
        String maSanPham = request.getParameter("maSanPham");
        String soLuongNhapStr = request.getParameter("soLuongNhap");
        //String ngayNhap = request.getParameter("ngayNhap");
        String giaNhapStr = request.getParameter("giaNhap");

        // Kiểm tra dữ liệu đầu vào
        if (maPhieu == null || maSanPham == null || soLuongNhapStr == null  || giaNhapStr == null) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin!");
            request.getRequestDispatcher("QuanLyNhapHangController").forward(request, response);
            return;
        }
        int maP = Integer.parseInt(maPhieu);
        int masp = Integer.parseInt(maSanPham);
        int soLuongNhap = Integer.parseInt(soLuongNhapStr);
        Long giaNhap = Long.parseLong(giaNhapStr);
        phieunhapBO bo = new phieunhapBO();
        // Cập nhật dữ liệu vào cơ sở dữ liệu
        boolean result = bo.updatePhieuNhap(maP, masp, soLuongNhap, giaNhap);
        if (result) {
        	request.setAttribute("error", "Sửa phiếu nhập tt!");
        } else {
            request.setAttribute("error", "Sửa phiếu nhập thất bại!");
            
        }
        request.getRequestDispatcher("QuanLyNhapHangController").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
