package Controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import BangGiaModal.banggiaBO;

/**
 * Servlet implementation class XoaGiaController
 */
@WebServlet("/XoaGiaController")
public class XoaGiaController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public XoaGiaController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String maGiaParam = request.getParameter("maGia");
        if (maGiaParam != null && !maGiaParam.isEmpty()) {
            int maGia = Integer.parseInt(maGiaParam); // Chuyển đổi từ String sang int

            // Tạo đối tượng dao để gọi phương thức xóa
            banggiaBO dao = new banggiaBO();

            // Thực hiện xóa giá
            boolean isDeleted = dao.XoaGiaSanPham(maGia);

            // Kiểm tra kết quả xóa và chuyển hướng đến trang phù hợp
            if (isDeleted) {
                // Nếu xóa thành công, chuyển hướng về trang danh sách sản phẩm
                response.sendRedirect("QuanLySanPhamController");
            } else {
                // Nếu xóa không thành công, thông báo lỗi
                request.setAttribute("error", "Không thể xóa giá này");
                request.getRequestDispatcher("QuanLySanPhamController").forward(request, response);
            }
        } else {
            // Nếu không có MaGia, thông báo lỗi
            request.setAttribute("error", "Mã giá không hợp lệ");
            request.getRequestDispatcher("QuanLySanPhamController").forward(request, response);
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
