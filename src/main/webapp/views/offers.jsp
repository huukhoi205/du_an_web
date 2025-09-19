<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ưu Đãi - KT Store</title>
    <link rel="stylesheet" href="../resources/css/offers.css">
</head>
<body>
    <header>
        <div class="logo">KT</div>
        <input type="text" placeholder="Tìm Kiếm Sản phẩm" class="search-bar">
        <div class="icons">
            <a href="cart.jsp"><i class="cart-icon">🛒</i></a>
            <a href="login.jsp">Đăng Nhập</a>
        </div>
    </header>
    <nav>
        <a href="index.jsp">DANH MỤC</a>
        <a href="new-phones.jsp">ĐIỆN THOẠI MỚI</a>
        <a href="used-phones.jsp">ĐIỆN THOẠI CŨ</a>
        <a href="repair.jsp">THU ĐIỆN THOẠI</a>
        <a href="appointment.jsp">SỬA CHỮA</a>
    </nav>
    <div class="offers-content">
        <h2>Ưu Đãi Đặc Biệt</h2>
        <div class="offer-item">
            <h3>Giảm 20% iPhone 14</h3>
            <p>Chỉ còn 11,999,000 VNĐ - Hết hạn: 25/09/2025</p>
            <button onclick="alert('Thêm ưu đãi vào giỏ hàng!')">Nhận Ưu Đãi</button>
        </div>
        <div class="offer-item">
            <h3>Trao đổi cũ lấy mới - Tặng 500k</h3>
            <p>Áp dụng cho tất cả dòng Samsung - Hết hạn: 30/09/2025</p>
            <button onclick="alert('Thêm ưu đãi vào giỏ hàng!')">Nhận Ưu Đãi</button>
        </div>
    </div>
    <footer>
        <div class="footer-content">
            <div class="footer-section">
                <h3>KT</h3>
                <p>Giải quyết mọi vấn đề về điện thoại</p>
            </div>
            <div class="footer-section">
                <h3>KIỂM TRA HÓA ĐƠN ĐIỆN TỬ</h3>
                <p>Tra cứu thông tin bảo hành</p>
            </div>
            <div class="footer-section">
                <h3>HỖ TRỢ CỬA HÀNG</h3>
                <p>Hỗ trợ đổi hàng</p>
            </div>
            <div class="footer-section">
                <h3>SOCIAL MEDIA</h3>
                <a href="#">Facebook</a> | <a href="#">Google</a>
            </div>
        </div>
    </footer>
    <script src="../resources/js/script.js"></script>
</body>
</html>