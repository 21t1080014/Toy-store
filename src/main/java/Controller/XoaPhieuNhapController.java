package Controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import PhieuNhapModal.phieunhapBO;

/**
 * Servlet implementation class XoaPhieuNhapController
 */
@WebServlet("/XoaPhieuNhapController")
public class XoaPhieuNhapController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public XoaPhieuNhapController() {
        super();
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy mã phiếu nhập từ request
        String maPhieuNhapStr = request.getParameter("maPhieuNhap");

        // Kiểm tra nếu mã phiếu nhập không hợp lệ
        if (maPhieuNhapStr == null || maPhieuNhapStr.isEmpty()) {
            // Gửi thông báo lỗi
            request.getSession().setAttribute("error", "Mã phiếu nhập không hợp lệ!");
            response.sendRedirect("QuanLyNhapHangController");
            return;
        }

        // Chuyển mã phiếu nhập về kiểu số nguyên
        int maPhieuNhap = Integer.parseInt(maPhieuNhapStr);

        // Tạo đối tượng BO để xử lý xóa
        phieunhapBO pnBO = new phieunhapBO();

        // Thực hiện xóa phiếu nhập
        boolean isDeleted = pnBO.deletePhieuNhap(maPhieuNhap);

        // Kiểm tra kết quả
        if (isDeleted) {
            // Xóa thành công
            request.getSession().setAttribute("message", "Xóa phiếu nhập thành công!");
        } else {
            // Xóa thất bại
            request.getSession().setAttribute("error", "Xóa phiếu nhập thất bại! Vui lòng kiểm tra lại.");
        }

        // Chuyển hướng về trang quản lý phiếu nhập
        request.getRequestDispatcher("QuanLyNhapHangController").forward(request, response);
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
