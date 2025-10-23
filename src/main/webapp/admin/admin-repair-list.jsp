<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quản lý lịch sửa chữa</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/cssadmin/admin-base.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/cssadmin/admin-components.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/cssadmin/admin-customer.css">
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
            <a href="${pageContext.request.contextPath}/admin/customer/list" class="menu-item"><span>👥</span>Khách hàng</a>
            <a href="${pageContext.request.contextPath}/AdminOldDeviceServlet" class="menu-item"><span>♻️</span>Thu máy cũ</a>
            <a href="${pageContext.request.contextPath}/AdminRepairScheduleServlet" class="menu-item active"><span>🛠️</span>Lịch sửa chữa</a>
        </nav>
    </div>
    <!-- Main Content -->
    <div class="main-content">
        <div class="breadcrumb">
                Trang chủ / Sửa chữa
        </div>
        <div class="admin-container">
            <h1>Danh sách lịch sửa chữa</h1>
            <div class="toolbar">
                <a href="AdminRepairScheduleServlet?action=add" class="btn">+ Thêm mới</a>
            </div>

            <table>
                <thead>
                <tr>
                    <th>Mã SC</th>
                    <th>Mã ND</th>
                    <th>Tên thiết bị</th>
                    <th>Mô tả lỗi</th>
                    <th>Chi phí dự kiến</th>
                    <th>Chi phí thực tế</th>
                    <th>Trạng thái</th>
                    <th>Ngày tiếp nhận</th>
                    <th>Ngày hoàn tất</th>
                    <th>Hành động</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="item" items="${list}">
                    <tr>
                        <td>${item.maSC}</td>
                        <td>${item.maND}</td>
                        <td>${item.tenThietBi}</td>
                        <td>${item.moTaLoi}</td>
                        <td>${item.chiPhiDuKien}</td>
                        <td>${item.chiPhiThucTe}</td>
                        <td>${item.trangThai}</td>
                        <td>${item.ngayTiepNhan}</td>
                        <td>${item.ngayHoanTat}</td>
                        <td>
                            <a href="AdminRepairScheduleServlet?action=edit&id=${item.maSC}" class="btn">Sửa</a>
                            <a href="AdminRepairScheduleServlet?action=delete&id=${item.maSC}" onclick="return confirm('Xóa lịch này?')" class="btn btn-danger">Xóa</a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
</body>
</html>
