<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
    response.setContentType("text/html; charset=UTF-8");
    
    // Lấy thông tin user từ session
    String userName = (String) session.getAttribute("userName");
    String userRole = (String) session.getAttribute("userRole");
    Integer userId = (Integer) session.getAttribute("userId");
    
    // Lấy userProfile từ request (được set bởi ExchangeServlet)
    model.UserProfile userProfile = (model.UserProfile) request.getAttribute("userProfile");
    
    // Lấy error message nếu có
    String errorMessage = (String) request.getAttribute("error");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thu mua điện thoại - KT Store</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/index.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/exchange.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        
        .form-container {
            max-width: 800px;
            margin: 50px auto;
            padding: 40px;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
        }
        
        .form-title {
            text-align: center;
            color: #333;
            margin-bottom: 10px;
            font-size: 28px;
            font-weight: bold;
        }
        
        .form-subtitle {
            text-align: center;
            color: #666;
            margin-bottom: 30px;
            font-size: 16px;
        }
        
        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            margin-bottom: 30px;
        }
        
        .form-group {
            display: flex;
            flex-direction: column;
        }
        
        .form-group.full-width {
            grid-column: 1 / -1;
        }
        
        .form-group label {
            margin-bottom: 8px;
            font-weight: 600;
            color: #333;
        }
        
        .required {
            color: #e74c3c;
        }
        
        .form-group input,
        .form-group select,
        .form-group textarea {
            padding: 12px;
            border: 2px solid #e1e8ed;
            border-radius: 8px;
            font-size: 14px;
            transition: border-color 0.3s ease;
        }
        
        #otherBrand {
            border: 2px solid #ffc107;
            background-color: #fffbf0;
        }
        
        #otherBrand:focus {
            border-color: #ff9800;
            background-color: #fff8e1;
        }
        
        .form-group input:focus,
        .form-group select:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: #007bff;
        }
        
        .textarea-container {
            display: flex;
            flex-direction: column;
            gap: 10px;
        }
        
        .btn-upload-image {
            background: #007bff;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
            align-self: flex-start;
            transition: background 0.3s ease;
        }
        
        .btn-upload-image:hover {
            background: #0056b3;
        }
        
        .btn-upload-image i {
            margin-right: 8px;
        }
        
        .image-upload-section {
            margin-top: 15px;
        }
        
        .image-preview-container {
            position: relative;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            gap: 15px;
            margin-top: 15px;
            border: 2px dashed #ddd;
            padding: 30px 20px;
            border-radius: 8px;
            min-height: 150px;
            background-color: #fafafa;
        }
        
        .image-preview-container.has-images {
            flex-direction: row;
            flex-wrap: wrap;
            justify-content: flex-start;
            background-color: #fff;
            gap: 10px;
        }
        
        .btn-upload-image {
            position: absolute;
            bottom: 15px;
            right: 15px;
            background: #007bff;
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 6px;
            cursor: pointer;
            font-size: 14px;
            display: flex;
            align-items: center;
            gap: 6px;
            transition: all 0.3s ease;
            z-index: 10;
        }
        
        .btn-upload-image:hover {
            background: #0056b3;
            transform: scale(1.05);
        }
        
        .image-preview-container.has-images .btn-upload-image {
            position: static;
            margin-top: 10px;
        }
        
        .no-images-text {
            color: #999;
            font-style: italic;
            text-align: center;
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 10px;
        }
        
        .image-preview-item {
            position: relative;
            width: 120px;
            height: 120px;
            border: 2px solid #e1e8ed;
            border-radius: 8px;
            overflow: hidden;
            display: flex;
            align-items: center;
            justify-content: center;
            background-color: #fff;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            transition: transform 0.2s ease;
        }
        
        .image-preview-item:hover {
            transform: scale(1.05);
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        }
        
        .image-preview-item img {
            max-width: 100%;
            max-height: 100%;
            object-fit: cover;
        }
        
        .image-preview-item .remove-image {
            position: absolute;
            top: 5px;
            right: 5px;
            background-color: rgba(220, 53, 69, 0.9);
            color: white;
            border: none;
            border-radius: 50%;
            width: 24px;
            height: 24px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 12px;
            cursor: pointer;
            transition: background-color 0.2s ease;
            box-shadow: 0 2px 4px rgba(0,0,0,0.2);
        }
        
        .image-preview-item .remove-image:hover {
            background-color: #dc3545;
        }
        
        .image-info {
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            background: linear-gradient(transparent, rgba(0,0,0,0.7));
            color: white;
            padding: 5px 8px;
            font-size: 11px;
            text-align: center;
        }
        
        .btn-submit {
            width: 100%;
            padding: 15px;
            background: #28a745;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.3s ease;
        }
        
        .btn-submit:hover {
            background: #218838;
        }
        
        .error-message {
            background: #f8d7da;
            color: #721c24;
            padding: 12px;
            border-radius: 5px;
            margin-bottom: 20px;
            border: 1px solid #f5c6cb;
        }
        
        /* Exchange History Styles */
        .exchange-history {
            margin-bottom: 40px;
            padding: 20px;
            background: #f8f9fa;
            border-radius: 10px;
            border: 1px solid #e9ecef;
        }
        
        .exchange-history h3 {
            color: #333;
            margin-bottom: 20px;
            font-size: 20px;
            border-bottom: 2px solid #007bff;
            padding-bottom: 10px;
        }
        
        .history-list {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }
        
        .history-item {
            background: white;
            border-radius: 8px;
            padding: 15px;
            border: 1px solid #dee2e6;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        
        .history-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px;
            padding-bottom: 10px;
            border-bottom: 1px solid #e9ecef;
        }
        
        .request-id {
            font-weight: bold;
            color: #007bff;
        }
        
        .request-status {
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: bold;
            text-transform: uppercase;
        }
        
        .status-choduyet {
            background: #fff3cd;
            color: #856404;
        }
        
        .status-dangdinhgia {
            background: #d1ecf1;
            color: #0c5460;
        }
        
        .status-hoantat {
            background: #d4edda;
            color: #155724;
        }
        
        .history-content {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 10px;
        }
        
        .device-info {
            grid-column: 1 / -1;
            font-size: 16px;
            margin-bottom: 5px;
        }
        
        .device-condition, .proposed-price, .agreed-price, .upgrade-product, .request-date {
            font-size: 14px;
            color: #666;
        }
        
        .agreed-price {
            color: #28a745;
            font-weight: bold;
        }
        
        .proposed-price {
            color: #ffc107;
            font-weight: bold;
        }
        
        .recaptcha-container {
            text-align: center;
            margin: 20px 0;
            color: #666;
            font-size: 12px;
        }
        
        /* Footer Styles */
        .footer {
            background: #2c3e50;
            color: white;
            padding: 40px 0 20px;
            margin-top: 50px;
        }
        
        .footer-content {
            display: grid;
            grid-template-columns: 2fr 1fr 1fr 1fr;
            gap: 40px;
            margin-bottom: 30px;
        }
        
        .footer-logo {
            margin-bottom: 15px;
        }
        
        .footer-logo-text {
            font-size: 36px;
            font-weight: bold;
            color: #00bcd4;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
        }
        
        .footer-tagline {
            color: #bdc3c7;
            font-size: 14px;
            margin-bottom: 20px;
            line-height: 1.5;
        }
        
        .social-links {
            display: flex;
            gap: 15px;
        }
        
        .social-link {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            text-decoration: none;
            transition: all 0.3s ease;
            font-size: 16px;
        }
        
        .social-link.facebook {
            background: #3b5998;
        }
        
        .social-link.instagram {
            background: linear-gradient(45deg, #f09433, #e6683c, #dc2743, #cc2366, #bc1888);
        }
        
        .social-link.youtube {
            background: #ff0000;
        }
        
        .social-link:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.3);
        }
        
        .footer-section h3 {
            color: white;
            font-size: 16px;
            font-weight: bold;
            margin-bottom: 20px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        
        .footer-section ul {
            list-style: none;
            padding: 0;
            margin: 0;
        }
        
        .footer-section ul li {
            margin-bottom: 10px;
        }
        
        .footer-section ul li a {
            color: #bdc3c7;
            text-decoration: none;
            font-size: 14px;
            transition: color 0.3s ease;
        }
        
        .footer-section ul li a:hover {
            color: #00bcd4;
        }
        
        .contact-info p {
            color: #bdc3c7;
            font-size: 14px;
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .contact-info i {
            color: #00bcd4;
            width: 16px;
        }
        
        @media (max-width: 768px) {
            .form-grid {
                grid-template-columns: 1fr;
            }
            
            .form-container {
                margin: 20px;
                padding: 20px;
            }
            
            .header-content {
                flex-direction: column;
                gap: 15px;
            }
            
            .search-box {
                margin: 0;
                max-width: 100%;
            }
            
            .footer-content {
                grid-template-columns: 1fr;
                gap: 30px;
                text-align: center;
            }
            
            .social-links {
                justify-content: center;
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
                    <% if (userName != null) { %>
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
                    <% } %>
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
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/views/index.jsp" class="nav-link">TRANG CHỦ</a>
                    </li>
                    <li class="nav-item dropdown">
                        <a href="${pageContext.request.contextPath}/products" class="nav-link">
                            ĐIỆN THOẠI MỚI
                            <i class="fas fa-chevron-down"></i>
                        </a>
                        <div class="dropdown-menu">
                            <a href="${pageContext.request.contextPath}/products?brand=Apple">iPhone</a>
                            <a href="${pageContext.request.contextPath}/products?brand=Samsung">Samsung</a>
                            <a href="${pageContext.request.contextPath}/products?brand=Xiaomi">Xiaomi</a>
                            <a href="${pageContext.request.contextPath}/products?brand=OPPO">OPPO</a>
                            <a href="${pageContext.request.contextPath}/products?brand=Vivo">Vivo</a>
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
                        <a href="${pageContext.request.contextPath}/exchange" class="nav-link active">THU ĐIỆN THOẠI</a>
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
            <div class="form-container">
                <h1 class="form-title">Bạn hãy ghi thông tin sản phẩm cần định giá?</h1>
                <p class="form-subtitle">Để lại thông tin để chúng tôi đến định giá cho bạn nhé !</p>
                
                <% if (errorMessage != null) { %>
                    <div class="error-message">
                        <i class="fas fa-exclamation-triangle"></i> <%= errorMessage %>
                    </div>
                <% } %>
                
                <!-- Lịch sử thu mua -->
                <% if (userId != null) { %>
                    <%
                        java.util.List<model.ExchangeRequest> exchangeHistory = 
                            (java.util.List<model.ExchangeRequest>) request.getAttribute("exchangeHistory");
                        if (exchangeHistory != null && !exchangeHistory.isEmpty()) {
                    %>
                    <div class="exchange-history">
                        <h3>Lịch sử thu mua của bạn</h3>
                        <div class="history-list">
                            <% for (model.ExchangeRequest exchangeRequest : exchangeHistory) { %>
                                <div class="history-item">
                                    <div class="history-header">
                                        <span class="request-id">Mã yêu cầu: #<%= exchangeRequest.getMaTMC() %></span>
                                        <span class="request-status status-<%= exchangeRequest.getTrangThai().toLowerCase() %>">
                                            <%= exchangeRequest.getTrangThai() %>
                                        </span>
                                    </div>
                                    <div class="history-content">
                                        <div class="device-info">
                                            <strong><%= exchangeRequest.getTenMay() %></strong> - <%= exchangeRequest.getHangSX() %>
                                        </div>
                                        <div class="device-condition">
                                            Tình trạng: <%= exchangeRequest.getTinhTrang() %>
                                        </div>
                                        <% if (exchangeRequest.getGiaDeXuat() != null) { %>
                                            <div class="proposed-price">
                                                Giá đề xuất: <%= java.text.NumberFormat.getInstance(new java.util.Locale("vi", "VN")).format(exchangeRequest.getGiaDeXuat()) %> ₫
                                            </div>
                                        <% } %>
                                        <% if (exchangeRequest.getGiaThoaThuan() != null) { %>
                                            <div class="agreed-price">
                                                Giá thỏa thuận: <%= java.text.NumberFormat.getInstance(new java.util.Locale("vi", "VN")).format(exchangeRequest.getGiaThoaThuan()) %> ₫
                                            </div>
                                        <% } %>
                                        <% if (exchangeRequest.getSanPhamLienQuan() != null && !exchangeRequest.getSanPhamLienQuan().equals("không")) { %>
                                            <div class="upgrade-product">
                                                Sản phẩm muốn đổi: <%= exchangeRequest.getSanPhamLienQuan() %>
                                            </div>
                                        <% } %>
                                        <div class="request-date">
                                            Ngày tạo: <%= new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm").format(exchangeRequest.getNgayTao()) %>
                                        </div>
                                    </div>
                                </div>
                            <% } %>
                        </div>
                    </div>
                    <% } %>
                <% } %>
                
                <form action="${pageContext.request.contextPath}/exchange" method="post" class="exchange-form" onsubmit="return submitForm()">
                    <div class="form-grid">
                        <div class="form-group">
                            <label for="fullName">Họ tên (Bắt buộc) <span class="required">*</span></label>
                            <input type="text" id="fullName" name="fullName" 
                                   value="<%= userProfile != null && userProfile.getHoTen() != null ? userProfile.getHoTen() : "" %>" 
                                   placeholder="Nhập họ và tên của bạn" required>
                        </div>
                        
                        <div class="form-group">
                            <label for="phoneNumber">Số điện thoại (Bắt buộc) <span class="required">*</span></label>
                            <input type="tel" id="phoneNumber" name="phoneNumber" 
                                   value="<%= userProfile != null && userProfile.getSoDT() != null ? userProfile.getSoDT() : "" %>" 
                                   placeholder="Nhập số điện thoại của bạn" 
                                   pattern="[0-9]{10}" 
                                   title="Số điện thoại phải có 10 chữ số" required>
                        </div>
                        
                        <div class="form-group">
                            <label for="location">Quận/Huyện, Tỉnh/Thành phố</label>
                            <input type="text" id="location" name="location" 
                                   value="<%= userProfile != null && userProfile.getDiaChi() != null ? userProfile.getDiaChi() : "" %>" 
                                   placeholder="VD: Quận 1, TP.HCM">
                        </div>
                        
                        <div class="form-group">
                            <label for="hangSX">Hãng sản xuất (Bắt buộc) <span class="required">*</span></label>
                            <select id="hangSX" name="hangSX" required onchange="toggleOtherBrand()">
                                <option value="">-- Chọn hãng --</option>
                                <option value="Apple">Apple</option>
                                <option value="Samsung">Samsung</option>
                                <option value="Xiaomi">Xiaomi</option>
                                <option value="OPPO">OPPO</option>
                                <option value="Vivo">Vivo</option>
                                <option value="Huawei">Huawei</option>
                                <option value="OnePlus">OnePlus</option>
                                <option value="Realme">Realme</option>
                                <option value="Sony">Sony</option>
                                <option value="Meizu">Meizu</option>
                                <option value="Khác">Khác</option>
                            </select>
                            <input type="text" id="otherBrand" name="otherBrand" 
                                   placeholder="Nhập tên hãng điện thoại khác..." 
                                   style="display: none; margin-top: 10px;">
                        </div>
                        
                        <div class="form-group">
                            <label for="productName">Nhập sản phẩm bạn cần thu (Bắt buộc) <span class="required">*</span></label>
                            <input type="text" id="productName" name="productName" 
                                   placeholder="VD: iPhone 12 Pro Max 256GB" required>
                        </div>
                        
                        <div class="form-group">
                            <label for="giaDeXuat">Giá đề xuất (VNĐ)</label>
                            <input type="text" id="giaDeXuat" name="giaDeXuat" 
                                   placeholder="VD: 8.000.000" 
                                   oninput="validateNumber(this)"
                                   onblur="formatCurrency(this)"
                                   onfocus="unformatCurrency(this)">
                        </div>
                        
                        <div class="form-group full-width">
                            <label for="deviceCondition">Mô tả ngắn tình trạng thiết bị</label>
                            <textarea id="deviceCondition" name="deviceCondition" rows="4" 
                                      placeholder="Mô tả tình trạng thiết bị... (VD: Màn hình có vết trầy nhẹ, pin còn 85%, máy hoạt động bình thường)"></textarea>
                        </div>
                        
                        <div class="form-group full-width">
                            <label>Ảnh thiết bị</label>
                            <div class="image-upload-section">
                                <div class="image-preview-container" id="imagePreviewContainer">
                                    <div class="no-images-text">
                                        <i class="fas fa-images" style="font-size: 24px;"></i>
                                        <div>Chưa có ảnh nào được chọn</div>
                                        <small>Kéo thả ảnh vào đây hoặc click nút "Tải ảnh lên"</small>
                                    </div>
                                    <button type="button" class="btn-upload-image" onclick="uploadImage()">
                                        <i class="fas fa-camera"></i> Tải ảnh lên
                                    </button>
                                </div>
                                <input type="hidden" id="uploadedImageNames" name="uploadedImageNames">
                            </div>
                        </div>
                        
                        <div class="form-group full-width">
                            <label for="upgradeProduct">Sản phẩm cần tư vấn lên đổi (nếu có)</label>
                            <input type="text" id="upgradeProduct" name="upgradeProduct" 
                                   placeholder="VD: iPhone 15 Pro Max">
                        </div>
                    </div>
                    
                    <div class="recaptcha-container">
                        <p>Bằng cách gửi form này, bạn đồng ý với <a href="#">Chính sách bảo mật</a> và <a href="#">Điều khoản sử dụng</a></p>
                    </div>
                    
                    <button type="submit" class="btn-submit">ĐĂNG KÝ</button>
                </form>
            </div>
        </div>
    </main>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <div class="footer-content">
                <div class="footer-section">
                    <h3>KT Store</h3>
                    <p>Chuyên cung cấp điện thoại chính hãng và dịch vụ sửa chữa uy tín</p>
                </div>
                <div class="footer-section">
                    <h3>Liên hệ</h3>
                    <p><i class="fas fa-phone"></i> 0123 456 789</p>
                    <p><i class="fas fa-envelope"></i> info@ktstore.com</p>
                </div>
                <div class="footer-section">
                    <h3>Dịch vụ</h3>
                    <p><a href="${pageContext.request.contextPath}/views/new-phones.jsp">Điện thoại mới</a></p>
                    <p><a href="${pageContext.request.contextPath}/views/used-phones.jsp">Điện thoại cũ</a></p>
                    <p><a href="${pageContext.request.contextPath}/exchange">Thu mua</a></p>
                    <p><a href="${pageContext.request.contextPath}/repair">Sửa chữa</a></p>
                </div>
            </div>
            <div class="footer-bottom">
                <p>&copy; 2024 KT Store. All rights reserved.</p>
            </div>
        </div>
    </footer>

    <script>
        // Validate number input (chỉ cho phép số)
        function validateNumber(input) {
            // Chỉ cho phép số
            input.value = input.value.replace(/[^\d]/g, '');
        }
        
        // Format currency when user leaves input
        function formatCurrency(input) {
            let value = input.value.replace(/\D/g, '');
            if (value) {
                const formattedValue = parseInt(value).toLocaleString('vi-VN');
                input.value = formattedValue;
            }
        }
        
        // Unformat currency when user focuses input (để dễ edit)
        function unformatCurrency(input) {
            let value = input.value.replace(/\./g, '');
            input.value = value;
        }
        
        // Toggle other brand input
        function toggleOtherBrand() {
            const brandSelect = document.getElementById('hangSX');
            const otherBrandInput = document.getElementById('otherBrand');
            const productInput = document.getElementById('productName');
            
            if (brandSelect.value === 'Khác') {
                otherBrandInput.style.display = 'block';
                otherBrandInput.required = true;
                otherBrandInput.focus();
                productInput.placeholder = 'VD: Tên sản phẩm cụ thể';
            } else {
                otherBrandInput.style.display = 'none';
                otherBrandInput.required = false;
                otherBrandInput.value = '';
                
                // Auto-fill product name based on brand selection
                if (brandSelect.value && !productInput.value) {
                    switch(brandSelect.value) {
                        case 'Apple':
                            productInput.placeholder = 'VD: iPhone 12 Pro Max 256GB';
                            break;
                        case 'Samsung':
                            productInput.placeholder = 'VD: Galaxy S23 Ultra 256GB';
                            break;
                        case 'Xiaomi':
                            productInput.placeholder = 'VD: Xiaomi 13 Pro 256GB';
                            break;
                        case 'OPPO':
                            productInput.placeholder = 'VD: OPPO Find X5 Pro 256GB';
                            break;
                        case 'Vivo':
                            productInput.placeholder = 'VD: Vivo X90 Pro 256GB';
                            break;
                        case 'Huawei':
                            productInput.placeholder = 'VD: Huawei P60 Pro 256GB';
                            break;
                        case 'OnePlus':
                            productInput.placeholder = 'VD: OnePlus 11 Pro 256GB';
                            break;
                        case 'Realme':
                            productInput.placeholder = 'VD: Realme GT3 256GB';
                            break;
                        case 'Sony':
                            productInput.placeholder = 'VD: Sony Xperia 1 V 256GB';
                            break;
                        case 'Meizu':
                            productInput.placeholder = 'VD: Meizu 20 Pro 256GB';
                            break;
                        default:
                            productInput.placeholder = 'VD: Tên sản phẩm cụ thể';
                    }
                }
            }
        }
        
        // Auto-fill product name based on brand selection (for non-"Khác" options)
        document.getElementById('hangSX').addEventListener('change', function() {
            if (this.value !== 'Khác') {
                toggleOtherBrand();
            }
        });
        
        // Global variables for image management
        let selectedImages = [];
        
        // Upload image function
        function uploadImage() {
            
            // Tạo input file ẩn
            const input = document.createElement('input');
            input.type = 'file';
            input.accept = 'image/*';
            input.multiple = true; // Cho phép chọn nhiều ảnh
            input.style.display = 'none';
            
            input.onchange = function(event) {
                const files = Array.from(event.target.files);
                
                files.forEach(file => {
                    
                    // Kiểm tra kích thước file (max 5MB)
                    if (file.size > 5 * 1024 * 1024) {
                        alert(`File "${file.name}" quá lớn. Vui lòng chọn ảnh dưới 5MB.`);
                        return;
                    }
                    
                    // Kiểm tra định dạng file
                    if (!file.type.startsWith('image/')) {
                        alert(`File "${file.name}" không phải là ảnh. Vui lòng chọn file ảnh.`);
                        return;
                    }
                    
                    // Tạo unique ID cho ảnh
                    const imageId = 'img_' + Date.now() + '_' + Math.random().toString(36).substr(2, 9);
                    
                    // Đọc file và thêm vào danh sách
                    const reader = new FileReader();
                    reader.onload = function(e) {
                        console.log('FileReader loaded:', file.name, e.target.result.substring(0, 50) + '...');
                        
                        const imageData = {
                            id: imageId,
                            file: file,
                            name: file.name,
                            size: file.size,
                            url: e.target.result,
                            uploadTime: new Date().toLocaleString('vi-VN')
                        };
                        
                        selectedImages.push(imageData);
                        console.log('Added image:', imageData);
                        renderImagePreviews();
                    };
                    
                    reader.onerror = function(e) {
                        console.error('FileReader error:', e);
                        alert('Lỗi khi đọc file ảnh. Vui lòng thử lại.');
                    };
                    
                    reader.readAsDataURL(file);
                });
            };
            
            // Trigger click để mở dialog chọn file
            document.body.appendChild(input);
            input.click();
            document.body.removeChild(input);
        }
        
        // Render image previews
        function renderImagePreviews() {
            const container = document.getElementById('imagePreviewContainer');
            console.log('Rendering images:', selectedImages.length, selectedImages);
            
            if (selectedImages.length === 0) {
                container.innerHTML = `
                    <div class="no-images-text">
                        <i class="fas fa-images" style="font-size: 24px;"></i>
                        <div>Chưa có ảnh nào được chọn</div>
                        <small>Kéo thả ảnh vào đây hoặc click nút "Tải ảnh lên"</small>
                    </div>
                    <button type="button" class="btn-upload-image" onclick="uploadImage()">
                        <i class="fas fa-camera"></i> Tải ảnh lên
                    </button>
                `;
                container.classList.remove('has-images');
            } else {
                container.classList.add('has-images');
                container.innerHTML = '';
                
                selectedImages.forEach((imageData, index) => {
                    console.log('Rendering image:', index, imageData.name, imageData.url ? 'URL exists' : 'No URL');
                    
                    const previewItem = document.createElement('div');
                    previewItem.className = 'image-preview-item';
                    previewItem.innerHTML = `
                        <img src="${imageData.url}" alt="Preview ${index + 1}" onerror="console.error('Image load error:', this.src)">
                        <button type="button" class="remove-image" onclick="removeImage(${index})" title="Xóa ảnh">
                            <i class="fas fa-times"></i>
                        </button>
                        <div class="image-info">
                            ${imageData.name}
                        </div>
                    `;
                    container.appendChild(previewItem);
                });
                
                // Thêm nút "Thêm ảnh" ở cuối
                const addButton = document.createElement('button');
                addButton.type = 'button';
                addButton.className = 'btn-upload-image';
                addButton.onclick = uploadImage;
                addButton.innerHTML = '<i class="fas fa-plus"></i> Thêm ảnh';
                addButton.style.background = '#17a2b8';
                container.appendChild(addButton);
            }
            
            updateHiddenInput();
        }
        
        // Remove image function
        function removeImage(index) {
            if (confirm('Bạn có chắc muốn xóa ảnh này?')) {
                selectedImages.splice(index, 1);
                renderImagePreviews();
            }
        }
        
        
        // Update hidden input with image names
        function updateHiddenInput() {
            const hiddenInput = document.getElementById('uploadedImageNames');
            const imageNames = selectedImages.map(img => img.name).join(',');
            hiddenInput.value = imageNames;
        }
        
        // Submit form function
        function submitForm() {
            // Cập nhật hidden input với danh sách ảnh
            updateHiddenInput();
            
            // Log thông tin ảnh để debug
            console.log('Submitting form with images:', selectedImages.length);
            console.log('Image names:', selectedImages.map(img => img.name));
            
            return true; // Cho phép submit form
        }
        
        // Toggle user menu
        function toggleUserMenu() {
            const dropdown = document.getElementById('userDropdown');
            dropdown.style.display = dropdown.style.display === 'block' ? 'none' : 'block';
        }

        // Close user menu when clicking outside
        document.addEventListener('click', function(event) {
            const userMenu = document.querySelector('.user-menu');
            const dropdown = document.getElementById('userDropdown');
            if (userMenu && !userMenu.contains(event.target)) {
                dropdown.style.display = 'none';
            }
        });
        
        // Initialize on page load
        document.addEventListener('DOMContentLoaded', function() {
            updateUploadButton();
        });
    </script>
</body>
</html>