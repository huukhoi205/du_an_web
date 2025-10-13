<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thêm lịch sửa chữa</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/cssadmin/admin-base.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/cssadmin/admin-components.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/cssadmin/admin-pages.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/cssadmin/admin-responsive.css">
    <style>
        .error-message {
            background: #fee;
            color: #c00;
            padding: 10px;
            border-radius: 4px;
            margin-bottom: 15px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: 500;
        }
        .form-group input,
        .form-group textarea,
        .form-group select {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        .form-group textarea {
            min-height: 80px;
            resize: vertical;
        }
        .required {
            color: red;
        }
    </style>
</head>
<body>
<div class="header">
    <div class="logo">
        <div class="logo-icon">n.u.t</div>
    </div>
    <div class="admin-info">Admin</div>
</div>

<div class="admin-layout">
    <div class="sidebar">
        <div class="sidebar-title">Hệ thống quản trị</div>
        <nav class="sidebar-menu">
            <a href="${pageContext.request.contextPath}/admin/product/list" class="menu-item"><span>📦</span>Sản phẩm</a>
            <a href="${pageContext.request.contextPath}/admin/category/list" class="menu-item"><span>📂</span>Danh mục</a>
            <a href="${pageContext.request.contextPath}/admin/order/list" class="menu-item"><span>🧾</span>Đơn hàng</a>
            <a href="${pageContext.request.contextPath}/admin/customer/list" class="menu-item"><span>👥</span>Khách hàng</a>
            <a href="${pageContext.request.contextPath}/AdminOldDeviceServlet" class="menu-item"><span>♻️</span>Thu máy cũ</a>
            <a href="${pageContext.request.contextPath}/AdminRepairScheduleServlet" class="menu-item active"><span>🛠️</span>Lịch sửa chữa</a>
        </nav>
    </div>

    <div class="main-content">
        <div class="admin-container">
            <h1>Thêm lịch sửa chữa</h1>
            
            <!-- Hiển thị lỗi nếu có -->
            <c:if test="${not empty errorMessage}">
                <div class="error-message">
                    ${errorMessage}
                </div>
            </c:if>
            
            <c:if test="${not empty errors}">
                <div class="error-message">
                    <ul style="margin: 0; padding-left: 20px;">
                        <c:forEach items="${errors}" var="error">
                            <li>${error}</li>
                        </c:forEach>
                    </ul>
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/AdminRepairScheduleServlet" method="post">
                <input type="hidden" name="action" value="create" />

                <div class="form-group">
                    <label>Mã người dùng: <span class="required">*</span></label>
                    <input type="number" name="maND" value="${maND}" required min="1" />
                    <small style="color: #666;">Nhập mã người dùng đã tồn tại trong hệ thống</small>
                </div>

                <div class="form-group">
                    <label>Tên thiết bị: <span class="required">*</span></label>
                    <input type="text" name="tenThietBi" value="${tenThietBi}" required maxlength="200" 
                           placeholder="VD: iPhone 14 Pro Max, Samsung Galaxy S23" />
                </div>

                <div class="form-group">
                    <label>Mô tả lỗi:</label>
                    <textarea name="moTaLoi" placeholder="Mô tả chi tiết lỗi của thiết bị...">${moTaLoi}</textarea>
                </div>

                <div class="form-group">
                    <label>Chi phí dự kiến (VNĐ):</label>
                    <input type="number" name="chiPhiDuKien" value="${chiPhiDuKien}" min="0" step="1000" 
                           placeholder="VD: 3500000" />
                </div>

                <div class="form-group">
                    <label>Chi phí thực tế (VNĐ):</label>
                    <input type="number" name="chiPhiThucTe" value="${chiPhiThucTe}" min="0" step="1000" 
                           placeholder="Để trống nếu chưa có" />
                </div>

                <div class="form-group">
                    <label>Trạng thái: <span class="required">*</span></label>
                    <select name="trangThai" required>
                        <option value="TiepNhan" ${trangThai == 'TiepNhan' ? 'selected' : ''}>Tiếp nhận</option>
                        <option value="DangSua" ${trangThai == 'DangSua' ? 'selected' : ''}>Đang sửa</option>
                        <option value="HoanTat" ${trangThai == 'HoanTat' ? 'selected' : ''}>Hoàn tất</option>
                        <option value="Huy" ${trangThai == 'Huy' ? 'selected' : ''}>Hủy</option>
                    </select>
                </div>

                <div class="btn-group">
                    <button type="submit" class="btn">💾 Lưu</button>
                    <a href="${pageContext.request.contextPath}/AdminRepairScheduleServlet" class="btn btn-secondary">❌ Hủy</a>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
// Validation phía client
document.querySelector('form').addEventListener('submit', function(e) {
    const maND = document.querySelector('input[name="maND"]').value;
    const tenThietBi = document.querySelector('input[name="tenThietBi"]').value;
    
    if (!maND || maND < 1) {
        alert('Vui lòng nhập mã người dùng hợp lệ!');
        e.preventDefault();
        return false;
    }
    
    if (!tenThietBi || tenThietBi.trim() === '') {
        alert('Vui lòng nhập tên thiết bị!');
        e.preventDefault();
        return false;
    }
});
</script>
</body>
</html>