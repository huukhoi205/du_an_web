<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Chi tiết khách hàng</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/cssadmin/admin-base.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/cssadmin/admin-components.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/cssadmin/admin-customer.css">
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
            <a href="../admin/product/list" class="menu-item"><span>📦</span>Sản phẩm</a>
            <a href="../admin/category/list" class="menu-item"><span>📂</span>Danh mục</a>
            <a href="../admin/order/list" class="menu-item"><span>🧾</span>Đơn hàng</a>
            <a href="../admin/customer/list" class="menu-item active"><span>👥</span>Khách hàng</a>
            <a href="../AdminOldDeviceServlet" class="menu-item"><span>♻️</span>Thu máy cũ</a>
            <a href="../AdminRepairScheduleServlet" class="menu-item"><span>🛠️</span>Lịch sửa chữa</a>
            </nav>
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <div class="breadcrumb">
                Trang chủ / Khách hàng / Chi tiết khách hàng
            <div class="admin-container">
                
                <h1>Chi tiết khách hàng</h1>
                
                <div class="customer-detail">
                    <div class="detail-section">
                        <h3>Thông tin cá nhân</h3>
                        <div class="detail-grid">
                            <div class="detail-item">
                                <label>Mã người dùng:</label>
                                <span class="detail-value">${customer.maND}</span>
                            </div>
                            <div class="detail-item">
                                <label>Họ và tên:</label>
                                <span class="detail-value">${customer.hoTen}</span>
                            </div>
                            <div class="detail-item">
                                <label>Email:</label>
                                <span class="detail-value">${customer.email}</span>
                            </div>
                            <div class="detail-item">
                                <label>Số điện thoại:</label>
                                <span class="detail-value">${customer.soDT != null && !customer.soDT.isEmpty() ? customer.soDT : 'Chưa có'}</span>
                            </div>
                            <div class="detail-item">
                                <label>Địa chỉ:</label>
                                <span class="detail-value">${customer.diaChi != null && !customer.diaChi.isEmpty() ? customer.diaChi : 'Chưa có'}</span>
                            </div>
                        </div>
                    </div>

                    <div class="detail-section">
                        <h3>Thông tin tài khoản</h3>
                        <div class="detail-grid">
                            <div class="detail-item">
                                <label>Mã tài khoản:</label>
                                <span class="detail-value">${customer.maTK}</span>
                            </div>
                            <div class="detail-item">
                                <label>Tên đăng nhập:</label>
                                <span class="detail-value">${customer.tenDangNhap}</span>
                            </div>
                            <div class="detail-item">
                                <label>Vai trò:</label>
                                <span class="detail-value role-badge ${customer.vaiTro}">${customer.vaiTro}</span>
                            </div>
                            <div class="detail-item">
                                <label>Trạng thái:</label>
                                <span class="detail-value status-badge ${customer.trangThai ? 'active' : 'inactive'}">
                                    ${customer.trangThai ? 'Hoạt động' : 'Khóa'}
                                </span>
                            </div>
                            <div class="detail-item">
                                <label>Ngày tạo tài khoản:</label>
                                <span class="detail-value">
                                    <fmt:formatDate value="${customer.ngayTaoTK}" pattern="dd/MM/yyyy HH:mm" />
                                </span>
                            </div>
                            <div class="detail-item">
                                <label>Ngày tạo người dùng:</label>
                                <span class="detail-value">
                                    <fmt:formatDate value="${customer.ngayTao}" pattern="dd/MM/yyyy HH:mm" />
                                </span>
                            </div>
                        </div>
                    </div>

                    <div class="detail-actions">
                        <a href="../admin/customer/edit?maND=${customer.maND}" class="btn btn-primary">Sửa thông tin</a>
                        <a href="../admin/customer/list" class="btn btn-secondary">Quay lại</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
