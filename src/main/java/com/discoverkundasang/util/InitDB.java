package com.discoverkundasang.util;

import io.github.cdimascio.dotenv.Dotenv;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

public class InitDB {
    public static void main(String[] args) {
        System.out.println("Starting database initialization...");
        
        Dotenv dotenv = Dotenv.configure()
            .filename("sql.env")
            .ignoreIfMalformed()
            .ignoreIfMissing()
            .load();
            
        String user = dotenv.get("DB_USER", "root");
        String password = dotenv.get("DB_PASSWORD", "");
        String rawUrl = "jdbc:mysql://localhost:3306/?useSSL=false&allowPublicKeyRetrieval=true";
        String dbName = "discover_kundasang";
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            // 1. Connect to MySQL engine to create database if not exists
            System.out.println("Connecting to MySQL to verify/create database '" + dbName + "'...");
            try (Connection conn = DriverManager.getConnection(rawUrl, user, password);
                 Statement stmt = conn.createStatement()) {
                stmt.executeUpdate("CREATE DATABASE IF NOT EXISTS " + dbName);
                System.out.println("Database '" + dbName + "' verified/created successfully.");
            }
            
            // 2. Connect to the database to create tables
            String dbUrl = "jdbc:mysql://localhost:3306/" + dbName + "?useSSL=false&allowPublicKeyRetrieval=true";
            System.out.println("Connecting to database '" + dbName + "' to initialize tables...");
            try (Connection conn = DriverManager.getConnection(dbUrl, user, password);
                 Statement stmt = conn.createStatement()) {
                
                System.out.println("Creating table 'inquiries'...");
                stmt.executeUpdate("CREATE TABLE IF NOT EXISTS inquiries (" +
                    "id INT AUTO_INCREMENT PRIMARY KEY," +
                    "name VARCHAR(100) NOT NULL," +
                    "contact_number VARCHAR(20) NOT NULL," +
                    "gender VARCHAR(20) NOT NULL," +
                    "email VARCHAR(100) NOT NULL," +
                    "source VARCHAR(50) NOT NULL," +
                    "message TEXT NOT NULL," +
                    "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP" +
                    ")");
                
                System.out.println("Creating table 'admins'...");
                stmt.executeUpdate("CREATE TABLE IF NOT EXISTS admins (" +
                    "id INT AUTO_INCREMENT PRIMARY KEY," +
                    "username VARCHAR(50) NOT NULL UNIQUE," +
                    "password VARCHAR(100) NOT NULL" +
                    ")");
                
                System.out.println("Inserting default admin credentials...");
                stmt.executeUpdate("INSERT INTO admins (username, password) " +
                    "VALUES ('admin', 'admin123') " +
                    "ON DUPLICATE KEY UPDATE username=username");
                
                System.out.println("Database initialization completed successfully!");
            }
            
        } catch (Exception e) {
            System.err.println("Error initializing database: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
