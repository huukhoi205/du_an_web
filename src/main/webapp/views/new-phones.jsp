<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Điện Thoại Mới - KT Store</title>
    <link rel="stylesheet" href="../resources/css/new-phones.css">
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
                <a href="login.jsp">user 1</a>
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

    <!-- Breadcrumb -->
    <div class="breadcrumb">
        <a href="index.jsp">Trang chủ</a>
        <span> › Mua bán điện thoại</span>
    </div>

    <!-- Featured Banner -->
    <section class="featured-banner">
        <div class="banner-content">
            <div class="banner-text">
                <h1>XIAOMI 15 & 15 Ultra</h1>
                <p>Giảm tối đa 4.000.000đ</p>
                <p>Khi Mua cùng Ưu đãi lên tới 60%</p>
                <div class="price-highlight">
                    <span class="price">19.890.000đ</span>
                    <button class="buy-now-btn">MUA NGAY</button>
                </div>
            </div>
            <div class="banner-image">
                <img src="../resources/images/xiaomi-15-ultra.jpg" alt="Xiaomi 15 Ultra">
            </div>
        </div>
        <div class="feature-tabs">
            <div class="tab active">Thiết kế</div>
            <div class="tab">Màn hình</div>
            <div class="tab">Camera</div>
            <div class="tab">Ưu điểm</div>
            <div class="tab">Bộ nhớ</div>
        </div>
    </section>

    <!-- Main Content -->
    <div class="main-container">
        <!-- Sidebar Filters -->
        <aside class="sidebar">
            <div class="filter-section">
                <h3>Lựa chọn hãng</h3>
                <div class="brand-list">
                    <div class="brand-item">
                        <input type="checkbox" id="apple">
                        <label for="apple">
                            <img src="../resources/images/apple-logo.png" alt="Apple">
                        </label>
                    </div>
                    <div class="brand-item">
                        <input type="checkbox" id="samsung">
                        <label for="samsung">
                            <img src="../resources/images/samsung-logo.png" alt="Samsung">
                        </label>
                    </div>
                    <div class="brand-item">
                        <input type="checkbox" id="xiaomi">
                        <label for="xiaomi">
                            <img src="../resources/images/xiaomi-logo.png" alt="Xiaomi">
                        </label>
                    </div>
                    <div class="brand-item">
                        <input type="checkbox" id="oppo">
                        <label for="oppo">
                            <img src="../resources/images/oppo-logo.png" alt="Oppo">
                        </label>
                    </div>
                    <div class="brand-item">
                        <input type="checkbox" id="vivo">
                        <label for="vivo">
                            <img src="../resources/images/vivo-logo.png" alt="Vivo">
                        </label>
                    </div>
                    <div class="brand-item">
                        <input type="checkbox" id="huawei">
                        <label for="huawei">
                            <img src="../resources/images/huawei-logo.png" alt="Huawei">
                        </label>
                    </div>
                    <div class="brand-item">
                        <input type="checkbox" id="realme">
                        <label for="realme">
                            <img src="../resources/images/realme-logo.png" alt="Realme">
                        </label>
                    </div>
                    <div class="brand-item">
                        <input type="checkbox" id="sony">
                        <label for="sony">
                            <img src="../resources/images/sony-logo.png" alt="Sony">
                        </label>
                    </div>
                    <div class="brand-item">
                        <input type="checkbox" id="google">
                        <label for="google">
                            <img src="../resources/images/google-logo.png" alt="Google">
                        </label>
                    </div>
                </div>
            </div>

            <div class="filter-section">
                <h3>Mức giá</h3>
                <div class="price-range">
                    <input type="range" min="0" max="50000000" value="25000000" class="price-slider">
                    <div class="price-labels">
                        <span>0đ</span>
                        <span>50.000.000đ</span>
                    </div>
                </div>
                <button class="apply-filter-btn">Áp dụng</button>
            </div>

            <div class="filter-section">
                <h3>Loại điện thoại</h3>
                <div class="phone-type-list">
                    <label><input type="checkbox"> Điện thoại</label>
                    <label><input type="checkbox"> Điện thoại gaming</label>
                    <label><input type="checkbox"> Điện thoại chụp ảnh</label>
                    <label><input type="checkbox"> Điện thoại pin khủng</label>
                </div>
            </div>

            <div class="filter-section">
                <h3>Bộ nhớ trong</h3>
                <div class="storage-list">
                    <label><input type="checkbox"> <16GB</label>
                    <label><input type="checkbox"> 32GB</label>
                    <label><input type="checkbox"> 64GB</label>
                    <label><input type="checkbox"> 128GB</label>
                    <label><input type="checkbox"> 256GB</label>
                    <label><input type="checkbox"> 512GB</label>
                    <label><input type="checkbox"> ≥1TB</label>
                </div>
            </div>

            <div class="filter-section">
                <h3>Kết nối mạng</h3>
                <div class="network-list">
                    <label><input type="checkbox"> 2G,3G,4G</label>
                    <label><input type="checkbox"> 5G</label>
                </div>
            </div>

            <div class="filter-section">
                <h3>Tính năng đặc biệt</h3>
                <div class="feature-list">
                    <label><input type="checkbox"> Chống nước</label>
                    <label><input type="checkbox"> Hỗ trợ 5G</label>
                    <label><input type="checkbox"> Sạc nhanh</label>
                    <label><input type="checkbox"> Nhận diện khuôn mặt</label>
                    <label><input type="checkbox"> Mở khóa vân tay</label>
                    <label><input type="checkbox"> Sạc không dây</label>
                </div>
            </div>

            <div class="filter-section">
                <h3>Dung lượng pin</h3>
                <div class="battery-list">
                    <label><input type="checkbox"> <3000 mAh</label>
                    <label><input type="checkbox"> 3000mAh → 4.000mAh</label>
                    <label><input type="checkbox"> 4000mAh → 5.000mAh</label>
                    <label><input type="checkbox"> >5000mAh → 6.000mAh</label>
                </div>
            </div>
        </aside>

        <!-- Products Grid -->
        <main class="products-section">
            <div class="products-header">
                <h2>Sắp xếp</h2>
                <div class="sort-options">
                    <button class="sort-btn active">Nổi bật</button>
                    <button class="sort-btn">% Giảm</button>
                    <button class="sort-btn">Giá tăng dần</button>
                    <button class="sort-btn">Giá giảm dần</button>
                </div>
            </div>

            <div class="products-grid">
                <!-- Product 1 -->
                <div class="product-card">
                    <div class="product-image">
                        <img src="../resources/images/samsung-galaxy-z-flip6.jpg" alt="Samsung Galaxy Z Flip6">
                    </div>
                    <div class="product-info">
                        <h3>Samsung Galaxy Z Flip6 5G (512GB/5G8GB)</h3>
                        <div class="price-info">
                            <span class="current-price">23.990.000 đ</span>
                            <span class="original-price">29.990.000 đ</span>
                            <span class="discount">-20%</span>
                        </div>
                    </div>
                    <div class="product-actions">
                        <button>Mua ngay</button>
                    </div>
                </div>

                <!-- Product 2 -->
                <div class="product-card">
                    <div class="product-image">
                        <img src="../resources/images/samsung-galaxy-z-fold6.jpg" alt="Samsung Galaxy Z Fold6">
                    </div>
                    <div class="product-info">
                        <h3>Samsung Galaxy Z Fold6 5G (512GB/5G8GB)</h3>
                        <div class="price-info">
                            <span class="current-price">47.990.000 đ</span>
                        </div>
                    </div>
                    <div class="product-actions">
                        <button>Mua ngay</button>
                    </div>
                </div>

                <!-- Product 3 -->
                <div class="product-card">
                    <div class="product-image">
                        <img src="../resources/images/samsung-galaxy-a35.jpg" alt="Samsung Galaxy A35">
                    </div>
                    <div class="product-info">
                        <h3>Samsung Galaxy A35 5G (8GB/128GB)</h3>
                        <div class="price-info">
                            <span class="current-price">8.990.000 đ</span>
                            <span class="original-price">9.990.000 đ</span>
                            <span class="discount">-10%</span>
                        </div>
                    </div>
                    <div class="product-actions">
                        <button>Mua ngay</button>
                    </div>
                </div>

                <!-- Product 4 -->
                <div class="product-card">
                    <div class="product-image">
                        <img src="../resources/images/xiaomi-14.jpg" alt="Xiaomi 14">
                    </div>
                    <div class="product-info">
                        <h3>Xiaomi 14 (12GB/256GB)</h3>
                        <div class="price-info">
                            <span class="current-price">14.990.000 đ</span>
                        </div>
                    </div>
                    <div class="product-actions">
                        <button>Mua ngay</button>
                    </div>
                </div>

                <!-- Product 5 -->
                <div class="product-card">
                    <div class="product-image">
                        <img src="../resources/images/iphone-15-pro.jpg" alt="iPhone 15 Pro">
                    </div>
                    <div class="product-info">
                        <h3>iPhone 15 Pro (256GB)</h3>
                        <div class="price-info">
                            <span class="current-price">29.990.000 đ</span>
                        </div>
                    </div>
                    <div class="product-actions">
                        <button>Mua ngay</button>
                    </div>
                </div>

                <!-- Product 6 -->
                <div class="product-card">
                    <div class="product-image">
                        <img src="../resources/images/oppo-find-x7.jpg" alt="Oppo Find X7">
                    </div>
                    <div class="product-info">
                        <h3>Oppo Find X7 (12GB/256GB)</h3>
                        <div class="price-info">
                            <span class="current-price">18.990.000 đ</span>
                        </div>
                    </div>
                    <div class="product-actions">
                        <button>Mua ngay</button>
                    </div>
                </div>

                <!-- Product 7 -->
                <div class="product-card">
                    <div class="product-image">
                        <img src="../resources/images/vivo-x100.jpg" alt="Vivo X100">
                    </div>
                    <div class="product-info">
                        <h3>Vivo X100 (12GB/256GB)</h3>
                        <div class="price-info">
                            <span class="current-price">17.990.000 đ</span>
                        </div>
                    </div>
                    <div class="product-actions">
                        <button>Mua ngay</button>
                    </div>
                </div>

                <!-- Product 8 -->
                <div class="product-card">
                    <div class="product-image">
                        <img src="../resources/images/huawei-pura-70.jpg" alt="Huawei Pura 70">
                    </div>
                    <div class="product-info">
                        <h3>Huawei Pura 70 (12GB/256GB)</h3>
                        <div class="price-info">
                            <span class="current-price">19.990.000 đ</span>
                        </div>
                    </div>
                    <div class="product-actions">
                        <button>Mua ngay</button>
                    </div>
                </div>

                <!-- Load More Button -->
                <div class="load-more-container">
                    <button class="load-more-btn">Xem thêm 278 sản phẩm</button>
                </div>
            </div>
        </main>
    </div>

    <!-- Product Description -->
    <section class="product-description">
        <h2>Điện thoại di động - "Người đồng hành" không thể thiếu trong thời đại mới</h2>
        <p>Từ khi ra đời, điện thoại di động đã mang về cho cuộc sống con người sự tiện lợi tối ưu. Từ chức năng cơ bản như gọi điện, nhắn tin đến những tính năng "thần thánh" như chụp ảnh, quay video, nghe nhạc, xem phim, chơi game... điện thoại thông minh đã trở thành một phần không thể thiếu trong cuộc sống hàng ngày của chúng ta.</p>
        
        <h3>Sự tiên tiến vượt bậc của các smartphone hiện đại</h3>
        <p>Các hãng điện thoại không ngừng sáng tạo những mẫu sản phẩm với các tính năng ưu việt nhằm mang đến trải nghiệm hoàn hảo cho người dùng. Từ camera độ phân giải cao, pin có dung lượng lớn, bộ xử lý mạnh mẽ đến những tính năng bảo mật tiên tiến...</p>
        
        <div class="phone-image">
            <img src="../resources/images/phone-showcase.jpg" alt="Điện thoại hiện đại">
        </div>
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

    <script src="../resources/js/script.js"></script>
</body>
</html>