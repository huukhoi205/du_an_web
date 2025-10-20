package util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class MD5Util {
    
    /**
     * Mã hóa chuỗi bằng thuật toán MD5
     * @param input - Chuỗi cần mã hóa
     * @return Chuỗi đã mã hóa MD5 (32 ký tự hex)
     */
    public static String getMD5(String input) {
        if (input == null || input.isEmpty()) {
            return "";
        }
        
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            byte[] messageDigest = md.digest(input.getBytes());
            
            StringBuilder hexString = new StringBuilder();
            for (byte b : messageDigest) {
                String hex = Integer.toHexString(0xFF & b);
                if (hex.length() == 1) {
                    hexString.append('0');
                }
                hexString.append(hex);
            }
            
            return hexString.toString();
            
        } catch (NoSuchAlgorithmException e) {
            System.out.println("MD5 Algorithm not found: " + e.getMessage());
            e.printStackTrace();
            return "";
        }
    }
    
    /**
     * Kiểm tra mật khẩu có khớp với hash không
     * @param password - Mật khẩu gốc
     * @param hash - Hash MD5 cần kiểm tra
     * @return true nếu khớp, false nếu không
     */
    public static boolean verifyPassword(String password, String hash) {
        String hashedPassword = getMD5(password);
        return hashedPassword.equals(hash);
    }
}