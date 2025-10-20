<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>LiÃªn Há»‡ - KT Store</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/contact.css">
</head>
<body>
    <header>
        <div class="logo">KT</div>
        <input type="text" placeholder="TÃ¬m Kiáº¿m Sáº£n pháº©m" class="search-bar">
        <div class="icons">
            <a href="cart.jsp"><i class="cart-icon">ðŸ›’</i></a>
            <a href="login.jsp">ÄÄƒng Nháº­p</a>
        </div>
    </header>
    <nav>
        <a href="index.jsp">DANH Má»¤C</a>
        <a href="new-phones.jsp">ÄIá»†N THOáº I Má»šI</a>
        <a href="used-phones.jsp">ÄIá»†N THOáº I CÅ¨</a>
        <a href="repair.jsp">THU ÄIá»†N THOáº I</a>
        <a href="appointment.jsp">Sá»¬A CHá»®A</a>
    </nav>
    <div class="contact-form">
        <h2>LiÃªn Há»‡ Vá»›i ChÃºng TÃ´i</h2>
        <form action="contact" method="POST">
            <input type="text" name="full_name" placeholder="Há» vÃ  tÃªn" required>
            <input type="email" name="email" placeholder="Email" required>
            <input type="tel" name="phone" placeholder="Sá»‘ Ä‘iá»‡n thoáº¡i" required>
            <textarea name="message" placeholder="Lá»i nháº¯n" required></textarea>
            <button type="submit">Gá»­i LiÃªn Há»‡</button>
        </form>
        <div class="contact-info">
            <p>Äá»‹a chá»‰: 123 ÄÆ°á»ng Äiá»‡n Thoáº¡i, TP. HCM</p>
            <p>Hotline: 0903-xxx-xxx</p>
            <p>Email: support@ktstore.com</p>
        </div>
    </div>
    <footer>
        <div class="footer-content">
            <div class="footer-section">
                <h3>KT</h3>
                <p>Giáº£i quyáº¿t má»i váº¥n Ä‘á» vá» Ä‘iá»‡n thoáº¡i</p>
            </div>
            <div class="footer-section">
                <h3>KIá»‚M TRA HÃ“A ÄÆ N ÄIá»†N Tá»¬</h3>
                <p>Tra cá»©u thÃ´ng tin báº£o hÃ nh</p>
            </div>
            <div class="footer-section">
                <h3>Há»– TRá»¢ Cá»¬A HÃ€NG</h3>
                <p>Há»— trá»£ Ä‘á»•i hÃ ng</p>
            </div>
            <div class="footer-section">
                <h3>SOCIAL MEDIA</h3>
                <a href="#">Facebook</a> | <a href="#">Google</a>
            </div>
        </div>
    </footer>
    <script src="${pageContext.request.contextPath}/resources/js/script.js"></script>
</body>
</html>
