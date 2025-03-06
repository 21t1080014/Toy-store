<%@page import="khachhang.khachhang"%>
<%@page import="danhmuc.danhmuc_sp"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dangnhapAdminModal.dangnhapAdmin"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Khách Hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
</head>

<body>
    <% dangnhapAdmin userad = (dangnhapAdmin) session.getAttribute("admin"); %>

    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container-fluid">
            <a class="navbar-brand" href="Admin.jsp">Admin Panel</a>
            <ul class="navbar-nav ms-auto">
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
                <div class="d-flex justify-content-between align-items-center my-4">
                    <h2 class="text-center">Quản lý Khách Hàng</h2>
                    <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addCustomerModal">
                        <i class="bi bi-plus-circle"></i> Thêm Khách Hàng
                    </button>
                </div>

                <!-- Danh sách khách hàng -->
                <table class="table table-striped table-bordered">
                    <thead class="table-dark">
                        <tr>
                            <th>#</th>
                            <th>Tên khách hàng</th>
                            <th>Email</th>
                            <th>Số điện thoại</th>
                            <th>Trạng thái</th>
                            <th>Địa chỉ</th>
                            <th>Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
					        ArrayList<khachhang> customers = (ArrayList<khachhang>) request.getAttribute("khachds");
					        if (customers != null && !customers.isEmpty()) {
					            int index = 1;
					            for (khachhang customer : customers) {
					    %>
					    <tr>
					        <td><%= index++ %></td>
					        <td><%= customer.getTenKhachHang() %></td>
					        <td><%= customer.getEmail() %></td>
					        <td><%= customer.getSoDienThoai() %></td>
					        <td><%= customer.getTrangThai() == 1 ? "Hoạt động" : "Ngừng hoạt động" %></td>
					        <td><%= customer.getDiaChi() %> </td>
					        <td>
					            <button class="btn btn-warning btn-sm" data-bs-toggle="modal" data-bs-target="#editCustomerModal" 
					                onclick="editCustomer('<%= customer.getMaKhachHang() %>', '<%= customer.getTenKhachHang() %>', '<%= customer.getTenDangNhap() %>', '<%= customer.getEmail() %>', '<%= customer.getSoDienThoai() %>', '<%= customer.getTrangThai()%>', '<%= customer.getDiaChi()%>')">
					                <i class="bi bi-pencil"></i> Sửa
					            </button>
					            <a href="DeleteKhachHangController?maKhachHang=<%= customer.getMaKhachHang() %>" class="btn btn-danger btn-sm">
					                <i class="bi bi-trash"></i> Xóa
					            </a>
					        </td>
					    </tr>
					    <% 
					            }
					        } else {
					    %>
					    <tr>
					        <td colspan="6" class="text-center">Không có khách hàng nào!</td>
					    </tr>
					    <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <%-- Kiểm tra thông báo thành công --%>
<% if (request.getAttribute("message") != null) { %>
    <div class="alert alert-success">
        <%= request.getAttribute("message") %>
    </div>
<% } %>

<%-- Kiểm tra thông báo lỗi --%>
<% if (request.getAttribute("error") != null) { %>
    <div class="alert alert-danger">
        <%= request.getAttribute("error") %>
    </div>
<% } %>

    <!-- Modal thêm khách hàng -->
    <div class="modal fade" id="addCustomerModal" tabindex="-1" aria-labelledby="addCustomerModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <form action="ThemKhachHangController" method="post">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="addCustomerModalLabel">Thêm khách hàng</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-3">
                            <label for="customerName" class="form-label">Tên khách hàng</label>
                            <input type="text" class="form-control" id="customerName" name="tenKhachHang" required>
                        </div>
                        <div class="mb-3">
                            <label for="customerEmail" class="form-label">Email</label>
                            <input type="email" class="form-control" id="customerEmail" name="email" required>
                        </div>
                        <div class="mb-3">
                            <label for="customerPhone" class="form-label">Số điện thoại</label>
                            <input type="text" class="form-control" id="customerPhone" name="soDienThoai" required>
                        </div>
                        <div class="mb-3">
                            <label for="customerDiachi" class="form-label">Địa chỉ </label>
                            <input type="text" class="form-control" id="customerDiachi" name="diaCHi" required>
                        </div>
                        <div class="mb-3">
                            <label for="customerTenDn" class="form-label">Tên Đăng nhập</label>
                            <input type="text" class="form-control" id="customerPhone" name="tenDN" required>
                        </div>
                        <div class="mb-3">
                            <label for="customerPass" class="form-label">Mật Khẩu</label>
                            <input type="text" class="form-control" id="customerPhone" name="pass" required>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                        <button type="submit" class="btn btn-primary">Thêm</button>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <!-- Modal sửa khách hàng -->
    <div class="modal fade" id="editCustomerModal" tabindex="-1" aria-labelledby="editCustomerModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <form action="SuaKhachHangController" method="post">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editCustomerModalLabel">Sửa khách hàng</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <input type="hidden" id="editCustomerId" name="maKhachHang">
                    <div class="mb-3">
                        <label for="editCustomerName" class="form-label">Tên khách hàng</label>
                        <input type="text" class="form-control" id="editCustomerName" name="tenKhachHang" required>
                    </div>
                    <div class="mb-3">
                        <label for="editCustomerEmail" class="form-label">Email</label>
                        <input type="email" class="form-control" id="editCustomerEmail" name="email" required>
                    </div>
                    <div class="mb-3">
                        <label for="editCustomerPhone" class="form-label">Số điện thoại</label>
                        <input type="text" class="form-control" id="editCustomerPhone" name="soDienThoai" required>
                    </div>
                    <div class="mb-3">
                        <label for="editCustomerTrangThai" class="form-label">Trạng thái</label>
                        <select class="form-select" id="editCustomerTrangThai" name="trangThai" required>
                            <option value="1">Hoạt động</option>
                            <option value="0">Ngừng hoạt động</option>
                        </select>
                    </div>
                    <div class="mb-3">
					    <label for="editCustomerTenDN" class="form-label">Tên Đăng Nhập</label>
					    <input type="text" class="form-control" id="editCustomerTenDN" name="tenDN" required>
					</div>

                    <div class="mb-3">
                        <label for="editCustomerA" class="form-label">Địa chỉ</label>
                        <input type="text" class="form-control" id="editCustomerA" name="diaCHi" required>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <button type="submit" class="btn btn-primary">Lưu</button>
                </div>
            </div>
        </form>
    </div>
</div>


    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
    function editCustomer(maKhachHang, tenKhachHang,tenDN, email, sDienThoai, trangThai, diaChi) {
    	console.log("Tên:", tenKhachHang, "Email:", email, "SĐT:", sDienThoai, "Trạng thái:", trangThai, "Địa chỉ:", diaChi);
    	document.getElementById("editCustomerId").value = maKhachHang;
        document.getElementById("editCustomerName").value = tenKhachHang;
        document.getElementById("editCustomerEmail").value = email;
        document.getElementById("editCustomerPhone").value = sDienThoai;
        document.getElementById("editCustomerTrangThai").value = trangThai;
        document.getElementById("editCustomerA").value = diaChi;
        document.getElementById("editCustomerTenDN").value = tenDN;
    }

    </script>
</body>

</html>
