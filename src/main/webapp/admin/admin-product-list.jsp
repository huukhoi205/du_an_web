<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Danh sách sản phẩm</title>
    <!-- CSS Chung -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/cssadmin/admin-base.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/cssadmin/admin-components.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/cssadmin/admin-responsive.css">
    <!-- CSS Riêng cho Product Page -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/cssadmin/admin-product.css">
</head>
<body class="product-page">
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
                <a href="${pageContext.request.contextPath}/admin/product/list" class="menu-item active"><span>📦</span>Sản phẩm</a>
                <a href="${pageContext.request.contextPath}/admin/category/list" class="menu-item"><span>📂</span>Danh mục</a>
                <a href="${pageContext.request.contextPath}/admin/order/list" class="menu-item"><span>🧾</span>Đơn hàng</a>
                <a href="${pageContext.request.contextPath}/admin/customer/list" class="menu-item"><span>👥</span>Khách hàng</a>
                <a href="${pageContext.request.contextPath}/AdminOldDeviceServlet" class="menu-item"><span>♻️</span>Thu máy cũ</a>
                <a href="${pageContext.request.contextPath}/AdminRepairScheduleServlet" class="menu-item"><span>🛠️</span>Lịch sửa chữa</a>
            </nav>
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <!-- Breadcrumb -->
            <div class="breadcrumb">
                Trang chủ / Sản phẩm
            </div>

            <div class="admin-container">
                <h1>Danh sách sản phẩm</h1>
      
                <!-- Error/Success Messages -->
                <c:if test="${not empty sessionScope.error}">
                    <div class="error-message">${sessionScope.error}</div>
                    <c:remove var="error" scope="session"/>
                </c:if>
                <c:if test="${not empty sessionScope.success}">
                    <div class="success-message">${sessionScope.success}</div>
                    <c:remove var="success" scope="session"/>
                </c:if>

                <!-- Toolbar: Search Form + Action Buttons -->
                <div class="toolbar">
                    <!-- Search Form -->
                    <div class="search-form">
                        <form action="${pageContext.request.contextPath}/admin/product/list" method="get">
                            <input type="text" 
                                   name="keyword" 
                                   placeholder="Tìm kiếm..." 
                                   value="${param.keyword != null ? param.keyword : ''}" />
                            
                            <select name="maHang">
                                <option value="">Chọn danh mục</option>
                                <c:forEach var="brand" items="${brands}">
                                    <option value="${brand.maDM}" 
                                            ${param.maHang == brand.maDM ? 'selected' : ''}>
                                        ${brand.tenDM}
                                    </option>
                                </c:forEach>
                            </select>
                            
                            <button type="submit">🔍</button>
                        </form>
                    </div>

                    <!-- Action Buttons -->
                    <div style="display: flex; gap: 10px;">
                        <a href="${pageContext.request.contextPath}/admin/product/add" class="btn">Tạo mới</a>
                        <a href="${pageContext.request.contextPath}/admin/product/list" class="btn-reset">Đặt lại</a>
                    </div>
                </div>

                <!-- Product Table -->
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Hình ảnh</th>
                            <th>Tên</th>
                            <th>Giá</th>
                            <th>Số lượng</th>
                            <th>Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="p" items="${productList}" varStatus="status">
                            <tr>
                                <td>${status.index + 1}</td>
                                <td>
                                    <c:if test="${not empty p.hinhAnh}">
                                        <img src="${pageContext.request.contextPath}/Uploads/${p.hinhAnh}" 
                                             alt="${p.tenSP}" 
                                             width="60"
                                             height="60" />
                                    </c:if>
                                </td>
                                <td>${p.tenSP}</td>
                                <td>${p.formattedPrice}</td>
                                <td>${p.soLuong}</td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/admin/product/edit?maSP=${p.maSP}">Xem</a> |
                                    <a href="${pageContext.request.contextPath}/admin/product/edit?maSP=${p.maSP}">Cập nhật</a> |
                                    <a href="${pageContext.request.contextPath}/admin/product/delete?maSP=${p.maSP}" 
                                       onclick="return confirm('Bạn có chắc muốn xóa sản phẩm này?')">Xóa</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>

                <!-- Pagination -->
                <div class="pagination">
                    <a href="#" class="disabled">Trang đầu</a>
                    <a href="#" class="disabled">Trước</a>
                    <span class="active">1</span>
                    <a href="#">2</a>
                    <a href="#">3</a>
                    <a href="#">Sau</a>
                    <a href="#">Trang cuối</a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>