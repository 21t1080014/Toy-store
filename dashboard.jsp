<%@page import="java.util.List"%>
<%@page import="dangnhapAdminModal.dangnhapAdmin"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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
                <h1 class="text-center my-4">Welcome to Admin Dashboard</h1>
                <div class="row g-4">
                    <!-- Total Users -->
                    <div class="col-md-6">
                        <div class="card text-center shadow">
                            <div class="card-body">
                                <h2 class="card-title text-primary">
                                    <%= request.getAttribute("totalUsers") != null ? request.getAttribute("totalUsers") : 0 %>
                                </h2>
                                <p class="card-text">Total Users</p>
                            </div>
                        </div>
                    </div>

                    <!-- Total Products -->
                    <div class="col-md-6">
                        <div class="card text-center shadow">
                            <div class="card-body">
                                <h2 class="card-title text-success">
                                    <%= request.getAttribute("totalProducts") != null ? request.getAttribute("totalProducts") : 0 %>
                                </h2>
                                <p class="card-text">Total Products</p>
                            </div>
                        </div>
                    </div>

                    <!-- Total Orders -->
                    <div class="col-md-6">
                        <div class="card text-center shadow">
                            <div class="card-body">
                                <h2 class="card-title text-warning">
                                    <%= request.getAttribute("totalOrders") != null ? request.getAttribute("totalOrders") : 0 %>
                                </h2>
                                <p class="card-text">Total Orders</p>
                            </div>
                        </div>
                    </div>

                    <!-- Total Categories -->
                    <div class="col-md-6">
                        <div class="card text-center shadow">
                            <div class="card-body">
                                <h2 class="card-title text-warning">
                                    <%= request.getAttribute("totalDanhMuc") != null ? request.getAttribute("totalDanhMuc") : 0 %>
                                </h2>
                                <p class="card-text">Total Categories</p>
                            </div>
                        </div>
                    </div>

                    <!-- Chart for Statistics -->
                    <div class="col-md-4">
                        <div class="card shadow">
                            <div class="card-body">
                                <h5 class="card-title text-center">Thống kê</h5>
                                <canvas id="myChart" width="400" height="200"></canvas>
                            </div>
                        </div>
                    </div>

                    <!-- Chart for Revenue (Doanh Thu) -->
                    <div class="col-md-8">
                        <div class="card shadow">
                            <div class="card-body">
                                <h5 class="card-title text-center">Doanh Thu 30 Ngày Qua</h5>
                                <canvas id="doanhThuChart" width="400" height="200"></canvas>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Data for Doanh Thu chart from backend
        var doanhThuData = <%= new org.json.JSONArray((List) request.getAttribute("doanhThu30Ngay")).toString() %>;

        // Prepare data for the Doanh Thu chart
        var labels = doanhThuData.map(item => item.Ngay);
        var data = doanhThuData.map(item => item.DoanhThu);

        // Render the Doanh Thu Chart
        var ctx = document.getElementById('doanhThuChart').getContext('2d');
        var myChart = new Chart(ctx, {
            type: 'line',
            data: {
                labels: labels,
                datasets: [{
                    label: 'Doanh thu 30 ngày qua',
                    data: data,
                    borderColor: 'rgba(75, 192, 192, 1)',
                    backgroundColor: 'rgba(75, 192, 192, 0.2)',
                    borderWidth: 1
                }]
            },
            options: {
                scales: {
                    x: {
                        title: {
                            display: true,
                            text: 'Ngày'
                        }
                    },
                    y: {
                        title: {
                            display: true,
                            text: 'Doanh thu (VND)'
                        },
                        beginAtZero: true
                    }
                }
            }
        });

        // Data for Pie Chart (Thống kê)
        const totalUsers = <%= request.getAttribute("totalUsers") != null ? request.getAttribute("totalUsers") : 0 %>;
        const totalProducts = <%= request.getAttribute("totalProducts") != null ? request.getAttribute("totalProducts") : 0 %>;
        const totalOrders = <%= request.getAttribute("totalOrders") != null ? request.getAttribute("totalOrders") : 0 %>;
        const totalDanhMuc = <%= request.getAttribute("totalDanhMuc") != null ? request.getAttribute("totalDanhMuc") : 0 %>;

        // Render Pie Chart for Statistics
        const ctxPie = document.getElementById('myChart').getContext('2d');
        const pieChart = new Chart(ctxPie, {
            type: 'pie',
            data: {
                labels: ['Người dùng', 'Sản phẩm', 'Đơn hàng', 'Danh mục'],
                datasets: [{
                    label: 'Thống kê',
                    data: [totalUsers, totalProducts, totalOrders, totalDanhMuc],
                    backgroundColor: [
                        'rgba(54, 162, 235, 0.7)',  // Blue
                        'rgba(75, 192, 192, 0.7)',  // Green
                        'rgba(255, 159, 64, 0.7)',  // Orange
                        'rgba(153, 102, 255, 0.7)'  // Purple
                    ],
                    borderColor: [
                        'rgba(54, 162, 235, 1)', 
                        'rgba(75, 192, 192, 1)', 
                        'rgba(255, 159, 64, 1)', 
                        'rgba(153, 102, 255, 1)'
                    ],
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: {
                        position: 'top',
                    },
                    tooltip: {
                        callbacks: {
                            label: function(tooltipItem) {
                                return tooltipItem.label + ': ' + tooltipItem.raw;
                            }
                        }
                    }
                }
            }
        });
    </script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>
