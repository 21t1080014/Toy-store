<%@page import="SanphamGia.sanphamGia"%>
<%@page import="danhmuc.danhmuc_sp"%>
<%@page import="java.util.ArrayList"%>

<%@ page import="java.net.URLEncoder" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
  <title>Chi Tiết Sản Phẩm</title>
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
			<% } %>
		</div>

		<div class="col-sm-8">
			<%
				sanphamGia sanPham = (sanphamGia) request.getAttribute("sanPham");
				if (sanPham != null) {
			%>
				<h2><%= sanPham.getTenSanPham() %></h2>
				<img src="<%= sanPham.getHinhAnh() %>" alt="<%= sanPham.getTenSanPham() %>" class="img-fluid" style="width:100%; height:400px; object-fit:cover;">
				<p><strong>Giá:</strong> <%= sanPham.getGia() %> VND</p>
				<p><strong>Mô Tả:</strong> <%= sanPham.getMoTa() %></p>

				<!-- Form đặt hàng -->
				<div class="text-center">
					<form action="nhanHangController" method="get">
						<input type="hidden" name="ms" value="<%= sanPham.getMaSanPham() %>">
						<input type="hidden" name="th" value="<%= sanPham.getTenSanPham() %>">
						<input type="hidden" name="gia" value="<%= sanPham.getGia() %>">
						<input type="number" name="sl" value="1" min="1" max="10" class="form-control" style="width: 100px; display:inline-block;">
						<button type="submit" class="btn btn-primary">Đặt Hàng</button>
					</form>
				</div>

			<% } else { %>
				<p>Không tìm thấy sản phẩm.</p>
			<% } %>
		</div>

		<div class="col-sm-2">
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
