<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>KT Store - Mua bán & trao đổi điện thoại giá tốt</title>
    <link rel="stylesheet" href="../resources/css/index.css">
</head>
<body>
    <!-- Header -->
    <header class="header">
        <div class="header-top">
            <div class="logo">KT</div>
            <div class="search-container">
                <input type="text" class="search-bar" placeholder="Tìm Kiếm Sản phẩm">
            </div>
            <div class="header-icons">
                <a href="cart.jsp">🛒</a>
                <a href="wishlist.jsp">❤️</a>
                <a href="login.jsp">ĐĂNG NHẬP</a>
            </div>
        </div>
    </header>

    <!-- Navigation -->
    <nav class="navigation">
        <div class="nav-container">
            <button class="menu-toggle">
                ☰ DANH<br>MỤC
            </button>
            <ul class="nav-links">
                <li><a href="new-phones.jsp">ĐIỆN THOẠI MỚI ▼</a></li>
                <li><a href="used-phones.jsp">ĐIỆN THOẠI CŨ ▼</a></li>
                <li><a href="repair.jsp">THU ĐIỆN THOẠI</a></li>
                <li><a href="appointment.jsp">SỬA CHỮA</a></li>
            </ul>
        </div>
    </nav>

    <!-- Hero Section -->
    <section class="hero-section">
        <div class="hero-content">
            <div class="hero-text">
                <h1>Mua bán & trao đổi điện thoại giá tốt</h1>
                <h2>uy tín - an toàn - chất lượng</h2>
                <p>với đội ngũ chất lượng với kinh nghiệm hơn 20 năm trong nghề, hứa hẹn sẽ mang đến cho khách hàng trải nghiệm tốt nhất</p>
            </div>
            <div class="hero-image">
                <img src="resources/images/hero-image.jpg" alt="Người đang dùng điện thoại">
            </div>
        </div>
    </section>

    <!-- Hot Deals Section -->
    <section class="hot-deals">
        <div class="section-header">
            <h2>🔥 KHUYẾN MÃI HOT</h2>
        </div>
        <div class="deals-carousel">
            <button class="carousel-btn prev-btn">‹</button>
            <div class="carousel-container">
                <div class="product-card">
                    <img src="resources/images/iphone12.jpg" alt="iPhone 12">
                    <h3>Iphone 12</h3>
                    <p class="price">27.990.000 đ</p>
                    <span class="condition">Mới ngay</span>
                </div>
                <div class="product-card">
                    <img src="resources/images/iphonex.jpg" alt="iPhone X">
                    <h3>Iphone x</h3>
                    <p class="price">5.990.000 đ</p>
                    <span class="condition">Mới ngay</span>
                </div>
                <div class="product-card">
                    <img src="resources/images/iphone13.jpg" alt="iPhone 13">
                    <h3>Iphone 13</h3>
                    <p class="price">7.990.000 đ</p>
                    <span class="condition">Mới ngay</span>
                </div>
                <div class="product-card">
                    <img src="resources/images/iphone14.jpg" alt="iPhone 14">
                    <h3>Iphone 14</h3>
                    <p class="price">8.990.000 đ</p>
                    <span class="condition">Mới ngay</span>
                </div>
            </div>
            <button class="carousel-btn next-btn">›</button>
        </div>
    </section>

    <!-- New Phones Section -->
    <section class="new-phones">
        <h2 class="section-title">ĐIỆN THOẠI MỚI NỔI BẬT</h2>
        <div class="products-grid">
            <div class="product-item">
                <div class="discount-tag">Trả góp 0%</div>
                <img src="resources/images/samsung-a67.jpg" alt="Samsung Galaxy A67">
                <h3>Samsung Galaxy A67 (4GB | 64GB) Chính Hãng</h3>
                <div class="price-info">
                    <span class="current-price">2.389.000 đ</span>
                    <span class="original-price">4.290.000 đ</span>
                </div>
                <p class="installment">Trả trước: 716.700 đ</p>
            </div>
            
            <div class="product-item">
                <div class="discount-tag">Trả góp 0%</div>
                <img src="resources/images/vivo-v30.jpg" alt="Vivo V30 5G">
                <h3>Vivo V30 5G (12GB | 256GB) Chính Hãng</h3>
                <div class="price-info">
                    <span class="current-price">11.399.000 đ</span>
                    <span class="original-price">13.990.000 đ</span>
                </div>
                <p class="installment">Trả trước: 3.419.700 đ</p>
            </div>
            
            <div class="product-item">
                <div class="discount-tag">Trả góp 0%</div>
                <img src="resources/images/samsung-a17.jpg" alt="Samsung Galaxy A17 4G">
                <h3>Samsung Galaxy A17 4G (6GB | 128GB) Chính Hãng</h3>
                <div class="price-info">
                    <span class="current-price">3.729.000 đ</span>
                    <span class="original-price">4.690.000 đ</span>
                </div>
                <p class="installment">Trả trước: 1.118.700 đ</p>
            </div>
            
            <div class="product-item">
                <div class="discount-tag">Trả góp 0%</div>
                <img src="resources/images/realme-note70.jpg" alt="Realme Note 70">
                <h3>realme Note 70 (4GB | 64GB) Chính Hãng</h3>
                <div class="price-info">
                    <span class="current-price">2.489.000 đ</span>
                    <span class="original-price">3.590.000 đ</span>
                </div>
                <p class="installment">Trả trước: 746.700 đ</p>
            </div>
            
            <div class="product-item">
                <div class="discount-tag">Trả góp 0%</div>
                <img src="resources/images/oppo-a5.jpg" alt="OPPO A5">
                <h3>OPPO A5 (6GB | 128GB) Chính Hãng</h3>
                <div class="price-info">
                    <span class="current-price">4.000.000 đ</span>
                    <span class="original-price">5.200.000 đ</span>
                </div>
                <p class="installment">Trả trước: 1.200.000 đ</p>
            </div>
        </div>
    </section>

    <!-- News Section -->
    <section class="news-section">
        <h2 class="section-title">BẢN TIN MỚI</h2>
        <div class="news-tabs">
            <button class="tab-btn active" data-tab="khai-hop">Khai hộp</button>
            <button class="tab-btn" data-tab="thi-thuat">Thủ Thuật - Hỏi Đáp</button>
            <button class="tab-btn" data-tab="tu-van">Tư vấn mua hàng</button>
        </div>
        
        <div class="news-content">
            <div class="news-grid">
                <article class="news-item">
                    <img src="resources/images/news1.jpg" alt="Kích thước iPhone A4">
                    <div class="news-info">
                        <span class="news-date">04/12/2024</span>
                        <h3>Kích thước iPhone A4, iPhone 17 (thường, Pro, Pro Max) lạm nhiều nho?</h3>
                    </div>
                </article>
                
                <article class="news-item">
                    <img src="resources/images/news2.jpg" alt="Pin iPhone Air">
                    <div class="news-info">
                        <span class="news-date">04/12/2024</span>
                        <h3>Pin iPhone Air, iPhone 17 (thường, Pro, Pro Max) dùng được bao lâu?</h3>
                    </div>
                </article>
                
                <article class="news-item">
                    <img src="resources/images/news3.jpg" alt="Tản nhiệt iPhone 17">
                    <div class="news-info">
                        <span class="news-date">04/12/2024</span>
                        <h3>Tản nhiệt buồng hơi tiến iPhone 17 Pro Max là gì?</h3>
                    </div>
                </article>
                
                <article class="news-item">
                    <img src="resources/images/news4.jpg" alt="Màn hình iPhone 17">
                    <div class="news-info">
                        <span class="news-date">04/12/2024</span>
                        <h3>Màn hình iPhone 17, iPhone Air bao nhiều Hz? Có gì mới?</h3>
                    </div>
                </article>
            </div>
            
            <div class="view-more">
                <button class="view-more-btn">Xem thêm bài viết</button>
            </div>
        </div>
    </section>

    <!-- Store Info -->
    <section class="store-info">
        <h2>Cửa hàng KT phone</h2>
        <p>Bệnh viện tâm thần tình yêu gia lai</p>
        <button class="store-btn">Xem bản đồ địa cửa hàng</button>
    </section>

    <!-- Footer -->
    <footer class="footer">
        <div class="footer-content">
            <div class="footer-section">
                <div class="footer-logo">KT</div>
                <p>GIỚI THIỆU VỀ CÔNG TY<br>
                CÂU HỎI THƯỜNG GẶP<br>
                CHÍNH SÁCH BẢO MẬT<br>
                QUY CHẾ HOẠT ĐỘNG</p>
            </div>
            
            <div class="footer-section">
                <h3>KIỂM TRA HÓA ĐƠN ĐIỆN TỬ</h3>
                <a href="#">TRA CỨU THÔNG TIN BẢO HÀNH</a>
                <a href="#">TIN TUYỂN DỤNG</a>
                <a href="#">TIN KHUYẾN MÃI</a>
                <a href="#">HƯỚNG DẪN ONLINE</a>
            </div>
            
            <div class="footer-section">
                <h3>HỆ THỐNG CỬA HÀNG</h3>
                <a href="#">HỆ THỐNG BẢO HÀNH</a>
                <a href="#">KIỂM TRA HÀNG APPLE CHÍNH HÃNG</a>
                <a href="#">GIỚI THIỆU ĐỔI MÁY</a>
                <a href="#">CHÍNH SÁCH ĐỔI TRẢ</a>
            </div>
            
            <div class="footer-section social-media">
                <h3>SOCIAL MEDIA</h3>
                <div class="social-icons">
                    <a href="#">f</a>
                    <a href="#">G</a>
                </div>
            </div>
        </div>
    </footer>

    <script src="resources/js/script.js"></script>
</body>
</html>