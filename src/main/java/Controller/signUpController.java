package Controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import khachhang.khachhang;
import khachhang.khachhangBO;
//import khachhangModal.khachhang;
//import khachhangModal.khachhangdao;

/**
 * Servlet implementation class signUpController
 */
@WebServlet("/signUpController")
public class signUpController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public signUpController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Lấy dữ liệu từ form đăng ký
				request.setCharacterEncoding("UTF-8");
				response.setCharacterEncoding("UTF-8");
		        String hoten = request.getParameter("hoten");
		        String diachi = request.getParameter("diachi");
		        String sodt = request.getParameter("sodt");
		        String email = request.getParameter("email");
		        String tendn = request.getParameter("username");
		        String pass = request.getParameter("password");
		        
		        // Khởi tạo đối tượng khachhangdao
		        khachhangBO khDao = new khachhangBO();

		        // Gọi phương thức Taotaikhoan để thực hiện đăng ký
		        boolean success = khDao.themTaiKhoan(hoten,email ,pass ,sodt,diachi , tendn );
				HttpSession session = request.getSession();
				String url = (String) session.getAttribute("trang");
		        // Kiểm tra kết quả và chuyển hướng trang
		        if (success) {
		        	
		        	session.setAttribute("un", tendn);
		        	khachhang kh = khDao.LayThongTinKhachHang(tendn);
		        	// Đăng ký thành công, chuyển hướng về trang đăng nhập hoặc trang chính
		        	session.setAttribute("kh", kh);
		            response.sendRedirect(url); // Chuyển hướng đến trang chính
		        } else {
		        	// Đảm bảo URL không có đường dẫn trùng lặp (ví dụ: không có /Nhom_8/Nhom_8/)
		            if (url.startsWith("/Nhom_8/")) {
		                url = url.substring("/Nhom_8".length()); // Xóa phần dư thừa nếu có
		            }
		            RequestDispatcher dispatcher = request.getRequestDispatcher(url);
		            dispatcher.forward(request, response);
		            
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
