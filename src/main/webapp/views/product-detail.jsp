<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.nio.charset.StandardCharsets" %>
<%@ page import="model.Product, java.util.Map, java.text.NumberFormat, java.util.Locale" %>
<%
    // Lấy thông tin sản phẩm từ request attribute (được set bởi ProductDetailServlet)
    Product product = (Product) request.getAttribute("product");
    Map<String, String> productSpecs = (Map<String, String>) request.getAttribute("productSpecs");
    
    // Debug logging
    System.out.println("JSP - Product from servlet: " + (product != null ? product.getTenSP() : "null"));
    System.out.println("JSP - ProductSpecs from servlet: " + (productSpecs != null ? productSpecs.size() + " items" : "null"));
    
    // Nếu không có sản phẩm, tạo sản phẩm mặc định
    if (product == null) {
        System.out.println("JSP - Creating fallback product");
        product = new Product();
        product.setMaSP(1);
        product.setTenSP("iPhone 16 128GB Chính Hãng VN/A");
        product.setGia(new java.math.BigDecimal("14699000"));
        product.setHinhAnh("ip14.png");
        product.setBrandName("Apple");
        product.setMoTa("Điện thoại cao cấp Apple");
    }
    
    // Nếu không có specs, tạo specs mặc định
    if (productSpecs == null) {
        System.out.println("JSP - Creating fallback specs");
        productSpecs = new java.util.HashMap<>();
        productSpecs.put("ManHinh", "6.7 inch OLED");
        productSpecs.put("CPU", "Apple A16 Bionic");
        productSpecs.put("RAM", "6GB");
        productSpecs.put("BoNhoTrong", "128GB");
        productSpecs.put("HeDieuHanh", "iOS 16");
        productSpecs.put("DungLuongPin", "4323mAh");
    }
    
    NumberFormat formatter = NumberFormat.getInstance(new Locale("vi", "VN"));
    
    // Lấy thông tin user từ session
    String userName = (String) session.getAttribute("userName");
    String userRole = (String) session.getAttribute("userRole");
    
    // Kiểm tra thông báo đăng nhập thành công
    String loginSuccess = (String) session.getAttribute("loginSuccess");
    if (loginSuccess != null) {
        session.removeAttribute("loginSuccess"); // Xóa sau khi hiển thị
    }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= product.getTenSP() %> - KT Store</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/index.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/product-detail.css">
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
                    <a href="${pageContext.request.contextPath}/views/wishlist.jsp" class="icon-btn" title="Yêu thích">
                        <i class="far fa-heart"></i>
                    </a>
                    
                    <% if (userName != null) { %>
                        <!-- User Menu -->
                        <div class="user-menu">
                            <button class="user-btn" onclick="toggleUserDropdown()">
                                <i class="far fa-user"></i>
                                <span><%= userName %></span>
                                <i class="fas fa-chevron-down"></i>
                            </button>
                            <div class="user-dropdown" id="userDropdown">
                                <a href="${pageContext.request.contextPath}/profile"><i class="far fa-user"></i> Trang cá nhân</a>
                                <a href="${pageContext.request.contextPath}/views/order-success.jsp"><i class="fas fa-box"></i> Đơn hàng</a>
                                <a href="${pageContext.request.contextPath}/user-services"><i class="fas fa-tools"></i> Thu mua - Sửa chữa</a>
                                <% if ("Admin".equals(userRole)) { %>
                                <a href="${pageContext.request.contextPath}/admin/index.jsp"><i class="fas fa-cog"></i> Quản trị</a>
                                <% } %>
                                <hr>
                                <a href="${pageContext.request.contextPath}/logout" class="logout-link"><i class="fas fa-sign-out-alt"></i> Đăng xuất</a>
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
                        <a href="exchange.jsp" class="nav-link">THU ĐIỆN THOẠI</a>
                    </li>
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/repair" class="nav-link">SỬA CHỮA</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Breadcrumbs -->
    <div class="breadcrumbs">
        <div class="container">
            <a href="${pageContext.request.contextPath}/views/index.jsp">Trang chủ</a>
            <span class="separator">></span>
            <% if ("Cu".equals(product.getTinhTrang())) { %>
                <a href="${pageContext.request.contextPath}/views/used-phones.jsp">Điện Thoại Cũ</a>
            <% } else { %>
                <a href="${pageContext.request.contextPath}/views/new-phones.jsp">Điện Thoại Mới</a>
            <% } %>
            <span class="separator">></span>
            <a href="${pageContext.request.contextPath}/views/new-phones.jsp"><%= product.getBrandName() != null ? product.getBrandName().toLowerCase() : "sản phẩm" %></a>
            <span class="separator">></span>
            <span class="current"><%= product.getTenSP().toLowerCase() %></span>
        </div>
    </div>

    <!-- Product Detail Section -->
    <main class="main-content">
        <div class="container">
            <div class="product-detail">
                <!-- Product Title -->
                <h1 class="product-title"><%= product.getTenSP() %></h1>
                
                <!-- Product Price -->
                <div class="product-price"><%= formatter.format(product.getGia()) %> ₫</div>
                
                <div class="product-content">
                    <!-- Product Image -->
                    <div class="product-image">
                        <img src="${pageContext.request.contextPath}/image/<%= product.getHinhAnh() != null ? product.getHinhAnh() : "default-phone.jpg" %>" 
                             alt="<%= product.getTenSP() %>"
                             onerror="this.src='${pageContext.request.contextPath}/image/default-phone.jpg'">
                    </div>
                    
                    <!-- Product Options -->
                    <div class="product-options">
                        <!-- Storage Options -->
                        <div class="option-group">
                            <label>Dung lượng:</label>
                            <div class="option-buttons">
                                <% 
                                String storage = productSpecs.get("BoNhoTrong");
                                String[] storageOptions = {"64 GB", "128 GB", "256 GB", "512 GB", "1 TB"};
                                for (String option : storageOptions) {
                                    boolean isActive = (storage != null && storage.contains(option.replace(" GB", "").replace(" TB", ""))) || 
                                                      (storage == null && "128 GB".equals(option));
                                %>
                                    <button class="option-btn <%= isActive ? "active" : "" %>"><%= option %></button>
                                <% } %>
                            </div>
                        </div>
                        
                        <!-- Color Options -->
                        <% 
                        String colors = productSpecs.get("MauSac");
                        System.out.println("JSP - MauSac from database: " + colors);
                        if (colors != null && !colors.trim().isEmpty()) {
                            // Use hard-coded colors for testing
                            String[] colorArray = {"Tím", "Đen", "Bạc"};
                            System.out.println("JSP - Using hard-coded colors for testing");
                        %>
                        <div class="option-group">
                            <label>Màu sắc:</label>
                            <div class="option-buttons">
                                <% 
                                for (int i = 0; i < colorArray.length; i++) {
                                    String color = colorArray[i];
                                    boolean isActive = (i == 0); // First color is active by default
                                %>
                                    <button class="option-btn color-btn <%= isActive ? "active" : "" %>" onclick="selectColor(this)"><%= color %></button>
                                <% } %>
                            </div>
                        </div>
                        <% } %>
                        
                        <!-- Condition Note -->
                        <div class="condition-note">
                            * <%= product.getTenSP() %> <%= "Cu".equals(product.getTinhTrang()) ? "cũ (Like New)" : "mới" %> đẹp keng như mới, bảo hành 6 tháng uy tín.
                        </div>
                        
                        <!-- Action Buttons -->
                        <div class="action-buttons">
                            <button class="btn-buy-now" onclick="buyNow('<%= product.getMaSP() %>', '<%= product.getTenSP() %>', '<%= product.getGia() %>')">
                                MUA NGAY
                                <div class="btn-subtitle">Giao hàng tận nơi hoặc lấy tại cửa hàng</div>
                            </button>
                            
                            <button class="btn-installment" onclick="installment('<%= product.getMaSP() %>', '<%= product.getTenSP() %>', '<%= product.getGia() %>')">
                                TRẢ GÓP 0%
                                <div class="btn-subtitle">Xét duyệt nhanh chóng qua điện thoại</div>
                            </button>
                            
                            <button class="btn-card-installment" onclick="cardInstallment('<%= product.getMaSP() %>', '<%= product.getTenSP() %>', '<%= product.getGia() %>')">
                                TRẢ GÓP QUA THẺ
                                <div class="btn-subtitle">Visa, Mastercard, JCB, Amex</div>
                            </button>
                        </div>
                    </div>
                </div>
                
                <!-- Product Information -->
                <div class="product-info">
                    <div class="info-column">
                        <div class="info-item">
                            <i class="fas fa-check-circle"></i>
                            <span>Bảo hành 6 tháng chính hãng.</span>
                        </div>
                        <div class="info-item">
                            <i class="fas fa-money-bill-wave"></i>
                            <span>Trả trước 30% qua Công ty tài chính.</span>
                            <div class="info-subtitle">Thủ tục chỉ cần CCCD + GPLX;</div>
                            <div class="info-subtitle">Hoặc trả góp lãi suất 0% qua thẻ tín dụng Visa, Master, JCB.</div>
                        </div>
                    </div>
                    <div class="info-column">
                        <div class="info-item">
                            <i class="fas fa-truck"></i>
                            <span>Giao hàng C.O.D trên toàn quốc</span>
                        </div>
                        <div class="info-item">
                            <i class="fas fa-sync-alt"></i>
                            <span>Bao test 1 đổi 1 trong 15 Ngày bao gồm nguồn và màn hình</span>
                        </div>
                    </div>
                </div>
                
                <!-- Product Specifications -->
                <div class="product-specifications">
                    <h3>Thông số sản phẩm</h3>
                    <div class="specs-grid">
                        <% if (productSpecs.get("ManHinh") != null) { %>
                        <div class="spec-item">
                            <span class="spec-label">Màn hình:</span>
                            <span class="spec-value"><%= productSpecs.get("ManHinh") %></span>
                        </div>
                        <% } %>
                        <% if (productSpecs.get("CPU") != null) { %>
                        <div class="spec-item">
                            <span class="spec-label">CPU:</span>
                            <span class="spec-value"><%= productSpecs.get("CPU") %></span>
                        </div>
                        <% } %>
                        <% if (productSpecs.get("GPU") != null) { %>
                        <div class="spec-item">
                            <span class="spec-label">GPU:</span>
                            <span class="spec-value"><%= productSpecs.get("GPU") %></span>
                        </div>
                        <% } %>
                        <% if (productSpecs.get("RAM") != null) { %>
                        <div class="spec-item">
                            <span class="spec-label">RAM:</span>
                            <span class="spec-value"><%= productSpecs.get("RAM") %></span>
                        </div>
                        <% } %>
                        <% if (productSpecs.get("BoNhoTrong") != null) { %>
                        <div class="spec-item">
                            <span class="spec-label">Bộ nhớ trong:</span>
                            <span class="spec-value"><%= productSpecs.get("BoNhoTrong") %></span>
                        </div>
                        <% } %>
                        <% if (productSpecs.get("HeDieuHanh") != null) { %>
                        <div class="spec-item">
                            <span class="spec-label">Hệ điều hành:</span>
                            <span class="spec-value"><%= productSpecs.get("HeDieuHanh") %></span>
                        </div>
                        <% } %>
                        <% if (productSpecs.get("CameraTruoc") != null) { %>
                        <div class="spec-item">
                            <span class="spec-label">Camera trước:</span>
                            <span class="spec-value"><%= productSpecs.get("CameraTruoc") %></span>
                        </div>
                        <% } %>
                        <% if (productSpecs.get("CameraSau") != null) { %>
                        <div class="spec-item">
                            <span class="spec-label">Camera sau:</span>
                            <span class="spec-value"><%= productSpecs.get("CameraSau") %></span>
                        </div>
                        <% } %>
                        <% if (productSpecs.get("QuayVideo") != null) { %>
                        <div class="spec-item">
                            <span class="spec-label">Quay video:</span>
                            <span class="spec-value"><%= productSpecs.get("QuayVideo") %></span>
                        </div>
                        <% } %>
                        <% if (productSpecs.get("DungLuongPin") != null) { %>
                        <div class="spec-item">
                            <span class="spec-label">Dung lượng pin:</span>
                            <span class="spec-value"><%= productSpecs.get("DungLuongPin") %></span>
                        </div>
                        <% } %>
                        <% if (productSpecs.get("SacNhanh") != null) { %>
                        <div class="spec-item">
                            <span class="spec-label">Sạc nhanh:</span>
                            <span class="spec-value"><%= productSpecs.get("SacNhanh") %></span>
                        </div>
                        <% } %>
                        <% if (productSpecs.get("SIM") != null) { %>
                        <div class="spec-item">
                            <span class="spec-label">SIM:</span>
                            <span class="spec-value"><%= productSpecs.get("SIM") %></span>
                        </div>
                        <% } %>
                        <% if (productSpecs.get("WiFi") != null) { %>
                        <div class="spec-item">
                            <span class="spec-label">WiFi:</span>
                            <span class="spec-value"><%= productSpecs.get("WiFi") %></span>
                        </div>
                        <% } %>
                        <% if (productSpecs.get("Bluetooth") != null) { %>
                        <div class="spec-item">
                            <span class="spec-label">Bluetooth:</span>
                            <span class="spec-value"><%= productSpecs.get("Bluetooth") %></span>
                        </div>
                        <% } %>
                        <% if (productSpecs.get("GPS") != null) { %>
                        <div class="spec-item">
                            <span class="spec-label">GPS:</span>
                            <span class="spec-value"><%= productSpecs.get("GPS") %></span>
                        </div>
                        <% } %>
                        <% if (productSpecs.get("ChatLieu") != null) { %>
                        <div class="spec-item">
                            <span class="spec-label">Chất liệu:</span>
                            <span class="spec-value"><%= productSpecs.get("ChatLieu") %></span>
                        </div>
                        <% } %>
                        <% if (productSpecs.get("KichThuoc") != null) { %>
                        <div class="spec-item">
                            <span class="spec-label">Kích thước:</span>
                            <span class="spec-value"><%= productSpecs.get("KichThuoc") %></span>
                        </div>
                        <% } %>
                        <% if (productSpecs.get("TrongLuong") != null) { %>
                        <div class="spec-item">
                            <span class="spec-label">Trọng lượng:</span>
                            <span class="spec-value"><%= productSpecs.get("TrongLuong") %></span>
                        </div>
                        <% } %>
                        <% if (productSpecs.get("MauSac") != null) { %>
                        <div class="spec-item">
                            <span class="spec-label">Màu sắc:</span>
                            <span class="spec-value"><%= productSpecs.get("MauSac") %></span>
                        </div>
                        <% } %>
                    </div>
                    <button class="btn-view-details">Xem cấu hình chi tiết</button>
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
        
        /* Option Button Styles */
        .option-btn {
            cursor: pointer;
            transition: all 0.3s ease;
            border: 2px solid #ddd;
            background: #fff;
        }
        
        .option-btn:hover {
            border-color: #e74c3c;
            background: #fff5f5;
        }
        
        .option-btn.active {
            border-color: #e74c3c !important;
            background: #e74c3c !important;
            color: #fff !important;
            font-weight: bold;
        }
        
        .color-btn {
            cursor: pointer !important;
        }
        
        .color-btn.active {
            border-color: #e74c3c !important;
            background: #e74c3c !important;
            color: #fff !important;
        }
        
        /* Login Modal Styles */
        .modal-overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            z-index: 1000;
            justify-content: center;
            align-items: center;
        }
        
        .modal-overlay.show {
            display: flex;
        }
        
        .modal-content {
            background: white;
            border-radius: 10px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
            max-width: 400px;
            width: 90%;
            animation: modalSlideIn 0.3s ease-out;
        }
        
        @keyframes modalSlideIn {
            from {
                opacity: 0;
                transform: translateY(-50px) scale(0.9);
            }
            to {
                opacity: 1;
                transform: translateY(0) scale(1);
            }
        }
        
        .modal-header {
            padding: 20px 20px 10px 20px;
            border-bottom: 1px solid #eee;
        }
        
        .modal-header h3 {
            margin: 0;
            color: #333;
            font-size: 18px;
            font-weight: 600;
        }
        
        .modal-body {
            padding: 20px;
        }
        
        .modal-body p {
            margin: 0;
            color: #666;
            font-size: 16px;
            line-height: 1.5;
        }
        
        .modal-footer {
            padding: 10px 20px 20px 20px;
            display: flex;
            justify-content: flex-end;
            gap: 10px;
        }
        
        .btn-cancel, .btn-login {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s;
        }
        
        .btn-cancel {
            background: #f5f5f5;
            color: #666;
        }
        
        .btn-cancel:hover {
            background: #e0e0e0;
            color: #333;
        }
        
        .btn-login {
            background: #e74c3c;
            color: white;
        }
        
        .btn-login:hover {
            background: #c0392b;
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

        // Action button functions
        function buyNow(maSP, tenSP, gia) {
            console.log('Buy Now:', maSP, tenSP, gia);
            // Redirect to cart with product info
            window.location.href = '${pageContext.request.contextPath}/views/cart.jsp?product=' + encodeURIComponent(tenSP) + '&maSP=' + maSP + '&gia=' + gia;
        }

        function installment(maSP, tenSP, gia) {
            console.log('Installment:', maSP, tenSP, gia);
            // Redirect to installment page
            window.location.href = '${pageContext.request.contextPath}/views/order.jsp?type=installment&product=' + encodeURIComponent(tenSP) + '&maSP=' + maSP + '&gia=' + gia;
        }

        function cardInstallment(maSP, tenSP, gia) {
            console.log('Card Installment:', maSP, tenSP, gia);
            // Redirect to card installment page
            window.location.href = '${pageContext.request.contextPath}/views/order.jsp?type=card&product=' + encodeURIComponent(tenSP) + '&maSP=' + maSP + '&gia=' + gia;
        }

        // Storage and Color Selection Logic
        let selectedStorage = null;
        let selectedColor = null;

        // Initialize when page loads
        document.addEventListener('DOMContentLoaded', function() {
            // Add click listeners to storage options
            const storageButtons = document.querySelectorAll('.option-group:first-of-type .option-btn');
            console.log('Found storage buttons:', storageButtons.length);
            storageButtons.forEach(button => {
                button.addEventListener('click', function() {
                    console.log('Storage button clicked:', this.textContent);
                    // Remove active class from all storage buttons
                    storageButtons.forEach(btn => btn.classList.remove('active'));
                    // Add active class to clicked button
                    this.classList.add('active');
                    selectedStorage = this.textContent.trim();
                    console.log('Selected storage:', selectedStorage);
                });
            });

            // Add click listeners to color options (only if they exist)
            const colorButtons = document.querySelectorAll('.option-group .color-btn');
            console.log('Found color buttons:', colorButtons.length);
            if (colorButtons.length > 0) {
                colorButtons.forEach(button => {
                    button.addEventListener('click', function() {
                        console.log('Color button clicked:', this.textContent);
                        // Remove active class from all color buttons
                        colorButtons.forEach(btn => btn.classList.remove('active'));
                        // Add active class to clicked button
                        this.classList.add('active');
                        selectedColor = this.textContent.trim();
                        console.log('Selected color:', selectedColor);
                    });
                });
            }

            // Set initial selections (first active options)
            const initialStorage = document.querySelector('.option-group:first-of-type .option-btn.active');
            if (initialStorage) {
                selectedStorage = initialStorage.textContent.trim();
                console.log('Initial storage:', selectedStorage);
            }

            // Set initial color selection (only if color options exist)
            const initialColor = document.querySelector('.option-group .color-btn.active');
            if (initialColor) {
                selectedColor = initialColor.textContent.trim();
                console.log('Initial color:', selectedColor);
            }
        });

        // Function to handle color selection
        function selectColor(button) {
            console.log('selectColor called with:', button.textContent);
            // Remove active class from all color buttons
            const allColorButtons = document.querySelectorAll('.color-btn');
            allColorButtons.forEach(btn => btn.classList.remove('active'));
            // Add active class to clicked button
            button.classList.add('active');
            selectedColor = button.textContent.trim();
            console.log('Selected color:', selectedColor);
        }

        // Override buyNow function to include selected options
        function buyNow(maSP, tenSP, gia) {
            console.log('Buy Now:', maSP, tenSP, gia);
            console.log('Selected storage:', selectedStorage);
            console.log('Selected color:', selectedColor);
            
            // Check if user is logged in
            <% if (userName == null) { %>
                // User not logged in, show login modal
                showLoginModal(maSP, tenSP, gia);
            <% } else { %>
                // User is logged in, proceed to cart
                addToCart(maSP, tenSP, gia);
            <% } %>
        }

        function addToCart(maSP, tenSP, gia) {
            // Create a form to submit POST request
            const form = document.createElement('form');
            form.method = 'POST';
            form.action = '${pageContext.request.contextPath}/cart';
            
            // Add form fields
            const actionField = document.createElement('input');
            actionField.type = 'hidden';
            actionField.name = 'action';
            actionField.value = 'add';
            form.appendChild(actionField);
            
            const productField = document.createElement('input');
            productField.type = 'hidden';
            productField.name = 'product';
            productField.value = tenSP;
            form.appendChild(productField);
            
            const maSPField = document.createElement('input');
            maSPField.type = 'hidden';
            maSPField.name = 'maSP';
            maSPField.value = maSP;
            form.appendChild(maSPField);
            
            const giaField = document.createElement('input');
            giaField.type = 'hidden';
            giaField.name = 'gia';
            giaField.value = gia;
            form.appendChild(giaField);
            
            // Add storage if selected
            if (selectedStorage) {
                const storageField = document.createElement('input');
                storageField.type = 'hidden';
                storageField.name = 'storage';
                storageField.value = selectedStorage;
                form.appendChild(storageField);
            }
            
            // Add color if selected
            if (selectedColor) {
                const colorField = document.createElement('input');
                colorField.type = 'hidden';
                colorField.name = 'color';
                colorField.value = selectedColor;
                form.appendChild(colorField);
            }
            
            // Submit form
            document.body.appendChild(form);
            form.submit();
        }

        function showLoginModal(maSP, tenSP, gia) {
            // Store product info for later use
            window.pendingProduct = {maSP: maSP, tenSP: tenSP, gia: gia, storage: selectedStorage, color: selectedColor};
            
            // Show login modal
            const modal = document.getElementById('loginModal');
            modal.classList.add('show');
        }

        function proceedToLogin() {
            // Redirect to login page with current page as redirect URL
            const currentUrl = window.location.href;
            window.location.href = '${pageContext.request.contextPath}/views/login.jsp?redirect=' + encodeURIComponent(currentUrl);
        }

        function cancelLogin() {
            // Hide modal and stay on current page
            const modal = document.getElementById('loginModal');
            modal.classList.remove('show');
            window.pendingProduct = null;
        }
    </script>

    <!-- Login Required Modal -->
    <div id="loginModal" class="modal-overlay">
        <div class="modal-content">
            <div class="modal-header">
                <h3>Yêu cầu đăng nhập</h3>
            </div>
            <div class="modal-body">
                <p>Vui lòng đăng nhập để tiếp tục mua hàng</p>
            </div>
            <div class="modal-footer">
                <button id="cancelLogin" class="btn-cancel">Hủy</button>
                <button id="proceedLogin" class="btn-login">Đăng nhập</button>
            </div>
        </div>
    </div>

    <script>
        // Modal event listeners
        document.addEventListener('DOMContentLoaded', function() {
            const modal = document.getElementById('loginModal');
            const cancelBtn = document.getElementById('cancelLogin');
            const loginBtn = document.getElementById('proceedLogin');

            // Cancel button
            if (cancelBtn) {
                cancelBtn.addEventListener('click', cancelLogin);
            }

            // Login button
            if (loginBtn) {
                loginBtn.addEventListener('click', proceedToLogin);
            }

            // Click outside modal to close
            if (modal) {
                modal.addEventListener('click', function(e) {
                    if (e.target === modal) {
                        cancelLogin();
                    }
                });
            }

            // ESC key to close
            document.addEventListener('keydown', function(e) {
                if (e.key === 'Escape' && modal && modal.classList.contains('show')) {
                    cancelLogin();
                }
            });
        });
    </script>
</body>
</html>