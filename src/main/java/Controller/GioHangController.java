package Controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import ChiTietHoaDon.CThoadoBO;
import ChiTietHoaDon.CThoadonBo;
import HoaDon.hoadoBO;

import danhmuc.danhmucBO;
import danhmuc.danhmuc_sp;
import hangModal.CgioHang;
import hangModal.Hang;
import khachhang.khachhang;

/**
 * Servlet implementation class GioHangController
 */
@WebServlet("/GioHangController")
public class GioHangController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GioHangController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		danhmucBO lbo = new danhmucBO();
        ArrayList<danhmuc_sp> listbo = lbo.getAllDanhMuc();
        request.setAttribute("listbo", listbo);
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        RequestDispatcher rd = request.getRequestDispatcher("Giohang.jsp");

        // Lấy giỏ hàng từ session
        CgioHang gh = (CgioHang) session.getAttribute("gh");
        
        // Nếu giỏ hàng chưa có, tạo mới giỏ hàng
        if (gh == null) {
            gh = new CgioHang();
            session.setAttribute("gh", gh);
        }

        // Lấy action từ request để xử lý các thao tác
        String action = request.getParameter("action");

        if (gh != null) {
            if ("xoachon".equals(action)) {
                // Xử lý xóa sản phẩm theo checkbox
                String[] hangchon = request.getParameterValues("hangg");
                if (hangchon != null) {
                    for (String tenh : hangchon) {
                        gh.Xoa(tenh);
                    }
                    session.setAttribute("gh", gh);
                }
            } else if ("xoa".equals(action)) {
                // Xóa một sản phẩm cụ thể
                String tenh = request.getParameter("item");
                if (tenh != null && !tenh.isEmpty()) {
                    gh.Xoa(tenh);
                    session.setAttribute("gh", gh);
                }
            } else if ("sua".equals(action)) {
                // Xử lý sửa số lượng sản phẩm
                Enumeration<String> params = request.getParameterNames();
                while (params.hasMoreElements()) {
                    String paramName = params.nextElement();
                    if (paramName.startsWith("txtsua_")) {
                        String tenHang = paramName.substring(7); // Lấy tên hàng
                        int sll = Integer.parseInt(request.getParameter(paramName)); // Lấy số lượng mới
                        for (Hang hang : gh.ds) {
                            if (hang.getTxtth().equals(tenHang)) {
                                hang.setTxtsl(sll);
                                hang.setThanhtien(hang.getTxtg() * sll); // Cập nhật thành tiền
                                break;
                            }
                        }
                    }
                }
                session.setAttribute("gh", gh);
            } else if ("xoaall".equals(action)) {
                // Xóa toàn bộ giỏ hàng
                session.removeAttribute("gh");
            } else if ("dathang".equals(action)) {
                khachhang kh = (khachhang) session.getAttribute("kh");
                if (kh == null) {
                    
                    response.sendRedirect("DangNhapController");
                    return;
                } else {
                    hoadoBO hdbo = new hoadoBO();
                    CThoadoBO ctbo = new CThoadoBO();

                    if (gh != null && !gh.ds.isEmpty()) {
                        try {
                            
                            hdbo.Them(kh.getMaKhachHang(),gh.TongTien());

                            
                            Long maHD = hdbo.getMaDonHangMax();
                            if(maHD == null) {
                            	System.out.println("maHD bị null"+maHD);
                            }else {
                            	System.out.println("maHD không bị null" + maHD);
                            }
                            
                            for (Hang h: gh.ds) {
                                ctbo.Them(h.getMasach(), h.getTxtsl(), maHD, h.getTxtg());
                            }

                            
                            session.removeAttribute("gh");

                            
                            request.setAttribute("thanhcong", "Đặt hàng thành công!");
                            rd.forward(request, response);
                            return;
                        } catch (Exception e) {
                            e.printStackTrace();
                            request.setAttribute("error", "Đã xảy ra lỗi khi đặt hàng.");
                            rd.forward(request, response);
                            return;
                        }
                    } else {
                        request.setAttribute("error", "Giỏ hàng của bạn đang trống.");
                        rd.forward(request, response);
                        return;
                    }
                }
            }
        }

        rd.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
