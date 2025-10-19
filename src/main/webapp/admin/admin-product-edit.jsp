<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sửa sản phẩm</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/cssadmin/admin-base.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/cssadmin/admin-components.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/cssadmin/admin-product.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/cssadmin/admin-responsive.css">
</head>
<body>
    <!-- Header -->
    <div class="header">
        <div class="logo-section">
            <button class="menu-toggle">☰</button>
            <div class="logo">
                <div class="logo-icon">n.u.t</div>
            </div>
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
                 <div class="breadcrumb">
                    <span>Trang chủ / Sửa sản phẩm</span>
                </div>
            <div class="admin-container">
                <!-- Breadcrumb -->


                <!-- Page Header -->
                <div class="page-header">
                    <h1 class="page-title">Sửa sản phẩm</h1>
                    <a href="${pageContext.request.contextPath}/admin/product/list" class="back-button">Về danh sách</a>
                </div>

                <!-- Messages -->
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
                        <!-- Product Form -->
                        <form action="${pageContext.request.contextPath}/admin/product/edit?maSP=${product.maSP}" 
                              method="post" enctype="multipart/form-data" class="product-form">
                            
                            <!-- LEFT COLUMN - Basic Information -->
                            <div class="form-section-left">
                                <div class="form-section">
                                    <h2 class="section-title">Thông tin cơ bản</h2>
                                    <div class="form-grid-vertical">
                                        <div class="form-group">
                                            <label class="form-label">Tên</label>
                                            <input type="text" name="tenSP" class="form-input" value="${product.tenSP}" placeholder="Iphone 12" required />
                                        </div>

                                        <div class="form-group">
                                            <label class="form-label">Giá</label>
                                            <input type="number" name="gia" class="form-input" value="${product.gia}" placeholder="30000000" step="0.01" required />
                                        </div>

                                        <div class="form-group">
                                            <label class="form-label">Danh mục</label>
                                            <select name="maHang" class="form-select" required>
                                                <option value="">-Chọn danh mục-</option>
                                                <c:forEach var="brand" items="${brands}">
                                                    <option value="${brand.maDM}" ${brand.maDM == product.maHang ? 'selected' : ''}>${brand.tenDM}</option>
                                                </c:forEach>
                                            </select>
                                        </div>

                                        <div class="form-group">
                                            <label class="form-label">Số lượng</label>
                                            <input type="number" name="soLuong" class="form-input" value="${product.soLuong}" placeholder="10" required />
                                        </div>

                                        <div class="form-group">
                                            <label class="form-label">Tình trạng</label>
                                            <select name="tinhTrang" class="form-select" required>
                                                <option value="Moi" ${product.tinhTrang == 'Moi' ? 'selected' : ''}>Mới</option>
                                                <option value="Cu" ${product.tinhTrang == 'Cu' ? 'selected' : ''}>Cũ</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- MIDDLE COLUMN - Description -->
                            <div class="form-section-middle">
                                <!-- Mô tả chi tiết -->
                                <div class="form-section">
                                    <h2 class="section-title">Mô tả chi tiết</h2>
                                    <textarea name="moTa" class="detailed-textarea" placeholder="Iphone 12 là sản phẩm mới nhất của Apple. Là một sản...">${product.moTa}</textarea>
                                </div>

                                <!-- Cấu hình chi tiết với bảng cuộn -->
                                <div class="form-section">
                                    <h2 class="section-title">Cấu hình chi tiết (tùy chọn)</h2>
                                    <div class="scrollable-specs-table">
                                        <table class="specs-table">
                                            <tr>
                                                <td class="spec-label">Màn hình:</td>
                                                <td class="spec-input"><input type="text" name="manHinh" class="form-input-small" value="${product.manHinh}" /></td>
                                            </tr>
                                            <tr>
                                                <td class="spec-label">CPU:</td>
                                                <td class="spec-input"><input type="text" name="cpu" class="form-input-small" value="${product.cpu}" /></td>
                                            </tr>
                                            <tr>
                                                <td class="spec-label">GPU:</td>
                                                <td class="spec-input"><input type="text" name="gpu" class="form-input-small" value="${product.gpu}" /></td>
                                            </tr>
                                            <tr>
                                                <td class="spec-label">RAM:</td>
                                                <td class="spec-input"><input type="text" name="ram" class="form-input-small" value="${product.ram}" /></td>
                                            </tr>
                                            <tr>
                                                <td class="spec-label">Bộ nhớ trong:</td>
                                                <td class="spec-input"><input type="text" name="boNhoTrong" class="form-input-small" value="${product.boNhoTrong}" /></td>
                                            </tr>
                                            <tr>
                                                <td class="spec-label">Hệ điều hành:</td>
                                                <td class="spec-input"><input type="text" name="heDieuHanh" class="form-input-small" value="${product.heDieuHanh}" /></td>
                                            </tr>
                                            <tr>
                                                <td class="spec-label">Camera trước:</td>
                                                <td class="spec-input"><input type="text" name="cameraTruoc" class="form-input-small" value="${product.cameraTruoc}" /></td>
                                            </tr>
                                            <tr>
                                                <td class="spec-label">Camera sau:</td>
                                                <td class="spec-input"><input type="text" name="cameraSau" class="form-input-small" value="${product.cameraSau}" /></td>
                                            </tr>
                                            <tr>
                                                <td class="spec-label">Quay video:</td>
                                                <td class="spec-input"><input type="text" name="quayVideo" class="form-input-small" value="${product.quayVideo}" /></td>
                                            </tr>
                                            <tr>
                                                <td class="spec-label">Dung lượng pin:</td>
                                                <td class="spec-input"><input type="text" name="dungLuongPin" class="form-input-small" value="${product.dungLuongPin}" /></td>
                                            </tr>
                                            <tr>
                                                <td class="spec-label">Sạc nhanh:</td>
                                                <td class="spec-input"><input type="text" name="sacNhanh" class="form-input-small" value="${product.sacNhanh}" /></td>
                                            </tr>
                                            <tr>
                                                <td class="spec-label">Sạc không dây:</td>
                                                <td class="spec-input"><input type="text" name="sacKhongDay" class="form-input-small" value="${product.sacKhongDay}" /></td>
                                            </tr>
                                            <tr>
                                                <td class="spec-label">SIM:</td>
                                                <td class="spec-input"><input type="text" name="sim" class="form-input-small" value="${product.sim}" /></td>
                                            </tr>
                                            <tr>
                                                <td class="spec-label">WiFi:</td>
                                                <td class="spec-input"><input type="text" name="wifi" class="form-input-small" value="${product.wifi}" /></td>
                                            </tr>
                                            <tr>
                                                <td class="spec-label">Bluetooth:</td>
                                                <td class="spec-input"><input type="text" name="bluetooth" class="form-input-small" value="${product.bluetooth}" /></td>
                                            </tr>
                                            <tr>
                                                <td class="spec-label">GPS:</td>
                                                <td class="spec-input"><input type="text" name="gps" class="form-input-small" value="${product.gps}" /></td>
                                            </tr>
                                            <tr>
                                                <td class="spec-label">Chất liệu:</td>
                                                <td class="spec-input"><input type="text" name="chatLieu" class="form-input-small" value="${product.chatLieu}" /></td>
                                            </tr>
                                            <tr>
                                                <td class="spec-label">Kích thước:</td>
                                                <td class="spec-input"><input type="text" name="kichThuoc" class="form-input-small" value="${product.kichThuoc}" /></td>
                                            </tr>
                                            <tr>
                                                <td class="spec-label">Trọng lượng:</td>
                                                <td class="spec-input"><input type="text" name="trongLuong" class="form-input-small" value="${product.trongLuong}" /></td>
                                            </tr>
                                            <tr>
                                                <td class="spec-label">Màu sắc:</td>
                                                <td class="spec-input"><input type="text" name="mauSac" class="form-input-small" value="${product.mauSac}" /></td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>
                            </div>

                            <!-- RIGHT COLUMN - Images -->
                            <div class="form-section-right">
                                <div class="form-section">
                                    <h2 class="section-title">Hình ảnh sản phẩm</h2>
                                    <div class="upload-group">
                                        <label class="upload-label">Hình ảnh sản phẩm</label>
                                        <c:if test="${not empty product.hinhAnh}">
                                            <div class="current-image">
                                                <p class="image-label">Ảnh hiện tại:</p>
                                                <img src="${pageContext.request.contextPath}/Uploads/${product.hinhAnh}" alt="Current Image" class="current-image-preview" />
                                            </div>
                                        </c:if>
                                        <label class="upload-button">
                                            Tải ảnh lên
                                            <input type="file" name="hinhAnhFile" accept="image/*" style="display: none;" />
                                        </label>
                                    </div>
                                    <div class="upload-group">
                                        <label class="upload-label">Hình ảnh đại diện</label>
                                        <label class="upload-button">
                                            Tải ảnh lên
                                            <input type="file" name="hinhAnhDaiDien" accept="image/*" style="display: none;" />
                                        </label>
                                    </div>
                                </div>
                            </div>

                            <!-- Submit Button -->
                            <div class="form-actions">
                                <button type="submit" class="submit-button">Lưu</button>
                            </div>
                        </form>
                    </c:when>
                    <c:otherwise>
                        <div class="error-message">Sản phẩm không tồn tại hoặc không thể tải.</div>
                        <a href="${pageContext.request.contextPath}/admin/product/list" class="back-button">Quay lại danh sách</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Menu toggle functionality
            const menuToggle = document.querySelector('.menu-toggle');
            const sidebar = document.querySelector('.sidebar');
            
            if (menuToggle && sidebar) {
                menuToggle.addEventListener('click', function() {
                    sidebar.classList.toggle('active');
                });
            }
            
            // File upload button text update
            const fileInputs = document.querySelectorAll('input[type="file"]');
            fileInputs.forEach(input => {
                const button = input.parentElement;
                const originalText = button.textContent;
                
                input.addEventListener('change', function() {
                    if (this.files.length > 0) {
                        if (this.multiple) {
                            button.textContent = this.files.length + ' files selected';
                        } else {
                            button.textContent = this.files[0].name;
                        }
                    } else {
                        button.textContent = originalText;
                    }
                });
            });
        });
    </script>
</body>
</html>