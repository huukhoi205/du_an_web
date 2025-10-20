<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String error = (String) request.getAttribute("error");
    String message = (String) request.getAttribute("message");
    String success = (String) request.getAttribute("success");
    
    String hoTen = (String) request.getAttribute("hoTen");
    String email = (String) request.getAttribute("email");
    String soDT = (String) request.getAttribute("soDT");
    String tenDangNhap = (String) request.getAttribute("tenDangNhap");

    if (hoTen == null) hoTen = "";
    if (email == null) email = "";
    if (soDT == null) soDT = "";
    if (tenDangNhap == null) tenDangNhap = "";
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký - KT Store</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/login.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <div class="login-page">
        <div class="left-side">
            <div class="illustration-wrapper">
                <img src="${pageContext.request.contextPath}/image/49668abf44a0f8d56f5221eec31f5edcc6766e6e.jpg" alt="KT Store Illustration" class="illustration">
            </div>
            <h2 class="welcome-text">Tạo tài khoản mới<br>để trải nghiệm tốt nhất</h2>
            <a href="${pageContext.request.contextPath}/views/index.jsp" class="back-home">
                <span class="arrow">←</span> Trang chủ
            </a>
        </div>
        
        <div class="right-side">
            <div class="form-wrapper">
                <% if (message != null && !message.isEmpty()) { %>
                    <div class="alert alert-success"><%= message %></div>
                <% } %>
                <% if (error != null && !error.isEmpty()) { %>
                    <div class="alert alert-error"><%= error %></div>
                <% } %>
                
                <form method="post" action="${pageContext.request.contextPath}/register" class="login-form">
                    <div class="form-group">
                        <input type="text" name="hoTen" placeholder="Nhập họ và tên" required value="<%= hoTen %>">
                    </div>
                    
                    <div class="form-group">
                        <input type="email" name="email" placeholder="Email" required value="<%= email %>" pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$">
                    </div>
                    
                    <div class="form-group">
                        <input type="tel" name="soDT" placeholder="Số điện thoại" required value="<%= soDT %>" pattern="[0-9]{10}" title="Số điện thoại phải có 10 số">
                    </div>
                    
                    <div class="form-group">
                        <input type="text" name="tenDangNhap" placeholder="Tên đăng nhập" required value="<%= tenDangNhap %>">
                    </div>
                    
                    <div class="form-group">
                        <input type="password" name="password" placeholder="Mật khẩu" required>
                    </div>
                    
                    <div class="form-group">
                        <input type="password" name="confirmPassword" placeholder="Xác nhận mật khẩu" required>
                    </div>
                    
                    <button type="submit" class="btn-login">Đăng ký</button>
                </form>
                
                <div class="form-footer">
                    <p class="link-register">Đã có tài khoản? <a href="${pageContext.request.contextPath}/views/login.jsp">Đăng nhập</a></p>
                </div>
            </div>
        </div>
    </div>

    <!-- Success Modal -->
    <div class="modal-overlay" id="successModal">
        <div class="modal-content">
            <div class="modal-header">
                <h3>Thông báo</h3>
            </div>
            <div class="modal-body">
                <div class="modal-icon">
                    <i class="fas fa-check-circle"></i>
                </div>
                <p id="successMessage">Đăng ký thành công! Bạn sẽ được chuyển đến trang đăng nhập sau <span id="countdown">3</span> giây...</p>
            </div>
            <div class="modal-footer">
                <button class="btn-ok" onclick="closeSuccessModal()">OK</button>
            </div>
        </div>
    </div>

    <style>
        /* Modal Styles */
        .modal-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            display: none;
            justify-content: center;
            align-items: center;
            z-index: 10000;
        }
        
        .modal-overlay.show {
            display: flex;
        }
        
        .modal-content {
            background: white;
            border-radius: 10px;
            padding: 0;
            max-width: 400px;
            width: 90%;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
            animation: modalSlideIn 0.3s ease-out;
        }
        
        @keyframes modalSlideIn {
            from {
                opacity: 0;
                transform: translateY(-50px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .modal-header {
            padding: 20px 20px 0 20px;
            text-align: center;
        }
        
        .modal-header h3 {
            margin: 0;
            color: #333;
            font-size: 18px;
        }
        
        .modal-body {
            padding: 20px;
            text-align: center;
        }
        
        .modal-icon {
            font-size: 48px;
            color: #27ae60;
            margin-bottom: 15px;
        }
        
        .modal-body p {
            margin: 10px 0;
            color: #666;
            line-height: 1.5;
        }
        
        #countdown {
            font-weight: bold;
            color: #e74c3c;
            font-size: 18px;
        }
        
        .modal-footer {
            padding: 0 20px 20px 20px;
            text-align: center;
        }
        
        .btn-ok {
            background: #27ae60;
            color: white;
            border: none;
            padding: 12px 30px;
            border-radius: 5px;
            font-size: 14px;
            font-weight: bold;
            cursor: pointer;
            transition: background 0.3s;
            min-width: 100px;
        }
        
        .btn-ok:hover {
            background: #229954;
        }
    </style>

    <script>
        // Show success modal if success message exists
        <% if (success != null && !success.isEmpty()) { %>
        document.addEventListener('DOMContentLoaded', function() {
            showSuccessModal('<%= success %>');
        });
        <% } %>
        
        function showSuccessModal(message) {
            const modal = document.getElementById('successModal');
            const messageElement = document.getElementById('successMessage');
            messageElement.innerHTML = message;
            modal.classList.add('show');
            
            // Countdown timer
            let countdown = 3;
            const countdownElement = document.getElementById('countdown');
            
            const timer = setInterval(function() {
                countdown--;
                countdownElement.textContent = countdown;
                
                if (countdown <= 0) {
                    clearInterval(timer);
                    window.location.href = '${pageContext.request.contextPath}/views/login.jsp';
                }
            }, 1000);
            
            // Auto redirect after 3 seconds (backup)
            setTimeout(function() {
                window.location.href = '${pageContext.request.contextPath}/views/login.jsp';
            }, 3000);
        }
        
        function closeSuccessModal() {
            const modal = document.getElementById('successModal');
            modal.classList.remove('show');
            // Redirect to login page
            window.location.href = '${pageContext.request.contextPath}/views/login.jsp';
        }
        
        // Close modal when clicking outside
        const successModal = document.getElementById('successModal');
        if (successModal) {
            successModal.addEventListener('click', function(e) {
                if (e.target === successModal) {
                    closeSuccessModal();
                }
            });
        }
    </script>
</body>
</html>