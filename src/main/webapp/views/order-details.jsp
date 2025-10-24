<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Order, model.OrderItem, model.Product, java.util.List, java.text.NumberFormat, java.util.Locale" %>

<%
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
    response.setContentType("text/html; charset=UTF-8");
    
    // Lấy thông tin user từ session
    String userName = (String) session.getAttribute("userName");
    Integer userId = (Integer) session.getAttribute("userId");
    String userRole = (String) session.getAttribute("userRole");
    
    // Lấy thông tin đơn hàng từ request attribute
    Order order = (Order) request.getAttribute("order");
    List<OrderItem> orderItems = (List<OrderItem>) request.getAttribute("orderItems");
    
    NumberFormat formatter = NumberFormat.getInstance(new Locale("vi", "VN"));
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết đơn hàng - KT Store</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/index.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        /* Order Details Page Styles */
        .order-details-page {
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
        
        .order-details-container {
            max-width: 1000px;
            margin: 0 auto;
            padding: 0 20px;
        }
        
        .order-info-card {
            background: white;
            border-radius: 12px;
            padding: 24px;
            box-shadow: 0 2px 12px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }
        
        .order-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 20px;
            padding-bottom: 20px;
            border-bottom: 1px solid #ecf0f1;
        }
        
        .order-info h2 {
            font-size: 24px;
            font-weight: bold;
            color: #2c3e50;
            margin: 0 0 8px 0;
        }
        
        .order-date {
            color: #7f8c8d;
            font-size: 14px;
        }
        
        .order-status {
            padding: 8px 16px;
            border-radius: 20px;
            font-size: 14px;
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
        
        .order-summary {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 20px;
        }
        
        .summary-item {
            text-align: center;
            padding: 16px;
            background: #f8f9fa;
            border-radius: 8px;
        }
        
        .summary-item i {
            font-size: 24px;
            color: #3498db;
            margin-bottom: 8px;
        }
        
        .summary-item h4 {
            font-size: 14px;
            color: #7f8c8d;
            margin: 0 0 4px 0;
        }
        
        .summary-item p {
            font-size: 18px;
            font-weight: bold;
            color: #2c3e50;
            margin: 0;
        }
        
        .order-items-section {
            background: white;
            border-radius: 12px;
            padding: 24px;
            box-shadow: 0 2px 12px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }
        
        .section-title {
            font-size: 20px;
            font-weight: bold;
            color: #2c3e50;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #3498db;
        }
        
        .order-items-list {
            display: grid;
            gap: 16px;
        }
        
        .order-item {
            display: flex;
            align-items: center;
            padding: 16px;
            background: #f8f9fa;
            border-radius: 8px;
            transition: background 0.3s;
        }
        
        .order-item:hover {
            background: #ecf0f1;
        }
        
        .item-image {
            width: 80px;
            height: 80px;
            border-radius: 8px;
            object-fit: cover;
            margin-right: 16px;
        }
        
        .item-info {
            flex: 1;
        }
        
        .item-name {
            font-size: 16px;
            font-weight: bold;
            color: #2c3e50;
            margin-bottom: 4px;
        }
        
        .item-specs {
            font-size: 14px;
            color: #7f8c8d;
            margin-bottom: 4px;
        }
        
        .item-price {
            font-size: 16px;
            font-weight: bold;
            color: #e74c3c;
        }
        
        .item-quantity {
            background: #3498db;
            color: white;
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: bold;
            margin-left: 16px;
        }
        
        .order-total-section {
            background: white;
            border-radius: 12px;
            padding: 24px;
            box-shadow: 0 2px 12px rgba(0,0,0,0.1);
        }
        
        .total-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 8px 0;
            border-bottom: 1px solid #ecf0f1;
        }
        
        .total-row:last-child {
            border-bottom: none;
            font-size: 18px;
            font-weight: bold;
            color: #2c3e50;
            margin-top: 10px;
            padding-top: 15px;
            border-top: 2px solid #3498db;
        }
        
        .back-button {
            background: #95a5a6;
            color: white;
            border: none;
            padding: 12px 24px;
            border-radius: 6px;
            font-size: 16px;
            font-weight: 500;
            cursor: pointer;
            transition: background 0.3s;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            margin-bottom: 20px;
        }
        
        .back-button:hover {
            background: #7f8c8d;
        }
        
        /* Responsive */
        @media (max-width: 768px) {
            .order-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 10px;
            }
            
            .order-summary {
                grid-template-columns: 1fr;
            }
            
            .order-item {
                flex-direction: column;
                text-align: center;
            }
            
            .item-image {
                margin-right: 0;
                margin-bottom: 12px;
            }
            
            .item-quantity {
                margin-left: 0;
                margin-top: 8px;
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
    <main class="order-details-page">
        <div class="container">
            <div class="page-header">
                <h1 class="page-title">Chi tiết đơn hàng</h1>
                <p class="page-subtitle">Thông tin chi tiết về đơn hàng của bạn</p>
            </div>

            <div class="order-details-container">
                <a href="${pageContext.request.contextPath}/views/orders.jsp" class="back-button">
                    <i class="fas fa-arrow-left"></i>
                    Quay lại danh sách đơn hàng
                </a>

                <% if (order != null) { %>
                    <!-- Order Information -->
                    <div class="order-info-card">
                        <div class="order-header">
                            <div class="order-info">
                                <h2>Đơn hàng #<%= order.getMaDH() %></h2>
                                <span class="order-date">
                                    <i class="fas fa-calendar"></i>
                                    <%= order.getNgayDat() %>
                                </span>
                            </div>
                            <div class="order-status status-<%= order.getTrangThai().toLowerCase().replace(" ", "-") %>">
                                <%= order.getTrangThai() %>
                            </div>
                        </div>

                        <div class="order-summary">
                            <div class="summary-item">
                                <i class="fas fa-shopping-cart"></i>
                                <h4>Số sản phẩm</h4>
                                <p><%= order.getSoLuongSanPham() %></p>
                            </div>
                            <div class="summary-item">
                                <i class="fas fa-money-bill-wave"></i>
                                <h4>Tổng tiền</h4>
                                <p><%= formatter.format(order.getTongTien()) %> ₫</p>
                            </div>
                            <div class="summary-item">
                                <i class="fas fa-map-marker-alt"></i>
                                <h4>Địa chỉ giao hàng</h4>
                                <p><%= order.getDiaChiGiaoHang() %></p>
                            </div>
                            <div class="summary-item">
                                <i class="fas fa-phone"></i>
                                <h4>Số điện thoại</h4>
                                <p><%= order.getSoDienThoai() %></p>
                            </div>
                        </div>
                    </div>

                    <!-- Order Items -->
                    <div class="order-items-section">
                        <h3 class="section-title">Sản phẩm trong đơn hàng</h3>
                        <div class="order-items-list">
                            <% if (orderItems != null && !orderItems.isEmpty()) { %>
                                <% for (OrderItem item : orderItems) { %>
                                    <div class="order-item">
                                        <img src="${pageContext.request.contextPath}/image/<%= item.getProduct().getHinhAnh() %>" 
                                             alt="<%= item.getProduct().getTenSP() %>" class="item-image">
                                        <div class="item-info">
                                            <div class="item-name"><%= item.getProduct().getTenSP() %></div>
                                            <div class="item-specs">Màu: <%= item.getMauSac() %> | Dung lượng: <%= item.getDungLuong() %></div>
                                            <div class="item-price"><%= formatter.format(item.getGia()) %> ₫</div>
                                        </div>
                                        <div class="item-quantity">x<%= item.getSoLuong() %></div>
                                    </div>
                                <% } %>
                            <% } else { %>
                                <p>Không có sản phẩm nào trong đơn hàng này.</p>
                            <% } %>
                        </div>
                    </div>

                    <!-- Order Total -->
                    <div class="order-total-section">
                        <h3 class="section-title">Tổng kết đơn hàng</h3>
                        <div class="total-row">
                            <span>Tạm tính:</span>
                            <span><%= formatter.format(order.getTongTien()) %> ₫</span>
                        </div>
                        <div class="total-row">
                            <span>Phí vận chuyển:</span>
                            <span>Miễn phí</span>
                        </div>
                        <div class="total-row">
                            <span>Giảm giá:</span>
                            <span>0 ₫</span>
                        </div>
                        <div class="total-row">
                            <span>Tổng cộng:</span>
                            <span><%= formatter.format(order.getTongTien()) %> ₫</span>
                        </div>
                    </div>
                <% } else { %>
                    <div class="order-info-card">
                        <h2>Không tìm thấy đơn hàng</h2>
                        <p>Đơn hàng bạn tìm kiếm không tồn tại hoặc bạn không có quyền xem.</p>
                        <a href="${pageContext.request.contextPath}/views/orders.jsp" class="back-button">
                            <i class="fas fa-arrow-left"></i>
                            Quay lại danh sách đơn hàng
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
