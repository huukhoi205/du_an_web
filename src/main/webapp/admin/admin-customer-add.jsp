<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Thêm khách hàng</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/cssadmin/admin-common.css">
</head>
<body>
    <!-- Header -->
    <div class="header">
        <div class="logo">
            <div class="logo-icon">n.u.t</div>
        </div>
        <div class="admin-info">
            Admin
        </div>
    </div>

    <!-- Layout Container -->
    <div class="admin-layout">
        <!-- Sidebar -->
        <div class="sidebar">
            <div class="sidebar-title">Hệ thống quản trị</div>
            <nav class="sidebar-menu">
                <a href="${pageContext.request.contextPath}/admin/product/list" class="menu-item">
                    <span class="menu-icon">👤</span>
                    <span>Sản phẩm</span>
                </a>
                <a href="${pageContext.request.contextPath}/admin/category/list" class="menu-item">
                    <span class="menu-icon">👤</span>
                    <span>Danh mục</span>
                </a>
                <a href="${pageContext.request.contextPath}/admin/order/list" class="menu-item">
                    <span class="menu-icon">👤</span>
                    <span>Đơn hàng</span>
                </a>
                <a href="${pageContext.request.contextPath}/admin/customer/list" class="menu-item active">
                    <span class="menu-icon">👤</span>
                    <span>Khách hàng</span>
                </a>
            </nav>
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <div class="admin-container">
                <h1>Thêm khách hàng</h1>
                <form action="${pageContext.request.contextPath}/admin/customer/add" method="post">
                    <label>Họ tên:</label>
                    <input type="text" name="hoTen" required />

                    <label>Email:</label>
                    <input type="email" name="email" required />

                    <label>Mật khẩu:</label>
                    <input type="password" name="matKhau" required />

                    <label>Vai trò:</label>
                    <input type="text" name="vaiTro" value="user" />

                    <div class="form-actions">
                        <button type="submit">Lưu</button>
                        <a href="${pageContext.request.contextPath}/admin/customer/list" class="btn">Hủy</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>