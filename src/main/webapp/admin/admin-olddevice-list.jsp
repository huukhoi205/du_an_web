<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quản lý thu máy cũ</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/cssadmin/admin-category.css">
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
            <a href="${pageContext.request.contextPath}/AdminOldDeviceServlet" class="menu-item active"><span>♻️</span>Thu máy cũ</a>
            <a href="${pageContext.request.contextPath}/AdminRepairScheduleServlet" class="menu-item"><span>🛠️</span>Lịch sửa chữa</a>
        </nav>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <div class="admin-container">
            <h1>Danh sách máy cũ thu mua</h1>
            <div class="toolbar">
                <a href="AdminOldDeviceServlet?action=add" class="btn">+ Thêm mới</a>
            </div>

            <table>
                <thead>
                <tr>
                    <th>Mã TMC</th>
                    <th>Mã ND</th>
                    <th>Tên máy</th>
                    <th>Hãng SX</th>
                    <th>Tình trạng</th>
                    <th>Giá đề xuất</th>
                    <th>Giá thỏa thuận</th>
                    <th>Trạng thái</th>
                    <th>Hành động</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="item" items="${list}">
                    <tr>
                        <td>${item.maTMC}</td>
                        <td>${item.maND}</td>
                        <td>${item.tenMay}</td>
                        <td>${item.hangSX}</td>
                        <td>${item.tinhTrang}</td>
                        <td>${item.giaDeXuat}</td>
                        <td>${item.giaThoaThuan}</td>
                        <td>${item.trangThai}</td>
                        <td>
                            <a href="AdminOldDeviceServlet?action=edit&id=${item.maTMC}" class="btn">Sửa</a>
                            <a href="AdminOldDeviceServlet?action=delete&id=${item.maTMC}" onclick="return confirm('Xóa máy này?')" class="btn btn-danger">Xóa</a>
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
