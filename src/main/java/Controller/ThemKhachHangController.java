package Controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import khachhang.khachhang;
import khachhang.khachhangBO;

/**
 * Servlet implementation class ThemKhachHangController
 */
@WebServlet("/ThemKhachHangController")
public class ThemKhachHangController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ThemKhachHangController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
     // Lấy dữ liệu từ form
        String tenKhachHang = request.getParameter("tenKhachHang");
        String email = request.getParameter("email");
        String soDienThoai = request.getParameter("soDienThoai");
        String diaChi = request.getParameter("diaCHi");
        String tenDangNhap = request.getParameter("tenDN");
        String matKhau = request.getParameter("pass");
        
        if (tenKhachHang==null || email==null || soDienThoai==null || diaChi.isEmpty() || tenDangNhap==null || matKhau==null) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin khách hàng.");
            request.getRequestDispatcher("QuanLyNguoiDungController").forward(request, response); 
            return;
        }
        // Kiểm tra dữ liệu có hợp lệ không (tùy chọn)
        if (tenKhachHang.isEmpty() || email.isEmpty() || soDienThoai.isEmpty() || diaChi.isEmpty() || tenDangNhap.isEmpty() || matKhau.isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin khách hàng.");
            request.getRequestDispatcher("QuanLyNguoiDungController").forward(request, response); 
            return;
        }
        
        khachhangBO Bo = new khachhangBO();
        boolean result = Bo.themTaiKhoan(tenKhachHang, email, matKhau, soDienThoai, diaChi,  tenDangNhap);
        
        if (result) {
            request.setAttribute("message", "Thêm danh mục thành công");
        } else {
            request.setAttribute("error", "Thêm danh mục thất bại");
        }

        // Quay lại trang danh mục
        response.sendRedirect("QuanLyNguoiDungController");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
