<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, model.Product, dao.ProductDAO" %>
<%
    ProductDAO productDAO = new ProductDAO();
    
    // Lấy tham số lọc từ request
    String selectedBrand = request.getParameter("brand");
    String minPriceStr = request.getParameter("minPrice");
    String maxPriceStr = request.getParameter("maxPrice");
    
    Double minPrice = null;
    Double maxPrice = null;
    
    try {
        if (minPriceStr != null && !minPriceStr.isEmpty()) {
            minPrice = Double.parseDouble(minPriceStr);
        }
        if (maxPriceStr != null && !maxPriceStr.isEmpty()) {
            maxPrice = Double.parseDouble(maxPriceStr);
        }
    } catch (NumberFormatException e) {
        System.err.println("Invalid price format: " + e.getMessage());
    }
    
    // Lấy danh sách sản phẩm cũ theo bộ lọc
    List<Product> products;
    if (selectedBrand != null || minPrice != null || maxPrice != null) {
        products = productDAO.getProductsByFilter(selectedBrand, minPrice != null ? minPrice : 0, maxPrice != null ? maxPrice : 0, null);
        // Lọc chỉ sản phẩm cũ
        products = products.stream().filter(p -> "Cu".equalsIgnoreCase(p.getTinhTrang())).collect(java.util.stream.Collectors.toList());
    } else {
        products = productDAO.getAllUsedProducts();
    }
    
    List<String> brands = productDAO.getAllBrands();
    
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
    <title>Điện Thoại Cũ - KT Store</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/index.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/new-phones.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/used-phones.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
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

    <!-- Navbar -->
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
                    <li class="nav-item"><a href="${pageContext.request.contextPath}/views/repair.jsp" class="nav-link">SỬA CHỮA</a></li>
            </ul>
            </div>
        </div>
    </nav>

    <!-- Banner quảng cáo -->
    <section class="promo-banner">
        <div class="container">
            <div class="banner-content">
                <img src="${pageContext.request.contextPath}/image/banner xiaomi.png" alt="Xiaomi 15 | 15 Ultra" class="banner-image">
    </div>
        </div>
    </section>

    <!-- Main Content -->
    <main class="products-page">
        <div class="container">
            <div class="page-layout">
        <!-- Sidebar Filters -->
                <aside class="filters-sidebar">
                    <h3 class="filter-title">Lọc sản phẩm</h3>
                    
                    <!-- Loại sản phẩm -->
                <div class="filter-group">
                        <h4>Loại sản phẩm</h4>
                        <div class="filter-options">
                            <label class="filter-option">
                                <input type="radio" name="product-type" value="new" onchange="window.location.href='${pageContext.request.contextPath}/views/new-phones.jsp'">
                                <span>Điện thoại mới</span>
                    </label>
                            <label class="filter-option">
                                <input type="radio" name="product-type" value="used" checked>
                                <span>Điện thoại cũ</span>
                    </label>
                </div>
                </div>

                    <!-- Hãng -->
                <div class="filter-group">
                        <h4>Hãng</h4>
                        <div class="brand-grid">
                            <div class="brand-item" data-brand="apple">
                                <img src="${pageContext.request.contextPath}/image/apple.png" alt="Apple">
                </div>
                            <div class="brand-item" data-brand="samsung">
                                <img src="${pageContext.request.contextPath}/image/samsung.png" alt="Samsung">
                </div>
                            <div class="brand-item" data-brand="xiaomi">
                                <img src="${pageContext.request.contextPath}/image/xiaomi.png" alt="Xiaomi">
            </div>
                            <div class="brand-item" data-brand="meizu">
                                <img src="${pageContext.request.contextPath}/image/meizu.jpg" alt="Meizu">
                    </div>
                            <div class="brand-item" data-brand="oppo">
                                <img src="${pageContext.request.contextPath}/image/oppo.png" alt="Oppo">
                        </div>
                            <div class="brand-item" data-brand="vivo">
                                <img src="${pageContext.request.contextPath}/image/vivo.png" alt="Vivo">
                    </div>
                            <div class="brand-item" data-brand="google">
                                <img src="${pageContext.request.contextPath}/image/google.png" alt="Google">
                    </div>
                            <div class="brand-item" data-brand="huawei">
                                <img src="${pageContext.request.contextPath}/image/huaawei.png" alt="Huawei">
                </div>
                            <div class="brand-item" data-brand="realme">
                                <img src="${pageContext.request.contextPath}/image/realme.png" alt="Realme">
                </div>
                            <div class="brand-item" data-brand="oneplus">
                                <img src="${pageContext.request.contextPath}/image/oneplus.png" alt="OnePlus">
            </div>
                            <div class="brand-item" data-brand="sony">
                                <img src="${pageContext.request.contextPath}/image/sony.png" alt="Sony">
            </div>
            </div>
    </div>

                    <!-- Mức giá -->
                    <div class="filter-group">
                        <h4>Mức giá</h4>
                        <div class="price-slider-container">
                            <div class="price-slider">
                                <input type="range" min="0" max="80000000" value="5000000" class="slider" id="priceFrom">
                                <input type="range" min="0" max="80000000" value="15000000" class="slider" id="priceTo">
            </div>
                            <div class="price-inputs">
                                <input type="text" placeholder="Từ" class="price-input" id="priceFromInput">
                                <input type="text" placeholder="Đến" class="price-input" id="priceToInput">
                                <button class="btn-apply" onclick="applyPriceFilter()">ÁP DỤNG</button>
            </div>
                            <div class="price-buttons">
                                <button class="price-btn" onclick="setPriceRange(1000000, 3000000)">1 đến 3 triệu</button>
                                <button class="price-btn" onclick="setPriceRange(0, 1000000)">Dưới 1 triệu</button>
                                <button class="price-btn" onclick="setPriceRange(3000000, 5000000)">3 đến 5 triệu</button>
                                <button class="price-btn" onclick="setPriceRange(5000000, 10000000)">5 đến 10 triệu</button>
            </div>
                            <button class="btn-view-more" onclick="toggleMorePriceOptions()">XEM THÊM <i class="fas fa-chevron-down"></i></button>
                            <div class="more-price-options" id="morePriceOptions" style="display: none;">
                                <button class="price-btn" onclick="setPriceRange(10000000, 20000000)">10 đến 20 triệu</button>
                                <button class="price-btn" onclick="setPriceRange(20000000, 30000000)">20 đến 30 triệu</button>
                                <button class="price-btn" onclick="setPriceRange(30000000, 50000000)">30 đến 50 triệu</button>
                                <button class="price-btn" onclick="setPriceRange(50000000, 80000000)">50 đến 80 triệu</button>
                                <button class="price-btn" onclick="setPriceRange(80000000, 80000000)">Trên 80 triệu</button>
                            </div>
                </div>
            </div>

                    <!-- Sẵn hàng -->
                <div class="filter-group">
                        <h4>Sẵn hàng</h4>
                        <div class="filter-options">
                            <label class="filter-option">
                                <input type="checkbox" name="stock" value="available">
                                <span>Sẵn hàng</span>
                            </label>
                    </div>
                </div>

                    <!-- Bộ nhớ trong -->
                <div class="filter-group">
                        <h4>Bộ nhớ trong</h4>
                        <div class="filter-options">
                            <label class="filter-option">
                                <input type="checkbox" name="storage" value="64">
                                <span>64GB</span>
                    </label>
                            <label class="filter-option">
                                <input type="checkbox" name="storage" value="128">
                                <span>128GB</span>
                    </label>
                            <label class="filter-option">
                                <input type="checkbox" name="storage" value="256">
                                <span>256GB</span>
                    </label>
                            <label class="filter-option">
                                <input type="checkbox" name="storage" value="512">
                                <span>512GB</span>
                    </label>
                            <label class="filter-option">
                                <input type="checkbox" name="storage" value="1tb">
                                <span>1TB</span>
                            </label>
                            <label class="filter-option">
                                <input type="checkbox" name="storage" value="2tb">
                                <span>2TB</span>
                    </label>
                </div>
        </div>

                    <!-- Kết nối NFC -->
                <div class="filter-group">
                        <h4>Kết nối NFC</h4>
                        <div class="filter-options">
                            <label class="filter-option">
                                <input type="radio" name="nfc" value="yes">
                                <span>Có</span>
                            </label>
                            <label class="filter-option">
                                <input type="radio" name="nfc" value="no">
                                <span>Không</span>
                            </label>
                    </div>
                </div>

                    <!-- Tần số quét (Hz) -->
                <div class="filter-group">
                        <h4>Tần số quét (Hz)</h4>
                        <div class="filter-options">
                            <label class="filter-option">
                                <input type="checkbox" name="refresh" value="60">
                                <span>60Hz</span>
                    </label>
                            <label class="filter-option">
                                <input type="checkbox" name="refresh" value="90">
                                <span>90Hz</span>
                    </label>
                            <label class="filter-option">
                                <input type="checkbox" name="refresh" value="120">
                                <span>120Hz</span>
                    </label>
                            <label class="filter-option">
                                <input type="checkbox" name="refresh" value="144">
                                <span>144Hz</span>
                    </label>
                            <label class="filter-option">
                                <input type="checkbox" name="refresh" value="165">
                                <span>165Hz</span>
                    </label>
                        </div>
                </div>

                    <!-- Dung lượng pin -->
                <div class="filter-group">
                        <h4>Dung lượng pin</h4>
                        <div class="filter-options">
                            <label class="filter-option">
                                <input type="checkbox" name="battery" value="1000-4000">
                                <span>1000mAh → 4000mAh</span>
                    </label>
                            <label class="filter-option">
                                <input type="checkbox" name="battery" value="4000-5000">
                                <span>4000mAh → 5000mAh</span>
                    </label>
                            <label class="filter-option">
                                <input type="checkbox" name="battery" value="5000-6000">
                                <span>5000mAh → 6000mAh</span>
                    </label>
                            <label class="filter-option">
                                <input type="checkbox" name="battery" value="6000-7000">
                                <span>6000mAh → 7000mAh</span>
                    </label>
                        </div>
                </div>

                    <!-- Kích thước màn hình -->
                <div class="filter-group">
                        <h4>Kích thước màn hình</h4>
                        <div class="filter-options">
                            <label class="filter-option">
                                <input type="checkbox" name="screen" value="foldable">
                                <span>Màn hình gập</span>
                    </label>
                            <label class="filter-option">
                                <input type="checkbox" name="screen" value="5-6">
                                <span>Từ 5" ₫ến < 6"</span>
                    </label>
                            <label class="filter-option">
                                <input type="checkbox" name="screen" value="6-6.5">
                                <span>Từ 6" ₫ến < 6.5"</span>
                    </label>
                            <label class="filter-option">
                                <input type="checkbox" name="screen" value="6.5-6.7">
                                <span>Từ 6.5" ₫ến < 6.7"</span>
                    </label>
                            <label class="filter-option">
                                <input type="checkbox" name="screen" value="6.7-7">
                                <span>Từ 6.7" ₫ến < 7"</span>
                            </label>
                            <label class="filter-option">
                                <input type="checkbox" name="screen" value="7+">
                                <span>Từ 7" trở lên</span>
                    </label>
                </div>
                </div>
        </aside>

        <!-- Products Grid -->
                <div class="products-content">
                    <div class="products-header">
                        <h2>Điện thoại cũ</h2>
                        <div class="products-count">Hiển thị <span id="productCount"><%= products.size() %></span> sản phẩm</div>
                    </div>
                    
                    <!-- Sort Options -->
                    <div class="product-controls">
                        <div class="sort-section">
                            <span class="sort-label">Sắp xếp theo</span>
                            <div class="sort-buttons">
                                <button class="sort-btn" onclick="sortProducts('relevance')">Liên quan</button>
                                <button class="sort-btn" onclick="sortProducts('newest')">Mới nhất</button>
                                <button class="sort-btn" onclick="sortProducts('bestselling')">Bán chạy</button>
                                <div class="price-sort-dropdown">
                                    <button class="sort-btn" onclick="togglePriceSort()">
                                        Giá tiền
                                        <i class="fas fa-sort" style="margin-left: 5px;"></i>
                                    </button>
                                    <div class="price-sort-options" id="priceSortOptions" style="display: none;">
                                        <button class="sort-option" onclick="sortProducts('price-asc')">Giá tăng dần</button>
                                        <button class="sort-option" onclick="sortProducts('price-desc')">Giá giảm dần</button>
                                    </div>
                                </div>
                            </div>
                        </div>
            </div>

                    <div class="products-grid">
                        <% 
                        java.text.NumberFormat formatter = java.text.NumberFormat.getInstance(new java.util.Locale("vi", "VN"));
                        for (Product product : products) { 
                        %>
                        <div class="product-card" onclick="viewProduct('<%= product.getTenSP() %>')">
                            <% if (product.getGia().compareTo(new java.math.BigDecimal("15000000")) > 0) { %>
                            <span class="discount-badge">-<%= (int)(Math.random() * 30 + 10) %>%</span>
                            <% } %>
                            <img src="${pageContext.request.contextPath}/image/<%= product.getHinhAnh() != null ? product.getHinhAnh() : "default-phone.jpg" %>" 
                                 alt="<%= product.getTenSP() %>" 
                                 onerror="this.src='${pageContext.request.contextPath}/image/default-phone.jpg'">
                            <h3><%= product.getTenSP() %></h3>
                            <div class="product-specs">
                                <div class="specs-item"><%= product.getBrandName() != null ? product.getBrandName() : "Unknown" %> • <%= product.getSoLuong() %> sản phẩm</div>
                            </div>
                            <div class="installment">Trả góp 0% dân 12 tháng</div>
                            <div class="product-price">
                                <% if (product.getGia().compareTo(new java.math.BigDecimal("15000000")) > 0) { %>
                                <span class="old-price"><%= formatter.format(product.getGia().multiply(new java.math.BigDecimal("1.3"))) %> ₫</span>
                                <% } %>
                                <span class="current-price"><%= formatter.format(product.getGia()) %> ₫</span>
                            </div>
                            <div class="promo-text">KM Giảm thêm lên ₫ến 10% giá phụ kiện khi mua kèm ₫iện thoại, Tablet, Laptop, ₫ồng hồ</div>
                            <div class="offers">+ 15 Ưu ₫ãi khác</div>
                            <button class="btn-buy" onclick="event.stopPropagation(); buyNow('<%= product.getMaSP() %>', '<%= product.getTenSP() %>', '<%= product.getGia() %>')">Mua ngay</button>
                        </div>
                        <% } %>
                    </div>

                </div>
            </div>
    </div>
    </div>
        </div>
    </main>

    <!-- Articles Section -->
    <section class="articles-section">
        <div class="container">
            <div class="article-content">
                <h3>Điện thoại di động - "Người đồng hành" không thể thiếu trong thời đại mới</h3>
                
                <p>Từ khi ra đời, điện thoại đã trở thành một phần không thể thiếu trong cuộc sống hàng ngày của chúng ta. Không chỉ là công cụ liên lạc đơn thuần, điện thoại ngày nay còn là trung tâm của mạng lưới kết nối toàn cầu, giúp chúng ta truy cập internet, chụp ảnh, gửi tin nhắn, thực hiện giao dịch ngân hàng di động, định vị GPS, giải trí, học tập và nghiên cứu. Điện thoại đã trở thành cầu nối quan trọng giúp kết nối mọi người trên toàn thế giới.</p>
                
                <h3>Sự kiện tạo nên đột phá của ngành công nghiệp điện thoại</h3>
                
                <p>Lịch sử của điện thoại bắt đầu từ thế kỷ 19 với những phát minh đầu tiên. Tuy nhiên, chỉ đến đầu thế kỷ 21, với sự ra đời của smartphone, điện thoại mới thực sự bùng nổ và thay đổi cách con người giao tiếp và làm việc. Đặc biệt, sự xuất hiện của iPhone vào năm 2007 và hệ điều hành Android của Google đã tạo nên cuộc cách mạng thực sự trong ngành công nghiệp điện thoại.</p>
                
                <div class="article-image">
                    <img src="${pageContext.request.contextPath}/image/04c2c81ba032ff50456151ae9da1608da9e29beb.jpg" alt="Smartphone">
            </div>
            
                <button class="btn-read-more" id="readMoreBtn" style="display: none;">XEM THÊM <i class="fas fa-chevron-down"></i></button>
            </div>
    </div>
    </section>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <div class="footer-grid">
                <div class="footer-col">
                <div class="footer-logo">KT</div>
                    <p>Mua bán & trao ₫ổi ₫iện thoại giá tốt</p>
                    <div class="social-links">
                        <a href="#" class="social-icon"><i class="fab fa-facebook-f"></i></a>
                        <a href="#" class="social-icon"><i class="fab fa-instagram"></i></a>
                        <a href="#" class="social-icon"><i class="fab fa-youtube"></i></a>
            </div>
            </div>
                <div class="footer-col">
                    <h3>Hỗ trợ khách hàng</h3>
                    <div class="footer-links">
                        <a href="#">Chính sách bảo hành</a>
                        <a href="#">Chính sách ₫ổi trả</a>
                        <a href="#">Hướng dẫn mua hàng</a>
                        <a href="#">Hướng dẫn thanh toán</a>
            </div>
                </div>
                <div class="footer-col">
                    <h3>Thông tin</h3>
                    <div class="footer-links">
                        <a href="#">Về chúng tôi</a>
                        <a href="#">Liên hệ</a>
                        <a href="#">Tuyển dụng</a>
                        <a href="#">Tin tức</a>
                    </div>
                </div>
                <div class="footer-col">
                    <h3>Liên hệ</h3>
                    <div class="footer-links">
                        <a href="tel:0123456789"><i class="fas fa-phone"></i> 012-345-6789</a>
                        <a href="mailto:info@ktstore.com"><i class="fas fa-envelope"></i> info@ktstore.com</a>
                        <a href="#"><i class="fas fa-map-marker-alt"></i> 123 Đường ABC, Quận XYZ</a>
                    </div>
                </div>
            </div>
        </div>
    </footer>

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

        // NEW FILTER LOGIC - Brand Filter (Independent)
        function filterByBrand(brandName) {
            console.log('filterByBrand called with:', brandName);
            const clickedBrand = event.target.closest('.brand-item');
            console.log('clickedBrand:', clickedBrand);
            
            // Check if this brand is currently active BEFORE removing active classes
            const isCurrentlyActive = clickedBrand.classList.contains('active');
            console.log('isCurrentlyActive:', isCurrentlyActive);
            
            // Remove active class from all brand items
            document.querySelectorAll('.brand-item').forEach(item => {
                item.classList.remove('active');
            });
            
            // If clicking the same brand again, deselect it
            if (isCurrentlyActive) {
                // Show all products
                console.log('Deselecting brand, showing all products');
                showAllProducts();
            } else {
                // Add active class to clicked brand
                clickedBrand.classList.add('active');
                console.log('Added active class to brand:', brandName);
                // Filter products by brand only
                console.log('Calling filterProductsByBrand with:', brandName);
                filterProductsByBrand(brandName);
            }
        }

        function filterProductsByBrand(brandName) {
            console.log('filterProductsByBrand called with:', brandName);
            const productCards = document.querySelectorAll('.product-card');
            console.log('Found product cards:', productCards.length);
            let visibleCount = 0;
            
            productCards.forEach((card, index) => {
                // Get product name from the card
                const productNameElement = card.querySelector('h3');
                const productName = productNameElement ? productNameElement.textContent.toLowerCase() : '';
                console.log(`Product ${index}: "${productName}"`);
                
                // Check if product name contains the brand name
                let brandMatch = false;
                
                // Special case for Apple brand - check for "iphone" in product name
                if (brandName.toLowerCase() === 'apple') {
                    brandMatch = productName.includes('iphone');
                } else {
                    brandMatch = productName.includes(brandName.toLowerCase());
                }
                
                if (brandMatch) {
                    card.style.display = 'block';
                    visibleCount++;
                    console.log(`Product ${index} matches brand ${brandName}`);
                } else {
                    card.style.display = 'none';
                    console.log(`Product ${index} does not match brand ${brandName}`);
                }
            });
            
            // Update product count
            document.getElementById('productCount').textContent = visibleCount;
            
            console.log('Brand filter:', brandName);
            console.log('Visible products:', visibleCount);
        }

        // NEW FILTER LOGIC - Price Filter (Independent)
        function setPriceRange(min, max) {
            document.getElementById('priceFrom').value = min;
            document.getElementById('priceTo').value = max;
            document.getElementById('priceFromInput').value = min.toLocaleString('vi-VN');
            document.getElementById('priceToInput').value = max.toLocaleString('vi-VN');
            
            // Filter products by price only
            filterProductsByPrice(min, max);
        }

        function applyPriceFilter() {
            const priceFrom = parseFloat(document.getElementById('priceFrom').value) || 0;
            const priceTo = parseFloat(document.getElementById('priceTo').value) || 80000000;
            filterProductsByPrice(priceFrom, priceTo);
        }

        function filterProductsByPrice(minPrice, maxPrice) {
            const productCards = document.querySelectorAll('.product-card');
            let visibleCount = 0;
            
            productCards.forEach((card) => {
                // Get product price from the card
                const productPrice = getProductPrice(card);
                
                // Check if price is within range
                if (productPrice >= minPrice && productPrice <= maxPrice) {
                    card.style.display = 'block';
                    visibleCount++;
                } else {
                    card.style.display = 'none';
                }
            });
            
            // Update product count
            document.getElementById('productCount').textContent = visibleCount;
            
            console.log('Price filter:', minPrice, '-', maxPrice);
            console.log('Visible products:', visibleCount);
        }

        function showAllProducts() {
            // Reset price inputs
            document.getElementById('priceFrom').value = 0;
            document.getElementById('priceTo').value = 80000000;
            document.getElementById('priceFromInput').value = '0';
            document.getElementById('priceToInput').value = '80.000.000';
            
            // Reset brand selection
            document.querySelectorAll('.brand-item').forEach(item => {
                item.classList.remove('active');
            });
            
            // Show all products
            const productCards = document.querySelectorAll('.product-card');
            productCards.forEach(card => {
                card.style.display = 'block';
            });
            document.getElementById('productCount').textContent = '<%= products.size() %>';
            console.log('Showing all products');
        }

        function viewProduct(productName) {
            window.location.href = '${pageContext.request.contextPath}/product-detail?product=' + encodeURIComponent(productName);
        }


        // Add event listeners for brand items
        document.addEventListener('DOMContentLoaded', function() {
            console.log('DOM loaded, setting up brand event listeners');
            const brandItems = document.querySelectorAll('.brand-item');
            console.log('Found brand items:', brandItems.length);
            brandItems.forEach((item, index) => {
                const brandName = item.getAttribute('data-brand');
                console.log(`Brand ${index}: ${brandName}`);
                item.addEventListener('click', function() {
                    console.log('Brand clicked:', brandName);
                    const brandName = this.getAttribute('data-brand');
                    filterByBrand(brandName);
                });
            });

            // Add event listeners for product images (link to product detail)
            const productImages = document.querySelectorAll('.product-card img');
            console.log('Found product images:', productImages.length);
            productImages.forEach((img, index) => {
                img.addEventListener('click', function() {
                    const productCard = this.closest('.product-card');
                    const productName = productCard.querySelector('h3').textContent;
                    console.log('Product image clicked:', productName);
                    // Link to product detail page via servlet
                    window.location.href = '${pageContext.request.contextPath}/product-detail?product=' + encodeURIComponent(productName);
                });
            });

            // Note: Buy now buttons now use onclick attribute with buyNow() function
        });

        function getProductPrice(card) {
            // Get price from the price element in the card
            const priceElement = card.querySelector('.product-price');
            if (priceElement) {
                const priceText = priceElement.textContent;
                // Extract number from price text (e.g., "15.990.000đ" -> 15990000)
                const price = priceText.replace(/[^\d]/g, '');
                return parseInt(price) || 0;
            }
            return 0;
        }


        function togglePriceSort() {
            const priceSortOptions = document.getElementById('priceSortOptions');
            if (priceSortOptions.style.display === 'none') {
                priceSortOptions.style.display = 'block';
            } else {
                priceSortOptions.style.display = 'none';
            }
        }

        function sortProducts(sortType) {
            // Remove active class from all sort buttons
            document.querySelectorAll('.sort-btn').forEach(btn => {
                btn.classList.remove('active');
            });
            
            // Add active class to clicked button
            event.target.classList.add('active');
            
            // Get all product cards
            const productCards = Array.from(document.querySelectorAll('.product-card'));
            
            // Sort based on type
            switch(sortType) {
                case 'relevance':
                    // Keep original order (already sorted by relevance)
                    break;
                case 'newest':
                    // Sort by newest (assuming higher ID = newer)
                    productCards.sort((a, b) => {
                        const idA = parseInt(a.getAttribute('data-id')) || 0;
                        const idB = parseInt(b.getAttribute('data-id')) || 0;
                        return idB - idA;
                    });
                    break;
                case 'bestselling':
                    // Sort by best selling (random for demo)
                    productCards.sort(() => Math.random() - 0.5);
                    break;
                case 'price-asc':
                    // Sort by price (low to high) - using hardcoded prices for static cards
                    productCards.sort((a, b) => {
                        const priceA = getProductPrice(a);
                        const priceB = getProductPrice(b);
                        return priceA - priceB;
                    });
                    break;
                case 'price-desc':
                    // Sort by price (high to low) - using hardcoded prices for static cards
                    productCards.sort((a, b) => {
                        const priceA = getProductPrice(a);
                        const priceB = getProductPrice(b);
                        return priceB - priceA;
                    });
                    break;
            }
            
            // Re-append sorted cards
            const productsGrid = document.querySelector('.products-grid');
            productCards.forEach(card => {
                productsGrid.appendChild(card);
            });
            
            // Hide price sort options after selection
            if (sortType.startsWith('price-')) {
                document.getElementById('priceSortOptions').style.display = 'none';
            }
            
            console.log('Sorted by:', sortType);
        }

        function toggleMorePriceOptions() {
            const moreOptions = document.getElementById('morePriceOptions');
            const btnViewMore = document.querySelector('.btn-view-more');
            const icon = btnViewMore.querySelector('i');
            
            if (moreOptions.style.display === 'none') {
                moreOptions.style.display = 'block';
                icon.classList.remove('fa-chevron-down');
                icon.classList.add('fa-chevron-up');
                btnViewMore.innerHTML = 'ẨN BỚT <i class="fas fa-chevron-up"></i>';
            } else {
                moreOptions.style.display = 'none';
                icon.classList.remove('fa-chevron-up');
                icon.classList.add('fa-chevron-down');
                btnViewMore.innerHTML = 'XEM THÊM <i class="fas fa-chevron-down"></i>';
            }
        }

        // Brand filter selection
        document.querySelectorAll('.brand-item').forEach(item => {
            item.addEventListener('click', function() {
                const brandName = this.getAttribute('data-brand');
                filterByBrand(brandName);
            });
        });

        // Product card click - REMOVED to avoid conflict with onclick attribute
        // document.querySelectorAll('.product-card').forEach(card => {
        //     card.addEventListener('click', function() {
        //         window.location.href = '${pageContext.request.contextPath}/views/product-detail.jsp';
        //     });
        // });

        // Price slider logic
        const priceFromSlider = document.getElementById('priceFrom');
        const priceToSlider = document.getElementById('priceTo');
        const priceFromInput = document.getElementById('priceFromInput');
        const priceToInput = document.getElementById('priceToInput');

        function updatePriceInputs() {
            let fromVal = Math.min(parseInt(priceFromSlider.value), parseInt(priceToSlider.value));
            let toVal = Math.max(parseInt(priceFromSlider.value), parseInt(priceToSlider.value));
            priceFromInput.value = fromVal.toLocaleString('vi-VN');
            priceToInput.value = toVal.toLocaleString('vi-VN');
        }

        if (priceFromSlider && priceToSlider) {
            priceFromSlider.oninput = updatePriceInputs;
            priceToSlider.oninput = updatePriceInputs;
        }

        if (priceFromInput && priceToInput) {
            priceFromInput.onchange = function() {
                let val = parseFloat(this.value.replace(/\./g, ''));
                if (!isNaN(val)) {
                    priceFromSlider.value = val;
                    updatePriceInputs();
                }
            };
            priceToInput.onchange = function() {
                let val = parseFloat(this.value.replace(/\./g, ''));
                if (!isNaN(val)) {
                    priceToSlider.value = val;
                    updatePriceInputs();
                }
            };
        }

        // Initial update
        updatePriceInputs();

        // Count words in article and show/hide "XEM THÊM" button
        const articleContent = document.querySelector('.article-content');
        const readMoreBtn = document.getElementById('readMoreBtn');
        
        if (articleContent && readMoreBtn) {
            // Get all text content from paragraphs and headings
            const paragraphs = articleContent.querySelectorAll('p');
            const headings = articleContent.querySelectorAll('h3');
            
            let totalText = '';
            paragraphs.forEach(p => totalText += p.textContent + ' ');
            headings.forEach(h => totalText += h.textContent + ' ');
            
            // Count words (split by spaces and filter empty strings)
            const wordCount = totalText.trim().split(/\s+/).filter(word => word.length > 0).length;
            
            // Show button only if article has more than 300 words
            if (wordCount > 300) {
                readMoreBtn.style.display = 'block';
            }
        }
    </script>
    
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
        
        /* Brand filter active state */
        .brand-item.active {
            border: 2px solid #e74c3c !important;
            background-color: #ffe6e6 !important;
        }
        
        /* Product card interactions */
        .product-card img {
            cursor: pointer;
            transition: transform 0.2s ease;
        }
        
        .product-card img:hover {
            transform: scale(1.05);
        }
        
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
        
        /* Product Controls */
        .product-controls {
            display: flex;
            justify-content: flex-end;
            align-items: center;
            margin: 20px 0;
            padding: 15px 20px;
            background: #f8f9fa;
            border-radius: 10px;
        }
        
        .sort-section {
            display: flex;
            align-items: center;
            gap: 15px;
        }
        
        .sort-label {
            font-weight: 500;
            color: #333;
        }
        
        .sort-buttons {
            display: flex;
            gap: 10px;
        }
        
        .sort-btn {
            padding: 8px 16px;
            background: white;
            border: 1px solid #ddd;
            border-radius: 6px;
            cursor: pointer;
            transition: all 0.3s;
            font-size: 14px;
        }
        
        .sort-btn:hover {
            background: #f0f0f0;
        }
        
        .sort-btn.active {
            background: #e74c3c;
            color: white;
            border-color: #e74c3c;
        }
        
        /* Price Sort Dropdown */
        .price-sort-dropdown {
            position: relative;
        }
        
        .price-sort-options {
            position: absolute;
            top: 100%;
            left: 0;
            background: white;
            border: 1px solid #ddd;
            border-radius: 6px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            z-index: 1000;
            min-width: 120px;
        }
        
        .sort-option {
            display: block;
            width: 100%;
            padding: 8px 16px;
            background: white;
            border: none;
            text-align: left;
            cursor: pointer;
            font-size: 14px;
            transition: background 0.3s;
        }
        
        .sort-option:hover {
            background: #f0f0f0;
        }
        
        .sort-option:first-child {
            border-radius: 6px 6px 0 0;
        }
        
        .sort-option:last-child {
            border-radius: 0 0 6px 6px;
        }
        
    </style>

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
