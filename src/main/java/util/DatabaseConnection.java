package util;

import java.sql.*;
import java.util.Properties;
import java.io.InputStream;

public class DatabaseConnection {
    private static final String CONFIG_FILE = "..resources/db.properties";
    private static String URL;
    private static String USERNAME;
    private static String PASSWORD;
    private static String DRIVER;
    
    static {
        loadConfig();
    }
    
    private static void loadConfig() {
        try (InputStream input = DatabaseConnection.class.getResourceAsStream(CONFIG_FILE)) {
            Properties prop = new Properties();
            if (input != null) {
                prop.load(input);
                DRIVER = prop.getProperty("db.driver", "com.mysql.cj.jdbc.Driver");
                URL = prop.getProperty("db.url", "jdbc:mysql://localhost:3306/QuanLyBanDienThoai?useSSL=false&serverTimezone=UTC&characterEncoding=utf8");
                USERNAME = prop.getProperty("db.username", "root");
                PASSWORD = prop.getProperty("db.password", "");
            } else {
                // Default values if config file not found
                DRIVER = "com.mysql.cj.jdbc.Driver";
                URL = "jdbc:mysql://localhost:3306/QuanLyBanDienThoai?useSSL=false&serverTimezone=UTC&characterEncoding=utf8";
                USERNAME = "root";
                PASSWORD = "";
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Set default values on error
            DRIVER = "com.mysql.cj.jdbc.Driver";
            URL = "jdbc:mysql://localhost:3306/QuanLyBanDienThoai?useSSL=false&serverTimezone=UTC&characterEncoding=utf8";
            USERNAME = "root";
            PASSWORD = "";
        }
    }
    
    public static Connection getConnection() throws SQLException {
        try {
            Class.forName(DRIVER);
            return DriverManager.getConnection(URL, USERNAME, PASSWORD);
        } catch (ClassNotFoundException e) {
            throw new SQLException("Database driver not found: " + e.getMessage());
        }
    }
    
    public static void closeConnection(Connection conn) {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    
    public static void closeStatement(Statement stmt) {
        if (stmt != null) {
            try {
                stmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    
    public static void closeResultSet(ResultSet rs) {
        if (rs != null) {
            try {
                rs.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    
    public static void close(Connection conn, Statement stmt, ResultSet rs) {
        closeResultSet(rs);
        closeStatement(stmt);
        closeConnection(conn);
    }
}