<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Sửa khách hàng</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/cssadmin/admin-base.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/cssadmin/admin-components.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/cssadmin/admin-pages.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/cssadmin/admin-responsive.css">
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
            <a href="${pageContext.request.contextPath}/admin/product/list" class="menu-item"><span>📦</span>Sản phẩm</a>
            <a href="${pageContext.request.contextPath}/admin/category/list" class="menu-item"><span>📂</span>Danh mục</a>
            <a href="${pageContext.request.contextPath}/admin/order/list" class="menu-item"><span>🧾</span>Đơn hàng</a>
            <a href="${pageContext.request.contextPath}/admin/customer/list" class="menu-item active"><span>👥</span>Khách hàng</a>
            <a href="${pageContext.request.contextPath}/AdminOldDeviceServlet" class="menu-item"><span>♻️</span>Thu máy cũ</a>
            <a href="${pageContext.request.contextPath}/AdminRepairScheduleServlet" class="menu-item"><span>🛠️</span>Lịch sửa chữa</a>
            </nav>
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <div class="admin-container">
                <h1>Sửa khách hàng</h1>
                <form action="${pageContext.request.contextPath}/admin/customer/edit" method="post">
                    <input type="hidden" name="maND" value="${customer.maND}" />
                    <input type="hidden" name="maTK" value="${customer.maTK}" />

                    <label>Họ tên:</label>
                    <input type="text" name="hoTen" value="${customer.hoTen}" required />

                    <label>Email:</label>
                    <input type="email" name="email" value="${customer.email}" required />

                    <label>Ngày tạo (người dùng):</label>
                    <input type="datetime-local" name="ngayTao" value="<fmt:formatDate value="${customer.ngayTao}" pattern="yyyy-MM-dd'T'HH:mm" />" required />

                    <label>Số điện thoại:</label>
                    <input type="text" name="soDT" value="${customer.soDT}" required />

                    <label>Địa chỉ:</label>
                    <input type="text" name="diaChi" value="${customer.diaChi}" required />

                    <label>Tên đăng nhập:</label>
                    <input type="text" name="tenDangNhap" value="${customer.tenDangNhap}" required />

                    <label>Mật khẩu (để trống nếu không thay đổi):</label>
                    <input type="password" name="matKhau" />

                    <label>Vai trò:</label>
                    <select name="vaiTro">
                        <option value="KhachHang" ${customer.vaiTro == 'KhachHang' ? 'selected' : ''}>Khách hàng</option>
                        <option value="Admin" ${customer.vaiTro == 'Admin' ? 'selected' : ''}>Admin</option>
                        <option value="NhanVien" ${customer.vaiTro == 'NhanVien' ? 'selected' : ''}>Nhân viên</option>
                    </select>

                    <label>Trạng thái:</label>
                    <input type="checkbox" name="trangThai" ${customer.trangThai ? 'checked' : ''} /> Hoạt động

                    <label>Ngày tạo (tài khoản):</label>
                    <input type="datetime-local" name="ngayTaoTK" value="<fmt:formatDate value="${customer.ngayTaoTK}" pattern="yyyy-MM-dd'T'HH:mm" />" required />

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