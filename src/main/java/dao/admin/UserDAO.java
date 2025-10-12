package dao.admin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import util.DatabaseConnection;

public class UserDAO {
    private static final String CHECK_USER_EXISTS = "SELECT MaND FROM NguoiDung WHERE MaND = ?";

    protected Connection getConnection() {
        try {
            return DatabaseConnection.getConnection();
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    public boolean userExists(int maND) {
        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement(CHECK_USER_EXISTS)) {
            ps.setInt(1, maND);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}