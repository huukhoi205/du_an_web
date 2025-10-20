<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Test Product Detail</title>
</head>
<body>
    <h1>Test Product Detail Links</h1>
    
    <h2>Products from Database:</h2>
    <ul>
        <li><a href="${pageContext.request.contextPath}/product-detail?product=iPhone 14 Pro Max">iPhone 14 Pro Max</a></li>
        <li><a href="${pageContext.request.contextPath}/product-detail?product=Samsung Galaxy S23 Ultra 256GB">Samsung Galaxy S23 Ultra 256GB</a></li>
        <li><a href="${pageContext.request.contextPath}/product-detail?product=Xiaomi Redmi Note 12 8GB/128GB">Xiaomi Redmi Note 12 8GB/128GB</a></li>
        <li><a href="${pageContext.request.contextPath}/product-detail?product=iPhone 12">iPhone 12</a></li>
    </ul>
    
    <h2>Test by MaSP:</h2>
    <ul>
        <li><a href="${pageContext.request.contextPath}/product-detail?maSP=1">Product MaSP=1</a></li>
        <li><a href="${pageContext.request.contextPath}/product-detail?maSP=2">Product MaSP=2</a></li>
        <li><a href="${pageContext.request.contextPath}/product-detail?maSP=3">Product MaSP=3</a></li>
        <li><a href="${pageContext.request.contextPath}/product-detail?maSP=5">Product MaSP=5</a></li>
    </ul>
    
    <h2>Test Non-existent Product:</h2>
    <ul>
        <li><a href="${pageContext.request.contextPath}/product-detail?product=Non-existent Product">Non-existent Product</a></li>
    </ul>
</body>
</html>
