package util;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

/**
 * DatabaseConnection dùng chung cho toàn bộ DAO.
 * Đọc cấu hình từ file resources/db.properties
 */
public class DatabaseConnection {
    private static String url;
    private static String username;
    private static String password;
    private static String driverClassName;

    static {
        try (InputStream input = DatabaseConnection.class.getClassLoader()
                .getResourceAsStream("db.properties")) {
            Properties prop = new Properties();
            if (input != null) {
                prop.load(input);
                driverClassName = prop.getProperty("db.driverClassName");
                url = prop.getProperty("db.url");
                username = prop.getProperty("db.username");
                password = prop.getProperty("db.password");
                Class.forName(driverClassName);
            } else {
                throw new RuntimeException("Không tìm thấy db.properties");
            }
        } catch (IOException | ClassNotFoundException ex) {
            ex.printStackTrace();
            throw new ExceptionInInitializerError(ex);
        }
    }
    public static Connection getConnection() throws SQLException {
        Connection conn = DriverManager.getConnection(url, username, password);
        System.out.println("DB connected: " + conn.isValid(1)); // True nếu kết nối OK
        
        // Ensure UTF-8 encoding for the connection
        try {
            conn.createStatement().execute("SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci");
            conn.createStatement().execute("SET CHARACTER SET utf8mb4");
        } catch (SQLException e) {
            System.err.println("Warning: Could not set UTF-8 encoding: " + e.getMessage());
        }
        
        return conn;
    }
    
    public static void close(Connection conn, java.sql.Statement stmt, java.sql.ResultSet rs) {
        try {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public static void closeResultSet(java.sql.ResultSet rs) {
        try {
            if (rs != null) rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public static void closeStatement(java.sql.Statement stmt) {
        try {
            if (stmt != null) stmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public static void closeConnection(Connection conn) {
        try {
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
