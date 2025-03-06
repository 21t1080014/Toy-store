package hangModal;

import java.util.ArrayList;
import java.util.List;



public class CgioHang {
	public List<Hang> ds = new ArrayList<Hang>();
	
	public List<Hang> getDs() {
		return ds;
	}
	
	public void Them(int ms ,String th ,Long gia,int sl) {
		for(int i=0;i < ds.size();i++) {
			if(ds.get(i).getTxtth().toLowerCase().trim().equals(th.toLowerCase().trim())) {
				Long g = ds.get(i).getTxtg();
				int sluong = ds.get(i).getTxtsl()+sl;
				ds.get(i).setTxtsl(sluong);
				//int tt = sluong*g;
				ds.get(i).setThanhtien(sluong*g);
				return;
			
			}
			
		}
		Hang n = new Hang(ms, th, gia, sl);
		ds.add(n);
	}
	public void Xoa(String tenHang) {
	    ds.removeIf(h -> h.getTxtth().equals(tenHang));
	}
	public long TongTien() {
		int n = ds.size();
		long tong =0;
		for(int i=0;i<n;i++) {
			tong += ds.get(i).getThanhtien();
		}
		return tong;
	}
}
