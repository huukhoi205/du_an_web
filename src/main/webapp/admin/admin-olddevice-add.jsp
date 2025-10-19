<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Thêm máy cũ</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/cssadmin/admin-base.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/cssadmin/admin-components.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/cssadmin/admin-pages.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/cssadmin/admin-responsive.css">
</head>
<body>
<div class="header">
    <div class="logo">
        <div class="logo-icon">n.u.t</div>
    </div>
    <div class="admin-info">Admin</div>
</div>

<div class="admin-layout">
    <div class="sidebar">
        <div class="sidebar-title">Hệ thống quản trị</div>
        <nav class="sidebar-menu">
            <a href="${pageContext.request.contextPath}/admin/product/list" class="menu-item"><span>📦</span>Sản phẩm</a>
            <a href="${pageContext.request.contextPath}/admin/category/list" class="menu-item"><span>📂</span>Danh mục</a>
            <a href="${pageContext.request.contextPath}/admin/order/list" class="menu-item"><span>🧾</span>Đơn hàng</a>
            <a href="${pageContext.request.contextPath}/admin/customer/list" class="menu-item"><span>👥</span>Khách hàng</a>
            <a href="${pageContext.request.contextPath}/AdminOldDeviceServlet" class="menu-item active"><span>♻️</span>Thu máy cũ</a>
            <a href="${pageContext.request.contextPath}/AdminRepairScheduleServlet" class="menu-item"><span>🛠️</span>Lịch sửa chữa</a>
        </nav>
    </div>

    <div class="main-content">
        <div class="breadcrumb">
            Trang chủ / Thu máy cũ / Thêm máy cũ
        <div class="admin-container">
            <h1>Thêm máy cũ</h1>
            <form action="AdminOldDeviceServlet" method="post">
                <input type="hidden" name="action" value="create" />

                <label>Mã người dùng:</label>
                <input type="number" name="maND" required />

                <label>Tên máy:</label>
                <input type="text" name="tenMay" required />

                <label>Hãng sản xuất:</label>
                <input type="text" name="hangSX" required />

                <label>Tình trạng:</label>
                <input type="text" name="tinhTrang" />

                <label>Giá đề xuất:</label>
                <input type="text" name="giaDeXuat" />

                <label>Giá thỏa thuận:</label>
                <input type="text" name="giaThoaThuan" />

                <div class="form-group">
                    <label>Trạng thái: <span class="required">*</span></label>
                    <select name="trangThai" required>
                        <option value="TiepNhan">Tiếp nhận</option>
                        <option value="HoanTat">Hoàn tất</option>
                        <option value="Huy">Hủy</option>
                    </select>
                </div>

                <label>Địa chỉ nhận:</label>
                <input type="text" name="diaChiNhan" />

                <div class="btn-group">
                    <button type="submit" class="btn">Lưu</button>
                    <a href="AdminOldDeviceServlet" class="btn btn-secondary">Hủy</a>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>