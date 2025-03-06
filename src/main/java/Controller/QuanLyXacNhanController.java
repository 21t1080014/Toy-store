package Controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DhangModal.DHang;
import DhangModal.DonHangDAO;
import dangnhapAdminModal.dangnhapAdmin;
import khachhang.khachhang;
import khachhang.khachhangBO;

/**
 * Servlet implementation class QuanLyXacNhanController
 */
@WebServlet("/QuanLyXacNhanController")
public class QuanLyXacNhanController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public QuanLyXacNhanController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		dangnhapAdmin userad = (dangnhapAdmin) request.getSession().getAttribute("admin");
		khachhangBO dmBO = new khachhangBO();
        if (userad != null) {
            // Nếu userad không phải null, truyền giá trị vào JSP
            request.setAttribute("admin", userad);
            DonHangDAO donHangDAO = new DonHangDAO();
            List<DHang> donHangList = donHangDAO.getAllDonHang();
            ArrayList<DHang> dsQuaHan = donHangDAO.getQuaHan();
            
            // Truyền dữ liệu danh sách đơn hàng quá hạn đến trang JSP
            request.setAttribute("dsQuaHan", dsQuaHan);
            // Đưa danh sách đơn hàng vào request
            request.setAttribute("donHangList", donHangList);
           
            //request.getRequestDispatcher("quanlyDanhMuc.jsp").forward(request, response);
        } else {
            // Nếu userad là null, có thể chuyển hướng đến trang đăng nhập
            response.sendRedirect("DangNhapAdminController");
            return;
        }// Lấy danh sách đơn hàng cần xác nhận
        

        // Chuyển tiếp (forward) sang trang xacnhan.jsp
        RequestDispatcher dispatcher = request.getRequestDispatcher("xacnhan.jsp");
        dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
