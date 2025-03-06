package Controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DhangModal.DonHangDAO;

/**
 * Servlet implementation class DeleteDonHangControlle
 */
@WebServlet("/DeleteDonHangControlle")
public class DeleteDonHangControlle extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteDonHangControlle() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		DonHangDAO service = new DonHangDAO();
        boolean isDeleted = service.deleteAll(); // Gọi phương thức xóa

        if (isDeleted) {
            // Xử lý thành công, chuyển hướng lại trang danh sách đơn hàng quá hạn
            response.sendRedirect("QuanLyXacNhanController");  // Chuyển hướng đến trang cần thiết
        } else {
            // Xử lý thất bại, có thể hiển thị thông báo lỗi
            request.setAttribute("error", "Có lỗi xảy ra khi xóa các đơn hàng quá hạn.");
            request.getRequestDispatcher("QuanLyXacNhanController").forward(request, response); // Chuyển hướng tới trang lỗi
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
