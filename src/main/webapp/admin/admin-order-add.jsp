<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Tạo đơn hàng</title>
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
                <c:when test="${param.error == 'invalidMaND'}">Mã khách hàng không hợp lệ.</c:when>
                <c:when test="${param.error == 'invalidTrangThai'}">Trạng thái không hợp lệ hoặc quá dài.</c:when>
                <c:when test="${param.error == 'invalidTongTien'}">Tổng tiền không hợp lệ.</c:when>
                <c:when test="${param.error == 'negativeTongTien'}">Tổng tiền không được âm.</c:when>
                

                <c:when test="${param.error == 'invalidInput'}">Dữ liệu đầu vào không hợp lệ.</c:when>
                <c:when test="${param.error == 'serverError'}">Lỗi máy chủ, vui lòng thử lại.</c:when>
                <c:otherwise>Lỗi không xác định: ${param.error}</c:otherwise>
            </c:choose>
        </p>
    </c:if>

    <c:if test="${not empty param.success}">
        <p style="color: green;">Thêm đơn hàng thành công!</p>
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
                <h1>Tạo đơn hàng</h1>
                <form action="${pageContext.request.contextPath}/admin/order/add" method="post">
                    <label>Khách hàng (maND):</label>
                    <c:choose>
                        <c:when test="${not empty customers}">
                            <select name="maND" required>
                                <option value="">-- Chọn khách hàng --</option>
                                <c:forEach var="c" items="${customers}">
                                    <option value="${c.maND}">${c.hoTen} (${c.maND})</option>
                                </c:forEach>
                            </select>
                        </c:when>
                        <c:otherwise>
                            <input type="number" name="maND" required placeholder="Nhập mã khách hàng" />
                            <small style="color: #666;">Lưu ý: Mã khách hàng phải tồn tại trong hệ thống (hiện có: 1, 2, 3)</small>
                        </c:otherwise>
                    </c:choose>

                    <label>Trạng thái:</label>
                    <select name="trangThai" required>
                        <option value="ChoXacNhan" selected>Chờ xác nhận</option>
                        <option value="DaThanhToan">Đã thanh toán</option>
                        <option value="DangGiao">Đang giao</option>
                        <option value="HoanTat">Hoàn tất</option>
                        <option value="Huy">Hủy</option>
                    </select>

                    <label>Tổng tiền:</label>
                    <input type="number" step="1" name="tongTien" value="0" required min="0" placeholder="Nhập tổng tiền"/>

                    <div class="form-actions">
                        <button type="submit">Tạo</button>
                        <a href="${pageContext.request.contextPath}/admin/order/list" class="btn">Hủy</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>