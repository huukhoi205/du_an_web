<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.admin.RepairSchedule" %>
<!DOCTYPE html>
<html>
<head>
    <title>Chỉnh sửa lịch sửa chữa</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/cssadmin/admin-category.css">
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
            <a href="${pageContext.request.contextPath}/AdminOldDeviceServlet" class="menu-item"><span>♻️</span>Thu máy cũ</a>
            <a href="${pageContext.request.contextPath}/AdminRepairScheduleServlet" class="menu-item active"><span>🛠️</span>Lịch sửa chữa</a>
        </nav>
    </div>

    <div class="main-content">
        <div class="admin-container">
            <%
            RepairSchedule item = (RepairSchedule) request.getAttribute("item");
            if (item == null) {
            %>
            <p>Không tìm thấy dữ liệu.</p>
            <a href="AdminRepairScheduleServlet" class="btn">Quay lại</a>
            <%
            } else {
            %>
            <h1>Chỉnh sửa lịch sửa chữa</h1>
            <form action="AdminRepairScheduleServlet" method="post">
                <input type="hidden" name="action" value="update" />
                <input type="hidden" name="maSC" value="<%= item.getMaSC() %>" />

                <label>Mã người dùng:</label>
                <input type="number" name="maND" value="<%= item.getMaND() %>" required />

                <label>Tên thiết bị:</label>
                <input type="text" name="tenThietBi" value="<%= item.getTenThietBi() %>" required />

                <label>Mô tả lỗi:</label>
                <input type="text" name="moTaLoi" value="<%= item.getMoTaLoi() %>" />

                <label>Chi phí dự kiến:</label>
                <input type="text" name="chiPhiDuKien" value="<%= item.getChiPhiDuKien() %>" />

                <label>Chi phí thực tế:</label>
                <input type="text" name="chiPhiThucTe" value="<%= item.getChiPhiThucTe() %>" />

                <label>Trạng thái:</label>
                <input type="text" name="trangThai" value="<%= item.getTrangThai() %>" />

                <label>Ngày hoàn tất (YYYY-MM-DD HH:MM:SS):</label>
                <input type="text" name="ngayHoanTat" value="<%= item.getNgayHoanTat() %>" />

                <div class="btn-group">
                    <button type="submit" class="btn">Cập nhật</button>
                    <a href="AdminRepairScheduleServlet" class="btn btn-secondary">Hủy</a>
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
