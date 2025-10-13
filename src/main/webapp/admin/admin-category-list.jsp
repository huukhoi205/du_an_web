<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Danh sách danh mục</title>
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
            <a href="${pageContext.request.contextPath}/admin/category/list" class="menu-item active"><span>📂</span>Danh mục</a>
            <a href="${pageContext.request.contextPath}/admin/order/list" class="menu-item"><span>🧾</span>Đơn hàng</a>
            <a href="${pageContext.request.contextPath}/admin/customer/list" class="menu-item "><span>👥</span>Khách hàng</a>
            <a href="${pageContext.request.contextPath}/AdminOldDeviceServlet" class="menu-item"><span>♻️</span>Thu máy cũ</a>
            <a href="${pageContext.request.contextPath}/AdminRepairScheduleServlet" class="menu-item"><span>🛠️</span>Lịch sửa chữa</a>
            </nav>
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <div class="admin-container">
                <h1>Danh sách danh mục</h1>
                <div class="toolbar">
                    <a href="${pageContext.request.contextPath}/admin/category/add" class="btn">+ Thêm mới</a>
                </div>

                <table>
                    <thead>
                    <tr>
                        <th>MaDM</th>
                        <th>Tên danh mục</th>
                        <th>Hành động</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="cat" items="${categories}">
                        <tr>
                            <td>${cat.maDM}</td>
                            <td>${cat.tenDM}</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/admin/category/edit?maDM=${cat.maDM}" class="btn">Sửa</a>
                                <a href="${pageContext.request.contextPath}/admin/category/delete?maDM=${cat.maDM}" onclick="return confirm('Xóa danh mục này?')" class="btn btn-danger">Xóa</a>
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