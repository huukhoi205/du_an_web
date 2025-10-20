<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Hủy session
    session.invalidate();
    
    // Redirect về trang chủ
    response.sendRedirect("index.jsp");
%>