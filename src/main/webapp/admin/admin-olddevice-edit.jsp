<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.admin.OldDevice" %>
<!DOCTYPE html>
<html>
<head>
    <title>Chỉnh sửa máy cũ</title>
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
        <div class="admin-container">
            <%
            OldDevice item = (OldDevice) request.getAttribute("item");
            if (item == null) {
            %>
            <p>Không tìm thấy dữ liệu.</p>
            <a href="AdminOldDeviceServlet" class="btn">Quay lại</a>
            <%
            } else {
            %>
            <h1>Chỉnh sửa máy cũ</h1>
            <form action="AdminOldDeviceServlet" method="post">
                <input type="hidden" name="action" value="update" />
                <input type="hidden" name="maTMC" value="<%= item.getMaTMC() %>" />

                <label>Mã người dùng:</label>
                <input type="number" name="maND" value="<%= item.getMaND() %>" required />

                <label>Tên máy:</label>
                <input type="text" name="tenMay" value="<%= item.getTenMay() %>" required />

                <label>Hãng sản xuất:</label>
                <input type="text" name="hangSX" value="<%= item.getHangSX() %>" required />

                <label>Tình trạng:</label>
                <input type="text" name="tinhTrang" value="<%= item.getTinhTrang() %>" />

                <label>Giá đề xuất:</label>
                <input type="text" name="giaDeXuat" value="<%= item.getGiaDeXuat() %>" />

                <label>Giá thỏa thuận:</label>
                <input type="text" name="giaThoaThuan" value="<%= item.getGiaThoaThuan() %>" />

                <label>Trạng thái:</label>
                <select name="trangThai" required>
                    <option value="TiepNhan" <%= item.getTrangThai().equals("TiepNhan") ? "selected" : "" %>>Tiếp nhận</option>
                    <option value="HoanTat" <%= item.getTrangThai().equals("HoanTat") ? "selected" : "" %>>Hoàn tất</option>
                    <option value="Huy" <%= item.getTrangThai().equals("Huy") ? "selected" : "" %>>Hủy</option>
                </select>

                <label>Địa chỉ nhận:</label>
                <input type="text" name="diaChiNhan" value="<%= item.getDiaChiNhan() != null ? item.getDiaChiNhan() : "" %>" />

                <div class="btn-group">
                    <button type="submit" class="btn">Cập nhật</button>
                    <a href="AdminOldDeviceServlet" class="btn btn-secondary">Hủy</a>
                </div>
            </form>
            <%
            }
            %>
        </div>
    </div>
</div>
</body>
</html>