<%@page import="danhmuc.danhmuc_sp"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dangnhapAdminModal.dangnhapAdmin"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý danh mục</title>
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
                        <a class="nav-link text-white active" href="QuanLyDanhMucController">
                            <i class="bi bi-tags"></i> Quản lý Danh mục
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-white" href="QuanLySanPhamController">
                            <i class="bi bi-box-seam"></i> Quản lý Sản phẩm
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
                    <h2 class="text-center">Quản lý Danh mục</h2>
                    <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addCategoryModal">
                        <i class="bi bi-plus-circle"></i> Thêm Danh mục
                    </button>
                </div>

                <!-- Danh sách danh mục -->
                <table class="table table-striped table-bordered">
                    <thead class="table-dark">
                        <tr>
                            <th>#</th>
                            <th>Tên danh mục</th>
                            <th>Mô tả</th>
                            <th>Trạng thái</th>
                            <th>Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
					        ArrayList<danhmuc_sp> categories = (ArrayList<danhmuc_sp>) request.getAttribute("categories");
					        if (categories != null && !categories.isEmpty()) {
					            int index = 1;
					            for (danhmuc_sp dmuc : categories) {
					    %>
					    <tr>
					        <td><%= index++ %></td>
					        <td><%= dmuc.getTenDanhMuc() %></td>
					        <td><%= dmuc.getMoTa() %></td>
					        <td><%= dmuc.getTrangThai() == 1 ? "Hoạt động" : "Ngừng hoạt động" %></td>
					        <td>
					            <button class="btn btn-warning btn-sm" data-bs-toggle="modal" data-bs-target="#editCategoryModal" 
					                onclick="editCategory('<%= dmuc.getMaDanhMuc() %>', '<%= dmuc.getTenDanhMuc() %>', '<%= dmuc.getMoTa() %>', '<%= dmuc.getTrangThai()%>')">
					                <i class="bi bi-pencil"></i> Sửa
					            </button>
					            <a href="DeleteDanhMucController?maDanhMuc=<%= dmuc.getMaDanhMuc() %>" class="btn btn-danger btn-sm">
					                <i class="bi bi-trash"></i> Xóa
					            </a>
					        </td>
					    </tr>
					    <% 
					            }
					        } else {
					    %>
					    <tr>
					        <td colspan="4" class="text-center">Không có danh mục nào!</td>
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

    <!-- Modal thêm danh mục -->
    <div class="modal fade" id="addCategoryModal" tabindex="-1" aria-labelledby="addCategoryModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <form action="ThemDanhMucController" method="post">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="addCategoryModalLabel">Thêm danh mục</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-3">
                            <label for="categoryName" class="form-label">Tên danh mục</label>
                            <input type="text" class="form-control" id="categoryName" name="tenDanhMuc" required>
                        </div>
                        <div class="mb-3">
                            <label for="categoryDescription" class="form-label">Mô tả</label>
                            <textarea class="form-control" id="categoryDescription" name="moTa" rows="3" required></textarea>
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

    <!-- Modal sửa danh mục -->
    <div class="modal fade" id="editCategoryModal" tabindex="-1" aria-labelledby="editCategoryModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <form action="SuaDanhMucController" method="post">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="editCategoryModalLabel">Sửa danh mục</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <input type="hidden" id="editCategoryId" name="maDanhMuc">
                        <div class="mb-3">
                            <label for="editCategoryName" class="form-label">Tên danh mục</label>
                            <input type="text" class="form-control" id="editCategoryName" name="tenDanhMuc" required>
                        </div>
                        <div class="mb-3">
                            <label for="editCategoryDescription" class="form-label">Mô tả</label>
                            <textarea class="form-control" id="editCategoryDescription" name="moTa" rows="3" required></textarea>
                        </div>
                        <div class="mb-3">
	                        <label for="editCategoryStatus" class="form-label">Trạng thái</label>
	                        <select class="form-select" id="editCategoryStatus" name="trangThai" required>
	                            <option value="1">Hoạt động</option>
	                            <option value="0">Ngừng hoạt động</option>
	                        </select>
                    	</div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                        <button type="submit" class="btn btn-warning">Cập nhật</button>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <script>
        function editCategory(id, name, description,trangThai) {
            document.getElementById('editCategoryId').value = id;
            document.getElementById('editCategoryName').value = name;
            document.getElementById('editCategoryDescription').value = description;
            document.getElementById('editCategoryStatus').value = trangThai;
        }
    </script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>
