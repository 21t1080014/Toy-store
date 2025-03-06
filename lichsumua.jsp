<%@page import="danhmuc.danhmuc_sp"%>
<%@page import="lichsuMhModal.LichsuMH"%>
<%@page import="java.util.ArrayList"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Lịch Sử Mua Hàng</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.8.1/font/bootstrap-icons.min.css">
  
</head>
<body>
    <%@include file="navbar.jsp" %>
    <div class="container">
        <div class="page-header">
            <h2 class="text-primary text-center">Lịch Sử Mua Hàng</h2>
        </div>
        <div class="row">
            <!-- Danh mục sản phẩm -->
            <div class="col-sm-2">
                <h4 class="text-success">Danh Mục Sản Phẩm</h4>
                <ul class="list-group">
                    <%
                        ArrayList<danhmuc_sp> listbo = (ArrayList<danhmuc_sp>) request.getAttribute("listbo");
                        if (listbo != null) {
                            for (danhmuc_sp item : listbo) {
                    %>
                                <li class="list-group-item">
                                    <a href="SanPhamController?ml=<%= item.getMaDanhMuc() %>">
                                        <%= item.getTenDanhMuc() %>
                                    </a>
                                </li>
                    <%
                            }
                        }
                    %>
                </ul>
            </div>

            <!-- Lịch sử mua hàng -->
            <div class="col-sm-8">
                <div class="panel panel-primary">
                    <div class="panel-heading text-center">Danh Sách Đơn Hàng</div>
                    <table class="table table-bordered table-hover">
                        <thead class="bg-info">
                            <tr>
                                <th>Tên Sản Phẩm</th>
                                <th>Giá</th>
                                <th>Số Lượng</th>
                                <th>Thành Tiền</th>
                                <th>Ngày Mua</th>
                                <th>Trạng Thái</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                ArrayList<LichsuMH> lichsudonhang = (ArrayList<LichsuMH>) session.getAttribute("lichsudonhang");
                                if (lichsudonhang == null || lichsudonhang.isEmpty()) {
                            %>
                                <tr>
                                    <td colspan="6" class="text-center text-warning">Bạn chưa có đơn hàng nào.</td>
                                </tr>
                            <%
                                } else {
                                    for (LichsuMH donhang : lichsudonhang) {
                            %>
                                <tr>
                                    <td><%= donhang.getTenSanPham() %></td>
                                    <td><%= donhang.getGiaSanPham() %> VND</td>
                                    <td><%= donhang.getSoLuongMua() %></td>
                                    <td><%= donhang.getThanhTien() %> VND</td>
                                    <td><%= donhang.getNgayMua() %></td>
                                    <td>
                                        <span class="label <%= donhang.getTrangThaiDonHang() == 1 ? "label-success" : "label-danger" %>">
                                            <%= donhang.getTrangThaiDonHang() == 1 ? "Đã thanh toán" : "Đang xử lý" %>
                                        </span>
                                    </td>
                                </tr>
                            <%
                                    }
                                }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Thanh tìm kiếm -->
            <div class="col-sm-2">
			    <div class="well">
			        <form action="SanPhamController" method="get" class="form-inline">
			            <div class="form-group">
			                <label for="search" class="control-label">Tìm kiếm</label>
			                <input type="text" id="search" name="search" class="form-control" placeholder="Tìm kiếm..." style="width: 100%; max-width: 300px;">
			            </div>
			            <button type="submit" class="btn btn-primary">
			                <span class="glyphicon glyphicon-search"></span> Tìm
			            </button>
			        </form>
			    </div>
			</div>

        </div>
    </div>
</body>
</html>
