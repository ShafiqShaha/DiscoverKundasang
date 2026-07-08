package com.discoverkundasang.util;

import io.github.cdimascio.dotenv.Dotenv;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    private static String url;
    private static String user;
    private static String password;

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            // Attempt to load from absolute workspace path first, then relative path
            Dotenv dotenv = null;
            try {
                dotenv = Dotenv.configure()
                    .directory("C:/Sandbox/TourismProjectDK")
                    .filename("sql.env")
                    .ignoreIfMalformed()
                    .ignoreIfMissing()
                    .load();
            } catch (Exception e) {
                // Fallback to relative directory loading
                try {
                    dotenv = Dotenv.configure()
                        .filename("sql.env")
                        .ignoreIfMalformed()
                        .ignoreIfMissing()
                        .load();
                } catch (Exception ex) {
                    ex.printStackTrace();
                }
            }
            
            if (dotenv != null) {
                url = dotenv.get("DB_URL");
                user = dotenv.get("DB_USER");
                password = dotenv.get("DB_PASSWORD");
            }
            
            // Secure default fallback assignments
            if (url == null || url.trim().isEmpty()) {
                url = "jdbc:mysql://localhost:3306/discover_kundasang?useSSL=false&allowPublicKeyRetrieval=true";
            }
            if (user == null || user.trim().isEmpty()) {
                user = "root";
            }
            if (password == null) {
                password = "";
            }
            
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(url, user, password);
    }
}
