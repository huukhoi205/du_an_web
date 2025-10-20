<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
    response.setContentType("text/html; charset=UTF-8");
    
    // Lấy thông tin user từ session
    String userName = (String) session.getAttribute("userName");
    String userRole = (String) session.getAttribute("userRole");
    
    // Lấy thông tin giỏ hàng từ request (được set bởi OrderServlet)
    java.util.List<controller.CartServlet.CartItem> cartItems = 
        (java.util.List<controller.CartServlet.CartItem>) request.getAttribute("cartItems");
    if (cartItems == null) {
        cartItems = new java.util.ArrayList<>();
    }
    
    // Lấy thông tin địa chỉ giao hàng từ request (được set bởi OrderServlet)
    java.util.List<dao.DiaChiGiaoHangDAO.DiaChiGiaoHang> danhSachDiaChi = 
        (java.util.List<dao.DiaChiGiaoHangDAO.DiaChiGiaoHang>) request.getAttribute("danhSachDiaChi");
    dao.DiaChiGiaoHangDAO.DiaChiGiaoHang diaChiMacDinh = 
        (dao.DiaChiGiaoHangDAO.DiaChiGiaoHang) request.getAttribute("diaChiMacDinh");
    
    if (danhSachDiaChi == null) {
        danhSachDiaChi = new java.util.ArrayList<>();
    }
    
    // Lấy thông tin tính toán từ request
    Integer uniqueProductsCount = (Integer) request.getAttribute("uniqueProductsCount");
    Double subtotal = (Double) request.getAttribute("subtotal");
    Double shippingFee = (Double) request.getAttribute("shippingFee");
    String shippingMessage = (String) request.getAttribute("shippingMessage");
    Double totalAmount = (Double) request.getAttribute("totalAmount");
    
    if (uniqueProductsCount == null) {
        uniqueProductsCount = cartItems.size();
    }
    if (subtotal == null) {
        subtotal = 0.0;
    }
    if (shippingFee == null) {
        shippingFee = 0.0;
    }
    if (shippingMessage == null) {
        shippingMessage = "Phí vận chuyển ngoài tỉnh";
    }
    if (totalAmount == null) {
        totalAmount = subtotal + shippingFee;
    }
    
    // Tính tổng tiền
    int totalItems = cartItems.size();
    
    // Import NumberFormat for currency formatting
    java.text.NumberFormat formatter = java.text.NumberFormat.getInstance(new java.util.Locale("vi", "VN"));
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đặt hàng - KT Store</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/index.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/order.css">
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
            <div class="order-container">
                <h1 class="page-title">Đặt hàng</h1>
                
                <% if (cartItems.isEmpty()) { %>
                <div class="empty-cart">
                    <i class="fas fa-shopping-cart"></i>
                    <h3>Giỏ hàng trống</h3>
                    <p>Bạn chưa có sản phẩm nào trong giỏ hàng</p>
                    <a href="${pageContext.request.contextPath}/views/index.jsp" class="btn-continue">Tiếp tục mua sắm</a>
                </div>
                <% } else { %>
                
                <div class="order-content">
                    <!-- Left Column - Order Form -->
                    <div class="order-form-section">
                        <form class="order-form" id="orderForm" method="post" action="${pageContext.request.contextPath}/OrderServlet">
                            <!-- Recipient Information -->
                            <div class="form-group">
                                <label for="recipientName">Thông tin người nhận</label>
                                <% if (diaChiMacDinh != null) { %>
                                    <input type="text" id="recipientName" name="recipientName" value="<%= diaChiMacDinh.getHoTenNguoiNhan() %>" required>
                                <% } else { %>
                                    <input type="text" id="recipientName" name="recipientName" value="<%= userName != null ? userName : "" %>" required>
                                <% } %>
                            </div>

                            <div class="form-group">
                                <label for="phoneNumber">SĐT</label>
                                <% if (diaChiMacDinh != null) { %>
                                    <input type="tel" id="phoneNumber" name="phoneNumber" value="<%= diaChiMacDinh.getSoDTNguoiNhan() %>" required>
                                <% } else { %>
                                    <input type="tel" id="phoneNumber" name="phoneNumber" placeholder="Nhập số điện thoại" required>
                                <% } %>
                            </div>

                            <div class="form-group">
                                <label for="deliveryAddress">Địa chỉ nhận</label>
                                <% if (diaChiMacDinh != null) { %>
                                    <input type="text" id="deliveryAddress" name="deliveryAddress" value="<%= diaChiMacDinh.getDiaChiChiTiet() %>" required>
                                <% } else { %>
                                    <input type="text" id="deliveryAddress" name="deliveryAddress" placeholder="Nhập địa chỉ giao hàng" required>
                                <% } %>
                            </div>
                            
                            <!-- Address Selection -->
                            <% if (!danhSachDiaChi.isEmpty()) { %>
                            <div class="form-group">
                                <label>Chọn địa chỉ giao hàng</label>
                                <div class="address-options">
                                    <% for (dao.DiaChiGiaoHangDAO.DiaChiGiaoHang diaChi : danhSachDiaChi) { %>
                                    <div class="address-option <%= diaChi.isMacDinh() ? "selected" : "" %>" 
                                         onclick="selectAddress('<%= diaChi.getHoTenNguoiNhan() %>', '<%= diaChi.getSoDTNguoiNhan() %>', '<%= diaChi.getDiaChiChiTiet() %>')">
                                        <div class="address-info">
                                            <div class="recipient-name">
                                                <strong><%= diaChi.getHoTenNguoiNhan() %></strong>
                                                <% if (diaChi.isMacDinh()) { %>
                                                <span class="default-badge">Mặc định</span>
                                                <% } %>
                                            </div>
                                            <div class="phone-number"><%= diaChi.getSoDTNguoiNhan() %></div>
                                            <div class="address-detail"><%= diaChi.getDiaChiChiTiet() %></div>
                                        </div>
                                    </div>
                                    <% } %>
                                </div>
                            </div>
                            <% } %>

                            <!-- Payment Method -->
                            <div class="form-group">
                                <label>Phương thức thanh toán</label>
                                <div class="payment-methods">
                                    <button type="button" class="payment-btn active" data-method="cash">
                                        <i class="fas fa-money-bill-wave"></i>
                                        Trực tiếp
                                    </button>
                                    <button type="button" class="payment-btn" data-method="credit">
                                        <i class="fas fa-credit-card"></i>
                                        Thẻ tín dụng
                                    </button>
                                    <button type="button" class="payment-btn" data-method="momo">
                                        <i class="fas fa-mobile-alt"></i>
                                        Ví MoMo
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div>

                    <!-- Right Column - Order Summary -->
                    <div class="order-summary-section">
                        <div class="summary-header">
                            <h3>Đơn hàng (<%= uniqueProductsCount %> sản phẩm)</h3>
                            <a href="${pageContext.request.contextPath}/views/cart.jsp" class="edit-link">Sửa</a>
                        </div>

                        <div class="order-items">
                            <% for (controller.CartServlet.CartItem item : cartItems) { 
                                String itemName = item.getProductName();
                                double itemPrice = 0.0;
                                if (item.getGia() != null && !item.getGia().isEmpty()) {
                                    itemPrice = Double.parseDouble(item.getGia());
                                }
                                int quantity = item.getQuantity();
                                double itemTotal = itemPrice * quantity;
                            %>
                            <div class="order-item">
                                <div class="item-info">
                                    <span class="item-name"><%= itemName %></span>
                                    <div class="item-details">
                                        <span class="item-quantity"><%= quantity %> x</span>
                                        <span class="item-price"><%= formatter.format(itemTotal) %> ₫</span>
                                    </div>
                                </div>
                            </div>
                            <% } %>
                        </div>

                        <div class="total-section">
                            <div class="subtotal">
                                <span class="subtotal-label">Tạm tính</span>
                                <span class="subtotal-amount" id="subtotalAmount"><%= formatter.format(subtotal) %> ₫</span>
                            </div>
                            <div class="shipping">
                                <span class="shipping-label">Phí vận chuyển</span>
                                <span class="shipping-amount" id="shippingAmount"><%= formatter.format(shippingFee) %> ₫</span>
                                <div class="shipping-message" id="shippingMessage"><%= shippingMessage %></div>
                            </div>
                            <div class="total">
                                <span class="total-label">Thành tiền</span>
                                <span class="total-amount" id="totalAmount"><%= formatter.format(totalAmount) %> ₫</span>
                            </div>
                        </div>

                        <button class="btn-pay" id="payBtn">
                            <i class="fas fa-credit-card"></i>
                            Thanh toán
                        </button>
                    </div>
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

    <!-- Payment Method Modal -->
    <div class="modal-overlay" id="paymentModal">
        <div class="modal-content">
            <div class="modal-header">
                <h3>Thông báo</h3>
            </div>
            <div class="modal-body">
                <div class="modal-icon">
                    <i class="fas fa-credit-card"></i>
                </div>
                <p>Tính năng thanh toán này đang được cập nhật.</p>
                <p>Hiện tại chỉ hỗ trợ thanh toán trực tiếp (COD).</p>
            </div>
            <div class="modal-footer">
                <button class="btn-ok" onclick="closePaymentModal()">OK</button>
            </div>
        </div>
    </div>

    <!-- Form Validation Modal -->
    <div class="modal-overlay" id="validationModal">
        <div class="modal-content">
            <div class="modal-header">
                <h3>Thông báo</h3>
            </div>
            <div class="modal-body">
                <div class="modal-icon">
                    <i class="fas fa-exclamation-triangle"></i>
                </div>
                <p id="validationMessage">Vui lòng điền đầy đủ thông tin.</p>
            </div>
            <div class="modal-footer">
                <button class="btn-ok" onclick="closeValidationModal()">OK</button>
            </div>
        </div>
    </div>

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
        
        .empty-cart {
            text-align: center;
            padding: 60px 20px;
            background: #f8f9fa;
            border-radius: 10px;
            margin: 40px 0;
        }
        
        .empty-cart i {
            font-size: 64px;
            color: #ddd;
            margin-bottom: 20px;
        }
        
        .empty-cart h3 {
            color: #333;
            margin-bottom: 10px;
        }
        
        .empty-cart p {
            color: #666;
            margin-bottom: 30px;
        }
        
        .btn-continue {
            display: inline-block;
            background: #e74c3c;
            color: white;
            padding: 12px 30px;
            text-decoration: none;
            border-radius: 5px;
            transition: background 0.3s;
        }
        
        .btn-continue:hover {
            background: #c0392b;
        }
        
        /* Main Layout */
        .order-content {
            display: flex;
            gap: 30px;
            margin-top: 30px;
        }
        
        .order-form-section {
            flex: 1;
            background: #f8f9fa;
            padding: 30px;
            border-radius: 10px;
            border: 1px solid #e9ecef;
        }
        
        .order-summary-section {
            flex: 1;
            background: #f8f9fa;
            padding: 30px;
            border-radius: 10px;
            border: 1px solid #e9ecef;
        }
        
        /* Form Styling */
        .form-group {
            margin-bottom: 25px;
        }
        
        .form-group label {
            display: block;
            font-weight: bold;
            color: #333;
            margin-bottom: 8px;
            font-size: 14px;
        }
        
        .form-group input {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
            background: white;
            transition: border-color 0.3s;
        }
        
        .form-group input:focus {
            outline: none;
            border-color: #e74c3c;
        }
        
        /* Address Options */
        .address-options {
            margin-top: 10px;
        }
        
        .address-option {
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 15px;
            margin-bottom: 10px;
            cursor: pointer;
            transition: all 0.3s;
            background: white;
        }
        
        .address-option:hover {
            border-color: #e74c3c;
            background: #fff5f5;
        }
        
        .address-option.selected {
            border-color: #e74c3c;
            background: #fff5f5;
            box-shadow: 0 2px 4px rgba(231, 76, 60, 0.1);
        }
        
        .address-info {
            display: flex;
            flex-direction: column;
            gap: 5px;
        }
        
        .recipient-name {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .default-badge {
            background: #e74c3c;
            color: white;
            padding: 2px 8px;
            border-radius: 3px;
            font-size: 12px;
            font-weight: normal;
        }
        
        .phone-number {
            color: #666;
            font-size: 14px;
        }
        
        .address-detail {
            color: #333;
            font-size: 14px;
        }
        
        /* Payment Methods */
        .payment-methods {
            display: flex;
            gap: 10px;
            margin-top: 10px;
        }
        
        .payment-btn {
            flex: 1;
            padding: 15px;
            border: 1px solid #ddd;
            background: white;
            border-radius: 5px;
            cursor: pointer;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            font-size: 14px;
            color: #333;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        
        .payment-btn:hover {
            border-color: #e74c3c;
            background: #fff5f5;
        }
        
        .payment-btn.active {
            border-color: #e74c3c;
            background: #e74c3c;
            color: white;
        }
        
        /* Order Summary Styling */
        .summary-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 1px solid #ddd;
        }
        
        .summary-header h3 {
            margin: 0;
            color: #333;
            font-size: 18px;
        }
        
        .edit-link {
            color: #666;
            text-decoration: none;
            font-size: 14px;
        }
        
        .edit-link:hover {
            color: #e74c3c;
        }
        
        .order-items {
            margin-bottom: 20px;
        }
        
        .order-item {
            padding: 15px 0;
            border-bottom: 1px solid #eee;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .order-item:last-child {
            border-bottom: none;
        }
        
        .item-info {
            display: flex;
            justify-content: space-between;
            align-items: center;
            width: 100%;
        }
        
        .item-name {
            font-weight: 500;
            color: #333;
        }
        
        .item-details {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .item-quantity {
            color: #666;
            font-size: 14px;
        }
        
        .item-price {
            font-weight: bold;
            color: #333;
        }
        
        .total-section {
            margin-top: 20px;
            padding-top: 20px;
            border-top: 2px solid #eee;
        }
        
        .subtotal, .shipping, .total {
            display: block;
            margin-bottom: 15px;
            padding: 8px 0;
        }
        
        .subtotal-label, .shipping-label, .total-label {
            color: #666;
            display: block;
            margin-bottom: 5px;
        }
        
        .subtotal-amount,         .shipping-amount {
            color: #333;
            display: block;
            text-align: right;
            font-weight: 500;
        }
        
        .shipping-message {
            font-size: 12px;
            color: #666;
            text-align: right;
            margin-top: 2px;
            font-style: italic;
        }
        
        /* Payment Modal Styles */
        .modal-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            display: none;
            justify-content: center;
            align-items: center;
            z-index: 10000;
        }
        
        .modal-overlay.show {
            display: flex;
        }
        
        .modal-content {
            background: white;
            border-radius: 10px;
            padding: 0;
            max-width: 400px;
            width: 90%;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
            animation: modalSlideIn 0.3s ease-out;
        }
        
        @keyframes modalSlideIn {
            from {
                opacity: 0;
                transform: translateY(-50px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .modal-header {
            padding: 20px 20px 0 20px;
            text-align: center;
        }
        
        .modal-header h3 {
            margin: 0;
            color: #333;
            font-size: 18px;
        }
        
        .modal-body {
            padding: 20px;
            text-align: center;
        }
        
        .modal-icon {
            font-size: 48px;
            color: #e74c3c;
            margin-bottom: 15px;
        }
        
        .modal-body p {
            margin: 10px 0;
            color: #666;
            line-height: 1.5;
        }
        
        .modal-footer {
            padding: 0 20px 20px 20px;
            text-align: center;
        }
        
        .btn-ok {
            background: #e74c3c;
            color: white;
            border: none;
            padding: 12px 30px;
            border-radius: 5px;
            font-size: 14px;
            font-weight: bold;
            cursor: pointer;
            transition: background 0.3s;
            min-width: 100px;
        }
        
        .btn-ok:hover {
            background: #c0392b;
        }
        
        /* Validation Modal Icon */
        #validationModal .modal-icon {
            color: #f39c12;
        }
        
        .total {
            font-weight: bold;
            font-size: 18px;
            color: #e74c3c;
            border-top: 1px solid #eee;
            padding-top: 15px;
            margin-top: 15px;
        }
        
        .total-label {
            color: #333;
            display: block;
            margin-bottom: 5px;
        }
        
        .total-amount {
            color: #e74c3c;
            font-size: 20px;
            display: block;
            text-align: right;
            font-weight: bold;
        }
        
        .btn-pay {
            width: 100%;
            background: #8B4513;
            color: white;
            border: none;
            padding: 15px;
            border-radius: 5px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: background 0.3s;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            margin-top: 20px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        
        .btn-pay:hover {
            background: #A0522D;
        }
        
        .btn-pay:disabled {
            background: #ccc;
            cursor: not-allowed;
        }
        
        /* Responsive Design */
        @media (max-width: 768px) {
            .order-content {
                flex-direction: column;
                gap: 20px;
            }
            
            .order-form-section,
            .order-summary-section {
                padding: 20px;
            }
            
            .payment-methods {
                flex-direction: column;
            }
            
            .payment-btn {
                margin-bottom: 10px;
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

        // Function to select address
        function selectAddress(recipientName, phoneNumber, address) {
            // Update form fields
            document.getElementById('recipientName').value = recipientName;
            document.getElementById('phoneNumber').value = phoneNumber;
            document.getElementById('deliveryAddress').value = address;
            
            // Update visual selection
            document.querySelectorAll('.address-option').forEach(option => {
                option.classList.remove('selected');
            });
            event.currentTarget.classList.add('selected');
            
            // Update shipping fee based on address
            updateShippingFee(address);
        }
        
        // Function to calculate shipping fee
        function calculateShippingFee(address) {
            if (!address || address.trim() === '') {
                return 0; // Chưa nhập địa chỉ thì phí vận chuyển = 0₫
            }
            
            const addressLower = address.toLowerCase().trim();
            const binhDinhKeywords = [
                'bình định', 'binh dinh', 'quy nhơn', 'quy nhon',
                'an nhơn', 'an nhon', 'hoài nhơn', 'hoai nhon',
                'phù cát', 'phu cat', 'phù mỹ', 'phu my',
                'tây sơn', 'tay son', 'vân canh', 'van canh',
                'vĩnh thạnh', 'vinh thanh', 'tuy phước', 'tuy phuoc'
            ];
            
            for (let keyword of binhDinhKeywords) {
                if (addressLower.includes(keyword)) {
                    return 0; // Free shipping for Binh Dinh
                }
            }
            
            return 98990; // Outside province fee
        }
        
        // Function to update shipping fee display
        function updateShippingFee(address) {
            const shippingFee = calculateShippingFee(address);
            const subtotal = parseFloat(document.getElementById('subtotalAmount').textContent.replace(/[^\d]/g, ''));
            const total = subtotal + shippingFee;
            
            // Update shipping amount
            document.getElementById('shippingAmount').textContent = formatCurrency(shippingFee) + ' ₫';
            
            // Update shipping message
            let shippingMessage;
            if (!address || address.trim() === '') {
                shippingMessage = 'Vui lòng nhập địa chỉ để tính phí vận chuyển';
            } else if (shippingFee === 0) {
                shippingMessage = 'Miễn phí vận chuyển trong tỉnh Bình Định';
            } else {
                shippingMessage = 'Phí vận chuyển ngoài tỉnh';
            }
            document.getElementById('shippingMessage').textContent = shippingMessage;
            
            // Update total amount
            document.getElementById('totalAmount').textContent = formatCurrency(total) + ' ₫';
        }
        
        // Function to format currency
        function formatCurrency(amount) {
            return new Intl.NumberFormat('vi-VN').format(amount);
        }
        
        // Function to show payment modal
        function showPaymentModal() {
            const modal = document.getElementById('paymentModal');
            modal.classList.add('show');
        }
        
        // Function to close payment modal
        function closePaymentModal() {
            const modal = document.getElementById('paymentModal');
            modal.classList.remove('show');
        }
        
        // Function to show validation modal
        function showValidationModal(message) {
            const modal = document.getElementById('validationModal');
            const messageElement = document.getElementById('validationMessage');
            messageElement.textContent = message;
            modal.classList.add('show');
        }
        
        // Function to close validation modal
        function closeValidationModal() {
            const modal = document.getElementById('validationModal');
            modal.classList.remove('show');
        }
        
        // Function to validate recipient name (at least 3 words)
        function validateRecipientName(name) {
            if (!name || name.trim() === '') {
                return 'Vui lòng nhập họ tên người nhận.';
            }
            
            const words = name.trim().split(/\s+/);
            if (words.length < 3) {
                return 'Họ tên người nhận phải có ít nhất 3 từ (ví dụ: Nguyễn Văn A).';
            }
            
            return null; // Valid
        }
        
        // Function to validate phone number (exactly 10 digits)
        function validatePhoneNumber(phone) {
            if (!phone || phone.trim() === '') {
                return 'Vui lòng nhập số điện thoại.';
            }
            
            const phoneDigits = phone.replace(/\D/g, ''); // Remove non-digits
            if (phoneDigits.length !== 10) {
                return 'Số điện thoại phải có đúng 10 số.';
            }
            
            return null; // Valid
        }
        
        // Function to validate delivery address
        function validateDeliveryAddress(address) {
            if (!address || address.trim() === '') {
                return 'Vui lòng nhập địa chỉ giao hàng.';
            }
            
            return null; // Valid
        }

        document.addEventListener('DOMContentLoaded', function() {
            // Payment method selection
            const paymentBtns = document.querySelectorAll('.payment-btn');
            paymentBtns.forEach(btn => {
                btn.addEventListener('click', function() {
                    const method = this.dataset.method;
                    
                    // Check if it's a supported payment method
                    if (method === 'credit' || method === 'momo') {
                        // Show modal for unsupported payment methods
                        showPaymentModal();
                        return;
                    }
                    
                    // For supported methods (cash/COD), proceed normally
                    paymentBtns.forEach(b => b.classList.remove('active'));
                    this.classList.add('active');
                });
            });
            
            // Update shipping fee when delivery address changes
            const deliveryAddressInput = document.getElementById('deliveryAddress');
            if (deliveryAddressInput) {
                deliveryAddressInput.addEventListener('input', function() {
                    updateShippingFee(this.value);
                });
            }
            
            // Close modal when clicking outside
            const paymentModal = document.getElementById('paymentModal');
            if (paymentModal) {
                paymentModal.addEventListener('click', function(e) {
                    if (e.target === paymentModal) {
                        closePaymentModal();
                    }
                });
            }
            
            // Close validation modal when clicking outside
            const validationModal = document.getElementById('validationModal');
            if (validationModal) {
                validationModal.addEventListener('click', function(e) {
                    if (e.target === validationModal) {
                        closeValidationModal();
                    }
                });
            }

            // Form submission
            const orderForm = document.getElementById('orderForm');
            const payBtn = document.getElementById('payBtn');
            
            if (payBtn) {
                payBtn.addEventListener('click', function() {
                    // Get form values
                    const recipientName = document.getElementById('recipientName').value;
                    const phoneNumber = document.getElementById('phoneNumber').value;
                    const deliveryAddress = document.getElementById('deliveryAddress').value;
                    
                    // Validate recipient name
                    const nameError = validateRecipientName(recipientName);
                    if (nameError) {
                        showValidationModal(nameError);
                        return;
                    }
                    
                    // Validate phone number
                    const phoneError = validatePhoneNumber(phoneNumber);
                    if (phoneError) {
                        showValidationModal(phoneError);
                        return;
                    }
                    
                    // Validate delivery address
                    const addressError = validateDeliveryAddress(deliveryAddress);
                    if (addressError) {
                        showValidationModal(addressError);
                        return;
                    }
                    
                    // Check if payment method is selected
                    const selectedPayment = document.querySelector('.payment-btn.active');
                    if (!selectedPayment) {
                        showValidationModal('Vui lòng chọn phương thức thanh toán.');
                        return;
                    }
                    
                    // Check if payment method is supported (only COD)
                    if (selectedPayment.dataset.method !== 'cash') {
                        showValidationModal('Hiện tại chỉ hỗ trợ thanh toán trực tiếp (COD).');
                        return;
                    }
                    
                    // Add payment method to form
                    const paymentInput = document.createElement('input');
                    paymentInput.type = 'hidden';
                    paymentInput.name = 'paymentMethod';
                    paymentInput.value = selectedPayment.dataset.method;
                    orderForm.appendChild(paymentInput);
                    
                    // Show loading
                    payBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Đang xử lý...';
                    payBtn.disabled = true;
                    
                    // Submit form
                    console.log('Submitting form to:', orderForm.action);
                    console.log('Form method:', orderForm.method);
                    orderForm.submit();
                });
            }
        });
    </script>
</body>
</html>