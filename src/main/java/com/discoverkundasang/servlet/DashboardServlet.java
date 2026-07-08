package com.discoverkundasang.servlet;

import com.discoverkundasang.util.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/DashboardServlet")
public class DashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        List<Map<String, String>> dbInquiries = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String connectionError = null;
        
        try {
            conn = DBConnection.getConnection();
            String sql = "SELECT * FROM inquiries ORDER BY created_at DESC";
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Map<String, String> row = new HashMap<>();
                row.put("id", String.valueOf(rs.getInt("id")));
                row.put("name", rs.getString("name"));
                row.put("contact_number", rs.getString("contact_number"));
                row.put("gender", rs.getString("gender"));
                row.put("email", rs.getString("email"));
                row.put("source", rs.getString("source"));
                row.put("message", rs.getString("message"));
                
                java.sql.Timestamp ts = rs.getTimestamp("created_at");
                row.put("created_at", ts != null ? ts.toString().substring(0, 19) : "-");
                
                dbInquiries.add(row);
            }
        } catch (Exception e) {
            connectionError = e.getMessage();
            e.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch (Exception e) {}
            if (ps != null) try { ps.close(); } catch (Exception e) {}
            if (conn != null) try { conn.close(); } catch (Exception e) {}
        }

        // Populate with premium demo inquiries ONLY if database is empty AND no connection error occurred
        if (dbInquiries.isEmpty() && connectionError == null) {
            Map<String, String> mock1 = new HashMap<>();
            mock1.put("id", "1");
            mock1.put("name", "Alif Daniel");
            mock1.put("contact_number", "+6012-3456789");
            mock1.put("gender", "Male");
            mock1.put("email", "alif@example.com");
            mock1.put("source", "Social Media");
            mock1.put("message", "Hello, I want to book the Mountain Pine Resort from July 10th to 12th. Is it available?");
            mock1.put("created_at", "2026-07-04 10:00:00");
            dbInquiries.add(mock1);

            Map<String, String> mock2 = new HashMap<>();
            mock2.put("id", "2");
            mock2.put("name", "Siti Aminah");
            mock2.put("contact_number", "+6019-8765432");
            mock2.put("gender", "Female");
            mock2.put("email", "siti@example.com");
            mock2.put("source", "Search Engine");
            mock2.put("message", "What is the best time to see Mount Kinabalu without cloud cover? Thank you.");
            mock2.put("created_at", "2026-07-03 14:30:00");
            dbInquiries.add(mock2);

            Map<String, String> mock3 = new HashMap<>();
            mock3.put("id", "3");
            mock3.put("name", "Johnathan Doe");
            mock3.put("contact_number", "+6011-2345678");
            mock3.put("gender", "Male");
            mock3.put("email", "john@example.com");
            mock3.put("source", "Friend or Family");
            mock3.put("message", "Awesome website! The gallery photos of Kundasang are absolutely breathtaking.");
            mock3.put("created_at", "2026-07-01 09:15:00");
            dbInquiries.add(mock3);

            Map<String, String> mock4 = new HashMap<>();
            mock4.put("id", "4");
            mock4.put("name", "Raziq Ramli");
            mock4.put("contact_number", "+6013-4567890");
            mock4.put("gender", "Prefer not to say");
            mock4.put("email", "raziq@example.com");
            mock4.put("source", "Newspaper or Magazine");
            mock4.put("message", "Do you offer customizable tour guide packages for groups of 10 people?");
            mock4.put("created_at", "2026-06-28 17:45:00");
            dbInquiries.add(mock4);
        }

        request.setAttribute("inquiries", dbInquiries);
        request.setAttribute("connectionError", connectionError);
        
        request.getRequestDispatcher("dashboard.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}
