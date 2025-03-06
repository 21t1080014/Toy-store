<%@page import="sanphamModal.sanpham"%>
<%@page import="PhieuNhapModal.phieuNhap"%>
<%@page import="dangnhapAdminModal.dangnhapAdmin"%>

<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Phiếu Nhập</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- JS Bootstrap (cần phải có tệp này để modal hoạt động) -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</head>

<body>
    <% dangnhapAdmin userad = (dangnhapAdmin) session.getAttribute("admin");
    ArrayList<sanpham> dsSpham11 = (ArrayList<sanpham>) request.getAttribute("dsSpham");
    %>
<%= request.getAttribute("dsSPham") %>
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
                    <h2 class="text-center">Quản lý Phiếu Nhập</h2>
                    <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addPhieuNhapModal">
                        <i class="bi bi-plus-circle"></i> Thêm Phiếu Nhập
                    </button>
                </div>

                <!-- Danh sách Phiếu Nhập -->
                <table class="table table-striped table-bordered">
                    <thead>
                        <tr>
                            <th>Mã Phiếu Nhập</th>
                            <th>Mã Sản Phẩm</th>
                            <th>Số Lượng Nhập</th>
                            <th>Ngày nhập</th>
                            <th>Giá Nhập</th>
                            <th>Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%-- Duyệt qua danh sách phiếu nhập và hiển thị --%>
                        <% 
                            ArrayList<phieuNhap> phieuNhaps = (ArrayList<phieuNhap>) request.getAttribute("dsphieu");
                            if (phieuNhaps != null) {
                                for (phieuNhap phieu : phieuNhaps) {
                        %>
                        <tr>
                            <td><%= phieu.getMaPhieuNhap() %></td>
                            <td><%= phieu.getMaSanPham() %></td>
                            <td><%= phieu.getSoLuongNhap() %></td>
                            <td><%= phieu.getNgayNhap() %></td>
                            <td><%= phieu.getGiaNhap() %></td>
                            <td>
                                <button class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#editPhieuNhapModal"
                                        onclick="editPhieuNhap('<%= phieu.getMaPhieuNhap() %>', '<%= phieu.getMaSanPham() %>', '<%= phieu.getSoLuongNhap() %>', '<%= phieu.getNgayNhap() %>', '<%= phieu.getGiaNhap()%>')">
                                    <i class="bi bi-pencil"></i> Sửa
                                </button>
                                <a href="XoaPhieuNhapController?maPhieuNhap=<%= phieu.getMaPhieuNhap() %>" class="btn btn-danger btn-sm">
					                <i class="bi bi-trash"></i> Xóa
					            </a>
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

    <!-- Modal Thêm Phiếu Nhập -->
<div class="modal fade" id="addPhieuNhapModal" tabindex="-1" aria-labelledby="addPhieuNhapModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <form action="ThemPhieuNhapController" method="post">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addPhieuNhapModalLabel">Thêm Phiếu Nhập</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="addMaSanPham" class="form-label">Mã Sản Phẩm</label>
                        <select class="form-control" id="addMaSanPham" name="maSanPham" required>
                            <% 
                                if (dsSpham11 != null) {
                                    for (sanpham maloai : dsSpham11) {
                            %>
                                <!-- Hiển thị tên sản phẩm cho người dùng và mã sản phẩm làm value -->
                                <option value="<%= maloai.getMaSanPham() %>">
                                    <%= maloai.getTenSanPham() %> <!-- Hiển thị tên sản phẩm -->
                                </option>
                            <% 
                                    }
                                }
                            %>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="addSoLuongNhap" class="form-label">Số Lượng Nhập</label>
                        <input type="number" class="form-control" id="addSoLuongNhap" name="soLuongNhap" required>
                    </div>
                    
                    <div class="mb-3">
                        <label for="addGiaNhap" class="form-label">Giá Nhập</label>
                        <input type="number" class="form-control" id="addGiaNhap" name="giaNhap" required>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <button type="submit" class="btn btn-primary">Thêm Phiếu Nhập</button>
                </div>
            </div>
        </form>
    </div>
</div>


    <div class="modal fade" id="editPhieuNhapModal" tabindex="-1" aria-labelledby="editPhieuNhapModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <form action="SuaPhieuNhapController" method="post">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editPhieuNhapModalLabel">Sửa Phiếu Nhập</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <input type="hidden" id="editPhieuNhapId" name="maPhieu">
                    <div class="mb-3">
                        <label for="editMaSanPham" class="form-label">Mã Sản Phẩm</label>
                        <input type="text" class="form-control" id="editMaSanPham" name="maSanPham" required>
                    </div>
                    <div class="mb-3">
                        <label for="editSoLuongNhap" class="form-label">Số Lượng Nhập</label>
                        <input type="number" class="form-control" id="editSoLuongNhap" name="soLuongNhap" required>
                    </div>
                    
                    <div class="mb-3">
                        <label for="editGiaNhap1" class="form-label">Giá Nhập</label>
                        <input type="number" class="form-control" id="editGiaNhap1" name="giaNhap" required>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <button type="submit" class="btn btn-primary">Lưu Thay Đổi</button>
                </div>
            </div>
        </form>
    </div>
</div>



    <script>
    function editPhieuNhap(maPhieu, maSanPham, soLuongNhap, ngayNhap, giaNhap) {
        // Gán giá trị vào các input trong modal
        document.getElementById('editPhieuNhapId').value = maPhieu;
        document.getElementById('editMaSanPham').value = maSanPham;
        document.getElementById('editSoLuongNhap').value = soLuongNhap;
        //document.getElementById('editNgayNhap').value = ngayNhap;

        // Gán giá trị giá nhập, kiểm tra lỗi nếu có
        if (isNaN(giaNhap)) {
            console.log("Giá trị giaNhap không hợp lệ:", giaNhap);
        } else {
            document.getElementById('editGiaNhap1').value = giaNhap; // Đúng id
            console.log("Gia Nhap quan que:", giaNhap);
        }

        // Hiển thị modal (nếu cần)
        var modal = new bootstrap.Modal(document.getElementById('editPhieuNhapModal'));
    modal.show();// Chỉ sử dụng nếu đang dùng Bootstrap
    }
    </script>

</body>
</html>
