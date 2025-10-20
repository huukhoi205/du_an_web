<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="util.DatabaseConnection, java.sql.*" %>
<%
    Connection conn = null;
    try {
        conn = DatabaseConnection.getConnection();
        out.println("<h2>Database Connection: SUCCESS</h2>");
        
        // Test query
        String sql = "SELECT COUNT(*) as count FROM sanpham";
        PreparedStatement stmt = conn.prepareStatement(sql);
        ResultSet rs = stmt.executeQuery();
        
        if (rs.next()) {
            int count = rs.getInt("count");
            out.println("<p>Total products in database: " + count + "</p>");
        }
        
        // List all products
        sql = "SELECT MaSP, TenSP, Gia FROM sanpham LIMIT 10";
        stmt = conn.prepareStatement(sql);
        rs = stmt.executeQuery();
        
        out.println("<h3>Products in database:</h3>");
        out.println("<ul>");
        while (rs.next()) {
            out.println("<li>MaSP: " + rs.getInt("MaSP") + " - " + rs.getString("TenSP") + " - " + rs.getBigDecimal("Gia") + "</li>");
        }
        out.println("</ul>");
        
        rs.close();
        stmt.close();
        
    } catch (Exception e) {
        out.println("<h2>Database Connection: ERROR</h2>");
        out.println("<p>Error: " + e.getMessage() + "</p>");
        e.printStackTrace();
    } finally {
        if (conn != null) {
            try { conn.close(); } catch (SQLException e) {}
        }
    }
%>
