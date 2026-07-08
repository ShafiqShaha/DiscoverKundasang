-- ==========================================================
-- CSC584 INDIVIDUAL ASSIGNMENT - TOURISM IN MALAYSIA
-- DATABASE CONFIGURATION SCRIPT (MYSQL)
-- ==========================================================

-- 1. Create and select the database
CREATE DATABASE IF NOT EXISTS discover_kundasang;
USE discover_kundasang;

-- 2. Create inquiries table to store visitor form submissions
CREATE TABLE IF NOT EXISTS inquiries (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    contact_number VARCHAR(20) NOT NULL,
    gender VARCHAR(20) NOT NULL,
    email VARCHAR(100) NOT NULL,
    source VARCHAR(50) NOT NULL,
    message TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3. Create admins table for secure system logins
CREATE TABLE IF NOT EXISTS admins (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL
);

-- 4. Pre-insert the default administrator credentials
INSERT INTO admins (username, password) 
VALUES ('admin', 'admin123') 
ON DUPLICATE KEY UPDATE username=username;
