<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sửa sản phẩm</title>
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
                <a href="${pageContext.request.contextPath}/admin/product/list" class="menu-item active">
                    <span class="menu-icon">💤</span>
                    <span>Sản phẩm</span>
                </a>
                <a href="${pageContext.request.contextPath}/admin/category/list" class="menu-item">
                    <span class="menu-icon">💤</span>
                    <span>Danh mục</span>
                </a>
                <a href="${pageContext.request.contextPath}/admin/order/list" class="menu-item">
                    <span class="menu-icon">💤</span>
                    <span>Đơn hàng</span>
                </a>
                <a href="${pageContext.request.contextPath}/admin/customer/list" class="menu-item">
                    <span class="menu-icon">💤</span>
                    <span>Khách hàng</span>
                </a>
            </nav>
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <div class="admin-container">
                <h1>Sửa sản phẩm</h1>
                <c:if test="${not empty sessionScope.error}">
                    <div class="error-message">${sessionScope.error}</div>
                    <c:remove var="error" scope="session"/>
                </c:if>
                <c:if test="${not empty sessionScope.success}">
                    <div class="success-message">${sessionScope.success}</div>
                    <c:remove var="success" scope="session"/>
                </c:if>
                <c:choose>
                    <c:when test="${not empty product}">
                        <form action="${pageContext.request.contextPath}/admin/product/edit?maSP=${product.maSP}" 
                              method="post" enctype="multipart/form-data">

                            <label>Tên sản phẩm:</label>
                            <input type="text" name="tenSP" value="${product.tenSP}" required />

                            <label>Hãng sản xuất:</label>
                            <select name="maHang" required>
                                <option value="">Chọn hãng</option>
                                <c:forEach var="brand" items="${brands}">
                                    <option value="${brand.maDM}" ${brand.maDM == product.maHang ? 'selected' : ''}>${brand.tenDM}</option>
                                </c:forEach>
                            </select>

                            <label>Tình trạng:</label>
                            <select name="tinhTrang" required>
                                <option value="Moi" ${product.tinhTrang == 'Moi' ? 'selected' : ''}>Mới</option>
                                <option value="Cu" ${product.tinhTrang == 'Cu' ? 'selected' : ''}>Cũ</option>
                            </select>

                            <label>Giá:</label>
                            <input type="number" name="gia" value="${product.gia}" step="0.01" required />

                            <label>Số lượng:</label>
                            <input type="number" name="soLuong" value="${product.soLuong}" required />

                            <label>Hình ảnh:</label>
                            <input type="file" name="hinhAnhFile" accept="image/*" />
                            <c:if test="${not empty product.hinhAnh}">
                                <div style="margin-top: 10px;">
                                    <p>Ảnh hiện tại:</p>
                                    <img src="${pageContext.request.contextPath}/Uploads/${product.hinhAnh}" alt="Current Image" width="100" />
                                </div>
                            </c:if>

                            <label>Mô tả:</label>
                            <textarea name="moTa" rows="4">${product.moTa}</textarea>

                            <h2>Cấu hình chi tiết (tùy chọn)</h2>

                            <label>Màn hình:</label>
                            <input type="text" name="manHinh" value="${product.manHinh}" />

                            <label>CPU:</label>
                            <input type="text" name="cpu" value="${product.cpu}" />

                            <label>GPU:</label>
                            <input type="text" name="gpu" value="${product.gpu}" />

                            <label>RAM:</label>
                            <input type="text" name="ram" value="${product.ram}" />

                            <label>Bộ nhớ trong:</label>
                            <input type="text" name="boNhoTrong" value="${product.boNhoTrong}" />

                            <label>Hệ điều hành:</label>
                            <input type="text" name="heDieuHanh" value="${product.heDieuHanh}" />

                            <label>Camera trước:</label>
                            <input type="text" name="cameraTruoc" value="${product.cameraTruoc}" />

                            <label>Camera sau:</label>
                            <input type="text" name="cameraSau" value="${product.cameraSau}" />

                            <label>Quay video:</label>
                            <input type="text" name="quayVideo" value="${product.quayVideo}" />

                            <label>Dung lượng pin:</label>
                            <input type="text" name="dungLuongPin" value="${product.dungLuongPin}" />

                            <label>Sạc nhanh:</label>
                            <input type="text" name="sacNhanh" value="${product.sacNhanh}" />

                            <label>Sạc không dây:</label>
                            <input type="text" name="sacKhongDay" value="${product.sacKhongDay}" />

                            <label>SIM:</label>
                            <input type="text" name="sim" value="${product.sim}" />

                            <label>WiFi:</label>
                            <input type="text" name="wifi" value="${product.wifi}" />

                            <label>Bluetooth:</label>
                            <input type="text" name="bluetooth" value="${product.bluetooth}" />

                            <label>GPS:</label>
                            <input type="text" name="gps" value="${product.gps}" />

                            <label>Chất liệu:</label>
                            <input type="text" name="chatLieu" value="${product.chatLieu}" />

                            <label>Kích thước:</label>
                            <input type="text" name="kichThuoc" value="${product.kichThuoc}" />

                            <label>Trọng lượng:</label>
                            <input type="text" name="trongLuong" value="${product.trongLuong}" />

                            <label>Màu sắc:</label>
                            <input type="text" name="mauSac" value="${product.mauSac}" />

                            <div class="form-actions">
                                <button type="submit">Lưu</button>
                                <a href="${pageContext.request.contextPath}/admin/product/list" class="btn">Hủy</a>
                            </div>
                        </form>
                    </c:when>
                    <c:otherwise>
                        <div class="error-message">Sản phẩm không tồn tại hoặc không thể tải.</div>
                        <a href="${pageContext.request.contextPath}/admin/product/list" class="btn">Quay lại danh sách</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</body>
</html>