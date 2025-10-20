<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.ProductDAO" %>
<%@ page import="model.Product" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>

<%
    ProductDAO productDAO = new ProductDAO();
    List<Product> hotDeals = productDAO.getAllNewProducts();
    List<Product> newPhones = productDAO.getAllNewProducts();
    if (newPhones.size() > 5) {
        newPhones = newPhones.subList(0, 5);
    }
    
    NumberFormat formatter = NumberFormat.getInstance(new Locale("vi", "VN"));
    
    // Lấy thông tin user từ session
    String userName = (String) session.getAttribute("userName");
    Integer userId = (Integer) session.getAttribute("userId");
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
    <title>KT Phone - Mua bán & trao đổi điện thoại giá tốt</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/index.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <!-- Success Message -->
    <% if (loginSuccess != null) { %>
    <div id="successMessage" class="success-message">
        <div class="success-content">
            <i class="fas fa-check-circle"></i>
            <span><%= loginSuccess %></span>
            <button onclick="hideSuccessMessage()" class="close-btn">&times;</button>
        </div>
    </div>
    <% } %>
    
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
                    <form action="${pageContext.request.contextPath}/views/search.jsp" method="get">
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
                    <span>DANH MỤC<br>SẢN PHẨM</span>
                </button>

                <ul class="nav-menu">
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
                        <a href="${pageContext.request.contextPath}/views/repair.jsp" class="nav-link">SỬA CHỮA</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Hero Banner -->
    <section class="hero-banner">
        <div class="banner-slider">
            <button class="slider-btn prev" onclick="slideBanner(-1)">
                <i class="fas fa-chevron-left"></i>
            </button>
            <div class="banner-wrapper">
                <img src="${pageContext.request.contextPath}/image/5e5b39087b2bbf2a0edb2743d9cc14cb347ea369.png" alt="iPhone 17 Pro" class="banner-image">
            </div>
            <button class="slider-btn next" onclick="slideBanner(1)">
                <i class="fas fa-chevron-right"></i>
            </button>
        </div>
    </section>

    <!-- Hot Deals Section -->
    <section class="hot-deals">
        <div class="container">
            <h2 class="section-title">
                <i class="fas fa-fire"></i> KHUYẾN MÃI HOT
            </h2>

            <div class="deals-slider">
                <button class="slider-btn prev" onclick="slideDeals(-1)">
                    <i class="fas fa-chevron-left"></i>
                </button>

                <div class="deals-container" id="dealsContainer">
                    <% for (Product product : hotDeals) { %>
                    <div class="deal-card" onclick="window.location.href='${pageContext.request.contextPath}/product-detail?maSP=<%= product.getMaSP() %>'">
                        <% if (product.isUsed()) { %>
                        <span class="condition-badge used">Cũ</span>
                        <% } else { %>
                        <span class="condition-badge new">Mới</span>
                        <% } %>
                        
                        <img src="${pageContext.request.contextPath}/image/<%= product.getHinhAnh() != null ? product.getHinhAnh() : "default-phone.jpg" %>" 
                             alt="<%= product.getTenSP() %>" 
                             onerror="this.src='${pageContext.request.contextPath}/image/default-phone.jpg'">
                        
                        <h3><%= product.getTenSP() %></h3>
                        <p class="price"><%= formatter.format(product.getGia()) %> đ</p>
                        <button class="btn-buy" onclick="event.stopPropagation(); buyNow('<%= product.getMaSP() %>', '<%= product.getTenSP() %>', '<%= product.getGia() %>')">Mua ngay</button>
                    </div>
                    <% } %>
                </div>

                <button class="slider-btn next" onclick="slideDeals(1)">
                    <i class="fas fa-chevron-right"></i>
                </button>
            </div>
        </div>
    </section>

    <!-- New Phones Section -->
    <section class="new-phones">
        <div class="container">
            <h2 class="section-title">ĐIỆN THOẠI MỚI NỔI BẬT</h2>

            <div class="products-grid">
                <% for (Product product : newPhones) { %>
                <div class="product-card" onclick="window.location.href='${pageContext.request.contextPath}/product-detail?maSP=<%= product.getMaSP() %>'">
                    <div class="discount-badge">Trả góp 0%</div>
                    
                        <img src="${pageContext.request.contextPath}/image/<%= product.getHinhAnh() != null ? product.getHinhAnh() : "default-phone.jpg" %>" 
                             alt="<%= product.getTenSP() %>" 
                             onerror="this.src='${pageContext.request.contextPath}/image/default-phone.jpg'">
                    
                    <h3><%= product.getTenSP() %></h3>
                    
                    <div class="product-price">
                        <span class="current-price"><%= formatter.format(product.getGia()) %> đ</span>
                    </div>
                    
                    <% long traTruoc = product.getGia().longValue() * 30 / 100; %>
                    <p class="installment">Trả trước: <%= formatter.format(traTruoc) %> đ</p>
                    
                    <div class="product-specs">
                        <div class="brand-name"><%= product.getBrandName() %></div>
                        <% if (product.getRam() != null || product.getBoNhoTrong() != null) { %>
                        <div class="specs-item">
                            <% if (product.getRam() != null) { %>
                            RAM: <%= product.getRam() %>
                            <% } %>
                            <% if (product.getBoNhoTrong() != null) { %>
                            | Bộ nhớ: <%= product.getBoNhoTrong() %>
                            <% } %>
                        </div>
                        <% } %>
                    </div>
                    
                    <button class="btn-buy" onclick="event.stopPropagation(); buyNow('<%= product.getMaSP() %>', '<%= product.getTenSP() %>', '<%= product.getGia() %>')">Mua ngay</button>
                </div>
                <% } %>
            </div>
        </div>
    </section>

    <!-- News Section -->
    <section class="news-section">
        <div class="container">
            <h2 class="section-title">BẢN TIN MỚI</h2>

            <div class="news-tabs">
                <button class="tab-btn active" data-tab="khui-hop">Khui hộp</button>
                <button class="tab-btn" data-tab="thu-thuat">Thủ Thuật - Hỏi Đáp</button>
                <button class="tab-btn" data-tab="tu-van">Tư vấn mua hàng</button>
            </div>

            <div class="news-grid">
                <article class="news-card">
                    <img src="${pageContext.request.contextPath}/image/news1.jpg" alt="iPhone 17" 
                         onerror="this.src='${pageContext.request.contextPath}/image/default-news.jpg'">
                    <span class="news-date">04/12/2024</span>
                    <h3>Kích thước iPhone Air, iPhone 17 (Thường, Pro, Pro Max) lạc nhiều không?</h3>
                </article>

                <article class="news-card">
                    <img src="${pageContext.request.contextPath}/image/news2.jpg" alt="iPhone 17" 
                         onerror="this.src='${pageContext.request.contextPath}/image/default-news.jpg'">
                    <span class="news-date">04/12/2024</span>
                    <h3>Pin iPhone Air, iPhone 17 (Thường, Pro, Pro Max) dùng được bao lâu?</h3>
                </article>

                <article class="news-card">
                    <img src="${pageContext.request.contextPath}/image/news3.jpg" alt="iPhone 17" 
                         onerror="this.src='${pageContext.request.contextPath}/image/default-news.jpg'">
                    <span class="news-date">04/12/2024</span>
                    <h3>Tản nhiệt buồng hơi trên iPhone 17 Pro Max là gì?</h3>
                </article>

                <article class="news-card">
                    <img src="${pageContext.request.contextPath}/image/news4.jpg" alt="iPhone 17" 
                         onerror="this.src='${pageContext.request.contextPath}/image/default-news.jpg'">
                    <span class="news-date">04/12/2024</span>
                    <h3>Màn hình iPhone 17, iPhone Air bao nhiêu Hz? Có gì mới?</h3>
                </article>
            </div>
            
            <div class="news-view-more">
                <a href="#" class="btn-news-more">Xem thêm bài tin ></a>
            </div>
        </div>
    </section>

    <!-- Store Info -->
    <section class="store-info">
        <div class="container">
            <div class="store-text">
                <h2>Cửa hàng KT phone</h2>
                <p>Bệnh viện tâm thần tình cảm là lại</p>
            </div>
            <button class="btn-store">Xem bản đồ đến cửa hàng</button>
        </div>
    </section>

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
        
        /* Buy Now Button Styles */
        .btn-buy {
            background: #e74c3c;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
            transition: background-color 0.3s;
            width: 100%;
            margin-top: 10px;
        }
        
        .btn-buy:hover {
            background: #c0392b;
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
        
        /* Success Message Styles */
        .success-message {
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 1001;
            animation: slideInRight 0.5s ease-out;
        }
        
        .success-content {
            background: #4CAF50;
            color: white;
            padding: 15px 20px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
            display: flex;
            align-items: center;
            gap: 10px;
            min-width: 300px;
        }
        
        .success-content i {
            font-size: 20px;
        }
        
        .success-content span {
            flex: 1;
            font-weight: 500;
        }
        
        .close-btn {
            background: none;
            border: none;
            color: white;
            font-size: 20px;
            cursor: pointer;
            padding: 0;
            width: 24px;
            height: 24px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
            transition: background 0.3s;
        }
        
        .close-btn:hover {
            background: rgba(255, 255, 255, 0.2);
        }
        
        @keyframes slideInRight {
            from {
                transform: translateX(100%);
                opacity: 0;
            }
            to {
                transform: translateX(0);
                opacity: 1;
            }
        }
        
        @keyframes slideOutRight {
            from {
                transform: translateX(0);
                opacity: 1;
            }
            to {
                transform: translateX(100%);
                opacity: 0;
            }
        }
    </style>
    <script>
        function toggleUserDropdown() {
            document.getElementById('userDropdown').classList.toggle('show');
        }

        // Buy now function for adding products to cart
        function buyNow(maSP, tenSP, gia) {
            console.log('Buy Now:', maSP, tenSP, gia);
            
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
            // Build URL to add to cart
            let url = '${pageContext.request.contextPath}/cart?action=add&product=' + encodeURIComponent(tenSP) + 
                      '&maSP=' + maSP + '&gia=' + gia;
            
            window.location.href = url;
        }

        function showLoginModal(maSP, tenSP, gia) {
            // Store product info for later use
            window.pendingProduct = {maSP: maSP, tenSP: tenSP, gia: gia};
            
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

        function hideSuccessMessage() {
            const successMessage = document.getElementById('successMessage');
            if (successMessage) {
                successMessage.style.animation = 'slideOutRight 0.3s ease-in';
                setTimeout(() => {
                    successMessage.remove();
                }, 300);
            }
        }

        // Auto hide success message after 5 seconds
        document.addEventListener('DOMContentLoaded', function() {
            const successMessage = document.getElementById('successMessage');
            if (successMessage) {
                setTimeout(() => {
                    hideSuccessMessage();
                }, 5000);
            }
        });

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

        // Banner slider function
        function slideBanner(direction) {
            // TODO: Implement banner slider if multiple banners needed
            console.log('Banner slide:', direction);
        }

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
</body>
</html>