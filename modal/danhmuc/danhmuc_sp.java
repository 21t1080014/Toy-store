package danhmuc;


public class danhmuc_sp {
	private int MaDanhMuc;
	private String TenDanhMuc;
	private String MoTa;
	private byte TrangThai;
	public danhmuc_sp() {
		super();
		// TODO Auto-generated constructor stub
	}
	public danhmuc_sp(int maDanhMuc, String tenDanhMuc, String moTa, byte trangThai) {
		super();
		MaDanhMuc = maDanhMuc;
		TenDanhMuc = tenDanhMuc;
		MoTa = moTa;
		TrangThai = trangThai;
	}
	public int getMaDanhMuc() {
		return MaDanhMuc;
	}
	public void setMaDanhMuc(int maDanhMuc) {
		MaDanhMuc = maDanhMuc;
	}
	public String getTenDanhMuc() {
		return TenDanhMuc;
	}
	public void setTenDanhMuc(String tenDanhMuc) {
		TenDanhMuc = tenDanhMuc;
	}
	public String getMoTa() {
		return MoTa;
	}
	public void setMoTa(String moTa) {
		MoTa = moTa;
	}
	public byte getTrangThai() {
		return TrangThai;
	}
	public void setTrangThai(byte trangThai) {
		TrangThai = trangThai;
	}
	
	
}
/***
SELECT TOP (1000) [MaDanhMuc]
      ,[TenDanhMuc]
      ,[MoTa]
      ,[TrangThai]
  FROM [WebBanHang].[dbo].[DanhMucSanPham]
***/