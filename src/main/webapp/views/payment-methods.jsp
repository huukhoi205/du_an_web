<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Phương Thức Thanh Toán - KT Store</title>
    <link rel="stylesheet" href="../resources/css/payment-methods.css">
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
        <a href="news.jsp">TIN TỨC</a>
        <a href="offers.jsp">ƯU ĐÃI</a>
        <a href="contact.jsp">LIÊN HỆ</a>
        <a href="about-us.jsp">VỀ CHÚNG TÔI</a>
        <a href="privacy-policy.jsp">BẢO MẬT</a>
    </nav>
    <div class="payment-content">
        <h2>Chọn Phương Thức Thanh Toán</h2>
        <p>Ngày giờ: <%= new Date() %></p>
        <div class="payment-option">
            <input type="radio" name="payment" id="cod" value="cod" checked>
            <label for="cod">Thanh Toán Khi Nhận Hàng (COD)</label>
        </div>
        <div class="payment-option">
            <input type="radio" name="payment" id="bank" value="bank">
            <label for="bank">Chuyển Khoản Ngân Hàng</label>
        </div>
        <div class="payment-option">
            <input type="radio" name="payment" id="card" value="card">
            <label for="card">Thẻ Tín Dụng/Ghi Nợ</label>
        </div>
        <button onclick="window.location.href='order.jsp'">Tiếp Tục Đặt Hàng</button>
        <button onclick="window.location.href='cart.jsp'">Quay Lại Giỏ Hàng</button>
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