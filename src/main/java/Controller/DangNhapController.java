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
//import khachhangModal.khachhangBo;
//import nl.captcha.Captcha;

/**
 * Servlet implementation class DangNhapController
 */
@WebServlet("/DangNhapController")
public class DangNhapController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DangNhapController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String username = request.getParameter("username");
        String password = request.getParameter("password");
        String captchaInput = request.getParameter("captcha");
        String errorMessage = null;
        HttpSession session = request.getSession();
        String url = (String) session.getAttribute("trang");
        khachhangBO khb = new khachhangBO();

        // Khởi tạo số lần đăng nhập sai nếu chưa có
        if (session.getAttribute("solandangnhap") == null) {
            session.setAttribute("solandangnhap", 0);
        }

        int dem = (int) session.getAttribute("solandangnhap");
        boolean isCaptchaDung = true;

        // Kiểm tra CAPTCHA nếu số lần đăng nhập sai >= 3loginAttempts
        if ( dem >= 3) {
            //Captcha captcha = (Captcha) session.getAttribute(Captcha.NAME);
//            if (captcha == null || !captcha.isCorrect(captchaInput)) {
//                isCaptchaDung = false;
//                errorMessage = "CAPTCHA không đúng.";
//            }
        }

        if (username != null && password != null && !username.isEmpty() && !password.isEmpty() && isCaptchaDung) {
            khachhang kh = khb.dangNhap(username, password);
            if (kh != null) {
                session.setAttribute("un", username);
                session.setAttribute("kh", kh);
                session.setAttribute("solandangnhap", 0); //cho số lần dem về 0
                if (url != null) {
                    response.sendRedirect(url);
                } else {
                    response.sendRedirect("SanPhamController");
                }
                return;
            } else {
                errorMessage = "Sai tài khoản hoặc mật khẩu.";
                dem++;
                session.setAttribute("solandangnhap", dem);
            }
        } else if (!isCaptchaDung) {
            dem++;
            session.setAttribute("solandangnhap", dem);
        } else {
            errorMessage = "Tài khoản và mật khẩu không được để trống.";
        }

        // Xử lý quay về trang trước đó với thông báo lỗi
        request.setAttribute("errorMessage", errorMessage);
        if (url != null) {
            if (url.startsWith("/DuAn_Hung_21t1080014/")) {
                url = url.substring("/DuAn_Hung_21t1080014".length());
            }
            RequestDispatcher dispatcher = request.getRequestDispatcher(url);
            dispatcher.forward(request, response);
        } else {
            request.getRequestDispatcher("SanPhamController").forward(request, response);
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
