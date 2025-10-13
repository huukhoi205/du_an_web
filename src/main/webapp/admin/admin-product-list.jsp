<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Danh sách sản phẩm</title>
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
            <div class="admin-container">
                <h1>Danh sách sản phẩm</h1>
                <c:if test="${not empty sessionScope.error}">
                    <div class="error-message">${sessionScope.error}</div>
                    <c:remove var="error" scope="session"/>
                </c:if>
                <c:if test="${not empty sessionScope.success}">
                    <div class="success-message">${sessionScope.success}</div>
                    <c:remove var="success" scope="session"/>
                </c:if>
                <div class="search-form">
				    <form action="${pageContext.request.contextPath}/admin/product/list" method="get">
				        <input type="text" name="keyword" placeholder="Tìm theo tên sản phẩm" 
				               value="${param.keyword != null ? param.keyword : ''}" />
				        <select name="maHang">
				            <option value="">Tất cả hãng</option>
				            <c:forEach var="brand" items="${brands}">
				                <option value="${brand.maDM}" 
				                        ${param.maHang == brand.maDM ? 'selected' : ''}>
				                    ${brand.tenDM}
				                </option>
				            </c:forEach>
				        </select>
				        <select name="tinhTrang">
				            <option value="">Tất cả tình trạng</option>
				            <option value="Moi" ${param.tinhTrang == 'Moi' ? 'selected' : ''}>Mới</option>
				            <option value="Cu" ${param.tinhTrang == 'Cu' ? 'selected' : ''}>Cũ</option>
				        </select>
				        <button type="submit">Tìm kiếm</button>
				        <a href="${pageContext.request.contextPath}/admin/product/list" class="btn-reset">Xóa bộ lọc</a>
				    </form>
				</div>
                <a href="${pageContext.request.contextPath}/admin/product/add" class="btn">+ Thêm mới</a>
                <table border="1">
                    <thead>
                        <tr>
                            <th>MaSP</th>
                            <th>Tên sản phẩm</th>
                            <th>Hãng</th>
                            <th>Tình trạng</th>
                            <th>Giá</th>
                            <th>Số lượng</th>
                            <th>Ảnh</th>
                            <th>Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="p" items="${productList}">
                            <tr>
                                <td>${p.maSP}</td>
                                <td>${p.tenSP}${p.conditionText}</td>
                                <td>${p.brandName}</td>
                                <td>${p.tinhTrang}</td>
                                <td>${p.formattedPrice}</td>
                                <td>${p.soLuong}</td>
                                <td>
                                    <c:if test="${not empty p.hinhAnh}">
                                        <img src="${pageContext.request.contextPath}/Uploads/${p.hinhAnh}" alt="${p.tenSP}" width="50"/>
                                    </c:if>
                                </td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/admin/product/edit?maSP=${p.maSP}">Sửa</a>
                                    <a href="${pageContext.request.contextPath}/admin/product/delete?maSP=${p.maSP}" onclick="return confirm('Bạn có chắc muốn xóa sản phẩm này?')">Xóa</a>
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