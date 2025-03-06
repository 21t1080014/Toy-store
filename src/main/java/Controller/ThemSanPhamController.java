package Controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import sanphamModal.sanphamDAO;

/**
 * Servlet implementation class ThemSanPhamController
 */
@WebServlet("/ThemSanPhamController")
public class ThemSanPhamController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ThemSanPhamController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		DiskFileItemFactory factory = new DiskFileItemFactory();
        ServletFileUpload upload = new ServletFileUpload(factory);
		// Lấy dữ liệu từ form
//        String tenSanPham = request.getParameter("tenSanPham");
//        int maDanhMuc = Integer.parseInt(request.getParameter("maDanhMuc"));
//        String moTa = request.getParameter("moTa");
//        String hinhAnh = request.getParameter("hinhAnh");
//        byte trangThai = Byte.parseByte(request.getParameter("trangThai"));
//        int soLuong = Integer.parseInt(request.getParameter("soLuong"));
        String tenSanPham = null;
        int maDanhMuc = 0;
        String moTa = null;
        String hinhAnh = null;
        byte trangThai = 0;
        int soLuong = 0;
//        Date ngayTao = new Date(); // Lấy ngày hiện tại
        try {
            List<FileItem> fileItems = upload.parseRequest(request);

            for (FileItem item : fileItems) {
                if (item.isFormField()) {
                    // Xử lý các trường dữ liệu (không phải file)
                    switch (item.getFieldName()) {
                        case "tenSanPham":
                            tenSanPham = item.getString("UTF-8");
                            break;
                        case "maDanhMuc":
                            maDanhMuc = Integer.parseInt(item.getString());
                            break;
                        case "moTa":
                            moTa = item.getString("UTF-8");
                            break;
                        case "trangThai":
                            trangThai = Byte.parseByte(item.getString());
                            break;
                        case "soLuong":
                            soLuong = Integer.parseInt(item.getString());
                            break;
                    }
                } else {
                    // Xử lý file upload
                    if (!item.getName().isEmpty()) {
                        String uploadPath = request.getServletContext().getRealPath("") + File.separator + "uploads";
                        File uploadDir = new File(uploadPath);
                        if (!uploadDir.exists()) {
                            uploadDir.mkdir();
                        }
                        hinhAnh = "uploads/" + item.getName();
                        File file = new File(uploadPath + File.separator + item.getName());
                        item.write(file);
                    }
                }
                
            }


        // Tạo đối tượng DAO
        sanphamDAO dao = new sanphamDAO();

        // Gọi phương thức thêm sản phẩm
        boolean success = dao.themSanPham(tenSanPham, maDanhMuc, moTa, hinhAnh, trangThai, soLuong);

        if (success) {
            // Thêm thành công, chuyển hướng đến danh sách sản phẩm
        	response.sendRedirect("QuanLySanPhamController");
        } else {
            // Thêm thất bại, hiển thị thông báo lỗi
            request.setAttribute("errorMessage", "Thêm sản phẩm thất bại!");
            request.getRequestDispatcher("QuanLySanPhamController").forward(request, response);
        }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi khi thêm sản phẩm!");
            request.getRequestDispatcher("QuanLySanPhamController").forward(request, response);
        }
//        request.getRequestDispatcher("QuanLySanPhamController").forward(request, response);

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
