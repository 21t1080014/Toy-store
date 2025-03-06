<%@page import="SanphamGia.sanphamGia"%>
<%@page import="danhmuc.danhmuc_sp"%>
<%@page import="java.util.ArrayList"%>

<%@ page import="java.net.URLEncoder" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.8.1/font/bootstrap-icons.min.css">
  
</head>
<body class="bg-light">
<%@include file="navbar.jsp" %>
  
<div class="container">
	<div class="row">
		<div class="col-sm-2">
			<%
			ArrayList<danhmuc_sp> dsLoai = (ArrayList<danhmuc_sp>) request.getAttribute("listbo");
			for (danhmuc_sp lb: dsLoai){ %>
				<a href="SanPhamController?ml=<%= lb.getMaDanhMuc()%>"><%=lb.getTenDanhMuc() %></a><hr>
				
			<% }%>
			
			
		</div>
		<div class="col-sm-8">
			<%
			
			ArrayList<sanphamGia> hien = (ArrayList<sanphamGia>) request.getAttribute("hien");
			
				int n=hien.size();
				for(int i=0;i<n;i++){
					sanphamGia s = hien.get(i);

						%>
			<div class="row">
				<div class="col-sm-4">
					<img src="<%= s.getHinhAnh() %>" class="card-img-top img-fluid" alt="<%= s.getTenSanPham() %>" style="width:100%; height:200px; object-fit:cover;">
					<h5 class="card-title text-center"><%=s.getTenSanPham() %><br></h5>
					<p class="card-text text-center"> Giá:<%=s.getGia() %>VND<br></p>
					<div class="text-center">
						<a href="nhanHangController?ms=<%=s.getMaSanPham() %>&th=<%=s.getTenSanPham()%>&gia=<%=s.getGia()%>&sl=1" class="btn btn-primary">
			            Đặt Hàng 
			        	</a>
			        	<a href="XemChiTietController?ms=<%=s.getMaSanPham() %>" class="btn btn-primary">
			            Xem Chi Tiết 
			        	</a>
					</div>
				</div>
				<%i++;if(i<n){s=hien.get(i); %>
				<div class="col-sm-4">
					<img src="<%= s.getHinhAnh() %>" class="card-img-top img-fluid" alt="<%= s.getTenSanPham() %>" style="width:100%; height:200px; object-fit:cover;">
					<h5 class="card-title text-center"><%=s.getTenSanPham() %><br></h5>
					<p class="card-text text-center">Giá:<%=s.getGia() %>VND<br></p>
					<div class="text-center">
						<a href="nhanHangController?ms=<%=s.getMaSanPham() %>&th=<%=s.getTenSanPham()%>&gia=<%=s.getGia()%>&sl=1" class="btn btn-primary">
			            Đặt Hàng 
			        	</a>
			        	<a href="XemChiTietController?ms=<%=s.getMaSanPham() %>" class="btn btn-primary">
			            Xem Chi Tiết 
			        	</a>
					</div>
				</div>
				<%} %>
				<%i++;if(i<n){s=hien.get(i); %>
				<div class="col-sm-4">
					<img src="<%= s.getHinhAnh() %>" class="card-img-top img-fluid" alt="<%= s.getTenSanPham() %>" style="width:100%; height:200px; object-fit:cover;">
					<h5 class="card-title text-center"><%=s.getTenSanPham() %><br></h5>
					<p class="card-text text-center">Giá:<%=s.getGia() %>VND<br></p>
					<div class="text-center">
						<a href="nhanHangController?ms=<%=s.getMaSanPham() %>&th=<%=s.getTenSanPham()%>&gia=<%=s.getGia()%>&sl=1" class="btn btn-primary">
			            Đặt Hàng 
			        	</a>
			        	<a href="XemChiTietController?ms=<%=s.getMaSanPham() %>" class="btn btn-primary">
			            Xem Chi Tiết 
			        	</a>
					</div>
				</div>
				<%} %>
			</div>
			<%} %>
			<%
			int currentPage = (int) request.getAttribute("currentPage");
			            int tongTrang = (int) request.getAttribute("tongTrang");
			            String ml = request.getParameter("ml") != null ? request.getParameter("ml") : "";
			            String search = request.getParameter("search") != null ? request.getParameter("search") : "";%>
			<div class="pagination">
			    <ul class="pagination">
			        <% 
            for (int i = 1; i <= tongTrang; i++) {
                String url = "SanPhamController?trangmacdinh=" + i; // Khởi tạo URL với số trang

                // Thêm tham số tìm kiếm nếu không null
                if (search != null && !search.isEmpty()) {
                	url += "&search=" + URLEncoder.encode(search, "UTF-8");
                }
                // Thêm mã lớp nếu không null
                if (ml != null && !ml.isEmpty()) {
                    url += "&ml=" + URLEncoder.encode(ml, "UTF-8");
                }

                // Kiểm tra trang hiện tại để đánh dấu trang đang hoạt động
                if (i == currentPage) { // currentPage là biến lưu trang hiện tại
        %>
                    <li class="page-item active"><span class="page-link"><%= i %></span></li>
        <% 
                } else { 
        %>
                    <li class="page-item"><a class="page-link" href="<%= url %>"><%= i %></a></li>
        <% 
                } 
            } 
        %>
			    </ul>
			</div>
		</div>
		<div class="col-sm-2">
		<%%>
			<form action="SanPhamController" method="get">
				<label for="search">Tìm kiếm</label>
				<input type="text" id="search" name="search" class="form-control" placeholder="Tìm kiếm ....">
				<button type="submit"><i class="bi bi-search"></i></button>
			</form>
		</div>
	</div>
</div>

</body>
</html>
