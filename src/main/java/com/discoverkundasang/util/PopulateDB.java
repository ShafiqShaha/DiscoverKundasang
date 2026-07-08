package com.discoverkundasang.util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class PopulateDB {
    public static void main(String[] args) {
        System.out.println("Starting database population...");

        String[][] data = {
            {"Ahmad Firdaus", "+6012-3456789", "Male", "ahmad.firdaus@example.com", "Social Media", "Planning a family trip to Desa Cattle Farm. Is it crowded on weekends?"},
            {"Sarah Tan", "+6019-8765432", "Female", "sarah.tan@example.com", "Search Engine", "Would love to know if the hiking trail to Sosodikon Hill is suitable for kids."},
            {"Lingesh Rao", "+6011-2345678", "Male", "lingesh.rao@example.com", "Friend or Family", "Do the chalets have mount view balcony views available?"},
            {"Siti Aminah", "+6013-9876543", "Female", "siti.aminah@example.com", "Newspaper or Magazine", "Is there transport service from KKIA to Kundasang?"},
            {"Nicholas Wong", "+6017-6543210", "Male", "nicholas.wong@example.com", "Social Media", "Are the glamping sites cool enough at night?"},
            {"Nurul Izzah", "+6014-3210987", "Female", "nurul.izzah@example.com", "Search Engine", "How far is Mesilau from the main market?"},
            {"Aaron Raj", "+6012-9876543", "Male", "aaron.raj@example.com", "Friend or Family", "Can we barbecue at the dome camping sites?"},
            {"Mei Ling", "+6016-5432109", "Female", "mei.ling@example.com", "Other", "Is wheelchair access available in the dairy farm?"},
            {"Muhammad Danial", "+6018-7654321", "Male", "danial@example.com", "Social Media", "Best month to visit Kundasang for flower blooming?"},
            {"Chloe Lim", "+6019-3214567", "Female", "chloe.lim@example.com", "Search Engine", "We want to book 4 rooms for corporate retreat."},
            {"Suresh Kumar", "+6012-1112223", "Male", "suresh@example.com", "Friend or Family", "Is local food readily available near pine resorts?"},
            {"Fatimah Hassan", "+6015-4445556", "Female", "fatimah.h@example.com", "Newspaper or Magazine", "Do we need warm winter clothing for nights?"},
            {"Jason Chong", "+6017-7778889", "Male", "jason.chong@example.com", "Social Media", "Can I bring my pet to the cottage accommodations?"},
            {"Anis Farhana", "+6011-9998887", "Female", "anis.f@example.com", "Other", "How is the mobile signal coverage at Sosodikon?"},
            {"Derrick Teo", "+6014-5556667", "Male", "derrick@example.com", "Search Engine", "Looking for a package tour including Mount Kinabalu climbing."},
            {"Priya Nair", "+6016-2223334", "Female", "priya.nair@example.com", "Friend or Family", "Is breakfast provided at the Mountain Pine Resort?"},
            {"Hafiz Syazwan", "+6018-4443332", "Male", "hafiz.s@example.com", "Social Media", "Are drone flights allowed around the highland areas?"},
            {"Michelle Yeoh", "+6012-7776665", "Female", "michelle.y@example.com", "Search Engine", "What time does the Desa Dairy farm close?"},
            {"Kenneth Lau", "+6019-5554443", "Male", "kenneth.l@example.com", "Other", "Where can we rent a car suitable for highland slopes?"},
            {"Aishah Radzi", "+6013-2221110", "Female", "aishah.r@example.com", "Friend or Family", "We want to hold a small wedding ceremony in Kundasang."}
        };

        String sql = "INSERT INTO inquiries (name, contact_number, gender, email, source, message) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            for (String[] row : data) {
                ps.setString(1, row[0]);
                ps.setString(2, row[1]);
                ps.setString(3, row[2]);
                ps.setString(4, row[3]);
                ps.setString(5, row[4]);
                ps.setString(6, row[5]);
                ps.addBatch();
            }

            int[] results = ps.executeBatch();
            System.out.println("Successfully inserted " + results.length + " visitor inquiries into the database!");

        } catch (SQLException e) {
            System.err.println("Database insertion error: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
