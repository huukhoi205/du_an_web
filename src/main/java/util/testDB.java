package util;

import java.sql.Connection;

public class testDB {
    public static void main(String[] args) {
        try {
            Connection conn = DatabaseConnection.getConnection();
            System.out.println(" Kết nối thành công!");
            conn.close();
        } catch (Exception e) {
            System.out.println(" Kết nối thất bại: " + e.getMessage());
        }
    }
}