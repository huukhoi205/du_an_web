<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.ProductDAO" %>
<%@ page import="model.Product" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>

<%
    ProductDAO productDAO = new ProductDAO();
    List<Product> hotDeals = productDAO.getHotDeals(6);
    List<Product> newPhones = productDAO.getAllNewPhones();
    if (newPhones.size() > 5) {
        newPhones = newPhones.subList(0, 5);
    }
    
    NumberFormat formatter = NumberFormat.getInstance(new Locale("vi", "VN"));
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>KT Store - Mua bán & trao đổi điện thoại giá tốt</title>
    <link rel="stylesheet" href="../resources/css/index.css">
    <style>
        .product-image {
            width: 100%;
            height: 200px;
            object-fit: cover;
            border-radius: 8px;
        }
        .product-card {
            position: relative;
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 15px;
            margin: 10px;
            text-align: center;
            background: white;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            cursor: pointer;
            transition: transform 0.2s;
        }
        .product-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
        }
        .price {
            color: #e74c3c;
            font-weight: bold;
            font-size: 18px;
        }
        .condition-badge {
            position: absolute;
            top: 10px;
            right: 10px;
            background: #27ae60;
            color: white;
            padding: 2px 6px;
            border-radius: 3px;
            font-size: 11px;
            font-weight: bold;
        }
        .used-badge {
            background: #f39c12;
        }
    </style>
</head>
<body>
    <!-- Header -->
    <header class="header">
        <div class="header-top">
            <div class="logo">KT</div>
            <div class="search-container">
                <form action="search.jsp" method="get">
                    <input type="text" name="q" class="search-bar" placeholder="Tìm Kiếm Sản phẩm">
                    <button type="submit" class="search-btn">🔍</button>
                </form>
            </div>
            <div class="header-icons">
                <a href="cart.jsp">🛒</a>
                <a href="wishlist.jsp">❤️</a>
                <%
                    String userName = (String) session.getAttribute("userName");
                    if (userName != null) {
                %>
                <a href="profile.jsp"><%= userName %></a>
                <a href="logout.jsp">ĐĂNG XUẤT</a>
                <%
                    } else {
                %>
                <a href="login.jsp">ĐĂNG NHẬP</a>
                <%
                    }
                %>
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
                <%
                    for (Product product : hotDeals) {
                %>
                <div class="product-card" onclick="window.location.href='product-detail.jsp?id=<%= product.getMaSP() %>'">
                    <% if (product.isUsed()) { %>
                    <div class="condition-badge used-badge">Cũ</div>
                    <% } else { %>
                    <div class="condition-badge">Mới</div>
                    <% } %>
                    <img src="resources/images/<%= product.getHinhAnh() != null ? product.getHinhAnh() : "default-phone.jpg" %>" 
                         alt="<%= product.getTenSP() %>" class="product-image">
                    <h3><%= product.getTenSP() %></h3>
                    <p class="price"><%= formatter.format(product.getGia()) %>đ</p>
                    <span class="condition">
                        <%= product.getBrandName() %> - <%= product.isNew() ? "Mới nguyên seal" : "Máy cũ" %>
                    </span>
                </div>
                <%
                    }
                %>
            </div>
            <button class="carousel-btn next-btn">›</button>
        </div>
    </section>

    <!-- New Phones Section -->
    <section class="new-phones">
        <h2 class="section-title">ĐIỆN THOẠI MỚI NỔI BẬT</h2>
        <div class="products-grid">
            <%
                for (Product product : newPhones) {
            %>
            <div class="product-item" onclick="window.location.href='product-detail.jsp?id=<%= product.getMaSP() %>'">
                <div class="discount-tag">Trả góp 0%</div>
                <img src="resources/images/<%= product.getHinhAnh() != null ? product.getHinhAnh() : "default-phone.jpg" %>" 
                     alt="<%= product.getTenSP() %>" class="product-image">
                <h3><%= product.getTenSP() %></h3>
                <div class="price-info">
                    <span class="current-price"><%= formatter.format(product.getGia()) %>đ</span>
                </div>
                <% 
                    long traTruoc = product.getGia().longValue() * 30 / 100;
                %>
                <p class="installment">Trả trước: <%= formatter.format(traTruoc) %>đ</p>
                
                <!-- Hiển thị thông tin cấu hình nếu có -->
                <div class="product-specs" style="font-size: 12px; color: #666; margin-top: 5px;">
                    <div><strong><%= product.getBrandName() %></strong></div>
                    <% if (product.getRam() != null || product.getBoNhoTrong() != null) { %>
                    <div>
                        <% if (product.getRam() != null) { %>
                        RAM: <%= product.getRam() %>
                        <% } %>
                        <% if (product.getBoNhoTrong() != null) { %>
                        | Bộ nhớ: <%= product.getBoNhoTrong() %>
                        <% } %>
                    </div>
                    <% } %>
                    <% if (product.getDungLuongPin() != null) { %>
                    <div>Pin: <%= product.getDungLuongPin() %></div>
                    <% } %>
                </div>
            </div>
            <%
                }
            %>
        </div>
        <div class="view-more" style="text-align: center; margin-top: 20px;">
            <a href="new-phones.jsp" class="view-more-btn" style="background: #3498db; color: white; padding: 10px 20px; text-decoration: none; border-radius: 5px;">
                Xem tất cả điện thoại mới
            </a>
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
                        <h3>Tản nhiệt buồng hơi tiền iPhone 17 Pro Max là gì?</h3>
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