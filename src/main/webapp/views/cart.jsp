<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Ensure UTF-8 encoding
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
    response.setContentType("text/html; charset=UTF-8");
%>
<%@ page import="controller.CartServlet.CartItem, java.util.List, java.text.NumberFormat, java.util.Locale" %>
<%
    // Lấy thông tin user từ session
    String userName = (String) session.getAttribute("userName");
    String userRole = (String) session.getAttribute("userRole");
    
    // Lấy cart items từ session
    List<CartItem> cartItems = (List<CartItem>) session.getAttribute("cartItems");
    if (cartItems == null) {
        cartItems = new java.util.ArrayList<>();
    }
    
    // Tính tổng tiền từ cart items
    java.math.BigDecimal totalAmount = java.math.BigDecimal.ZERO;
    for (CartItem item : cartItems) {
        if (item.getGia() != null && !item.getGia().isEmpty()) {
            try {
                java.math.BigDecimal itemPrice = new java.math.BigDecimal(item.getGia());
                java.math.BigDecimal itemTotal = itemPrice.multiply(new java.math.BigDecimal(item.getQuantity()));
                totalAmount = totalAmount.add(itemTotal);
            } catch (NumberFormatException e) {
                System.err.println("Invalid price format for item: " + item.getProductName());
            }
        }
    }
    
    // Debug logging
    System.out.println("Cart - Total items: " + cartItems.size());
    System.out.println("Cart - Total amount: " + totalAmount);
    for (CartItem item : cartItems) {
        System.out.println("Cart - Item: " + item.getProductName() + ", Storage: " + item.getStorage() + ", Color: " + item.getColor() + ", Qty: " + item.getQuantity());
    }
    
    NumberFormat formatter = NumberFormat.getInstance(new Locale("vi", "VN"));
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Giỏ hàng - KT Store</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/index.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/cart.css">
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
                    <a href="${pageContext.request.contextPath}/cart" class="icon-btn" title="Giỏ hàng">
                        <i class="fas fa-shopping-cart"></i>
                    </a>
                    <a href="wishlist.jsp" class="icon-btn" title="Yêu thích">
                        <i class="far fa-heart"></i>
                    </a>
                    <%
                        if (userName != null) {
                    %>
                        <div class="user-dropdown">
                            <button class="user-btn" onclick="toggleUserDropdown()">
                                <i class="fas fa-user"></i>
                                <%= userName %>
                                <i class="fas fa-chevron-down"></i>
                            </button>
                            <div class="dropdown-menu">
                                <a href="${pageContext.request.contextPath}/profile">Trang cá nhân</a>
                                <a href="${pageContext.request.contextPath}/views/order-success.jsp">Đơn hàng</a>
                                <a href="${pageContext.request.contextPath}/user-services">Thu mua - Sửa chữa</a>
                                <a href="logout.jsp">Đăng xuất</a>
                            </div>
                        </div>
                    <%
                        } else {
                    %>
                        <a href="login.jsp" class="btn-login">ĐĂNG NHẬP</a>
                        <span class="separator">|</span>
                        <a href="register.jsp" class="btn-register">ĐĂNG KÝ</a>
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
    <main class="main-content">
        <div class="container">
            <div class="cart-container">
                <h1 class="page-title">Giỏ hàng</h1>
                
                <div class="cart-content">
                    <!-- Cart Items -->
                    <div class="cart-items">
                        <% if (cartItems.isEmpty()) { %>
                        <!-- Empty Cart Message -->
                        <div class="empty-cart">
                            <h3>Giỏ hàng trống</h3>
                            <p>Bạn chưa có sản phẩm nào trong giỏ hàng.</p>
                            <a href="${pageContext.request.contextPath}/views/index.jsp" class="btn-continue-shopping">Tiếp tục mua sắm</a>
                        </div>
                        <% } else { %>
                        <!-- Dynamic Cart Items -->
                        <% for (int i = 0; i < cartItems.size(); i++) { 
                            CartItem item = cartItems.get(i);
                        %>
                        <div class="cart-item" data-item-id="<%= item.getId() %>">
                            <div class="item-info">
                                <h3><%= item.getProductName() %></h3>
                                <div class="item-details">
                                    <span class="quantity-controls">
                                        <button class="qty-btn minus" onclick="updateQuantity(<%= item.getId() %>, <%= item.getQuantity() - 1 %>)">—</button>
                                        <input type="number" value="<%= item.getQuantity() %>" min="1" class="qty-input" data-unit-price="<%= item.getGia() %>" onchange="updateQuantity(<%= item.getId() %>, this.value)">
                                        <button class="qty-btn plus" onclick="updateQuantity(<%= item.getId() %>, <%= item.getQuantity() + 1 %>)">+</button>
                                    </span>
                                    <% if (item.getStorage() != null && !item.getStorage().isEmpty()) { %>
                                    <span class="item-storage">Dung lượng: <%= item.getStorage() %></span>
                                    <% } %>
                                    <% if (item.getColor() != null && !item.getColor().isEmpty()) { %>
                                    <span class="item-color">Màu sắc: <%= item.getColor() %></span>
                                    <% } %>
                                    <a href="#" class="remove-link" onclick="removeItem(<%= item.getId() %>)">Xóa</a>
                                </div>
                            </div>
                            <div class="item-price">
                                <% if (item.getGia() != null && !item.getGia().isEmpty()) { %>
                                <span class="current-price"><%= formatter.format(new java.math.BigDecimal(item.getGia()).multiply(new java.math.BigDecimal(item.getQuantity()))) %> ₫</span>
                                <% } else { %>
                                <span class="current-price">0 ₫</span>
                                <% } %>
                            </div>
                            <div class="item-actions">
                                <a href="${pageContext.request.contextPath}/product-detail?product=<%= java.net.URLEncoder.encode(item.getProductName(), "UTF-8") %>" class="view-details">Xem chi tiết</a>
                            </div>
                        </div>
                        <% if (i < cartItems.size() - 1) { %>
                        <!-- Divider -->
                        <div class="item-divider"></div>
                        <% } %>
                        <% } %>
                        <% } %>
                    </div>

                    <!-- Cart Summary -->
                    <div class="cart-summary">
                        <div class="total-section">
                            <span class="total-label">Tổng tiền :</span>
                            <span class="total-amount" id="totalAmount">
                                <%= formatter.format(totalAmount) %> ₫
                            </span>
                        </div>
                        <button class="btn-order" onclick="proceedToOrder()">Đặt hàng</button>
                    </div>
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
        .user-dropdown { position: relative; }
        .dropdown-menu { 
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
        .dropdown-menu.show { display: block !important; }
        .dropdown-menu a { 
            display: block !important; 
            padding: 12px 20px !important; 
            color: #333 !important; 
            text-decoration: none !important; 
            transition: all 0.3s !important; 
        }
        .dropdown-menu a:hover { background: #f5f5f5 !important; color: #e74c3c !important; }
        
        /* Empty Cart Styles */
        .empty-cart {
            text-align: center;
            padding: 60px 20px;
            background: #f8f9fa;
            border-radius: 10px;
            margin: 20px 0;
        }
        
        .empty-cart h3 {
            color: #333;
            margin-bottom: 10px;
            font-size: 24px;
        }
        
        .empty-cart p {
            color: #666;
            margin-bottom: 30px;
            font-size: 16px;
        }
        
        .btn-continue-shopping {
            display: inline-block;
            background: #e74c3c;
            color: white;
            padding: 12px 30px;
            text-decoration: none;
            border-radius: 5px;
            font-weight: bold;
            transition: background 0.3s;
        }
        
        .btn-continue-shopping:hover {
            background: #c0392b;
            color: white;
        }
        
        /* Custom Modal Styles */
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
        
        .btn-cancel, .btn-delete {
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
        
        .btn-delete {
            background: #e74c3c;
            color: white;
        }
        
        .btn-delete:hover {
            background: #c0392b;
        }
        
        /* Order Button Styles */
        .btn-order {
            background: #27ae60;
            color: white;
            border: none;
            padding: 15px 30px;
            border-radius: 5px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: background-color 0.3s;
            width: 100%;
            margin-top: 15px;
        }
        
        .btn-order:hover {
            background: #229954;
        }
        
        .btn-order:disabled {
            background: #bdc3c7;
            cursor: not-allowed;
        }
    </style>

    <script>
        // User dropdown functionality
        document.addEventListener('DOMContentLoaded', function() {
            const userBtn = document.querySelector('.user-btn');
            const dropdownMenu = document.querySelector('.dropdown-menu');
            
            if (userBtn && dropdownMenu) {
                userBtn.addEventListener('click', function(e) {
                    e.stopPropagation();
                    dropdownMenu.classList.toggle('show');
                });
                
                document.addEventListener('click', function() {
                    dropdownMenu.classList.remove('show');
                });
            }

            // Quantity controls
            const qtyButtons = document.querySelectorAll('.qty-btn');
            qtyButtons.forEach(button => {
                button.addEventListener('click', function() {
                    const input = this.parentElement.querySelector('.qty-input');
                    let value = parseInt(input.value);
                    
                    if (this.classList.contains('plus')) {
                        value++;
                    } else if (this.classList.contains('minus') && value > 1) {
                        value--;
                    }
                    
                    input.value = value;
                    updateTotal();
                });
            });

            // Update total function
            function updateTotal() {
                let total = 0;
                const cartItems = document.querySelectorAll('.cart-item');
                
                cartItems.forEach(item => {
                    const quantityElement = item.querySelector('.qty-input');
                    
                    if (quantityElement) {
                        const unitPrice = parseFloat(quantityElement.getAttribute('data-unit-price') || 0);
                        const quantity = parseInt(quantityElement.value) || 0;
                        total += unitPrice * quantity;
                    }
                });
                
                const totalElement = document.getElementById('totalAmount');
                if (totalElement) {
                    totalElement.textContent = formatCurrency(total) + ' ₫';
                }
            }
            
            // Format currency function
            function formatCurrency(amount) {
                return new Intl.NumberFormat('vi-VN').format(amount);
            }
            
            // Update total on page load
            updateTotal();
        });

        // Cart management functions
        let currentItemId = null;

        function removeItem(itemId) {
            console.log('Removing item:', itemId);
            currentItemId = itemId;
            showConfirmModal();
        }

        function updateQuantity(itemId, newQuantity) {
            console.log('Updating quantity for item:', itemId, 'to:', newQuantity);
            if (newQuantity < 1) {
                currentItemId = itemId;
                showConfirmModal();
            } else {
                // Create a form to submit POST request
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = '${pageContext.request.contextPath}/cart';
                
                // Add form fields
                const actionField = document.createElement('input');
                actionField.type = 'hidden';
                actionField.name = 'action';
                actionField.value = 'update';
                form.appendChild(actionField);
                
                const itemIdField = document.createElement('input');
                itemIdField.type = 'hidden';
                itemIdField.name = 'itemId';
                itemIdField.value = itemId;
                form.appendChild(itemIdField);
                
                const quantityField = document.createElement('input');
                quantityField.type = 'hidden';
                quantityField.name = 'quantity';
                quantityField.value = newQuantity;
                form.appendChild(quantityField);
                
                // Submit form
                document.body.appendChild(form);
                form.submit();
            }
        }
        
        function updateItemQuantity(itemId, newQuantity) {
            // Find the item in the cart and update its quantity display
            const itemElement = document.querySelector(`[data-item-id="${itemId}"]`);
            if (itemElement) {
                const qtyInput = itemElement.querySelector('.qty-input');
                if (qtyInput) {
                    qtyInput.value = newQuantity;
                }
                
                // Update item total price
                const priceElement = itemElement.querySelector('.current-price');
                if (priceElement) {
                    const unitPrice = parseFloat(qtyInput.getAttribute('data-unit-price') || 0);
                    const newTotal = unitPrice * newQuantity;
                    priceElement.textContent = formatCurrency(newTotal) + ' ₫';
                }
                
                // Recalculate total
                recalculateTotal();
            }
        }

        function recalculateTotal() {
            let total = 0;
            const items = document.querySelectorAll('.cart-item');
            
            items.forEach(item => {
                const priceElement = item.querySelector('.current-price');
                if (priceElement) {
                    const priceText = priceElement.textContent;
                    const price = parseFloat(priceText.replace(/[^\d]/g, ''));
                    total += price;
                }
            });
            
            const totalElement = document.getElementById('totalAmount');
            if (totalElement) {
                totalElement.textContent = formatCurrency(total) + ' ₫';
            }
        }

        function formatCurrency(amount) {
            return new Intl.NumberFormat('vi-VN').format(amount);
        }

        function proceedToOrder() {
            const cartItems = document.querySelectorAll('.cart-item');
            if (cartItems.length === 0) {
                alert('Giỏ hàng trống! Vui lòng thêm sản phẩm trước khi đặt hàng.');
                return;
            }
            
            // Redirect to order page
            window.location.href = '${pageContext.request.contextPath}/order';
        }

        function showConfirmModal() {
            const modal = document.getElementById('confirmModal');
            modal.classList.add('show');
        }

        function hideConfirmModal() {
            const modal = document.getElementById('confirmModal');
            modal.classList.remove('show');
            currentItemId = null;
        }

        function confirmDelete() {
            if (currentItemId) {
                window.location.href = '${pageContext.request.contextPath}/cart?action=remove&itemId=' + currentItemId;
            }
        }

        // Modal event listeners
        document.addEventListener('DOMContentLoaded', function() {
            const modal = document.getElementById('confirmModal');
            const cancelBtn = document.getElementById('confirmCancel');
            const deleteBtn = document.getElementById('confirmDelete');

            // Cancel button
            cancelBtn.addEventListener('click', hideConfirmModal);

            // Delete button
            deleteBtn.addEventListener('click', confirmDelete);

            // Click outside modal to close
            modal.addEventListener('click', function(e) {
                if (e.target === modal) {
                    hideConfirmModal();
                }
            });

            // ESC key to close
            document.addEventListener('keydown', function(e) {
                if (e.key === 'Escape' && modal.classList.contains('show')) {
                    hideConfirmModal();
                }
            });
        });
    </script>

    <!-- Custom Confirmation Modal -->
    <div id="confirmModal" class="modal-overlay">
        <div class="modal-content">
            <div class="modal-header">
                <h3>Xác nhận xóa sản phẩm</h3>
            </div>
            <div class="modal-body">
                <p>Bạn có chắc muốn xóa sản phẩm này khỏi giỏ hàng?</p>
            </div>
            <div class="modal-footer">
                <button id="confirmCancel" class="btn-cancel">Hủy</button>
                <button id="confirmDelete" class="btn-delete">Xóa</button>
            </div>
        </div>
    </div>
</body>
</html>