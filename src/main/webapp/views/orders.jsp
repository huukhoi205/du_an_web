<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Order, model.UserProfile, java.util.List, java.text.NumberFormat, java.util.Locale" %>

<%
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
    response.setContentType("text/html; charset=UTF-8");
    
    // Lấy thông tin user từ session
    String userName = (String) session.getAttribute("userName");
    Integer userId = (Integer) session.getAttribute("userId");
    String userRole = (String) session.getAttribute("userRole");
    
    // Lấy thông tin user từ request attribute (được set bởi OrdersServlet)
    UserProfile userProfile = (UserProfile) request.getAttribute("userProfile");
    List<Order> orders = (List<Order>) request.getAttribute("orders");
    
    // Debug: Hiển thị thông tin user
    System.out.println("orders.jsp - userProfile: " + (userProfile != null ? userProfile.toString() : "null"));
    if (userProfile != null) {
        System.out.println("orders.jsp - HoTen: " + userProfile.getHoTen());
        System.out.println("orders.jsp - Email: " + userProfile.getEmail());
        System.out.println("orders.jsp - SoDT: " + userProfile.getSoDT());
        System.out.println("orders.jsp - MaND: " + userProfile.getMaND());
    }
    
    // Fallback nếu không có dữ liệu
    if (orders == null) {
        orders = new java.util.ArrayList<Order>();
    }
    
    NumberFormat formatter = NumberFormat.getInstance(new Locale("vi", "VN"));
    
    // Lấy thông báo
    String success = (String) request.getAttribute("success");
    String error = (String) request.getAttribute("error");
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đơn hàng của tôi - KT Store</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/index.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        /* Orders Page Styles */
        .orders-page {
            min-height: 100vh;
            background: #f8f9fa;
            padding: 20px 0;
        }
        
        .page-header {
            text-align: center;
            margin-bottom: 40px;
        }
        
        .page-title {
            font-size: 32px;
            font-weight: bold;
            color: #2c3e50;
            margin-bottom: 10px;
        }
        
        .page-subtitle {
            font-size: 16px;
            color: #7f8c8d;
        }
        
        .orders-container {
            max-width: 1000px;
            margin: 0 auto;
            padding: 0 20px;
        }
        
        .orders-list {
            display: grid;
            gap: 20px;
        }
        
        .order-card {
            background: white;
            border-radius: 12px;
            padding: 24px;
            box-shadow: 0 2px 12px rgba(0,0,0,0.1);
            transition: transform 0.3s, box-shadow 0.3s;
            cursor: pointer;
        }
        
        .order-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 20px rgba(0,0,0,0.15);
        }
        
        .order-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 16px;
        }
        
        .order-info h3 {
            font-size: 20px;
            font-weight: bold;
            color: #2c3e50;
            margin: 0 0 8px 0;
        }
        
        .order-date {
            color: #7f8c8d;
            font-size: 14px;
        }
        
        .order-date i {
            margin-right: 6px;
        }
        
        .order-status {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: bold;
            text-transform: uppercase;
        }
        
        .status-dang-xu-ly {
            background: #fff3cd;
            color: #856404;
        }
        
        .status-da-xac-nhan {
            background: #d1ecf1;
            color: #0c5460;
        }
        
        .status-dang-giao {
            background: #d4edda;
            color: #155724;
        }
        
        .status-da-giao {
            background: #cce5ff;
            color: #004085;
        }
        
        .status-da-huy {
            background: #f8d7da;
            color: #721c24;
        }
        
        .order-details {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 16px;
        }
        
        .order-items {
            display: flex;
            align-items: center;
            color: #7f8c8d;
            font-size: 14px;
        }
        
        .order-items i {
            margin-right: 8px;
            color: #3498db;
        }
        
        .order-total {
            display: flex;
            align-items: center;
            font-size: 18px;
            font-weight: bold;
            color: #e74c3c;
        }
        
        .order-total i {
            margin-right: 8px;
        }
        
        .order-actions {
            text-align: right;
        }
        
        .btn-view-details {
            background: #3498db;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 6px;
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
            transition: background 0.3s;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }
        
        .btn-view-details:hover {
            background: #2980b9;
        }
        
        .empty-orders {
            text-align: center;
            padding: 60px 20px;
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 12px rgba(0,0,0,0.1);
        }
        
        .empty-orders i {
            font-size: 64px;
            color: #bdc3c7;
            margin-bottom: 20px;
        }
        
        .empty-orders h3 {
            font-size: 24px;
            color: #2c3e50;
            margin-bottom: 10px;
        }
        
        .empty-orders p {
            color: #7f8c8d;
            font-size: 16px;
            margin-bottom: 30px;
        }
        
        .btn-shop-now {
            background: #e74c3c;
            color: white;
            border: none;
            padding: 12px 24px;
            border-radius: 6px;
            font-size: 16px;
            font-weight: 500;
            cursor: pointer;
            transition: background 0.3s;
            text-decoration: none;
            display: inline-block;
        }
        
        .btn-shop-now:hover {
            background: #c0392b;
        }
        
        /* Responsive */
        @media (max-width: 768px) {
            .order-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 10px;
            }
            
            .order-details {
                flex-direction: column;
                gap: 10px;
                align-items: flex-start;
            }
            
            .order-actions {
                text-align: left;
            }
            
            .page-title {
                font-size: 24px;
            }
        }
    </style>
</head>
<body>
    <!-- Header -->
    <header class="header">
        <div class="container">
            <div class="header-content">
                <!-- Logo -->
                <div class="logo">
                    <a href="${pageContext.request.contextPath}/views/index.jsp">
                        <img src="${pageContext.request.contextPath}/image/ca6a32d5a48f3e706cefc42bf7073f0751fc03f2.jpg" alt="KT Store" style="height: 70px;">
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
                                <a href="${pageContext.request.contextPath}/views/orders.jsp"><i class="fas fa-box"></i> Đơn hàng</a>
                                <a href="${pageContext.request.contextPath}/myorders"><i class="fas fa-exchange-alt"></i> Thu mua-Sửa chữa</a>
                                <% if ("Admin".equals(userRole)) { %>
                                <a href="${pageContext.request.contextPath}/admin/index.jsp"><i class="fas fa-cog"></i> Quản trị</a>
                                <% } %>
                                <hr>
                                <a href="${pageContext.request.contextPath}/views/logout.jsp" class="logout-link"><i class="fas fa-sign-out-alt"></i> Đăng xuất</a>
                            </div>
                        </div>
                    <% } else { %>
                        <a href="login.jsp" class="btn-login">ĐĂNG NHẬP</a>
                        <span class="separator">|</span>
                        <a href="register.jsp" class="btn-register">ĐĂNG KÝ</a>
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
    <main class="orders-page">
        <div class="container">
            <div class="page-header">
                <h1 class="page-title">Đơn hàng của tôi</h1>
                <p class="page-subtitle">Quản lý và theo dõi các đơn hàng của bạn</p>
            </div>

            <div class="orders-container">
                <% if (orders != null && !orders.isEmpty()) { %>
                    <div class="orders-list">
                        <% for (Order order : orders) { %>
                            <div class="order-card" onclick="viewOrderDetails(<%= order.getMaDH() %>)">
                                <div class="order-header">
                                    <div class="order-info">
                                        <h3>Đơn hàng #<%= order.getMaDH() %></h3>
                                        <span class="order-date">
                                            <i class="fas fa-calendar"></i>
                                            <%= order.getNgayDat() %>
                                        </span>
                                    </div>
                                    <div class="order-status status-<%= order.getTrangThai().toLowerCase().replace(" ", "-") %>">
                                        <%= order.getTrangThai() %>
                                    </div>
                                </div>
                                
                                <div class="order-details">
                                    <div class="order-items">
                                        <i class="fas fa-shopping-cart"></i>
                                        <%= order.getSoLuongSanPham() %> sản phẩm
                                    </div>
                                    <div class="order-total">
                                        <i class="fas fa-money-bill-wave"></i>
                                        <%= formatter.format(order.getTongTien()) %> ₫
                                    </div>
                                </div>
                                
                                <div class="order-actions">
                                    <button class="btn-view-details">
                                        <i class="fas fa-eye"></i>
                                        Xem chi tiết
                                    </button>
                                </div>
                            </div>
                        <% } %>
                    </div>
                <% } else { %>
                    <div class="empty-orders">
                        <i class="fas fa-shopping-bag"></i>
                        <h3>Chưa có đơn hàng nào</h3>
                        <p>Bạn chưa có đơn hàng nào. Hãy bắt đầu mua sắm ngay!</p>
                        <a href="${pageContext.request.contextPath}/views/index.jsp" class="btn-shop-now">
                            <i class="fas fa-shopping-cart"></i>
                            Mua sắm ngay
                        </a>
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

    <script src="${pageContext.request.contextPath}/resources/js/script-new.js"></script>
    
    <script>
        function toggleUserDropdown() {
            const dropdown = document.getElementById('userDropdown');
            dropdown.classList.toggle('show');
        }

        function viewOrderDetails(orderId) {
            // Chuyển đến trang chi tiết đơn hàng
            window.location.href = '${pageContext.request.contextPath}/order-details?orderId=' + orderId;
        }

        // Đóng dropdown khi click bên ngoài
        window.onclick = function(event) {
            if (!event.target.matches('.user-btn') && !event.target.closest('.user-menu')) {
                const dropdown = document.getElementById('userDropdown');
                if (dropdown.classList.contains('show')) {
                    dropdown.classList.remove('show');
                }
            }
        }
    </script>
</body>
</html>
