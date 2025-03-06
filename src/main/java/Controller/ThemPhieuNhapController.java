package Controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import PhieuNhapModal.phieunhapBO;
import sanphamModal.sanpham;
import sanphamModal.sanphamBO;

/**
 * Servlet implementation class ThemPhieuNhapController
 */
@WebServlet("/ThemPhieuNhapController")
public class ThemPhieuNhapController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ThemPhieuNhapController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String maSanPham = request.getParameter("maSanPham");
        int soLuongNhap = Integer.parseInt(request.getParameter("soLuongNhap"));
        //Date ngayNhap = Date.valueOf(request.getParameter("ngayNhap"));
        Long giaNhap = Long.parseLong(request.getParameter("giaNhap"));
        int maSP = Integer.parseInt(maSanPham);
        // Tạo đối tượng phiếu nhập mới
//        phieuNhap newPhieuNhap = new phieuNhap(maSanPham, soLuongNhap, giaNhap);
        
        phieunhapBO pnBO = new phieunhapBO();
        // Thêm phiếu nhập vào cơ sở dữ liệu (giả sử bạn có một service để xử lý)
        boolean isSuccess = pnBO.addPhieuNhap(maSP, soLuongNhap, giaNhap);

        // Kiểm tra nếu thêm thành công
        if (isSuccess) {
            request.setAttribute("message", "Thêm phiếu nhập thành công!");
        } else {
            request.setAttribute("error", "Lỗi khi thêm phiếu nhập.");
        }

        // Chuyển hướng lại trang quản lý phiếu nhập
        response.sendRedirect("QuanLyNhapHangController");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
