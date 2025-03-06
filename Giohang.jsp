<%@page import="hangModal.Hang"%>
<%@page import="hangModal.CgioHang"%>
<%@page import="danhmuc.danhmuc_sp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="java.util.ArrayList"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Giỏ Hàng</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.8.1/font/bootstrap-icons.min.css">
</head>
<body>
	<%@include file="navbar.jsp" %><h2>Giỏ Hàng</h2>
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
	            String thanhcong = (String) request.getAttribute("thanhcong");
	        	//CgioHang gioHang = (CgioHang) request.getAttribute("gioHang");
	        	CgioHang gioHang = (CgioHang) session.getAttribute("gh");
	            if (gioHang == null) {
	                gioHang = new CgioHang();
	                session.setAttribute("gh", gioHang);
	            }
	       
	        if(thanhcong != null){ %>
			<div class='alert alert-success'>
			<%=thanhcong %>
			
			</div><%}%>
	        <h3>Sản Phẩm Trong Giỏ Hàng:</h3>
	        <%
	            if (gioHang.ds.size() > 0) {
	        %>
	        <form action="GioHangController" method="post">
    <table class="table table-bordered">
        <thead>
            <tr>
                <th></th>
                <th>Tên Hàng</th>
                <th>Giá</th>
                <th>Số Lượng</th>
                <th>Thành Tiền</th>
                <th>Thao Tác</th>
            </tr>
        </thead>
        <tbody>
            <% for (Hang hang : gioHang.ds) { %>
            <tr>
                <td><input type="checkbox" name="hangg" value="<%= hang.getMasach() %>"></td>
                <td><%= hang.getTxtth() %></td>
                <td><%= hang.getTxtg() %></td>
                <td>
                    <input type="number" name="txtsua_<%= hang.getTxtth() %>" value="<%= hang.getTxtsl() %>" required>
                </td>
                <td><%= hang.getThanhtien() %></td>
                <td>
                	<input type="hidden" name="item" value="<%= hang.getTxtth() %>">
                    <!-- Nút "Xóa" -->
                    <button type="submit" name="action" value="xoa" class="btn btn-danger btn-sm">Xóa</button>
                    <!-- Nút "Sửa"  -->
                    <button type="submit" name="action" value="sua" class="btn btn-info btn-sm">Sửa</button>
                </td>
            </tr>
            <% } %>
        </tbody>
    </table>

    <!-- Thêm nút để xóa tất cả các mục được chọn -->
    <button type="submit" name="action" value="xoachon" class="btn btn-danger btn-sm">Xóa chọn</button>
    <!-- Thêm nút để hủy toàn bộ giỏ hàng -->
    <button type="submit" name="action" value="xoaall" class="btn btn-danger btn-sm">Hủy giỏ hàng</button>
    <!-- Thêm nút để đặt hàng -->
    <button type="submit" name="action" value="dathang" class="btn btn-success btn-sm">Đặt hàng</button>
</form>

	            
	            <div class="alert alert-info">
	                Tổng Tiền: <%= gioHang.TongTien() %>
	            </div>
	        <% } else { %>
	            <div class="alert alert-warning">Giỏ hàng của bạn đang trống.</div>
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
