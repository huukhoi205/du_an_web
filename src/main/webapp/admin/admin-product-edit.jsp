<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Sửa sản phẩm</title>
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
                <a href="${pageContext.request.contextPath}/admin/product/list" class="menu-item active">
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
                <a href="${pageContext.request.contextPath}/admin/customer/list" class="menu-item">
                    <span class="menu-icon">👤</span>
                    <span>Khách hàng</span>
                </a>
            </nav>
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <div class="admin-container">
                <h1>Sửa sản phẩm</h1>
                <form action="${pageContext.request.contextPath}/admin/product/edit" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="maSP" value="${product.maSP}" />

                    <label>Tên sản phẩm:</label>
                    <input type="text" name="tenSP" value="${product.tenSP}" />

                    <label>Mã hãng (maHang):</label>
                    <c:choose>
                        <c:when test="${not empty categories}">
                            <select name="maHang">
                                <c:forEach var="cat" items="${categories}">
                                    <option value="${cat.maDM}" <c:if test="${cat.maDM == product.maHang}">selected</c:if>>${cat.tenDM}</option>
                                </c:forEach>
                            </select>
                        </c:when>
                        <c:otherwise>
                            <input type="number" name="maHang" value="${product.maHang}" />
                        </c:otherwise>
                    </c:choose>

                    <label>Tình trạng:</label>
                    <input type="text" name="tinhTrang" value="${product.tinhTrang}" />

                    <label>Giá:</label>
                    <input type="number" step="0.01" name="gia" value="${product.gia}" />

                    <label>Số lượng:</label>
                    <input type="number" name="soLuong" value="${product.soLuong}" />

                    <label>Hình ảnh (tên file):</label>
                    <input type="text" name="hinhAnh" value="${product.hinhAnh}" />

                    <label>Mô tả:</label>
                    <textarea name="moTa">${product.moTa}</textarea>

                    <div class="form-actions">
                        <button type="submit">Lưu</button>
                        <a href="${pageContext.request.contextPath}/admin/product/list" class="btn">Hủy</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>