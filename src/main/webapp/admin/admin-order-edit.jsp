<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Chi tiết / Sửa đơn hàng</title>
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
                <a href="${pageContext.request.contextPath}/admin/order/list" class="menu-item active">
                    <span class="menu-icon">👤</span>
                    <span>Đơn hàng</span>
                </a>
                <a href="${pageContext.request.contextPath}/admin/customer/list" class="menu-item">
                    <span class="menu-icon">👤</span>
                    <span>Khách hàng</span>
                </a>
            </nav>
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <div class="admin-container">
                <h1>Chi tiết đơn hàng</h1>
                <c:if test="${not empty order}">
                    <form action="${pageContext.request.contextPath}/admin/order/update" method="post">
                        <input type="hidden" name="maDH" value="${order.maDH}" />
                        <p><strong>MaND:</strong> ${order.maND}</p>
                        <p><strong>Ngày đặt:</strong> <fmt:formatDate value="${order.ngayDat}" pattern="yyyy-MM-dd HH:mm:ss"/></p>

                        <label>Trạng thái:</label>
                        <input type="text" name="trangThai" value="${order.trangThai}" />

                        <label>Tổng tiền:</label>
                        <input type="number" step="0.01" name="tongTien" value="${order.tongTien}" />

                        <div class="form-actions">
                            <button type="submit">Cập nhật</button>
                            <a href="${pageContext.request.contextPath}/admin/order/list" class="btn">Hủy</a>
                        </div>
                    </form>
                </c:if>
                <c:if test="${empty order}">
                    <p>Không có dữ liệu đơn hàng để hiển thị.</p>
                </c:if>
            </div>
        </div>
    </div>
</body>
</html>