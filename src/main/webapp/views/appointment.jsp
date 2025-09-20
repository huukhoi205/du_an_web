<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đặt Lịch Hẹn Bảo Hành và Sửa Chữa - KT Store</title>
    <link rel="stylesheet" href="../resources/css/appointment.css">
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

    <!-- Main Content -->
    <main class="main-content">
        <section class="appointment-section">
            <h2 class="section-title">ĐẶT LỊCH HẸN BẢO HÀNH VÀ SỬA CHỮA</h2>
            <p class="section-subtitle">(Nhận voucher 10% tối đa 50.000 sau khi đặt lịch)</p>
            
            <form method="post" action="processAppointment.jsp">
                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label">Họ và tên <span class="required">*</span></label>
                        <input type="text" name="fullName" class="form-input" placeholder="Nguyen Van A" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Số điện thoại <span class="required">*</span></label>
                        <input type="tel" name="phone" class="form-input" placeholder="0903.xxx.xxx" required>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label">Email</label>
                        <input type="email" name="email" class="form-input" placeholder="Email (không bắt buộc)">
                    </div>
                    <div class="form-group">
                        <label class="form-label">Dòng máy cần sửa chữa <span class="required">*</span></label>
                        <input type="text" name="deviceModel" class="form-input" placeholder="Dòng máy (VD: iPhone 11 Pro Max, ...)" required>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group full-width">
                        <label class="form-label">Chọn khu vực <span class="required">*</span></label>
                        <select name="region" class="form-input" required>
                            <option value="">Chọn khu vực</option>
                            <option value="mien-bac">Miền Bắc</option>
                            <option value="mien-trung">Miền Trung</option>
                            <option value="mien-nam">Miền Nam</option>
                        </select>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group full-width">
                        <label class="form-label">Mô tả lỗi <span class="required">*</span></label>
                        <textarea name="issueDescription" class="form-textarea" placeholder="Mô tả lỗi (Bắt buộc)" required></textarea>
                    </div>
                </div>

                <div class="captcha-container">
                    <div class="captcha-box">
                        <input type="checkbox" class="captcha-checkbox" required>
                        <span>I'm not a robot</span>
                    </div>
                </div>

                <button type="submit" class="submit-btn">TIẾP TỤC</button>
            </form>
        </section>
    </main>

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