<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Test Servlet</title>
</head>
<body>
    <h1>Test ProductDetailServlet</h1>
    
    <h2>Test với sản phẩm có trong database:</h2>
    <ul>
        <li><a href="${pageContext.request.contextPath}/product-detail?product=iPhone 14 Pro Max" target="_blank">iPhone 14 Pro Max</a></li>
        <li><a href="${pageContext.request.contextPath}/product-detail?product=Samsung Galaxy S23 Ultra 256GB" target="_blank">Samsung Galaxy S23 Ultra 256GB</a></li>
        <li><a href="${pageContext.request.contextPath}/product-detail?product=Xiaomi Redmi Note 12 8GB/128GB" target="_blank">Xiaomi Redmi Note 12 8GB/128GB</a></li>
        <li><a href="${pageContext.request.contextPath}/product-detail?product=iPhone 12" target="_blank">iPhone 12</a></li>
    </ul>
    
    <h2>Test với MaSP:</h2>
    <ul>
        <li><a href="${pageContext.request.contextPath}/product-detail?maSP=1" target="_blank">MaSP=1 (iPhone 14 Pro Max)</a></li>
        <li><a href="${pageContext.request.contextPath}/product-detail?maSP=2" target="_blank">MaSP=2 (Samsung Galaxy S23 Ultra)</a></li>
        <li><a href="${pageContext.request.contextPath}/product-detail?maSP=3" target="_blank">MaSP=3 (Xiaomi Redmi Note 12)</a></li>
        <li><a href="${pageContext.request.contextPath}/product-detail?maSP=5" target="_blank">MaSP=5 (iPhone 12)</a></li>
    </ul>
    
    <h2>Test với sản phẩm không có trong database:</h2>
    <ul>
        <li><a href="${pageContext.request.contextPath}/product-detail?product=Non-existent Product" target="_blank">Non-existent Product</a></li>
        <li><a href="${pageContext.request.contextPath}/product-detail?maSP=999" target="_blank">MaSP=999 (Non-existent)</a></li>
    </ul>
    
    <h2>Test không có parameter:</h2>
    <ul>
        <li><a href="${pageContext.request.contextPath}/product-detail" target="_blank">No parameters</a></li>
    </ul>
    
    <p><strong>Hướng dẫn:</strong></p>
    <ol>
        <li>Click vào các link trên</li>
        <li>Kiểm tra console logs trong Developer Tools</li>
        <li>Xem trang product-detail có hiển thị thông tin đúng không</li>
    </ol>
</body>
</html>
