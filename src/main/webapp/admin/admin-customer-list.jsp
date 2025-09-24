<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Danh sách khách hàng</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/cssadmin/admin-customer.css">
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
                <h1>Danh sách khách hàng</h1>
                <div class="toolbar">
                    <a href="${pageContext.request.contextPath}/admin/customer/add" class="btn">+ Thêm mới</a>
                </div>

                <table>
                    <thead>
                    <tr>
                        <th>MaND</th>
                        <th>Họ tên</th>
                        <th>Email</th>
                        <th>Vai trò</th>
                        <th>Hành động</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="c" items="${customers}">
                        <tr>
                            <td>${c.maND}</td>
                            <td>${c.hoTen}</td>
                            <td>${c.email}</td>
                            <td>${c.vaiTro}</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/admin/customer/edit?maND=${c.maND}" class="btn">Sửa</a>
                                <a href="${pageContext.request.contextPath}/admin/customer/delete?maND=${c.maND}" onclick="return confirm('Xóa khách hàng này?')" class="btn btn-danger">Xóa</a>
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