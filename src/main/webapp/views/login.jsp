<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String error = (String) request.getAttribute("error");
    String email = (String) request.getAttribute("email");
    if (email == null) email = "";
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập - KT Store</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/login.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <div class="login-page">
        <div class="left-side">
            <div class="illustration-wrapper">
                <img src="${pageContext.request.contextPath}/image/49668abf44a0f8d56f5221eec31f5edcc6766e6e.jpg" alt="KT Store Illustration" class="illustration">
            </div>
            <h2 class="welcome-text">Chào mừng bạn<br>quay trở lại</h2>
            <a href="${pageContext.request.contextPath}/views/index.jsp" class="back-home">
                <span class="arrow">←</span> Trang chủ
            </a>
        </div>
        
        <div class="right-side">
            <div class="form-wrapper">
                <% if (error != null && !error.isEmpty()) { %>
                    <div class="alert alert-error"><%= error %></div>
                <% } %>
                
                <form method="post" action="${pageContext.request.contextPath}/login" class="login-form">
                    <input type="hidden" name="redirect" value="<%= request.getParameter("redirect") != null ? request.getParameter("redirect") : "" %>">
                    <div class="form-group">
                        <input type="text" name="email" placeholder="Email hoặc Tên đăng nhập" required value="<%= email %>">
                    </div>
                    
                    <div class="form-group">
                        <input type="password" name="password" placeholder="Mật khẩu" required>
                    </div>
                    
                    <button type="submit" class="btn-login">Đăng nhập</button>
                </form>
                
                <div class="form-footer">
                    <p class="link-register">Chưa có tài khoản? <a href="${pageContext.request.contextPath}/views/register.jsp">Đăng ký</a></p>
                    <p class="forgot-password"><a href="${pageContext.request.contextPath}/views/forgot-password.jsp">Bạn quên mật khẩu?</a></p>
                </div>
            </div>
        </div>
    </div>
</body>
</html>