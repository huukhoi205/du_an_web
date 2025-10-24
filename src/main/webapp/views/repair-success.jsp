<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
    response.setContentType("text/html; charset=UTF-8");
    
    // Lấy thông tin từ request attributes (được set bởi RepairSuccessServlet)
    Integer repairMaSC = (Integer) request.getAttribute("repairMaSC");
    String repairFullName = (String) request.getAttribute("repairFullName");
    String repairEmail = (String) request.getAttribute("repairEmail");
    String repairPhone = (String) request.getAttribute("repairPhone");
    String repairTenThietBi = (String) request.getAttribute("repairTenThietBi");
    String repairLoaiLoi = (String) request.getAttribute("repairLoaiLoi");
    Double repairChiPhiDuKien = (Double) request.getAttribute("repairChiPhiDuKien");
    Double repairChiPhiThucTe = (Double) request.getAttribute("repairChiPhiThucTe");
    String repairTrangThai = (String) request.getAttribute("repairTrangThai");
    java.sql.Timestamp repairNgayTiepNhan = (java.sql.Timestamp) request.getAttribute("repairNgayTiepNhan");
    
    // Format currency
    java.text.NumberFormat formatter = java.text.NumberFormat.getInstance(new java.util.Locale("vi", "VN"));
    
    // Set default values if null
    if (repairFullName == null) repairFullName = "N/A";
    if (repairEmail == null) repairEmail = "N/A";
    if (repairPhone == null) repairPhone = "N/A";
    if (repairTenThietBi == null) repairTenThietBi = "N/A";
    if (repairLoaiLoi == null) repairLoaiLoi = "N/A";
    if (repairTrangThai == null) repairTrangThai = "N/A";
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đặt lịch sửa chữa thành công - KT Store</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/index.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .success-container {
            max-width: 800px;
            margin: 50px auto;
            padding: 40px;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
            text-align: center;
        }
        
        .success-icon {
            font-size: 80px;
            color: #28a745;
            margin-bottom: 20px;
        }
        
        .success-title {
            font-size: 28px;
            color: #333;
            margin-bottom: 10px;
            font-weight: bold;
        }
        
        .success-message {
            font-size: 16px;
            color: #666;
            margin-bottom: 30px;
            line-height: 1.6;
        }
        
        .repair-info {
            background: #f8f9fa;
            border-radius: 8px;
            padding: 30px;
            margin: 30px 0;
            text-align: left;
        }
        
        .info-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 12px 0;
            border-bottom: 1px solid #eee;
        }
        
        .info-item:last-child {
            border-bottom: none;
        }
        
        .info-label {
            font-weight: 600;
            color: #333;
            min-width: 200px;
        }
        
        .info-value {
            color: #666;
            text-align: right;
            flex: 1;
        }
        
        .total-item {
            background: #e3f2fd;
            margin: 15px -15px -15px -15px;
            padding: 15px;
            border-radius: 0 0 8px 8px;
            font-weight: bold;
            color: #1976d2;
        }
        
        .action-buttons {
            margin-top: 30px;
            display: flex;
            gap: 15px;
            justify-content: center;
            flex-wrap: wrap;
        }
        
        .btn {
            padding: 12px 30px;
            border: none;
            border-radius: 5px;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
            cursor: pointer;
        }
        
        .btn-primary {
            background: #007bff;
            color: white;
        }
        
        .btn-primary:hover {
            background: #0056b3;
        }
        
        .btn-secondary {
            background: #6c757d;
            color: white;
        }
        
        .btn-secondary:hover {
            background: #545b62;
        }
        
        .progress-steps {
            display: flex;
            justify-content: center;
            margin: 30px 0;
            gap: 20px;
        }
        
        .step {
            display: flex;
            align-items: center;
            font-weight: 600;
        }
        
        .step.completed {
            color: #28a745;
        }
        
        .step.pending {
            color: #ffc107;
        }
        
        .step-icon {
            width: 35px;
            height: 35px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 10px;
            font-size: 16px;
            transition: all 0.3s ease;
        }
        
        .step.completed .step-icon {
            background: linear-gradient(135deg, #28a745, #20c997);
            color: white;
            box-shadow: 0 4px 15px rgba(40, 167, 69, 0.3);
            animation: pulse-green 2s infinite;
        }
        
        .step.pending .step-icon {
            background: linear-gradient(135deg, #ffc107, #fd7e14);
            color: white;
            box-shadow: 0 4px 15px rgba(255, 193, 7, 0.3);
            animation: pulse-orange 2s infinite;
        }
        
        @keyframes pulse-green {
            0% { box-shadow: 0 4px 15px rgba(40, 167, 69, 0.3); }
            50% { box-shadow: 0 6px 20px rgba(40, 167, 69, 0.5); }
            100% { box-shadow: 0 4px 15px rgba(40, 167, 69, 0.3); }
        }
        
        @keyframes pulse-orange {
            0% { box-shadow: 0 4px 15px rgba(255, 193, 7, 0.3); }
            50% { box-shadow: 0 6px 20px rgba(255, 193, 7, 0.5); }
            100% { box-shadow: 0 4px 15px rgba(255, 193, 7, 0.3); }
        }
        
        @media (max-width: 768px) {
            .success-container {
                margin: 20px;
                padding: 20px;
            }
            
            .info-item {
                flex-direction: column;
                align-items: flex-start;
                gap: 5px;
            }
            
            .info-value {
                text-align: left;
            }
            
            .action-buttons {
                flex-direction: column;
            }
            
            .progress-steps {
                flex-direction: column;
                gap: 10px;
            }
        }
    </style>
</head>
<body>
    <!-- Header -->
    <header class="header">
        <div class="container">
            <div class="header-content">
                <div class="logo">
                    <a href="${pageContext.request.contextPath}/views/index.jsp">
                        <img src="${pageContext.request.contextPath}/image/ca6a32d5a48f3e706cefc42bf7073f0751fc03f2.jpg" alt="KT Store" style="height: 55px;">
                    </a>
                </div>
                
                <div class="search-box">
                    <i class="fas fa-search"></i>
                    <input type="text" placeholder="Tìm kiếm sản phẩm...">
                </div>
                
                <div class="header-actions">
                    <a href="${pageContext.request.contextPath}/cart" class="icon-btn"><i class="fas fa-shopping-cart"></i></a>
                    <a href="#" class="icon-btn"><i class="fas fa-heart"></i></a>
                    <% 
                        String userName = (String) session.getAttribute("userName");
                        if (userName != null) { 
                    %>
                        <div class="user-menu">
                            <div class="user-btn" onclick="toggleUserMenu()">
                                <i class="fas fa-user"></i>
                                <span><%= userName %></span>
                                <i class="fas fa-chevron-down"></i>
                            </div>
                            <div class="user-dropdown" id="userDropdown">
                                <a href="${pageContext.request.contextPath}/profile"><i class="far fa-user"></i> Trang cá nhân</a>
                                <a href="${pageContext.request.contextPath}/views/order-success.jsp"><i class="fas fa-box"></i> Đơn hàng</a>
                                <hr>
                                <a href="${pageContext.request.contextPath}/views/logout.jsp" class="logout-link"><i class="fas fa-sign-out-alt"></i> Đăng xuất</a>
                            </div>
                        </div>
                    <% } else { %>
                        <a href="${pageContext.request.contextPath}/views/login.jsp" class="btn-login">ĐĂNG NHẬP</a>
                        <span class="separator">|</span>
                        <a href="${pageContext.request.contextPath}/views/register.jsp" class="btn-register">ĐĂNG KÝ</a>
                    <% } %>
                </div>
            </div>
        </div>
    </header>

    <!-- Navbar -->
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
                            ĐIỆN THOẠI MỚI <i class="fas fa-chevron-down"></i>
                        </a>
                        <div class="dropdown-menu">
                            <a href="${pageContext.request.contextPath}/views/new-phones.jsp">iPhone</a>
                            <a href="${pageContext.request.contextPath}/views/new-phones.jsp">Samsung</a>
                            <a href="${pageContext.request.contextPath}/views/new-phones.jsp">Xiaomi</a>
                        </div>
                    </li>
                    <li class="nav-item"><a href="${pageContext.request.contextPath}/views/used-phones.jsp" class="nav-link">ĐIỆN THOẠI CŨ</a></li>
                    <li class="nav-item"><a href="${pageContext.request.contextPath}/views/exchange.jsp" class="nav-link">THU ĐIỆN THOẠI</a></li>
                    <li class="nav-item"><a href="${pageContext.request.contextPath}/repair" class="nav-link">SỬA CHỮA</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <main class="main-content">
        <div class="container">
            <div class="success-container">
                <!-- Success Icon -->
                <div class="success-icon">
                    <i class="fas fa-check-circle"></i>
                </div>
                
                <!-- Success Title -->
                <h1 class="success-title">Đặt lịch sửa chữa thành công!</h1>
                
                <!-- Success Message -->
                <p class="success-message">
                    Cảm ơn <strong><%= repairFullName != null ? repairFullName : "khách hàng" %></strong> đã đặt lịch sửa chữa thành công của chúng tôi.<br>
                    KT Store sẽ sớm liên hệ với bạn để tiếp nhận và sửa chữa thiết bị.
                </p>
                
                <!-- Progress Steps -->
                <div class="progress-steps">
                    <div class="step completed">
                        <div class="step-icon">
                            <i class="fas fa-check"></i>
                        </div>
                        <span>Đặt lịch</span>
                    </div>
                    <div class="step pending">
                        <div class="step-icon">
                            <i class="fas fa-hourglass-half"></i>
                        </div>
                        <span>Chờ duyệt</span>
                    </div>
                    <div class="step pending">
                        <div class="step-icon">
                            <i class="fas fa-wrench"></i>
                        </div>
                        <span>Sửa chữa</span>
                    </div>
                    <div class="step pending">
                        <div class="step-icon">
                            <i class="fas fa-flag-checkered"></i>
                        </div>
                        <span>Hoàn thành</span>
                    </div>
                </div>
                
                <!-- Repair Information -->
                <div class="repair-info">
                    <h3 style="margin-bottom: 20px; color: #333; text-align: center;">Thông tin đặt lịch sửa chữa</h3>
                    
                    <div class="info-item">
                        <span class="info-label">Mã sửa chữa:</span>
                        <span class="info-value"><%= repairMaSC != null ? "#" + repairMaSC : "N/A" %></span>
                    </div>
                    
                    <div class="info-item">
                        <span class="info-label">Họ và tên:</span>
                        <span class="info-value"><%= repairFullName %></span>
                    </div>
                    
                    <div class="info-item">
                        <span class="info-label">Số điện thoại:</span>
                        <span class="info-value"><%= repairPhone %></span>
                    </div>
                    
                    <div class="info-item">
                        <span class="info-label">Email:</span>
                        <span class="info-value"><%= repairEmail %></span>
                    </div>
                    
                    <div class="info-item">
                        <span class="info-label">Tên thiết bị cần sửa chữa:</span>
                        <span class="info-value"><%= repairTenThietBi %></span>
                    </div>
                    
                    <div class="info-item">
                        <span class="info-label">Loại lỗi:</span>
                        <span class="info-value">
                            <%= repairLoaiLoi %>
                        </span>
                    </div>
                    
                    <div class="info-item">
                        <span class="info-label">Phương thức thanh toán:</span>
                        <span class="info-value">Khách hàng thanh toán tại cửa hàng</span>
                    </div>
                    
                    <div class="info-item">
                        <span class="info-label">Thời gian dự kiến:</span>
                        <span class="info-value">Trong ngày ngay sau khi tiếp nhận sản phẩm</span>
                    </div>
                    
                    <div class="info-item total-item">
                        <span class="info-label">Chi phí dự kiến:</span>
                        <span class="info-value">
                            <% 
                                if (repairChiPhiDuKien != null && repairChiPhiDuKien > 0) {
                                    if ("Khác".equals(repairLoaiLoi)) {
                                        out.print("Cửa hàng sẽ liên hệ để báo giá");
                                    } else {
                                        out.print(formatter.format(repairChiPhiDuKien) + " đ");
                                    }
                                } else {
                                    out.print("Cửa hàng sẽ liên hệ để báo giá");
                                }
                            %>
                        </span>
                    </div>
                </div>
                
                <!-- Action Buttons -->
                <div class="action-buttons">
                    <a href="${pageContext.request.contextPath}/views/index.jsp" class="btn btn-primary">
                        <i class="fas fa-home"></i> Về trang chủ
                    </a>
                    <a href="${pageContext.request.contextPath}/repair" class="btn btn-secondary">
                        <i class="fas fa-tools"></i> Đặt lịch khác
                    </a>
                </div>
            </div>
        </div>
    </main>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <div class="footer-grid">
                <div class="footer-col">
                    <div class="footer-logo">KT</div>
                </div>
                <div class="footer-col">
                    <h3>GIỚI THIỆU VỀ CÔNG TY</h3>
                    <div class="footer-links">
                        <a href="#">CÂU HỎI THƯỜNG GẶP</a>
                        <a href="#">CHÍNH SÁCH BẢO MẬT</a>
                        <a href="#">QUY CHẾ HOẠT ĐỘNG</a>
                    </div>
                </div>
                <div class="footer-col">
                    <h3>KIỂM TRA HÓA ĐƠN ĐIỆN TỬ</h3>
                    <div class="footer-links">
                        <a href="#">TRA CỨU THÔNG TIN BẢO HÀNH</a>
                        <a href="#">TIN TUYỂN DỤNG</a>
                        <a href="#">TIN KHUYẾN MÃI</a>
                        <a href="#">HƯỚNG DẪN ONLINE</a>
                    </div>
                </div>
                <div class="footer-col">
                    <h3>HỆ THỐNG CỬA HÀNG</h3>
                    <div class="footer-links">
                        <a href="#">HỆ THỐNG BẢO HÀNH</a>
                        <a href="#">KIỂM TRA HÀNG APPLE CHÍNH HÃNG</a>
                        <a href="#">GIỚI THIỆU ĐỔI MÁY</a>
                        <a href="#">CHÍNH SÁCH ĐỔI TRẢ</a>
                    </div>
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

    <script>
        function toggleUserMenu() {
            document.getElementById('userDropdown').classList.toggle('show');
        }
    </script>
</body>
</html>
