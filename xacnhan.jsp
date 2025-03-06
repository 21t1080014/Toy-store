<%@ page import="java.util.ArrayList"%>
<%@ page import="dangnhapAdminModal.dangnhapAdmin"%>
<%@ page import="DhangModal.DHang" %>
<%@ page import="java.util.List" %>
<%@ page import="DAO.KetNoi" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Xác Nhận Đơn Hàng</title>
    <!-- Updated Bootstrap v4.5 -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
</head>

<body>
    <% 
    dangnhapAdmin userad = (dangnhapAdmin) session.getAttribute("admin");
    List<DHang> donHangList = (List<DHang>) request.getAttribute("donHangList");
    %>

    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container-fluid">
            <a class="navbar-brand" href="Admin.jsp">Admin Panel</a>
            <ul class="navbar-nav ml-auto">
                <li class="nav-item">
                    <a class="nav-link" href="logoutAdmin">
                        <i class="bi bi-box-arrow-right"></i> Logout
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link disabled">Xin chào, <%= userad.getUsername() %></a>
                </li>
            </ul>
        </div>
    </nav>

    <!-- Main Container -->
    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <div class="col-md-3 bg-dark text-white vh-100 position-sticky top-0 p-3">
                <h4 class="text-center">Menu</h4>
                <ul class="nav flex-column">
                    <li class="nav-item">
                        <a class="nav-link text-white" href="DashboardController">
                            <i class="bi bi-speedometer2"></i> Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-white" href="QuanLySanPhamController">
                            <i class="bi bi-box-seam"></i> Quản lý Sản phẩm
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-white" href="QuanLyDanhMucController">
                            <i class="bi bi-tags"></i> Quản lý Danh mục
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-white" href="QuanLyXacNhanController">
                            <i class="bi bi-cart-check"></i> Quản lý Đơn hàng
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-white" href="QuanLyNguoiDungController">
                            <i class="bi bi-people"></i> Quản lý Người dùng
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-white" href="QuanLyNhapHangController">
                            <i class="bi bi-airplane"></i> Quản lý Nhập Hàng
                        </a>
                    </li>
                </ul>
            </div>

            <!-- Main Content -->
            <div class="col-md-9">
                <div class="row">
                    <div class="col-md-12">
                        <h2 class="text-center">Quản lý Xác nhận Đơn hàng</h2>
                    </div>
                </div>
                <!-- Button to trigger modal for expired products -->
                <button type="button" class="btn btn-warning mb-3" data-toggle="modal" data-target="#quaHanModal">
                    Xem danh sách sản phẩm quá 30 ngày
                </button>

                <!-- Order list table -->
                <table class="table table-bordered table-hover">
                    <thead class="thead-dark">
                        <tr>
                            <th>#</th>
                            <th>Tên khách hàng</th>
                            <th>Số lượng mua</th>
                            <th>Ngày đặt hàng</th>
                            <th>Tổng tiền</th>
                            <th>Trạng thái</th>
                            <th>Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                            if (donHangList != null && !donHangList.isEmpty()) {
                                int index = 1;
                                for (DHang dhang : donHangList) {
                        %>
                        <tr>
                            <td><%= index++ %></td>
                            <td><%= dhang.getTenKhachHang() %></td>
                            <td><%= dhang.getSoLuongMua() %></td>
                            <td><%= dhang.getNgayDatHang() %></td>
                            <td><%= dhang.getTongTien() %></td>
                            <td>Chưa XỬ Lý</td>
                            <td>
                                <button class="btn btn-success btn-sm" data-toggle="modal" data-target="#confirmModal"
                                    onclick="confirmOrder('<%= dhang.getMaDonHang() %>', '<%= dhang.getTenKhachHang() %>')">
                                    <i class="fa fa-check-circle"></i> Xác nhận
                                </button>
                                
                            </td>
                        </tr>
                        <% 
                                }
                            } else {
                        %>
                        <tr>
                            <td colspan="7" class="text-center">Không có đơn hàng nào cần xác nhận!</td>
                        </tr>
                        <%} %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Modal xác nhận đơn hàng -->
    <div class="modal fade" id="confirmModal" tabindex="-1" role="dialog" aria-labelledby="confirmModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <form action="ConfirmDonHangController" method="post">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="confirmModalLabel">Xác nhận đơn hàng</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <input type="hidden" id="orderId" name="maDonHang">
                        <p>Bạn có chắc chắn muốn xác nhận đơn hàng từ <span id="customerName"></span>?</p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Hủy</button>
                        <button type="submit" class="btn btn-primary">Xác nhận</button>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <!-- Modal danh sách sản phẩm quá hạn -->
    <div class="modal fade" id="quaHanModal" tabindex="-1" role="dialog" aria-labelledby="quaHanModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="quaHanModalLabel">Danh sách sản phẩm quá hạn</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                
                <a href="DeleteDonHangControlle" class="btn btn-danger btn-sm">
                                    <i class="fa fa-trash"></i> Xóa quá hạn 30 ngày
                                </a>
                    <!-- Table displaying expired products -->
                    <table class="table table-bordered">
                        <thead>
                            <tr>
                                <th>Tên Khách Hàng</th>
                                <th>Số Lượng Mua</th>
                                <th>Ngày Đặt Hàng</th>
                                <th>Tổng Tiền</th>
                                <th>Tổng Giá</th>
                                <th>Ma Đơn Hàng</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% 
                                ArrayList<DHang> dsQuaHan = (ArrayList<DHang>) request.getAttribute("dsQuaHan");
                                for(DHang donHang : dsQuaHan) {
                            %>
                            <tr>
                                <td><%= donHang.getTenKhachHang() %></td>
                                <td><%= donHang.getSoLuongMua() %></td>
                                <td><%= donHang.getNgayDatHang() %></td>
                                <td><%= donHang.getTongTien() %></td>
                                <td><%= donHang.getTongGia() %></td>
                                <td><%= donHang.getMaDonHang() %></td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <script>
        function confirmOrder(orderId, customerName) {
            document.getElementById("orderId").value = orderId;
            document.getElementById("customerName").innerText = customerName;
        }
    </script>
</body>

</html>
