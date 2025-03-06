<%@page import="BangGiaModal.BangGia"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Giá Sản phẩm</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
</head>

<body>
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
                    <h2 class="text-center">Quản lý Giá Sản phẩm thuộc mã sản phẩm <%= request.getAttribute("maSanPham") %></h2>
                    <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addPriceModal">
                        <i class="bi bi-plus-circle"></i> Thêm Giá
                    </button>
                </div>

                <!-- Danh sách giá -->
                <% 
                    // Lấy danh sách giá sản phẩm từ request
                    ArrayList<BangGia> dsGia = (ArrayList<BangGia>) request.getAttribute("dsGia");
                %>

                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th>Mã giá</th>
                            <th>Mã sản phẩm</th>
                            <th>Giá</th>
                            <th>Ngày áp dụng</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% if (dsGia != null && !dsGia.isEmpty()) {
                            for (BangGia gia : dsGia) { %>
                                <tr>
                                    <td><%= gia.getMaGia() %></td>
                                    <td><%= gia.getMaSanPham() %></td>
                                    <td><%= gia.getGia() %></td>
                                    <td><%= gia.getNgayApDung() %></td>
                                    <td>
                                        <button class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#editPriceModal" 
                                            data-id="<%= gia.getMaGia() %>" data-price="<%= gia.getGia() %>">Sửa</button>
                                        <form action="XoaGiaController" method="post" class="d-inline">
                                            <input type="hidden" name="maGia" value="<%= gia.getMaGia() %>">
                                            <button type="submit" class="btn btn-danger" onclick="return confirm('Bạn có chắc muốn xóa?');">Xóa</button>
                                        </form>
                                    </td>
                                </tr>
                        <% } 
                        } else { %>
                            <tr>
                                <td colspan="5" class="text-center">Không có dữ liệu.</td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Add Price Modal -->
    <div class="modal fade" id="addPriceModal" tabindex="-1" aria-labelledby="addPriceModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <form action="ThemGiaController" method="post">
                    <div class="modal-header">
                        <h5 class="modal-title" id="addPriceModalLabel">Thêm Giá</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-3">
                            <label for="maSanPham" class="form-label">Mã Sản Phẩm</label>
                            <input type="number" class="form-control" id="maSanPham" name="maSanPham" value="<%= request.getAttribute("maSanPham") %>" readonly>
                        </div>
                        <div class="mb-3">
                            <label for="gia" class="form-label">Giá</label>
                            <input type="number" class="form-control" id="gia" name="gia" required>
                        </div>
                        
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                        <button type="submit" class="btn btn-primary">Lưu</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
	<!-- Edit Price Modal -->
	<div class="modal fade" id="editPriceModal" tabindex="-1" aria-labelledby="editPriceModalLabel" aria-hidden="true">
	    <div class="modal-dialog">
	        <div class="modal-content">
	            <form action="SuaGiaController" method="post">
	                <div class="modal-header">
	                    <h5 class="modal-title" id="editPriceModalLabel">Sửa Giá</h5>
	                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	                </div>
	                <div class="modal-body">
	                    <div class="mb-3">
	                        <label for="editMaGia" class="form-label">Mã Giá</label>
	                        <input type="text" class="form-control" id="editMaGia" name="maGia" readonly>
	                    </div>
	                    
	                    <div class="mb-3">
	                        <label for="editGia" class="form-label">Giá</label>
	                        <input type="number" class="form-control" id="editGia" name="gia" required>
	                    </div>
	                    <input type="hidden" name="maSanPham1" value="<%= request.getAttribute("maSanPham")%>">
	                </div>
	                <div class="modal-footer">
	                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
	                    <button type="submit" class="btn btn-primary" >Lưu</button>
	                </div>
	            </form>
	        </div>
	    </div>
	</div>
		
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
    // Cập nhật dữ liệu vào modal sửa giá
document.addEventListener("DOMContentLoaded", () => {
    const editPriceModal = document.getElementById("editPriceModal");

    editPriceModal.addEventListener("show.bs.modal", function (event) {
        const button = event.relatedTarget; // Nút được click
        const maGia = button.getAttribute("data-id");
        const gia = button.getAttribute("data-price");

        // Set giá trị cho các trường trong modal
        this.querySelector("#editMaGia").value = maGia;
        this.querySelector("#editGia").value = gia;
    });
});
    </script>
</body>

</html>
