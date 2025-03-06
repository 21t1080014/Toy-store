package Controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DhangModal.DHang;
import DhangModal.DonHangDAO;

/**
 * Servlet implementation class ConfirmDonHangController
 */
@WebServlet("/ConfirmDonHangController")
public class ConfirmDonHangController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ConfirmDonHangController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Lấy maDonHang từ request
        String maDonHang = request.getParameter("maDonHang");

        if (maDonHang != null && !maDonHang.isEmpty()) {
            // Khởi tạo DAO để xử lý đơn hàng
            DonHangDAO donHangDAO = new DonHangDAO();
            
            // Xác nhận đơn hàng bằng mã đơn hàng
            boolean isConfirmed = donHangDAO.XacNhanDH(maDonHang);
            
            if (isConfirmed) {
                // Nếu xác nhận thành công, thông báo thành công
                request.setAttribute("message", "Đơn hàng #" + maDonHang + " đã được xác nhận!");
            } else {
                // Nếu không thành công, thông báo lỗi
                request.setAttribute("message", "Xác nhận đơn hàng #" + maDonHang + " thất bại!");
            }
        } else {
            // Nếu mã đơn hàng không hợp lệ
            request.setAttribute("message", "Mã đơn hàng không hợp lệ!");
        }

        // Chuyển hướng lại trang quản lý đơn hàng (QuanLyDonHangController)
        request.getRequestDispatcher("QuanLyXacNhanController").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
