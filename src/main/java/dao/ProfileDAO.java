package dao;

import model.UserProfile;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import util.DatabaseConnection;

public class ProfileDAO {
    
    /**
     * Lấy thông tin người dùng theo ID
     */
    public UserProfile getUserById(int userId) {
        UserProfile user = null;
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM nguoidung WHERE MaND = ?";
            System.out.println("ProfileDAO.getUserById - SQL: " + sql + ", userId: " + userId);
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            rs = stmt.executeQuery();
            
            System.out.println("ProfileDAO.getUserById - Executing query for userId: " + userId);
            
            if (rs.next()) {
                user = new UserProfile();
                user.setMaND(rs.getInt("MaND"));
                user.setHoTen(rs.getString("HoTen"));
                user.setEmail(rs.getString("Email"));
                user.setSoDT(rs.getString("SoDT"));
                user.setDiaChi(rs.getString("DiaChi"));
                // NgaySinh, GioiTinh, VaiTro không có trong bảng nguoidung
                user.setNgaySinh(null);
                user.setGioiTinh(null);
                user.setVaiTro("KhachHang"); // Default role
                
                System.out.println("ProfileDAO.getUserById - Raw data from database:");
                System.out.println("  - MaND: " + rs.getInt("MaND"));
                System.out.println("  - HoTen: " + rs.getString("HoTen"));
                System.out.println("  - Email: " + rs.getString("Email"));
                System.out.println("  - SoDT: " + rs.getString("SoDT"));
                System.out.println("  - DiaChi: " + rs.getString("DiaChi"));
                System.out.println("ProfileDAO.getUserById - User found: " + user.getHoTen() + ", " + user.getEmail() + ", " + user.getSoDT());
            } else {
                System.out.println("ProfileDAO.getUserById - No user found with MaND: " + userId);
                
                // Debug: Kiểm tra tất cả user trong bảng nguoidung
                System.out.println("ProfileDAO.getUserById - Checking all users in nguoidung table:");
                try {
                    PreparedStatement debugStmt = conn.prepareStatement("SELECT MaND, HoTen, Email, SoDT FROM nguoidung");
                    ResultSet debugRs = debugStmt.executeQuery();
                    while (debugRs.next()) {
                        System.out.println("  - MaND: " + debugRs.getInt("MaND") + 
                                         ", HoTen: " + debugRs.getString("HoTen") + 
                                         ", Email: " + debugRs.getString("Email") + 
                                         ", SoDT: " + debugRs.getString("SoDT"));
                    }
                    debugRs.close();
                    debugStmt.close();
                } catch (SQLException e) {
                    System.err.println("Error checking all users: " + e.getMessage());
                }
                
                // Debug: Kiểm tra user ID 18 trong bảng taikhoan
                System.out.println("ProfileDAO.getUserById - Checking user ID " + userId + " in taikhoan table:");
                try {
                    PreparedStatement debugStmt2 = conn.prepareStatement("SELECT MaND, TenDangNhap, VaiTro FROM taikhoan WHERE MaND = ?");
                    debugStmt2.setInt(1, userId);
                    ResultSet debugRs2 = debugStmt2.executeQuery();
                    if (debugRs2.next()) {
                        System.out.println("  - Found in taikhoan: MaND=" + debugRs2.getInt("MaND") + 
                                         ", TenDangNhap=" + debugRs2.getString("TenDangNhap") + 
                                         ", VaiTro=" + debugRs2.getString("VaiTro"));
                    } else {
                        System.out.println("  - User ID " + userId + " not found in taikhoan table");
                    }
                    debugRs2.close();
                    debugStmt2.close();
                } catch (SQLException e) {
                    System.err.println("Error checking user in taikhoan: " + e.getMessage());
                }
                
                // Thử tạo user từ thông tin trong bảng taikhoan
                user = createUserFromTaikhoan(userId);
                if (user != null) {
                    System.out.println("ProfileDAO.getUserById - Created user from taikhoan table: " + user.getHoTen());
                }
            }
            
        } catch (SQLException e) {
            System.err.println("Error getting user profile: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DatabaseConnection.close(conn, stmt, rs);
        }
        
        return user;
    }
    
    /**
     * Tạo user từ thông tin trong bảng taikhoan nếu chưa có trong nguoidung
     */
    private UserProfile createUserFromTaikhoan(int userId) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = DatabaseConnection.getConnection();
            // Lấy thông tin từ bảng taikhoan
            String sql = "SELECT TenDangNhap, VaiTro FROM taikhoan WHERE MaND = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                String tenDangNhap = rs.getString("TenDangNhap");
                String vaiTro = rs.getString("VaiTro");
                
                // Tạo user profile với thông tin cơ bản
                UserProfile user = new UserProfile();
                user.setMaND(userId);
                user.setHoTen(tenDangNhap); // Sử dụng tên đăng nhập làm họ tên tạm thời
                user.setEmail(null);
                user.setSoDT(null);
                user.setDiaChi(null);
                user.setVaiTro(vaiTro != null ? vaiTro : "KhachHang");
                
                System.out.println("ProfileDAO.createUserFromTaikhoan - Created user with tenDangNhap: " + tenDangNhap + ", vaiTro: " + user.getVaiTro());
                return user;
            } else {
                System.out.println("ProfileDAO.createUserFromTaikhoan - User ID " + userId + " not found in taikhoan table");
            }
            
        } catch (SQLException e) {
            System.err.println("Error creating user from taikhoan: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DatabaseConnection.close(conn, stmt, rs);
        }
        
        return null;
    }
    
    /**
     * Lấy thông tin người dùng theo tên đăng nhập (từ bảng taikhoan)
     */
    public UserProfile getUserByUserName(String userName) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = DatabaseConnection.getConnection();
            // Tìm MaND từ bảng taikhoan bằng TenDangNhap
            String sql = "SELECT n.MaND, n.HoTen, n.Email, n.SoDT, n.DiaChi " +
                        "FROM nguoidung n " +
                        "JOIN taikhoan t ON n.MaND = t.MaND " +
                        "WHERE t.TenDangNhap = ?";
            
            System.out.println("ProfileDAO.getUserByUserName - SQL: " + sql + ", userName: '" + userName + "'");
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, userName);
            rs = stmt.executeQuery();
            
            // Debug: Kiểm tra exact match
            System.out.println("ProfileDAO.getUserByUserName - Checking exact match for userName: '" + userName + "'");
            
            if (rs.next()) {
                UserProfile user = new UserProfile();
                user.setMaND(rs.getInt("MaND"));
                user.setHoTen(rs.getString("HoTen"));
                user.setEmail(rs.getString("Email"));
                user.setSoDT(rs.getString("SoDT"));
                user.setDiaChi(rs.getString("DiaChi"));
                user.setVaiTro("KhachHang");
                
                System.out.println("ProfileDAO.getUserByUserName - Raw data from JOIN query:");
                System.out.println("  - MaND: " + rs.getInt("MaND"));
                System.out.println("  - HoTen: " + rs.getString("HoTen"));
                System.out.println("  - Email: " + rs.getString("Email"));
                System.out.println("  - SoDT: " + rs.getString("SoDT"));
                System.out.println("  - DiaChi: " + rs.getString("DiaChi"));
                System.out.println("ProfileDAO.getUserByUserName - Found user by userName: " + 
                                 user.getHoTen() + ", " + user.getEmail() + ", " + user.getSoDT());
                return user;
            } else {
                System.out.println("ProfileDAO.getUserByUserName - No user found with userName: " + userName);
                
                // Debug: Kiểm tra tất cả tên đăng nhập trong taikhoan
                System.out.println("ProfileDAO.getUserByUserName - Checking all usernames in taikhoan table:");
                try {
                    PreparedStatement debugStmt = conn.prepareStatement("SELECT TenDangNhap, MaND FROM taikhoan");
                    ResultSet debugRs = debugStmt.executeQuery();
                    while (debugRs.next()) {
                        String dbUserName = debugRs.getString("TenDangNhap");
                        System.out.println("  - TenDangNhap: '" + dbUserName + "'" + 
                                         ", MaND: " + debugRs.getInt("MaND") +
                                         ", equals('" + userName + "'): " + dbUserName.equals(userName) +
                                         ", equalsIgnoreCase('" + userName + "'): " + dbUserName.equalsIgnoreCase(userName));
                    }
                    debugRs.close();
                    debugStmt.close();
                } catch (SQLException e) {
                    System.err.println("Error checking all usernames: " + e.getMessage());
                }
                
                // Debug: Kiểm tra JOIN query có hoạt động không
                System.out.println("ProfileDAO.getUserByUserName - Testing JOIN query manually:");
                try {
                    PreparedStatement debugStmt2 = conn.prepareStatement("SELECT n.MaND, n.HoTen, n.Email, n.SoDT, n.DiaChi, t.TenDangNhap " +
                                                                        "FROM nguoidung n " +
                                                                        "JOIN taikhoan t ON n.MaND = t.MaND");
                    ResultSet debugRs2 = debugStmt2.executeQuery();
                    while (debugRs2.next()) {
                        System.out.println("  - JOIN result: MaND=" + debugRs2.getInt("MaND") + 
                                         ", HoTen='" + debugRs2.getString("HoTen") + "'" +
                                         ", TenDangNhap='" + debugRs2.getString("TenDangNhap") + "'" +
                                         ", Email='" + debugRs2.getString("Email") + "'");
                    }
                    debugRs2.close();
                    debugStmt2.close();
                } catch (SQLException e) {
                    System.err.println("Error testing JOIN query: " + e.getMessage());
                }
                
                // Debug: Thử tìm với case-insensitive search
                System.out.println("ProfileDAO.getUserByUserName - Trying case-insensitive search:");
                try {
                    PreparedStatement debugStmt3 = conn.prepareStatement("SELECT n.MaND, n.HoTen, n.Email, n.SoDT, n.DiaChi " +
                                                                        "FROM nguoidung n " +
                                                                        "JOIN taikhoan t ON n.MaND = t.MaND " +
                                                                        "WHERE LOWER(t.TenDangNhap) = LOWER(?)");
                    debugStmt3.setString(1, userName);
                    ResultSet debugRs3 = debugStmt3.executeQuery();
                    if (debugRs3.next()) {
                        System.out.println("  - Found with case-insensitive search: MaND=" + debugRs3.getInt("MaND") + 
                                         ", HoTen='" + debugRs3.getString("HoTen") + "'");
                    } else {
                        System.out.println("  - No match even with case-insensitive search");
                    }
                    debugRs3.close();
                    debugStmt3.close();
                } catch (SQLException e) {
                    System.err.println("Error testing case-insensitive search: " + e.getMessage());
                }
            }
            
        } catch (SQLException e) {
            System.err.println("Error getting user by userName: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DatabaseConnection.close(conn, stmt, rs);
        }
        
        return null;
    }
    
    /**
     * Lấy thông tin user trực tiếp từ bảng taikhoan bằng MaND
     */
    public UserProfile getUserFromTaikhoan(int maND) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT MaND, TenDangNhap, VaiTro FROM taikhoan WHERE MaND = ?";
            
            System.out.println("ProfileDAO.getUserFromTaikhoan - SQL: " + sql + ", maND: " + maND);
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, maND);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                UserProfile user = new UserProfile();
                user.setMaND(rs.getInt("MaND"));
                user.setHoTen(rs.getString("TenDangNhap")); // Sử dụng TenDangNhap làm HoTen
                user.setEmail(null);
                user.setSoDT(null);
                user.setDiaChi(null);
                user.setVaiTro(rs.getString("VaiTro"));
                
                System.out.println("ProfileDAO.getUserFromTaikhoan - Found user in taikhoan: " + 
                                 "MaND=" + user.getMaND() + 
                                 ", TenDangNhap=" + user.getHoTen() + 
                                 ", VaiTro=" + user.getVaiTro());
                return user;
            } else {
                System.out.println("ProfileDAO.getUserFromTaikhoan - No user found with MaND: " + maND);
            }
            
        } catch (SQLException e) {
            System.err.println("Error getting user from taikhoan: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DatabaseConnection.close(conn, stmt, rs);
        }
        
        return null;
    }
    
    /**
     * Lấy MaND từ tên đăng nhập
     */
    public Integer getMaNDByUserName(String userName) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT MaND FROM taikhoan WHERE TenDangNhap = ?";
            
            System.out.println("ProfileDAO.getMaNDByUserName - SQL: " + sql + ", userName: " + userName);
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, userName);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                int maND = rs.getInt("MaND");
                System.out.println("ProfileDAO.getMaNDByUserName - Found MaND: " + maND + " for userName: " + userName);
                return maND;
            } else {
                System.out.println("ProfileDAO.getMaNDByUserName - No MaND found for userName: " + userName);
                
                // Debug: Kiểm tra tất cả tên đăng nhập trong taikhoan
                System.out.println("ProfileDAO.getMaNDByUserName - Checking all usernames in taikhoan table:");
                try {
                    PreparedStatement debugStmt = conn.prepareStatement("SELECT TenDangNhap, MaND FROM taikhoan");
                    ResultSet debugRs = debugStmt.executeQuery();
                    while (debugRs.next()) {
                        System.out.println("  - TenDangNhap: '" + debugRs.getString("TenDangNhap") + "'" + 
                                         ", MaND: " + debugRs.getInt("MaND"));
                    }
                    debugRs.close();
                    debugStmt.close();
                } catch (SQLException e) {
                    System.err.println("Error checking all usernames: " + e.getMessage());
                }
            }
            
        } catch (SQLException e) {
            System.err.println("Error getting MaND by userName: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DatabaseConnection.close(conn, stmt, rs);
        }
        
        return null;
    }
    
    /**
     * Cập nhật thông tin người dùng
     */
    public boolean updateUserProfile(UserProfile user) {
        Connection conn = null;
        PreparedStatement stmt = null;
        
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "UPDATE nguoidung SET HoTen = ?, Email = ?, SoDT = ?, DiaChi = ? WHERE MaND = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, user.getHoTen());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getSoDT());
            stmt.setString(4, user.getDiaChi());
            stmt.setInt(5, user.getMaND());
            
            int result = stmt.executeUpdate();
            return result > 0;
            
        } catch (SQLException e) {
            System.err.println("Error updating user profile: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            DatabaseConnection.close(conn, stmt, null);
        }
    }
    
    /**
     * Kiểm tra email đã tồn tại chưa (trừ user hiện tại)
     */
    public boolean isEmailExists(String email, int currentUserId) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT COUNT(*) FROM nguoidung WHERE Email = ? AND MaND != ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            stmt.setInt(2, currentUserId);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
            
        } catch (SQLException e) {
            System.err.println("Error checking email: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DatabaseConnection.close(conn, stmt, rs);
        }
        
        return false;
    }
    
    /**
     * Kiểm tra số điện thoại đã tồn tại chưa (trừ user hiện tại)
     */
    public boolean isPhoneExists(String phone, int currentUserId) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT COUNT(*) FROM nguoidung WHERE SoDT = ? AND MaND != ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, phone);
            stmt.setInt(2, currentUserId);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
            
        } catch (SQLException e) {
            System.err.println("Error checking phone: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DatabaseConnection.close(conn, stmt, rs);
        }
        
        return false;
    }
}
