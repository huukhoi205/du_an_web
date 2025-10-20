<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    // Láº¥y thÃ´ng tin user tá»« session
    String userName = (String) session.getAttribute("userName");`n        String userRole = (String) session.getAttribute("userRole");
    Integer userId = (Integer) session.getAttribute("userId");
    String userRole = (String) session.getAttribute("userRole");
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Äáº·t lá»‹ch háº¹n báº£o hÃ nh vÃ  sá»­a chá»¯a - KT Store</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/index.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/repair.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <!-- Header -->
    <header class="header">
        <div class="container">
            <div class="header-content">
                <!-- Logo -->
                <div class="logo">
                    <a href="${pageContext.request.contextPath}/views/index.jsp">
                        <img src="${pageContext.request.contextPath}/image/ca6a32d5a48f3e706cefc42bf7073f0751fc03f2.jpg" alt="KT Store" style="height: 55px;">
                    </a>
                </div>

                <!-- Search Box -->
                <div class="search-box">
                    <i class="fas fa-search"></i>
                    <form action="search.jsp" method="get">
                        <input type="text" name="q" placeholder="TÃ¬m Kiáº¿m Sáº£n pháº©m" id="searchInput">
                    </form>
                </div>

                <!-- Header Actions -->
                <div class="header-actions">
                    <a href="cart.jsp" class="icon-btn" title="Giá» hÃ ng">
                        <i class="fas fa-shopping-cart"></i>
                    </a>
                    <a href="wishlist.jsp" class="icon-btn" title="YÃªu thÃ­ch">
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
                                <a href="profile.jsp"><i class="far fa-user"></i> Trang cÃ¡ nhÃ¢n</a>
                                <a href="orders.jsp"><i class="fas fa-box"></i> ÄÆ¡n hÃ ng</a>
                                <% if ("Admin".equals(userRole)) { %>
                                <a href="admin/dashboard.jsp"><i class="fas fa-cog"></i> Quáº£n trá»‹</a>
                                <% } %>
                                <hr>
                                <a href="logout.jsp" class="logout-link"><i class="fas fa-sign-out-alt"></i> ÄÄƒng xuáº¥t</a>
                            </div>
                        </div>
                    <% } else { %>
                        <a href="login.jsp" class="btn-login">ÄÄ‚NG NHáº¬P</a>
                        <span class="separator">|</span>
                        <a href="register.jsp" class="btn-register">ÄÄ‚NG KÃ</a>
                    <% } %>
                </div>
            </div>
        </div>
    </header>

    <!-- Navigation -->
    <nav class="navbar">
        <div class="container">
            <div class="nav-content">
                <button class="menu-toggle">
                    <i class="fas fa-bars"></i>
                    <span>DANH Má»¤C<br>Sáº¢N PHáº¨M</span>
                </button>

                <ul class="nav-menu">
                    <li class="nav-item dropdown">
                        <a href="${pageContext.request.contextPath}/views/new-phones.jsp" class="nav-link">
                            ÄIá»†N THOáº I Má»šI
                            <i class="fas fa-chevron-down"></i>
                        </a>
                        <div class="dropdown-menu">
                            <a href="${pageContext.request.contextPath}/views/new-phones.jsp">iPhone</a>
                            <a href="${pageContext.request.contextPath}/views/new-phones.jsp">Samsung</a>
                            <a href="${pageContext.request.contextPath}/views/new-phones.jsp">Xiaomi</a>
                            <a href="${pageContext.request.contextPath}/views/new-phones.jsp">OPPO</a>
                            <a href="${pageContext.request.contextPath}/views/new-phones.jsp">Vivo</a>
                        </div>
                    </li>
                    <li class="nav-item dropdown">
                        <a href="${pageContext.request.contextPath}/views/used-phones.jsp" class="nav-link">
                            ÄIá»†N THOáº I CÅ¨
                            <i class="fas fa-chevron-down"></i>
                        </a>
                        <div class="dropdown-menu">
                            <a href="${pageContext.request.contextPath}/views/used-phones.jsp">iPhone CÅ©</a>
                            <a href="${pageContext.request.contextPath}/views/used-phones.jsp">Samsung CÅ©</a>
                            <a href="${pageContext.request.contextPath}/views/used-phones.jsp">Táº¥t cáº£ Ä‘iá»‡n thoáº¡i cÅ©</a>
                        </div>
                    </li>
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/views/exchange.jsp" class="nav-link">THU ÄIá»†N THOáº I</a>
                    </li>
                    <li class="nav-item">
                        <a href="repair.jsp" class="nav-link active">Sá»¬A CHá»®A</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <main class="main-content">
        <div class="container">
            <div class="repair-form-container">
                <div class="form-header">
                    <h1>Äáº¶T Lá»ŠCH Háº¸N Báº¢O HÃ€NH VÃ€ Sá»¬A CHá»®A</h1>
                    <p class="voucher-text">(Nháº­n voucher 10% tá»‘i Ä‘a 50.000â‚« sau khi Ä‘áº·t lá»‹ch)</p>
                </div>

                <form class="repair-form" action="repair-submit.jsp" method="post">
                    <div class="form-row">
                        <div class="form-column">
                            <div class="form-group">
                                <label for="fullName">Há» vÃ  tÃªn *</label>
                                <input type="text" id="fullName" name="fullName" value="Nguyen Van A" required>
                            </div>
                            
                            <div class="form-group">
                                <label for="email">Email</label>
                                <input type="email" id="email" name="email" placeholder="Email (khÃ´ng báº¯t buá»™c)">
                            </div>
                            
                            <div class="form-group">
                                <label for="region">Chá»n khu vá»±c *</label>
                                <input type="text" id="region" name="region" value="Miá»n Nam" required>
                            </div>
                            
                            <div class="form-group">
                                <label for="errorDescription">MÃ´ táº£ lá»—i *</label>
                                <textarea id="errorDescription" name="errorDescription" rows="4" placeholder="MÃ´ táº£ lá»—i (Báº¯t buá»™c)" required></textarea>
                            </div>
                        </div>

                        <div class="form-column">
                            <div class="form-group">
                                <label for="phone">Sá»‘ Ä‘iá»‡n thoáº¡i *</label>
                                <input type="tel" id="phone" name="phone" value="0903.xxx.xxx" required>
                            </div>
                            
                            <div class="form-group">
                                <label for="deviceModel">DÃ²ng mÃ¡y cáº§n sá»­a chá»¯a *</label>
                                <input type="text" id="deviceModel" name="deviceModel" placeholder="DÃ²ng mÃ¡y (VD: iPhone 11 Pro Max, ...)" required>
                            </div>
                        </div>
                    </div>

                    <div class="captcha-section">
                        <div class="captcha-container">
                            <input type="checkbox" id="captcha" name="captcha" required>
                            <label for="captcha">I'm not a robot</label>
                            <div class="captcha-logo">
                                <img src="https://www.google.com/recaptcha/api2/anchor?k=6Lc..." alt="reCAPTCHA">
                            </div>
                        </div>
                        <div class="captcha-links">
                            <a href="#">Privacy</a> - <a href="#">Terms</a>
                        </div>
                    </div>

                    <div class="form-actions">
                        <button type="submit" class="btn-submit">TIáº¾P Tá»¤C</button>
                    </div>
                </form>
            </div>
        </div>
    </main>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <div class="footer-grid">
                <div class="footer-col">
                    <div class="footer-logo">KT</div>
                    <div class="footer-links">
                        <a href="#">GIá»šI THIá»†U Vá»€ CÃ”NG TY</a>
                        <a href="#">CÃ‚U Há»ŽI THÆ¯á»œNG Gáº¶P</a>
                        <a href="#">CHÃNH SÃCH Báº¢O Máº¬T</a>
                        <a href="#">QUY CHáº¾ HOáº T Äá»˜NG</a>
                    </div>
                </div>

                <div class="footer-col">
                    <h3>KIá»‚M TRA HÃ“A ÄÆ N ÄIá»†N Tá»¬</h3>
                    <a href="#">TRA Cá»¨U THÃ”NG TIN Báº¢O HÃ€NH</a>
                    <a href="#">TIN TUYá»‚N Dá»¤NG</a>
                    <a href="#">TIN KHUYáº¾N MÃƒI</a>
                    <a href="#">HÆ¯á»šNG DáºªN ONLINE</a>
                </div>

                <div class="footer-col">
                    <h3>Há»† THá»NG Cá»¬A HÃ€NG</h3>
                    <a href="#">Há»† THá»NG Báº¢O HÃ€NH</a>
                    <a href="#">KIá»‚M TRA HÃ€NG APPLE CHÃNH HÃƒNG</a>
                    <a href="#">GIá»šI THIá»†U Äá»I TÃC</a>
                    <a href="#">CHÃNH SÃCH Äá»”I TRáº¢</a>
                </div>

                <div class="footer-col">
                    <h3>SOCIAL MEDIA</h3>
                    <div class="social-links">
                        <a href="#" class="social-icon"><i class="fab fa-facebook-f"></i></a>
                        <a href="#" class="social-icon"><i class="fab fa-google"></i></a>
                    </div>
                </div>
            </div>
        </div>
    </footer>
    <script src="${pageContext.request.contextPath}/resources/js/script-new.js"></script>`n    <style>`n        .user-menu { position: relative; }`n        .user-dropdown { `n            position: absolute !important; `n            top: 100% !important; `n            right: 0 !important; `n            margin-top: 10px !important; `n            background: #fff !important; `n            border-radius: 10px !important; `n            box-shadow: 0 5px 20px rgba(0,0,0,0.15) !important; `n            min-width: 200px !important; `n            display: none !important; `n            z-index: 1000 !important; `n        }`n        .user-dropdown.show { display: block !important; }`n        .user-dropdown a { `n            display: flex !important; `n            align-items: center !important; `n            gap: 10px !important; `n            padding: 12px 20px !important; `n            color: #333 !important; `n            text-decoration: none !important; `n            transition: all 0.3s !important; `n        }`n        .user-dropdown a:hover { background: #f5f5f5 !important; color: #e74c3c !important; }`n    </style>`n    <script>`n        function toggleUserDropdown() {`n            document.getElementById("userDropdown").classList.toggle("show");`n        }`n`n        // Close dropdown when clicking outside`n        window.onclick = function(event) {`n            if (!event.target.matches(".user-btn") && !event.target.matches(".user-btn *")) {`n                var dropdowns = document.getElementsByClassName("user-dropdown");`n                for (var i = 0; i < dropdowns.length; i++) {`n                    var openDropdown = dropdowns[i];`n                    if (openDropdown.classList.contains("show")) {`n                        openDropdown.classList.remove("show");`n                    }`n                }`n            }`n        }`n    </script>
    <script>
        // User dropdown function
        function toggleUserDropdown() {
            const dropdown = document.getElementById('userDropdown');
            dropdown.style.display = dropdown.style.display === 'block' ? 'none' : 'block';
        }

        // Close dropdown when clicking outside
        document.addEventListener('click', function(event) {
            const userMenu = document.querySelector('.user-menu');
            const dropdown = document.getElementById('userDropdown');
            
            if (userMenu && !userMenu.contains(event.target)) {
                dropdown.style.display = 'none';
            }
        });
    </script>
</body>
</html>
