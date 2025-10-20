<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
    response.setContentType("text/html; charset=UTF-8");
    
    // Lấy thông tin đơn hàng từ session
    String orderSuccessMessage = (String) session.getAttribute("orderSuccess");
    String userName = (String) session.getAttribute("userName");
    String userRole = (String) session.getAttribute("userRole");
    
    // Lấy thông tin chi tiết đơn hàng
    Integer orderId = (Integer) session.getAttribute("orderId");
    String recipientName = (String) session.getAttribute("recipientName");
    String phoneNumber = (String) session.getAttribute("phoneNumber");
    String deliveryAddress = (String) session.getAttribute("deliveryAddress");
    String paymentMethod = (String) session.getAttribute("paymentMethod");
    Double totalAmount = (Double) session.getAttribute("totalAmount");
    java.sql.Timestamp orderDate = (java.sql.Timestamp) session.getAttribute("orderDate");
    
    // Format currency
    java.text.NumberFormat formatter = java.text.NumberFormat.getInstance(new java.util.Locale("vi", "VN"));
    
    // Xóa message sau khi hiển thị
    if (orderSuccessMessage != null) {
        session.removeAttribute("orderSuccess");
    }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đặt hàng thành công - KT Store</title>
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
                    <span>DANH MỤC<br>SẢN PHẨM</span>
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
                        <a href="${pageContext.request.contextPath}/views/repair.jsp" class="nav-link">SỬA CHỮA</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <main class="main-content">
        <div class="container">
            <div class="success-container">
                <div class="success-icon">
                    <i class="fas fa-check-circle"></i>
                </div>
                
                <h1 class="success-title">Đặt hàng thành công!</h1>
                
                <div class="success-message">
                    <p>Cảm ơn <%= userName != null ? userName : "bạn" %>!</p>
                    <p>Chúc mừng bạn đã đặt hàng thành công. KT Store sẽ sớm liên hệ với bạn để bàn giao sản phẩm nhanh nhất.</p>
                </div>
                
                <% if (orderId != null) { %>
                <div class="order-info">
                    <div class="info-card">
                        <h3>Thông tin đơn hàng</h3>
                        <div class="info-content">
                            <div class="info-item">
                                <span class="info-label">Mã đơn hàng:</span>
                                <span class="info-value"><%= orderId %></span>
                            </div>
                            <div class="info-item">
                                <span class="info-label">Phương thức thanh toán:</span>
                                <span class="info-value">
                                    <% if ("cash".equals(paymentMethod)) { %>
                                        Thanh toán khi nhận hàng
                                    <% } else if ("credit".equals(paymentMethod)) { %>
                                        Thẻ tín dụng
                                    <% } else if ("momo".equals(paymentMethod)) { %>
                                        Ví MoMo
                                    <% } else { %>
                                        <%= paymentMethod != null ? paymentMethod : "Chưa xác định" %>
                                    <% } %>
                                </span>
                            </div>
                            <div class="info-item">
                                <span class="info-label">Thời gian nhận hàng dự kiến:</span>
                                <span class="info-value">2-3 ngày</span>
                            </div>
                            <% if (recipientName != null) { %>
                            <div class="info-item">
                                <span class="info-label">Họ tên người nhận:</span>
                                <span class="info-value"><%= recipientName %></span>
                            </div>
                            <% } %>
                            <% if (phoneNumber != null) { %>
                            <div class="info-item">
                                <span class="info-label">Số điện thoại:</span>
                                <span class="info-value"><%= phoneNumber %></span>
                            </div>
                            <% } %>
                            <% if (deliveryAddress != null) { %>
                            <div class="info-item">
                                <span class="info-label">Địa chỉ nhận:</span>
                                <span class="info-value"><%= deliveryAddress %></span>
                            </div>
                            <% } %>
                            <div class="info-item total-item">
                                <span class="info-label">Tổng tiền:</span>
                                <span class="info-value total-amount">
                                    <% if (totalAmount != null) { %>
                                        <%= formatter.format(totalAmount) %> ₫
                                    <% } else { %>
                                        0 ₫
                                    <% } %>
                                </span>
                            </div>
                        </div>
                    </div>
                </div>
                <% } %>
                
                <!-- Order Progress Steps -->
                <div class="order-progress">
                    <div class="progress-step completed">
                        <div class="step-icon">
                            <i class="fas fa-shopping-cart"></i>
                        </div>
                        <span class="step-text">Giỏ hàng</span>
                    </div>
                    
                    <div class="progress-line completed"></div>
                    
                    <div class="progress-step completed current">
                        <div class="step-icon">
                            <i class="fas fa-check"></i>
                        </div>
                        <span class="step-text">Đặt hàng</span>
                    </div>
                    
                    <div class="progress-line"></div>
                    
                    <div class="progress-step">
                        <div class="step-icon">
                            <i class="fas fa-truck"></i>
                        </div>
                        <span class="step-text">Vận chuyển</span>
                    </div>
                    
                    <div class="progress-line"></div>
                    
                    <div class="progress-step">
                        <div class="step-icon">
                            <i class="fas fa-money-bill-wave"></i>
                        </div>
                        <span class="step-text">Thanh toán</span>
                    </div>
                </div>
                
                <!-- Action Buttons -->
                <div class="action-buttons">
                    <a href="${pageContext.request.contextPath}/views/index.jsp" class="btn btn-primary">
                        <i class="fas fa-home"></i>
                        Về trang chủ
                    </a>
                    <a href="${pageContext.request.contextPath}/views/new-phones.jsp" class="btn btn-secondary">
                        <i class="fas fa-shopping-bag"></i>
                        Tiếp tục mua sắm
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
        
        /* Success Page Styles */
        .success-container {
            max-width: 800px;
            margin: 40px auto;
            padding: 40px;
            text-align: center;
            background: #fff;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        }
        
        .success-icon {
            font-size: 80px;
            color: #27ae60;
            margin-bottom: 20px;
        }
        
        .success-title {
            font-size: 32px;
            color: #333;
            margin-bottom: 20px;
            font-weight: bold;
        }
        
        .success-message {
            margin-bottom: 30px;
        }
        
        .success-message p {
            font-size: 16px;
            color: #666;
            margin: 10px 0;
            line-height: 1.6;
        }
        
        .order-info {
            margin: 30px 0;
        }
        
        .info-card {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 25px;
            border-left: 4px solid #27ae60;
            text-align: left;
        }
        
        .info-card h3 {
            color: #333;
            margin-bottom: 20px;
            font-size: 18px;
            text-align: center;
        }
        
        .info-content {
            display: flex;
            flex-direction: column;
            gap: 12px;
        }
        
        .info-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 8px 0;
            border-bottom: 1px solid #e9ecef;
        }
        
        .info-item:last-child {
            border-bottom: none;
        }
        
        .info-label {
            font-weight: 500;
            color: #666;
            font-size: 14px;
        }
        
        .info-value {
            font-weight: 600;
            color: #333;
            font-size: 14px;
            text-align: right;
        }
        
        .total-item {
            background: #fff;
            padding: 15px;
            border-radius: 8px;
            margin-top: 10px;
            border: 2px solid #e74c3c;
        }
        
        .total-item .info-label {
            font-size: 16px;
            font-weight: bold;
            color: #333;
        }
        
        .total-amount {
            font-size: 18px;
            font-weight: bold;
            color: #e74c3c;
        }
        
        /* Order Progress */
        .order-progress {
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 40px 0;
            flex-wrap: wrap;
        }
        
        .progress-step {
            display: flex;
            flex-direction: column;
            align-items: center;
            position: relative;
        }
        
        .step-icon {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
            margin-bottom: 10px;
            transition: all 0.3s;
        }
        
        .progress-step.completed .step-icon {
            background: #27ae60;
            color: white;
        }
        
        .progress-step.current .step-icon {
            background: #e74c3c;
            color: white;
            animation: pulse 2s infinite;
        }
        
        .progress-step:not(.completed):not(.current) .step-icon {
            background: #ecf0f1;
            color: #bdc3c7;
        }
        
        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.1); }
            100% { transform: scale(1); }
        }
        
        .step-text {
            font-size: 12px;
            color: #666;
            font-weight: 500;
        }
        
        .progress-line {
            width: 80px;
            height: 2px;
            background: #ecf0f1;
            margin: 0 10px;
            margin-top: -30px;
        }
        
        .progress-line.completed {
            background: #27ae60;
        }
        
        /* Action Buttons */
        .action-buttons {
            margin-top: 40px;
            display: flex;
            gap: 20px;
            justify-content: center;
            flex-wrap: wrap;
        }
        
        .btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 12px 24px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s;
            border: none;
            cursor: pointer;
        }
        
        .btn-primary {
            background: #e74c3c;
            color: white;
        }
        
        .btn-primary:hover {
            background: #c0392b;
            transform: translateY(-2px);
        }
        
        .btn-secondary {
            background: #3498db;
            color: white;
        }
        
        .btn-secondary:hover {
            background: #2980b9;
            transform: translateY(-2px);
        }
        
        /* Responsive */
        @media (max-width: 768px) {
            .success-container {
                margin: 20px;
                padding: 20px;
            }
            
            .success-title {
                font-size: 24px;
            }
            
            .order-progress {
                flex-direction: column;
                gap: 20px;
            }
            
            .progress-line {
                width: 2px;
                height: 40px;
                margin: 0;
                margin-top: 0;
            }
            
            .action-buttons {
                flex-direction: column;
                align-items: center;
            }
            
            .btn {
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
    </script>
</body>
</html>