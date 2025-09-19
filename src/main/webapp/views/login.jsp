<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng Nhập - KT Store</title>
    <link rel="stylesheet" href="../resources/css/login.css">
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
    <div class="login-content">
        <h2>Đăng Nhập</h2>
        <form>
            <input type="text" placeholder="Tên đăng nhập" required>
            <input type="password" placeholder="Mật khẩu" required>
            <button type="submit">Đăng Nhập</button>
        </form>
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