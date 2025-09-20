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
    <div class="login-container">
        <!-- Left Side - Illustration -->
        <div class="login-left">
            <div class="illustration-container">
                <!-- Phone Illustration -->
                <div class="phone-illustration">
                    <div class="phone-frame">
                        <div class="phone-screen">
                            <div class="chat-bubble green"></div>
                            <div class="chat-bubble orange"></div>
                            <div class="chat-bubble green small"></div>
                            <div class="chat-bubble orange small"></div>
                        </div>
                    </div>
                </div>
                
                <!-- Character Illustration -->
                <div class="character">
                    <div class="character-head">
                        <div class="glasses"></div>
                    </div>
                    <div class="character-body"></div>
                    <div class="character-legs"></div>
                    <div class="character-phone"></div>
                </div>
            </div>
            
            <!-- Brand and Text -->
            <div class="brand-section">
                <h1 class="brand-name">KT Store</h1>
                <p class="brand-tagline">Ở đây chúng tôi có mọi máy mà bạn cần</p>
            </div>
            
            <!-- Back to Home -->
            <div class="back-home">
                <a href="index.jsp">
                    <span class="back-icon">←</span>
                    <span>Trang chủ</span>
                </a>
            </div>
        </div>
        
        <!-- Right Side - Login Form -->
        <div class="login-right">
            <div class="login-form-container">
                <form class="login-form" method="post" action="processLogin.jsp">
                    <div class="input-group">
                        <input type="email" name="email" placeholder="Email" required>
                    </div>
                    
                    <div class="input-group">
                        <input type="password" name="password" placeholder="Mật khẩu" required>
                    </div>
                    
                    <button type="submit" class="login-btn">Đăng nhập</button>
                    
                    <div class="login-links">
                        <a href="forgot-password.jsp" class="forgot-link">Bạn quên mật khẩu ?</a>
                        <p class="signup-text">
                            Bạn chưa có mật khẩu? 
                            <a href="register.jsp" class="signup-link">Đăng ký</a>
                        </p>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>