package hangModal;

public class Hang {
	private int masach;
	private String txtth;
	private Long txtg;
	private int txtsl;
	private Long thanhtien;
	public Hang() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Hang(int masach,String txtth, Long txtg, int txtsl) {
		super();
		this.masach =masach;
		this.txtth = txtth;
		this.txtg = txtg;
		this.txtsl = txtsl;
		this.thanhtien = txtg*txtsl;
	}
	
	public int getMasach() {
		return masach;
	}
	public void setMasach(int masach) {
		this.masach = masach;
	}
	public String getTxtth() {
		return txtth;
	}
	public void setTxtth(String txtth) {
		this.txtth = txtth;
	}
	
	public int getTxtsl() {
		return txtsl;
	}
	public void setTxtsl(int txtsl) {
		this.txtsl = txtsl;
	}
	public Long getTxtg() {
		return txtg;
	}
	public void setTxtg(Long txtg) {
		this.txtg = txtg;
	}
	public Long getThanhtien() {
		return thanhtien;
	}
	public void setThanhtien(Long thanhtien) {
		this.thanhtien = thanhtien;
	}
	
	
	
}
