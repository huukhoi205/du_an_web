<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Danh sách đơn hàng</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/cssadmin/admin-order.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/cssadmin/admin-base.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/cssadmin/admin-components.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/cssadmin/admin-responsive.css">
</head>
<body>
    <!-- Error Message -->
    <c:if test="${not empty param.error}">
        <div class="error-message">
            <c:choose>
                <c:when test="${param.error == 'invalidMaDH'}">Mã đơn hàng không hợp lệ.</c:when>
                <c:when test="${param.error == 'orderNotFound'}">Không tìm thấy đơn hàng.</c:when>
                <c:when test="${param.error == 'serverError'}">Lỗi máy chủ, vui lòng thử lại.</c:when>
                <c:otherwise>Lỗi không xác định.</c:otherwise>
            </c:choose>
        </div>
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
            <div class="breadcrumb">Trang chủ / Đơn hàng</div>
                <h1>Danh sách đơn hàng</h1>
                <div class="toolbar">
                    <a href="${pageContext.request.contextPath}/admin/order/add" class="btn btn-primary">+ Tạo đơn hàng</a>
                </div>

                <table class="order-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Khách hàng</th>
                            <th>Số điện thoại</th>
                            <th>Ngày đặt</th>
                            <th>Trạng thái</th>
                            <th>Giá trị đơn hàng</th>
                            <th>Xử lý đơn</th>
                            <th>Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="o" items="${orders}">
                            <tr>
                                <td>${o.maDH}</td>
                                <td>${o.tenKhachHang}</td> <!-- Thay maND bằng tenKhachHang -->
                                <td class="phone-number">${o.dienThoai}</td> <!-- Thay hardcode bằng dienThoai -->
                                <td><fmt:formatDate value="${o.ngayDat}" pattern="dd/MM/yyyy"/></td>
                                <td>
                                    <c:choose>
                                        <c:when test="${o.trangThai == 'Đang chờ duyệt'}">
                                            <span class="status-badge status-pending">${o.trangThai}</span>
                                        </c:when>
                                        <c:when test="${o.trangThai == 'Đang giao hàng'}">
                                            <span class="status-badge status-shipping">${o.trangThai}</span>
                                        </c:when>
                                        <c:when test="${o.trangThai == 'Đã giao'}">
                                            <span class="status-badge status-delivered">${o.trangThai}</span>
                                        </c:when>
                                        <c:when test="${o.trangThai == 'Đã hủy'}">
                                            <span class="status-badge status-cancelled">${o.trangThai}</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="status-badge">${o.trangThai}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="price">${o.tongTien}</td>
                                <td>
                                    <div class="order-processing">
                                        <c:choose>
                                            <c:when test="${o.trangThai == 'Đang chờ duyệt'}">
                                                <a href="${pageContext.request.contextPath}/admin/order/approve?maDH=${o.maDH}" class="process-btn">Duyệt đơn</a>
                                            </c:when>
                                            <c:when test="${o.trangThai == 'Đang giao hàng'}">
                                                <a href="${pageContext.request.contextPath}/admin/order/confirm-payment?maDH=${o.maDH}" class="process-btn">Xác nhận thanh toán</a>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="no-action">-</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/admin/order/detail?maDH=${o.maDH}" class="view-detail">Xem chi tiết</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>

                <!-- Pagination -->
                <div class="pagination">
                    <a href="#" class="page-link">Trang đầu</a>
                    <a href="#" class="page-link">Trước</a>
                    <a href="#" class="page-link current">1</a>
                    <a href="#" class="page-link">2</a>
                    <a href="#" class="page-link">3</a>
                    <a href="#" class="page-link">Sau</a>
                    <a href="#" class="page-link">Trang cuối</a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>