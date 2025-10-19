<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Chi tiết đơn hàng</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/cssadmin/admin-order.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/cssadmin/admin-base.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/cssadmin/admin-components.css">
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
                <a href="${pageContext.request.contextPath}/admin/order/list" class="menu-item active"><span>🧾</span>Đơn hàng</a>
                <a href="${pageContext.request.contextPath}/admin/customer/list" class="menu-item"><span>👥</span>Khách hàng</a>
                <a href="${pageContext.request.contextPath}/AdminOldDeviceServlet" class="menu-item"><span>♻️</span>Thu máy cũ</a>
                <a href="${pageContext.request.contextPath}/AdminRepairScheduleServlet" class="menu-item"><span>🛠️</span>Lịch sửa chữa</a>
            </nav>
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <div class="breadcrumb">
                Trang chủ / Đơn hàng / Chi tiết đơn hàng </div>
            <div class="admin-container">
                <h1>Chi tiết đơn hàng</h1>
                <div class="order-details">
                    <h2>Trạng thái / Chi tiết đơn hàng</h2>
                    <p><strong>Tên khách hàng:</strong> ${order.tenKhachHang}</p>
                    <p><strong>Điện thoại:</strong> ${order.dienThoai}</p>
                    <p><strong>Thời gian đặt hàng:</strong> <fmt:formatDate value="${order.ngayDat}" pattern="dd/MM/yyyy HH:mm:ss" /></p>
                    <p><strong>Địa chỉ:</strong> ${order.diaChi}</p>
                    <!-- Thêm trạng thái đơn hàng -->
                    <p><strong>Trạng thái:</strong>
                        <c:choose>
                            <c:when test="${order.trangThai == 'ChoXacNhan'}">
                                <span class="status-badge status-pending">Đang chờ duyệt</span>
                            </c:when>
                            <c:when test="${order.trangThai == 'DaThanhToan'}">
                                <span class="status-badge status-shipping">Đã thanh toán</span>
                            </c:when>
                            <c:when test="${order.trangThai == 'DangGiao'}">
                                <span class="status-badge status-shipping">Đang giao</span>
                            </c:when>
                            <c:when test="${order.trangThai == 'HoanTat'}">
                                <span class="status-badge status-delivered">Hoàn tất</span>
                            </c:when>
                            <c:when test="${order.trangThai == 'Huy'}">
                                <span class="status-badge status-cancelled">Đã hủy</span>
                            </c:when>
                            <c:otherwise>
                                <span class="status-badge">${order.trangThai}</span>
                            </c:otherwise>
                        </c:choose>
                    </p>

                    <table class="order-table">
                        <thead>
                            <tr>
                                <th>STT</th>
                                <th>Tên sản phẩm</th>
                                <th>Số lượng</th>
                                <th>Giá bán</th>
                                <th>Thành tiền</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="item" items="${orderDetails}" varStatus="loop">
                                <tr>
                                    <td>${loop.count}</td>
                                    <td>${item.tenSanPham}</td>
                                    <td>${item.soLuong}</td>
                                    <td><fmt:formatNumber value="${item.gia}" type="currency" currencySymbol="đ" /></td>
                                    <td><fmt:formatNumber value="${item.soLuong * item.gia}" type="currency" currencySymbol="đ" /></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                    <p><strong>Tổng cộng:</strong> <span style="color: red;"><fmt:formatNumber value="${totalAmount}" type="currency" currencySymbol="đ" /></span></p>
                </div>

                <!-- Pagination (optional, can be adjusted based on need) -->
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