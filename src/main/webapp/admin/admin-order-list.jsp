<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Danh sách đơn hàng</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/cssadmin/admin-base.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/cssadmin/admin-components.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/cssadmin/admin-pages.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/cssadmin/admin-responsive.css">
</head>
<body>
    <!-- Error Message -->
    <c:if test="${not empty param.error}">
        <p style="color: red;">
            <c:choose>
                <c:when test="${param.error == 'invalidMaDH'}">Mã đơn hàng không hợp lệ.</c:when>
                <c:when test="${param.error == 'orderNotFound'}">Không tìm thấy đơn hàng.</c:when>
                <c:when test="${param.error == 'serverError'}">Lỗi máy chủ, vui lòng thử lại.</c:when>
                <c:otherwise>Lỗi không xác định.</c:otherwise>
            </c:choose>
        </p>
    </c:if>

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
            <a href="${pageContext.request.contextPath}/admin/order/list" class="menu-item active"><span>🧾</span>Đơn hàng</a>
            <a href="${pageContext.request.contextPath}/admin/customer/list" class="menu-item"><span>👥</span>Khách hàng</a>
            <a href="${pageContext.request.contextPath}/AdminOldDeviceServlet" class="menu-item"><span>♻️</span>Thu máy cũ</a>
            <a href="${pageContext.request.contextPath}/AdminRepairScheduleServlet" class="menu-item"><span>🛠️</span>Lịch sửa chữa</a>
            </nav>
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <div class="admin-container">
                <h1>Danh sách đơn hàng</h1>
                <div class="toolbar">
                    <a href="${pageContext.request.contextPath}/admin/order/add" class="btn">+ Tạo đơn hàng</a>
                </div>

                <table>
                    <thead>
                    <tr>
                        <th>MaDH</th>
                        <th>MaND</th>
                        <th>Ngày đặt</th>
                        <th>Trạng thái</th>
                        <th>Tổng tiền</th>
                        <th>Hành động</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="o" items="${orders}">
                        <tr>
                            <td>${o.maDH}</td>
                            <td>${o.maND}</td>
                            <td><fmt:formatDate value="${o.ngayDat}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                            <td>${o.trangThai}</td>
                            <td>${o.tongTien}</td>
                            <td>
                                <form action="${pageContext.request.contextPath}/admin/order/edit" method="post" style="display:inline-block">
                                    <input type="hidden" name="maDH" value="${o.maDH}" />
                                    <button type="submit" class="btn">Cập nhật</button>
                                </form>
                                <a href="${pageContext.request.contextPath}/admin/order/delete?maDH=${o.maDH}" onclick="return confirm('Xóa đơn hàng này?')" class="btn btn-danger">Xóa</a>
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