package admin;

import java.util.List;
import java.util.Map;

public class DashboardBO {
	private DashboardDAO dao=new DashboardDAO();
	public int getTotalUsers() {
		return dao.getTotalUsers();
	}
	public int getTotalProducts() {
		return dao.getTotalProducts();
	}
	public int getTotalOrder() {
		return dao.getTotalOrder();
		
	}
	public int getTotalDanhMuc() {
		return dao.getTotalDanhMuc();
	}
	public List<Map<String, Object>> getDoanhThu30Ngay() {
		return dao.getDoanhThu30Ngay();
	}
}
