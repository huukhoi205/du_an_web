<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
    
    String step = request.getParameter("step");
    if (step == null) step = "1";
    
    String message = request.getParameter("message");
    String error = request.getParameter("error");
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>QuÃªn máº­t kháº©u - KT Store</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/forgot-password.css">
</head>
<body>
    <div class="forgot-password-page">
        <!-- Left Side -->
        <div class="left-side">
            <div class="illustration-wrapper">
                <img src="${pageContext.request.contextPath}/image/49668abf44a0f8d56f5221eec31f5edcc6766e6e.jpg" alt="KT Store Illustration" class="illustration">
            </div>
            
            <h2 class="welcome-text">Láº¥y láº¡i máº­t kháº©u Ä‘á»ƒ dá»… dÃ ng<br>nháº­p nÃ o!</h2>
            
            <a href="${pageContext.request.contextPath}/views/index.jsp" class="back-home">
                <span class="arrow">â†</span> Trang chá»§
            </a>
        </div>
        
        <!-- Right Side -->
        <div class="right-side">
            <div class="form-wrapper">
                <h2 class="form-title">QuÃªn máº­t kháº©u</h2>
                
                <% if (message != null && !message.isEmpty()) { %>
                    <div class="alert alert-success"><%= message %></div>
                <% } %>
                
                <% if (error != null && !error.isEmpty()) { %>
                    <div class="alert alert-error"><%= error %></div>
                <% } %>
                
                <% if ("1".equals(step)) { %>
                    <!-- BÆ°á»›c 1: Nháº­p thÃ´ng tin vÃ  OTP -->
                    <form method="post" action="forgot-password-process.jsp" class="forgot-form" id="step1Form">
                        <input type="hidden" name="step" value="1">
                        
                        <div class="form-group">
                            <input type="text" name="fullName" placeholder="Nháº­p há» vÃ  tÃªn" required>
                        </div>
                        
                        <div class="form-group">
                            <input type="text" name="emailOrPhone" placeholder="Email hoáº·c sá»‘ Ä‘iá»‡n thoáº¡i" required>
                        </div>
                        
                        <div class="form-group otp-group">
                            <input type="text" name="otp" placeholder="MÃ£ OTP" required class="otp-input">
                            <button type="button" class="btn-get-otp" onclick="getOTP()">Láº¥y mÃ£ OTP</button>
                        </div>
                        
                        <button type="submit" class="btn-submit">Tiáº¿p tá»¥c</button>
                    </form>
                <% } else { %>
                    <!-- BÆ°á»›c 2: Nháº­p máº­t kháº©u má»›i -->
                    <form method="post" action="forgot-password-process.jsp" class="forgot-form" id="step2Form">
                        <input type="hidden" name="step" value="2">
                        
                        <div class="form-group">
                            <input type="password" name="newPassword" placeholder="Nháº­p máº­t kháº©u má»›i" required>
                        </div>
                        
                        <div class="form-group">
                            <input type="password" name="confirmPassword" placeholder="Nháº­p láº¡i máº­t kháº©u" required>
                        </div>
                        
                        <button type="submit" class="btn-submit">HoÃ n thÃ nh</button>
                    </form>
                <% } %>
            </div>
        </div>
    </div>
    
    <script>
        function getOTP() {
            const emailOrPhone = document.querySelector('input[name="emailOrPhone"]').value;
            const fullName = document.querySelector('input[name="fullName"]').value;
            
            if (!fullName || !emailOrPhone) {
                alert('Vui lÃ²ng nháº­p há» tÃªn vÃ  email/sá»‘ Ä‘iá»‡n thoáº¡i trÆ°á»›c!');
                return;
            }
            
            // TODO: Gá»i API gá»­i OTP
            alert('MÃ£ OTP Ä‘Ã£ Ä‘Æ°á»£c gá»­i Ä‘áº¿n ' + emailOrPhone);
            
            // Disable button vÃ  Ä‘áº¿m ngÆ°á»£c
            const btn = event.target;
            btn.disabled = true;
            let countdown = 60;
            btn.textContent = countdown + 's';
            
            const timer = setInterval(() => {
                countdown--;
                btn.textContent = countdown + 's';
                if (countdown <= 0) {
                    clearInterval(timer);
                    btn.disabled = false;
                    btn.textContent = 'Láº¥y mÃ£ OTP';
                }
            }, 1000);
        }
    </script>
</body>
</html>

