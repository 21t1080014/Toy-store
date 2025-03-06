package Controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import admin.DashboardBO;
import dangnhapAdminModal.dangnhapAdmin;

/**
 * Servlet implementation class DashboardController
 */
@WebServlet("/DashboardController")
public class DashboardController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DashboardController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		DashboardBO bo = new DashboardBO();
		dangnhapAdmin userad = (dangnhapAdmin) request.getSession().getAttribute("admin");
		
        if (userad != null) {
            // Nếu userad không phải null, truyền giá trị vào JSP
            request.setAttribute("admin", userad);
        } else {
            // Nếu userad là null, có thể chuyển hướng đến trang đăng nhập
            response.sendRedirect("DangNhapAdminController");
            return;
        }
       
        List<Map<String, Object>> doanhThu30Ngay = bo.getDoanhThu30Ngay();
//        request.setAttribute("doanhThu30Ngay", doanhThu30Ngay);
//        request.getRequestDispatcher("dashboard.jsp").forward(request, response);
        // Lấy dữ liệu
        int totalUsers = bo.getTotalUsers();
        int totalProducts = bo.getTotalProducts();
        int totalOrders = bo.getTotalOrder();
        int totalDanhMuc = bo.getTotalDanhMuc();

        request.setAttribute("doanhThu30Ngay", doanhThu30Ngay);
        request.setAttribute("totalUsers", totalUsers);
        request.setAttribute("totalProducts", totalProducts);
        request.setAttribute("totalOrders", totalOrders);
        request.setAttribute("totalDanhMuc", totalDanhMuc);

        // Chuyển tiếp về trang dashboard.jsp
        request.getRequestDispatcher("dashboard.jsp").forward(request, response);

        
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
