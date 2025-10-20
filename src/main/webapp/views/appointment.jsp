<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Äáº·t Lá»‹ch Háº¹n Báº£o HÃ nh vÃ  Sá»­a Chá»¯a - KT Store</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/appointment.css">
</head>
<body>
    <!-- Header -->
    <header class="header">
        <div class="header-top">
            <div class="logo">KT</div>
            <div class="search-container">
                <input type="text" class="search-bar" placeholder="TÃ¬m Kiáº¿m Sáº£n pháº©m">
            </div>
            <div class="header-icons">
                <a href="cart.jsp">ðŸ›’</a>
                <a href="wishlist.jsp">â¤ï¸</a>
                <a href="login.jsp">ÄÄ‚NG NHáº¬P</a>
            </div>
        </div>
    </header>

    <!-- Navigation -->
    <nav class="navigation">
        <div class="nav-container">
            <button class="menu-toggle">
                â˜° DANH<br>Má»¤C
            </button>
            <ul class="nav-links">
                <li><a href="new-phones.jsp">ÄIá»†N THOáº I Má»šI â–¼</a></li>
                <li><a href="used-phones.jsp">ÄIá»†N THOáº I CÅ¨ â–¼</a></li>
                <li><a href="repair.jsp">THU ÄIá»†N THOáº I</a></li>
                <li><a href="appointment.jsp">Sá»¬A CHá»®A</a></li>
            </ul>
        </div>
    </nav>

    <!-- Main Content -->
    <main class="main-content">
        <section class="appointment-section">
            <h2 class="section-title">Äáº¶T Lá»ŠCH Háº¸N Báº¢O HÃ€NH VÃ€ Sá»¬A CHá»®A</h2>
            <p class="section-subtitle">(Nháº­n voucher 10% tá»‘i Ä‘a 50.000 sau khi Ä‘áº·t lá»‹ch)</p>
            
            <form method="post" action="processAppointment.jsp">
                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label">Há» vÃ  tÃªn <span class="required">*</span></label>
                        <input type="text" name="fullName" class="form-input" placeholder="Nguyen Van A" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Sá»‘ Ä‘iá»‡n thoáº¡i <span class="required">*</span></label>
                        <input type="tel" name="phone" class="form-input" placeholder="0903.xxx.xxx" required>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label">Email</label>
                        <input type="email" name="email" class="form-input" placeholder="Email (khÃ´ng báº¯t buá»™c)">
                    </div>
                    <div class="form-group">
                        <label class="form-label">DÃ²ng mÃ¡y cáº§n sá»­a chá»¯a <span class="required">*</span></label>
                        <input type="text" name="deviceModel" class="form-input" placeholder="DÃ²ng mÃ¡y (VD: iPhone 11 Pro Max, ...)" required>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group full-width">
                        <label class="form-label">Chá»n khu vá»±c <span class="required">*</span></label>
                        <select name="region" class="form-input" required>
                            <option value="">Chá»n khu vá»±c</option>
                            <option value="mien-bac">Miá»n Báº¯c</option>
                            <option value="mien-trung">Miá»n Trung</option>
                            <option value="mien-nam">Miá»n Nam</option>
                        </select>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group full-width">
                        <label class="form-label">MÃ´ táº£ lá»—i <span class="required">*</span></label>
                        <textarea name="issueDescription" class="form-textarea" placeholder="MÃ´ táº£ lá»—i (Báº¯t buá»™c)" required></textarea>
                    </div>
                </div>

                <div class="captcha-container">
                    <div class="captcha-box">
                        <input type="checkbox" class="captcha-checkbox" required>
                        <span>I'm not a robot</span>
                    </div>
                </div>

                <button type="submit" class="submit-btn">TIáº¾P Tá»¤C</button>
            </form>
        </section>
    </main>

    <!-- Footer -->
    <footer class="footer">
        <div class="footer-content">
            <div class="footer-section">
                <div class="footer-logo">KT</div>
                <p>GIá»šI THIá»†U Vá»€ CÃ”NG TY<br>
                CÃ‚U Há»ŽI THÆ¯á»œNG Gáº¶P<br>
                CHÃNH SÃCH Báº¢O Máº¬T<br>
                QUY CHáº¾ HOáº T Äá»˜NG</p>
            </div>
            
            <div class="footer-section">
                <h3>KIá»‚M TRA HÃ“A ÄÆ N ÄIá»†N Tá»¬</h3>
                <a href="#">TRA Cá»¨U THÃ”NG TIN Báº¢O HÃ€NH</a>
                <a href="#">TIN TUYá»‚N Dá»¤NG</a>
                <a href="#">TIN KHUYáº¾N MÃƒI</a>
                <a href="#">HÆ¯á»šNG DáºªN ONLINE</a>
            </div>
            
            <div class="footer-section">
                <h3>Há»† THá»NG Cá»¬A HÃ€NG</h3>
                <a href="#">Há»† THá»NG Báº¢O HÃ€NH</a>
                <a href="#">KIá»‚M TRA HÃ€NG APPLE CHÃNH HÃƒNG</a>
                <a href="#">GIá»šI THIá»†U Äá»”I MÃY</a>
                <a href="#">CHÃNH SÃCH Äá»”I TRáº¢</a>
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
    
    <script src="${pageContext.request.contextPath}/resources/js/script.js"></script>
</body>
</html>
