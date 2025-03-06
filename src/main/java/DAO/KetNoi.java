package DAO;

import java.sql.Connection;
import java.sql.DriverManager;

public class KetNoi {
	public Connection cn;
	public void ketnoi() {
		try {
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			String url="jdbc:sqlserver://localhost:1433;databaseName=WebBanHang;user=sa; password=123";
			cn=DriverManager.getConnection(url);
			System.out.println("đã Kết nối thành công");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
