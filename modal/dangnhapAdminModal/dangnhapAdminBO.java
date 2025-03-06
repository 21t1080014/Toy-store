package dangnhapAdminModal;

public class dangnhapAdminBO {
	private dangnhapAdminDAO dao;

	public dangnhapAdmin DangNhap(String use , String pass) {
		dao = null;
		return dao.DangNhap(use, pass);
	}
}
