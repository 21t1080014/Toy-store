<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng Nhập Quản Trị</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container">
        <div class="row justify-content-center" style="margin-top: 100px;">
            <div class="col-md-4">
                <h2 class="text-center">Đăng Nhập Quản Trị</h2>
                <form action="DangNhapAdminController" method="post">
                    <div class="form-group">
                        <label for="Admin_dn">Tên Đăng Nhập</label>
                        <input type="text" class="form-control" id="Admin_dn" name="Admin_dn" required>
                    </div>
                    <div class="form-group">
                        <label for="Admin_mk">Mật Khẩu</label>
                        <input type="password" class="form-control" id="Admin_mk" name="Admin_mk" required>
                    </div>
                    <button type="submit" class="btn btn-primary btn-block">Đăng Nhập</button>
                </form>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.0.9/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>