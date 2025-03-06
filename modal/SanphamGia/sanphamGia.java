package SanphamGia;

public class sanphamGia {
	private int MaSanPham;
	private String TenSanPham;
	private String HinhAnh;
	private String MoTa;
	private byte TrangThai;
	private int SoLuong;
	private Long Gia;
	private int MaDanhMuc;
	public sanphamGia() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	
	
	public sanphamGia(int maSanPham, String tenSanPham, String hinhAnh, String moTa, byte trangThai, int soLuong,
			Long gia, int maDanhMuc) {
		super();
		MaSanPham = maSanPham;
		TenSanPham = tenSanPham;
		HinhAnh = hinhAnh;
		MoTa = moTa;
		TrangThai = trangThai;
		SoLuong = soLuong;
		Gia = gia;
		MaDanhMuc = maDanhMuc;
	}



	public int getMaDanhMuc() {
		return MaDanhMuc;
	}

	public void setMaDanhMuc(int maDanhMuc) {
		MaDanhMuc = maDanhMuc;
	}

	public String getHinhAnh() {
		return HinhAnh;
	}

	public void setHinhAnh(String hinhAnh) {
		HinhAnh = hinhAnh;
	}

	public int getMaSanPham() {
		return MaSanPham;
	}
	public void setMaSanPham(int maSanPham) {
		MaSanPham = maSanPham;
	}
	public String getTenSanPham() {
		return TenSanPham;
	}
	public void setTenSanPham(String tenSanPham) {
		TenSanPham = tenSanPham;
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
	public int getSoLuong() {
		return SoLuong;
	}
	public void setSoLuong(int soLuong) {
		SoLuong = soLuong;
	}
	public Long getGia() {
		return Gia;
	}
	public void setGia(Long gia) {
		Gia = gia;
	}
	
	
}
/****
 * [MaSanPham]
      ,[TenSanPham]
      ,[HinhAnh]
      ,[MoTa]
      ,[TrangThai]
      ,[SoLuong]
      ,[Gia]
 */
