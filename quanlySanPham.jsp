<%@page import="danhmuc.danhmuc_sp"%>
<%@page import="sanphamModal.sanpham"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Sản phẩm</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
</head>

<body>
    <% 
        ArrayList<sanpham> dsSanPham = (ArrayList<sanpham>) request.getAttribute("dsSanPham");
        ArrayList<danhmuc_sp> dsLoai = (ArrayList<danhmuc_sp>) request.getAttribute("dsLoai");
    %>

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
                    <a class="nav-link disabled">Xin chào, Admin</a>
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
                    <h2 class="text-center">Quản lý Sản phẩm</h2>
                    <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addProductModal">
                        <i class="bi bi-plus-circle"></i> Thêm Sản phẩm
                    </button>
                </div>

                <!-- Danh sách sản phẩm -->
                <table class="table table-striped table-bordered">
                    <thead class="table-dark">
                        <tr>
                            <th>#</th>
                            <th>Tên sản phẩm</th>
                            <th>Danh mục</th>
                            <th>Mô tả</th>
                            <th>Hình ảnh</th>
                            <th>Trạng thái</th>
                            <th>Số lượng</th>
                            <th>Ngày tạo</th>
                            <th>Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% if (dsSanPham != null && !dsSanPham.isEmpty()) { 
                            for (sanpham sp : dsSanPham) { %>
                                <tr>
                                    <td><%= sp.getMaSanPham() %></td>
                                    <td><%= sp.getTenSanPham() %></td>
                                    <%
									    if (dsLoai != null) {
									        for (danhmuc_sp maloai : dsLoai) {
									            if (maloai.getMaDanhMuc() == sp.getMaDanhMuc()) {
									%>
									    <td><%= maloai.getTenDanhMuc() %></td>
									<%
									                break; // Thoát vòng lặp khi tìm được danh mục khớp
									            }
									        }
									    }
									%>

                                    <td><%= sp.getMoTa() %></td>
                                    <td>
                                        <img src="<%= sp.getHinhAnh() %>" alt="Hình ảnh" width="50">
                                    </td>
                                    <td><%= sp.getTrangThai() == 1 ? "Hiện" : "Ẩn" %></td>
                                    <td><%= sp.getSoLuong() %></td>
                                    <td><%= sp.getNgayTao() %></td>
                                    <td>
                                        <button class="btn btn-sm btn-warning" 
										    onclick="editProduct('<%= sp.getMaSanPham() %>', '<%= sp.getTenSanPham() %>', '<%= sp.getMoTa() %>', 
										    '<%= sp.getSoLuong() %>', '<%= sp.getMaDanhMuc() %>', '<%= sp.getHinhAnh() %>', '<%= sp.getTrangThai() %>')">
										    <i class="bi bi-pencil"></i> Sửa
										</button>
                                        <a href="XoaSanPhamController?maSanPham=<%= sp.getMaSanPham() %>" 
                                           class="btn btn-sm btn-danger" onclick="return confirm('Bạn có chắc chắn muốn xóa?')">
                                            <i class="bi bi-trash"></i> Xóa
                                        </a>
                                        <a href="QuanLyGiaController?maSanPham=<%= sp.getMaSanPham() %>" 
										   class="btn btn-sm btn-success">
										   <i class="bi bi-coin"></i>
										</a>

                                    </td>
                                </tr>
                        <%  }
                        } else { %>
                            <tr>
                                <td colspan="9" class="text-center">Không có sản phẩm nào.</td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Modal thêm sản phẩm -->
    <div class="modal fade" id="addProductModal" tabindex="-1" aria-labelledby="addProductModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <form action="ThemSanPhamController" method="post" enctype="multipart/form-data">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="addProductModalLabel">Thêm sản phẩm</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-3">
                            <label for="productName" class="form-label">Tên sản phẩm</label>
                            <input type="text" class="form-control" id="productName" name="tenSanPham" required>
                        </div>
                        <div class="mb-3">
                            <label for="productCategory" class="form-label">Mã danh mục</label>
                            
                            <select class="form-control" id="maDanhMuc" name="maDanhMuc" required>
                                            <% 
                                                // Lấy danh sách các loại sản phẩm từ request
                                               
                                                if (dsLoai != null) {
                                                    for (danhmuc_sp maloai : dsLoai) {
                                            %>
                                                        <option value="<%= maloai.getMaDanhMuc() %>"><%= maloai.getTenDanhMuc() %></option>
                                            <% 
                                                    }
                                                }
                                            %>
                                        </select>
                        </div>
                        <div class="mb-3">
                            <label for="productDescription" class="form-label">Mô tả</label>
                            <textarea class="form-control" id="productDescription" name="moTa" style="min-height: 100px;" required></textarea>
                        </div>
                        <div class="mb-3">
                            <label for="productImage" class="form-label">Hình ảnh</label>
                            <input type="file" class="form-control" id="productImage" name="hinhAnh" required>
                        </div>
                        <div class="mb-3">
                            <label for="productStatus" class="form-label">Trạng thái</label>
                            <select class="form-select" id="productStatus" name="trangThai" required>
                                <option value="1">Hiện</option>
                                <option value="0">Ẩn</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="productQuantity" class="form-label">Số lượng</label>
                            <input type="number" class="form-control" id="productQuantity" name="soLuong" required>
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
    
    <!-- Modal sửa sản phẩm -->
<div class="modal fade" id="editProductModal" tabindex="-1" aria-labelledby="editProductModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <form action="SuaSanPhamController" method="post" enctype="multipart/form-data">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editProductModalLabel">Sửa sản phẩm</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <!-- Mã sản phẩm (ẩn) -->
                    <input type="hidden" id="editProductId" name="maSanPham">

                    <!-- Tên sản phẩm -->
                    <div class="mb-3">
                        <label for="editProductName" class="form-label">Tên sản phẩm</label>
                        <input type="text" class="form-control" id="editProductName" name="tenSanPham" required>
                    </div>

                    <!-- Danh mục -->
                    <div class="mb-3">
                        <label for="editProductCategory" class="form-label">Danh mục</label>
                        <select class="form-control" id="editProductCategory" name="maDanhMuc" required>
                            <% 
                                if (dsLoai != null) {
                                    for (danhmuc_sp maloai : dsLoai) {
                            %>
                                <option value="<%= maloai.getMaDanhMuc() %>"><%= maloai.getTenDanhMuc() %></option>
                            <% 
                                    }
                                }
                            %>
                        </select>
                    </div>

                    <!-- Mô tả -->
                    <div class="mb-3">
                        <label for="editProductDescription" class="form-label">Mô tả</label>
                        <textarea class="form-control" id="editProductDescription" name="moTa" style="min-height: 100px;" required></textarea>
                    </div>

                    <!-- Hình ảnh -->
                    <div class="mb-3">
                        <label for="editProductImageFile" class="form-label">Hình ảnh</label>
                        <!-- Input file để thay đổi hình ảnh -->
                        <input type="file" class="form-control" id="editProductImageFile" name="hinhAnh">
                        
                        <!-- Giữ hình ảnh hiện tại trong một input ẩn nếu không thay đổi -->
                        <input type="hidden" name="existingImage" id="existingImage" value="<%= request.getAttribute("hinhAnh") %>">
                        
                        <!-- Hiển Thị ảnh trước khi sửa -->
                        <div>
                            <img id="editProductImagePreview" src="<%= request.getAttribute("hinhAnh") %>" alt="Current Image" style="max-width: 100px;">
                        </div>
                    </div>

                    <!-- Trạng thái -->
                    <div class="mb-3">
                        <label for="editProductStatus" class="form-label">Trạng thái</label>
                        <select class="form-select" id="editProductStatus" name="trangThai" required>
                            <option value="1">Hiện</option>
                            <option value="0">Ẩn</option>
                        </select>
                    </div>

                    <!-- Số lượng -->
                    <div class="mb-3">
                        <label for="editProductQuantity" class="form-label">Số lượng</label>
                        <input type="number" class="form-control" id="editProductQuantity" name="soLuong" required>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                </div>
            </div>
        </form>
    </div>
</div>
    

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
    function editProduct(maSanPham, tenSanPham, moTa, soLuong, maDanhMuc, hinhAnh, trangThai) {
    	
            // Populate the modal fields with the current product data
            document.getElementById("editProductId").value = maSanPham;
            document.getElementById("editProductName").value = tenSanPham;
            document.getElementById("editProductDescription").value = moTa;
            document.getElementById("editProductQuantity").value = soLuong;
            document.getElementById("editProductStatus").value = trangThai;
            document.getElementById("editProductCategory").value = maDanhMuc;

         // Set the current product image in the modal
            document.getElementById("editProductImagePreview").src = hinhAnh;
            document.getElementById("existingImage").value = hinhAnh;
        
        // Hiển thị modal
        new bootstrap.Modal(document.getElementById("editProductModal")).show();
    }
    </script>
</body>

</html>
