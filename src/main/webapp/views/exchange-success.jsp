<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
    response.setContentType("text/html; charset=UTF-8");
    
    // Lấy thông tin từ request attributes (được set bởi ExchangeSuccessServlet)
    Integer exchangeMaTMC = (Integer) request.getAttribute("exchangeMaTMC");
    String exchangeFullName = (String) request.getAttribute("exchangeFullName");
    String exchangePhoneNumber = (String) request.getAttribute("exchangePhoneNumber");
    String exchangeLocation = (String) request.getAttribute("exchangeLocation");
    String exchangeProductName = (String) request.getAttribute("exchangeProductName");
    String exchangeDeviceCondition = (String) request.getAttribute("exchangeDeviceCondition");
    String exchangeUpgradeProduct = (String) request.getAttribute("exchangeUpgradeProduct");
    String exchangeHangSX = (String) request.getAttribute("exchangeHangSX");
    java.math.BigDecimal exchangeGiaDeXuat = (java.math.BigDecimal) request.getAttribute("exchangeGiaDeXuat");
    java.math.BigDecimal exchangeGiaThoaThuan = (java.math.BigDecimal) request.getAttribute("exchangeGiaThoaThuan");
    String exchangeTrangThai = (String) request.getAttribute("exchangeTrangThai");
    java.sql.Timestamp exchangeNgayTao = (java.sql.Timestamp) request.getAttribute("exchangeNgayTao");
    
    // Lấy giá đề xuất của cửa hàng từ database (tạm thời để null, sẽ implement sau)
    java.math.BigDecimal giaDeXuatCuaHang = null;
    
    // Format currency
    java.text.NumberFormat formatter = java.text.NumberFormat.getInstance(new java.util.Locale("vi", "VN"));
    
    // Set default values if null
    if (exchangeFullName == null) exchangeFullName = "N/A";
    if (exchangePhoneNumber == null) exchangePhoneNumber = "N/A";
    if (exchangeLocation == null) exchangeLocation = "N/A";
    if (exchangeProductName == null) exchangeProductName = "N/A";
    if (exchangeDeviceCondition == null) exchangeDeviceCondition = "N/A";
    if (exchangeUpgradeProduct == null) exchangeUpgradeProduct = "N/A";
    if (exchangeHangSX == null) exchangeHangSX = "N/A";
    if (exchangeTrangThai == null) exchangeTrangThai = "N/A";
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký thu mua thành công - KT Store</title>
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
        
        .exchange-info {
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
            background: linear-gradient(135deg, #e3f2fd, #bbdefb);
            margin: 15px -15px -15px -15px;
            padding: 15px;
            border-radius: 0 0 8px 8px;
            font-weight: bold;
            color: #1976d2;
            border: 2px solid #2196f3;
            box-shadow: 0 2px 10px rgba(33, 150, 243, 0.2);
        }
        
        .price-highlight {
            background: linear-gradient(135deg, #fff3e0, #ffe0b2);
            border: 2px solid #ff9800;
            color: #e65100;
            font-weight: bold;
            padding: 12px;
            border-radius: 8px;
            margin: 10px 0;
            box-shadow: 0 2px 8px rgba(255, 152, 0, 0.2);
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
                <h1 class="success-title">Đăng ký thu mua thành công!</h1>
                
                <!-- Success Message -->
                <p class="success-message">
                    Cảm ơn <strong><%= exchangeFullName != null ? exchangeFullName : "khách hàng" %></strong> đã đăng ký thu mua thành công của chúng tôi.<br>
                    KT Store sẽ sớm liên hệ với bạn để định giá và thu mua thiết bị.
                </p>
                
                <!-- Progress Steps -->
                <div class="progress-steps">
                    <div class="step completed">
                        <div class="step-icon">
                            <i class="fas fa-check"></i>
                        </div>
                        <span>Đăng ký</span>
                    </div>
                    <div class="step pending">
                        <div class="step-icon">
                            <i class="fas fa-hourglass-half"></i>
                        </div>
                        <span>Chờ duyệt</span>
                    </div>
                    <div class="step pending">
                        <div class="step-icon">
                            <i class="fas fa-search-dollar"></i>
                        </div>
                        <span>Định giá</span>
                    </div>
                    <div class="step pending">
                        <div class="step-icon">
                            <i class="fas fa-handshake"></i>
                        </div>
                        <span>Hoàn thành</span>
                    </div>
                </div>
                
                <!-- Exchange Information -->
                <div class="exchange-info">
                    <h3 style="margin-bottom: 20px; color: #333; text-align: center;">Thông tin đăng ký thu mua</h3>
                    
                    <div class="info-item">
                        <span class="info-label">Mã thu mua:</span>
                        <span class="info-value"><%= exchangeMaTMC != null ? "#" + exchangeMaTMC : "N/A" %></span>
                    </div>
                    
                    <div class="info-item">
                        <span class="info-label">Họ và tên:</span>
                        <span class="info-value"><%= exchangeFullName %></span>
                    </div>
                    
                    <div class="info-item">
                        <span class="info-label">Số điện thoại:</span>
                        <span class="info-value"><%= exchangePhoneNumber %></span>
                    </div>
                    
                    <div class="info-item">
                        <span class="info-label">Khu vực:</span>
                        <span class="info-value"><%= exchangeLocation %></span>
                    </div>
                    
                    <div class="info-item">
                        <span class="info-label">Tên thiết bị cần thu:</span>
                        <span class="info-value"><%= exchangeProductName %></span>
                    </div>
                    
                    <div class="info-item">
                        <span class="info-label">Hãng sản xuất:</span>
                        <span class="info-value"><%= exchangeHangSX %></span>
                    </div>
                    
                    <div class="info-item">
                        <span class="info-label">Tình trạng thiết bị:</span>
                        <span class="info-value">
                            <%= exchangeDeviceCondition %>
                        </span>
                    </div>
                    
                    <% if (exchangeUpgradeProduct != null && !exchangeUpgradeProduct.trim().isEmpty()) { %>
                    <div class="info-item">
                        <span class="info-label">Sản phẩm muốn đổi:</span>
                        <span class="info-value"><%= exchangeUpgradeProduct %></span>
                    </div>
                    <% } %>
                    
                    <div class="info-item">
                        <span class="info-label">Thời gian dự kiến:</span>
                        <span class="info-value">Trong vòng 24h</span>
                    </div>
                    
                    <div class="info-item">
                        <span class="info-label">Giá đề xuất của khách hàng:</span>
                        <span class="info-value">
                            <% 
                                if (exchangeGiaDeXuat != null && exchangeGiaDeXuat.compareTo(java.math.BigDecimal.ZERO) > 0) {
                                    out.print(formatter.format(exchangeGiaDeXuat) + " đ");
                                } else {
                                    out.print("Chưa có");
                                }
                            %>
                        </span>
                    </div>
                    
                    <div class="info-item total-item">
                        <span class="info-label">Giá đề xuất của cửa hàng:</span>
                        <span class="info-value">
                            <% 
                                if (giaDeXuatCuaHang != null && giaDeXuatCuaHang.compareTo(java.math.BigDecimal.ZERO) > 0) {
                                    out.print(formatter.format(giaDeXuatCuaHang) + " đ");
                                } else {
                                    out.print("Đang chờ admin định giá");
                                }
                            %>
                        </span>
                    </div>
                </div>
                
                <!-- Price Comparison Section -->
                <div class="price-highlight">
                    <div style="text-align: center; margin-bottom: 10px;">
                        <i class="fas fa-balance-scale" style="font-size: 24px; margin-right: 10px;"></i>
                        <strong>So sánh giá đề xuất</strong>
                    </div>
                    <div style="display: flex; justify-content: space-between; align-items: center;">
                        <div style="text-align: center; flex: 1;">
                            <div style="font-size: 14px; color: #666; margin-bottom: 5px;">Khách hàng đề xuất</div>
                            <div style="font-size: 18px; font-weight: bold;">
                                <% 
                                    if (exchangeGiaDeXuat != null && exchangeGiaDeXuat.compareTo(java.math.BigDecimal.ZERO) > 0) {
                                        out.print(formatter.format(exchangeGiaDeXuat) + " đ");
                                    } else {
                                        out.print("Chưa có");
                                    }
                                %>
                            </div>
                        </div>
                        <div style="font-size: 24px; color: #666; margin: 0 20px;">
                            <i class="fas fa-arrows-alt-h"></i>
                        </div>
                        <div style="text-align: center; flex: 1;">
                            <div style="font-size: 14px; color: #666; margin-bottom: 5px;">Cửa hàng đề xuất</div>
                            <div style="font-size: 18px; font-weight: bold; color: #e65100;">
                                <% 
                                    if (giaDeXuatCuaHang != null && giaDeXuatCuaHang.compareTo(java.math.BigDecimal.ZERO) > 0) {
                                        out.print(formatter.format(giaDeXuatCuaHang) + " đ");
                                    } else {
                                        out.print("Đang chờ định giá");
                                    }
                                %>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Action Buttons -->
                <div class="action-buttons">
                    <a href="${pageContext.request.contextPath}/views/index.jsp" class="btn btn-primary">
                        <i class="fas fa-home"></i> Về trang chủ
                    </a>
                    <a href="${pageContext.request.contextPath}/exchange" class="btn btn-secondary">
                        <i class="fas fa-mobile-alt"></i> Đăng ký khác
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
