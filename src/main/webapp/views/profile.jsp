<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.UserProfile" %>
<%
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
    response.setContentType("text/html; charset=UTF-8");
    
    // Lấy thông tin user từ session
    String userName = (String) session.getAttribute("userName");
    String userRole = (String) session.getAttribute("userRole");
    
    // Lấy thông tin profile từ request (được set bởi ProfileServlet)
    UserProfile userProfile = (UserProfile) request.getAttribute("userProfile");
    
    // Lấy thông báo
    String successMessage = (String) request.getAttribute("success");
    String errorMessage = (String) request.getAttribute("error");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thông tin cá nhân - KT Store</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/index.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <!-- Header -->
    <header class="header">
        <div class="container">
            <div class="header-content">
                <!-- Logo -->
                <div class="logo">
                    <a href="${pageContext.request.contextPath}/views/index.jsp">
                        <img src="${pageContext.request.contextPath}/image/ca6a32d5a48f3e706cefc42bf7073f0751fc03f2.jpg" alt="KT Store" style="height: 55px;">
                    </a>
                </div>

                <!-- Search Box -->
                <div class="search-box">
                    <i class="fas fa-search"></i>
                    <form action="search.jsp" method="get">
                        <input type="text" name="q" placeholder="Tìm Kiếm Sản phẩm" id="searchInput">
                    </form>
                </div>

                <!-- Header Actions -->
                <div class="header-actions">
                    <a href="${pageContext.request.contextPath}/views/cart.jsp" class="icon-btn" title="Giỏ hàng">
                        <i class="fas fa-shopping-cart"></i>
                    </a>
                    <a href="wishlist.jsp" class="icon-btn" title="Yêu thích">
                        <i class="far fa-heart"></i>
                    </a>
                    <%
                        if (userName != null) {
                    %>
                        <div class="user-menu">
                            <button class="user-btn" onclick="toggleUserDropdown()">
                                <i class="fas fa-user"></i>
                                <%= userName %>
                                <i class="fas fa-chevron-down"></i>
                            </button>
                            <div class="user-dropdown" id="userDropdown">
                                <a href="${pageContext.request.contextPath}/profile"><i class="far fa-user"></i> Thông tin tài khoản</a>
                                <a href="${pageContext.request.contextPath}/views/order-success.jsp"><i class="fas fa-box"></i> Đơn hàng</a>
                                <% if ("Admin".equals(userRole)) { %>
                                <a href="${pageContext.request.contextPath}/admin/index.jsp"><i class="fas fa-cog"></i> Quản trị</a>
                                <% } %>
                                <hr>
                                <a href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt"></i> Đăng xuất</a>
                            </div>
                        </div>
                    <%
                        } else {
                    %>
                        <a href="${pageContext.request.contextPath}/views/login.jsp" class="btn-login">ĐĂNG NHẬP</a>
                        <span class="separator">|</span>
                        <a href="${pageContext.request.contextPath}/views/register.jsp" class="btn-register">ĐĂNG KÝ</a>
                    <%
                        }
                    %>
                </div>
            </div>
        </div>
    </header>

    <!-- Navigation -->
    <nav class="navbar">
        <div class="container">
            <div class="nav-content">
                <button class="menu-toggle">
                    <i class="fas fa-bars"></i>
                    <span>DANH MỤC</span>
                </button>

                <ul class="nav-menu">
                    <li class="nav-item dropdown">
                        <a href="${pageContext.request.contextPath}/views/new-phones.jsp" class="nav-link">
                            ĐIỆN THOẠI MỚI
                            <i class="fas fa-chevron-down"></i>
                        </a>
                        <div class="dropdown-menu">
                            <a href="${pageContext.request.contextPath}/views/new-phones.jsp">iPhone</a>
                            <a href="${pageContext.request.contextPath}/views/new-phones.jsp">Samsung</a>
                            <a href="${pageContext.request.contextPath}/views/new-phones.jsp">Xiaomi</a>
                            <a href="${pageContext.request.contextPath}/views/new-phones.jsp">OPPO</a>
                            <a href="${pageContext.request.contextPath}/views/new-phones.jsp">Vivo</a>
                        </div>
                    </li>
                    <li class="nav-item dropdown">
                        <a href="${pageContext.request.contextPath}/views/used-phones.jsp" class="nav-link">
                            ĐIỆN THOẠI CŨ
                            <i class="fas fa-chevron-down"></i>
                        </a>
                        <div class="dropdown-menu">
                            <a href="${pageContext.request.contextPath}/views/used-phones.jsp">iPhone Cũ</a>
                            <a href="${pageContext.request.contextPath}/views/used-phones.jsp">Samsung Cũ</a>
                            <a href="${pageContext.request.contextPath}/views/used-phones.jsp">Tất cả điện thoại cũ</a>
                        </div>
                    </li>
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/views/exchange.jsp" class="nav-link">THU ĐIỆN THOẠI</a>
                    </li>
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/repair" class="nav-link">SỬA CHỮA</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <main class="main-content">
        <div class="container">
            <div class="profile-container">
                <h1 class="page-title">Thông tin cá nhân</h1>
                
                <!-- Success/Error Messages -->
                <% if (successMessage != null) { %>
                <div class="alert alert-success">
                    <i class="fas fa-check-circle"></i>
                    <%= successMessage %>
                </div>
                <% } %>
                
                <% if (errorMessage != null) { %>
                <div class="alert alert-error">
                    <i class="fas fa-exclamation-circle"></i>
                    <%= errorMessage %>
                </div>
                <% } %>
                
                <% if (userProfile != null) { %>
                <div class="profile-content">
                    <form class="profile-form" method="post" action="${pageContext.request.contextPath}/profile">
                        <div class="form-row">
                            <div class="form-group">
                                <label for="hoTen">Họ và tên *</label>
                                <input type="text" id="hoTen" name="hoTen" value="<%= userProfile.getHoTen() != null ? userProfile.getHoTen() : "" %>" required>
                            </div>
                            
                            <div class="form-group">
                                <label for="email">Email *</label>
                                <input type="email" id="email" name="email" value="<%= userProfile.getEmail() != null ? userProfile.getEmail() : "" %>" required>
                            </div>
                        </div>
                        
                        <div class="form-row">
                            <div class="form-group">
                                <label for="soDT">Số điện thoại</label>
                                <input type="tel" id="soDT" name="soDT" value="<%= userProfile.getSoDT() != null ? userProfile.getSoDT() : "" %>" placeholder="Nhập số điện thoại (tùy chọn)">
                            </div>
                        </div>
                        
                        <div class="form-row">
                            <div class="form-group">
                                <label for="vaiTro">Vai trò</label>
                                <input type="text" id="vaiTro" value="<%= userProfile.getVaiTro() != null ? userProfile.getVaiTro() : "Khách hàng" %>" readonly>
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label for="diaChi">Địa chỉ</label>
                            <textarea id="diaChi" name="diaChi" rows="3" placeholder="Nhập địa chỉ (tùy chọn)"><%= userProfile.getDiaChi() != null ? userProfile.getDiaChi() : "" %></textarea>
                        </div>
                        
                        <div class="form-actions">
                            <button type="submit" class="btn-update">
                                <i class="fas fa-save"></i>
                                Cập nhật thông tin
                            </button>
                            <a href="${pageContext.request.contextPath}/views/index.jsp" class="btn-cancel">
                                <i class="fas fa-arrow-left"></i>
                                Quay lại
                            </a>
                        </div>
                    </form>
                </div>
                <% } else { %>
                <div class="error-state">
                    <i class="fas fa-exclamation-triangle"></i>
                    <h3>Không tìm thấy thông tin</h3>
                    <p>Không thể tải thông tin cá nhân. Vui lòng thử lại sau.</p>
                    <a href="${pageContext.request.contextPath}/views/index.jsp" class="btn-back">Về trang chủ</a>
                </div>
                <% } %>
            </div>
        </div>
    </main>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <div class="footer-grid">
                <div class="footer-col">
                    <div class="footer-logo">KT</div>
                    <div class="footer-links">
                        <a href="#">GIỚI THIỆU VỀ CÔNG TY</a>
                        <a href="#">CÂU HỎI THƯỜNG GẶP</a>
                        <a href="#">CHÍNH SÁCH BẢO MẬT</a>
                        <a href="#">QUY CHẾ HOẠT ĐỘNG</a>
                    </div>
                </div>

                <div class="footer-col">
                    <h3>KIỂM TRA HÓA ĐƠN ĐIỆN TỬ</h3>
                    <a href="#">TRA CỨU THÔNG TIN BẢO HÀNH</a>
                    <a href="#">TIN TUYỂN DỤNG</a>
                    <a href="#">TIN KHUYẾN MÃI</a>
                    <a href="#">HƯỚNG DẪN ONLINE</a>
                </div>

                <div class="footer-col">
                    <h3>HỆ THỐNG CỬA HÀNG</h3>
                    <a href="#">HỆ THỐNG BẢO HÀNH</a>
                    <a href="#">KIỂM TRA HÀNG APPLE CHÍNH HÃNG</a>
                    <a href="#">GIỚI THIỆU ĐỐI TÁC</a>
                    <a href="#">CHÍNH SÁCH ĐỔI TRẢ</a>
                </div>

                <div class="footer-col">
                    <h3>SOCIAL MEDIA</h3>
                    <div class="social-links">
                        <a href="#" class="social-icon"><i class="fab fa-facebook-f"></i></a>
                        <a href="#" class="social-icon"><i class="fab fa-google"></i></a>
                    </div>
                </div>
            </div>
        </div>
    </footer>

    <style>
        .user-menu { position: relative; }
        .user-dropdown { 
            position: absolute !important; 
            top: 100% !important; 
            right: 0 !important; 
            margin-top: 10px !important; 
            background: #fff !important; 
            border-radius: 10px !important; 
            box-shadow: 0 5px 20px rgba(0,0,0,0.15) !important; 
            min-width: 200px !important; 
            display: none !important; 
            z-index: 1000 !important; 
        }
        .user-dropdown.show { display: block !important; }
        .user-dropdown a { 
            display: flex !important; 
            align-items: center !important; 
            gap: 10px !important; 
            padding: 12px 20px !important; 
            color: #333 !important; 
            text-decoration: none !important; 
            transition: all 0.3s !important; 
        }
        .user-dropdown a:hover { background: #f5f5f5 !important; color: #e74c3c !important; }
        
        /* Profile Page Styles */
        .profile-container {
            max-width: 800px;
            margin: 40px auto;
            padding: 0 20px;
        }
        
        .page-title {
            font-size: 28px;
            color: #333;
            margin-bottom: 30px;
            text-align: center;
        }
        
        /* Alert Messages */
        .alert {
            padding: 15px 20px;
            border-radius: 8px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .alert-success {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        
        .alert-error {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        
        /* Profile Form */
        .profile-content {
            background: #fff;
            border-radius: 10px;
            padding: 30px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }
        
        .profile-form {
            max-width: 600px;
            margin: 0 auto;
        }
        
        .form-row {
            display: flex;
            gap: 20px;
            margin-bottom: 20px;
        }
        
        .form-row .form-group {
            flex: 1;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-group label {
            display: block;
            font-weight: 600;
            color: #333;
            margin-bottom: 8px;
            font-size: 14px;
        }
        
        .form-group input,
        .form-group select,
        .form-group textarea {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
            background: #fff;
            transition: border-color 0.3s;
            box-sizing: border-box;
        }
        
        .form-group input:focus,
        .form-group select:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: #e74c3c;
        }
        
        .form-group input[readonly] {
            background: #f8f9fa;
            color: #666;
        }
        
        .form-group textarea {
            resize: vertical;
            min-height: 80px;
        }
        
        /* Form Actions */
        .form-actions {
            display: flex;
            gap: 15px;
            justify-content: center;
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid #eee;
        }
        
        .btn-update {
            background: #e74c3c;
            color: white;
            border: none;
            padding: 12px 30px;
            border-radius: 5px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.3s;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .btn-update:hover {
            background: #c0392b;
        }
        
        .btn-cancel {
            background: #6c757d;
            color: white;
            text-decoration: none;
            padding: 12px 30px;
            border-radius: 5px;
            font-size: 14px;
            font-weight: 600;
            transition: background 0.3s;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .btn-cancel:hover {
            background: #5a6268;
        }
        
        /* Error State */
        .error-state {
            text-align: center;
            padding: 60px 20px;
            background: #f8f9fa;
            border-radius: 10px;
        }
        
        .error-state i {
            font-size: 64px;
            color: #f39c12;
            margin-bottom: 20px;
        }
        
        .error-state h3 {
            color: #333;
            margin-bottom: 10px;
        }
        
        .error-state p {
            color: #666;
            margin-bottom: 30px;
        }
        
        .btn-back {
            display: inline-block;
            background: #e74c3c;
            color: white;
            padding: 12px 30px;
            text-decoration: none;
            border-radius: 5px;
            transition: background 0.3s;
        }
        
        .btn-back:hover {
            background: #c0392b;
        }
        
        /* Responsive */
        @media (max-width: 768px) {
            .profile-container {
                margin: 20px auto;
                padding: 0 10px;
            }
            
            .profile-content {
                padding: 20px;
            }
            
            .form-row {
                flex-direction: column;
                gap: 0;
            }
            
            .form-actions {
                flex-direction: column;
                align-items: center;
            }
            
            .btn-update,
            .btn-cancel {
                width: 100%;
                max-width: 300px;
                justify-content: center;
            }
        }
    </style>

    <script>
        function toggleUserDropdown() {
            document.getElementById('userDropdown').classList.toggle('show');
        }

        // Close dropdown when clicking outside
        window.onclick = function(event) {
            if (!event.target.matches('.user-btn') && !event.target.matches('.user-btn *')) {
                var dropdowns = document.getElementsByClassName("user-dropdown");
                for (var i = 0; i < dropdowns.length; i++) {
                    var openDropdown = dropdowns[i];
                    if (openDropdown.classList.contains('show')) {
                        openDropdown.classList.remove('show');
                    }
                }
            }
        }
        
        // Form validation
        document.addEventListener('DOMContentLoaded', function() {
            const form = document.querySelector('.profile-form');
            if (form) {
                form.addEventListener('submit', function(e) {
                    const hoTen = document.getElementById('hoTen').value.trim();
                    const email = document.getElementById('email').value.trim();
                    const soDT = document.getElementById('soDT').value.trim();
                    const diaChi = document.getElementById('diaChi').value.trim();
                    
                    if (!hoTen) {
                        alert('Họ tên không được để trống!');
                        e.preventDefault();
                        return;
                    }
                    
                    if (!email) {
                        alert('Email không được để trống!');
                        e.preventDefault();
                        return;
                    }
                    
                    if (!isValidEmail(email)) {
                        alert('Email không hợp lệ!');
                        e.preventDefault();
                        return;
                    }
                    
                    if (!soDT) {
                        alert('Số điện thoại không được để trống!');
                        e.preventDefault();
                        return;
                    }
                    
                    if (!isValidPhone(soDT)) {
                        alert('Số điện thoại phải có 10 số!');
                        e.preventDefault();
                        return;
                    }
                    
                    if (!diaChi) {
                        alert('Địa chỉ không được để trống!');
                        e.preventDefault();
                        return;
                    }
                });
            }
        });
        
        function isValidEmail(email) {
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            return emailRegex.test(email);
        }
        
        function isValidPhone(phone) {
            const phoneDigits = phone.replace(/\D/g, '');
            return phoneDigits.length === 10;
        }
    </script>
</body>
</html>