package Controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import hangModal.CgioHang;



/**
 * Servlet implementation class nhanHangController
 */
@WebServlet("/nhanHangController")
public class nhanHangController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public nhanHangController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
	    response.setCharacterEncoding("UTF-8");
	    
	    String ms = request.getParameter("ms");
	    String th = request.getParameter("th");
	    String gia = request.getParameter("gia");
	    String sl = request.getParameter("sl");

	    if (th != null && gia != null && sl != null) {
	        HttpSession session = request.getSession();
	        
	        // Lấy giỏ hàng từ session
	        CgioHang gh = (CgioHang) session.getAttribute("gh");
	        
	        // Nếu giỏ hàng chưa tồn tại thì tạo mới
	        if (gh == null) {
	            gh = new CgioHang();
	            session.setAttribute("gh", gh);
	        }

	        // Chuyển đổi giá trị số lượng và giá sang kiểu int
	        Long giaInt = Long.parseLong(gia);
	        int slInt = Integer.parseInt(sl);
	        int msInt = Integer.parseInt(ms);
	        // Thêm sản phẩm vào giỏ hàng
	        gh.Them(msInt,th, giaInt, slInt);

	        // Đặt giỏ hàng vào session
	        session.setAttribute("gh", gh);

	        // Đặt thông báo thành công vào request
	        request.setAttribute("thanhcong", "Sản phẩm đã được thêm vào giỏ hàng!");

	        // Chuyển tiếp đến giohangController
	        response.sendRedirect("GioHangController");
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
