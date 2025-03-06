<%@page import="khachhang.khachhang"%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Navbar</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>
<body>
<%
    khachhang kh = (khachhang) session.getAttribute("kh");
%>
<nav class="navbar navbar-inverse">
    <div class="container-fluid">
        <ul class="nav navbar-nav">
            <li class="active"><a class="navbar-brand fw-bold text-white fs-3" href="SanPhamController"><i class="bi bi-shop"></i>ToyLand</a></li>
            
            
        </ul>
        
        <ul class="nav navbar-nav navbar-right">
        	<li class="nav-item"><a href="GioHangController"><i class="bi bi-cart-plus-fill"></i> Giỏ Hàng</a></li>
        	<li class="nav-item">
                    <a class="nav-link text-light" href="SanPhamController"><i class="bi bi-house-door-fill"></i> Trang chủ</a>
                </li>
            <% if (kh != null) { %>
            	<li class="nav-item"><a href="lichsumhController"><i class="bi bi-basket3-fill"></i> Lịch sử mua hàng</a></li>
                <li><a href="LogoutUserController"><span class="glyphicon glyphicon-user"></span> Logout</a></li>
                <li><a href="#"><span class="glyphicon glyphicon-log-in"></span> Xin chào <%= kh.getTenKhachHang() %> </a></li>
            <% } else { %>
                <li><a href="#" data-toggle="modal" data-target="#loginModal"><span class="glyphicon glyphicon-log-in"></span> Login</a></li>
                <li><a href="#" data-toggle="modal" data-target="#signUpModal"><span class="glyphicon glyphicon-user"></span> Sign up</a></li>
            <% } %>
        </ul>
    </div>
</nav>

<!-- Modal Đăng Nhập -->
<div class="modal fade" id="loginModal" tabindex="-1" aria-labelledby="loginModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="loginModalLabel">Đăng Nhập</h5>
                <a type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></a>
            </div>
            <div class="modal-body">
                <form method="post" action="DangNhapController">
                    <div class="mb-3">
                        <label for="username" class="form-label">User Name</label>
                        <input type="text" class="form-control" id="username" name="username" required>
                    </div>
                    <div class="mb-3">
                        <label for="password" class="form-label">Password</label>
                        <input type="password" class="form-control" id="password" name="password" required>
                    </div>
                    <% if (request.getAttribute("errorMessage") != null) { %>
                        <div class="text-danger"><%= request.getAttribute("errorMessage") %></div>
                    <% } %>
                    <% if (session.getAttribute("solandangnhap") != null && (int)session.getAttribute("solandangnhap") >= 3) { %>
                        <img src="simpleCaptcha.jpg"> <br>
                        <input type="text" name="captcha" class="form-control"> <br>
                    <% } %>
                    <button type="submit" class="btn btn-primary">Đăng Nhập</button>
                </form>
                <% if (session.getAttribute("kt") != null && !"".equals(session.getAttribute("kt"))) { %>
                    <div class="text-danger">Đăng nhập sai</div>
                    <%
                        session.setAttribute("kt", "");
                    %>
                <% } %>
            </div>
        </div>
    </div>
</div>

<!-- Modal Đăng Ký -->
<div class="modal fade" id="signUpModal" tabindex="-1" aria-labelledby="signUpModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="signUpModalLabel">Đăng Ký</h5>
                <a type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></a>
            </div>
            <div class="modal-body">
                <form method="post" action="signUpController">
                    <div class="mb-3">
                        <label for="hoten" class="form-label">Họ Tên</label>
                        <input type="text" class="form-control" id="hoten" name="hoten" required>
                    </div>
                    <div class="mb-3">
                        <label for="diachi" class="form-label">Địa Chỉ</label>
                        <input type="text" class="form-control" id="diachi" name="diachi" required>
                    </div>
                    <div class="mb-3">
                        <label for="sodt" class="form-label">Số Điện Thoại</label>
                        <input type="text" class="form-control" id="sodt" name="sodt" required>
                    </div>
                    <div class="mb-3">
                        <label for="email" class="form-label">Email</label>
                        <input type="email" class="form-control" id="email" name="email" required>
                    </div>
                    <div class="mb-3">
                        <label for="username" class="form-label">Tên Đăng Nhập</label>
                        <input type="text" class="form-control" id="username" name="username" required>
                    </div>
                    <div class="mb-3">
                        <label for="password" class="form-label">Mật Khẩu</label>
                        <input type="password" class="form-control" id="password" name="password" required>
                    </div>
                    <% if (request.getAttribute("signUpError") != null) { %>
                        <div class="alert alert-danger">
                            <%= request.getAttribute("signUpError") %>
                        </div>
                    <% } %>
                    <button type="submit" class="btn btn-primary">Đăng Ký</button>
                </form>
            </div>
        </div>
    </div>
</div>

<% if (request.getAttribute("errorMessage") != null) { %>
    <script type="text/javascript">
        $(document).ready(function() {
            $('#loginModal').modal('show');
        });
    </script>
<% } %>
</body>
</html>
