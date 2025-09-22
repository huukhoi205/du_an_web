<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="util.DatabaseConnection"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.SQLException"%>
<!DOCTYPE html>
<html>
<head>
    <title>Kiểm tra kết nối cơ sở dữ liệu</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/cssadmin/admin-common.css">
</head>
<body>
<div class="admin-container">
    <h1>Kiểm tra kết nối cơ sở dữ liệu</h1>
    <%
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String errorMessage = null;
        int categoryCount = 0;

        try {
            // Thử kết nối
            conn = DatabaseConnection.getConnection();
            out.println("<p>Kết nối thành công đến database: " + conn.getCatalog() + "</p>");

            // Truy vấn đơn giản để lấy số lượng danh mục
            String sql = "SELECT COUNT(*) AS count FROM danhmuc";
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            if (rs.next()) {
                categoryCount = rs.getInt("count");
                out.println("<p>Số lượng danh mục trong bảng danhmuc: " + categoryCount + "</p>");
            } else {
                out.println("<p>Không có dữ liệu trong bảng danhmuc.</p>");
            }
        } catch (SQLException e) {
            errorMessage = "Lỗi kết nối hoặc truy vấn: " + e.getMessage();
            out.println("<p style='color: red;'>" + errorMessage + "</p>");
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                out.println("<p style='color: red;'>Lỗi khi đóng kết nối: " + e.getMessage() + "</p>");
            }
        }
    %>
    <p><a href="${pageContext.request.contextPath}/admin/category/list" class="btn">Quay lại danh sách danh mục</a></p>
</div>
</body>
</html>