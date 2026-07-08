package com.discoverkundasang.servlet;

import com.discoverkundasang.util.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/InquiryServlet")
public class InquiryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String name = request.getParameter("name");
        String contactNumber = request.getParameter("contact_number");
        String gender = request.getParameter("gender");
        String email = request.getParameter("email");
        String source = request.getParameter("source");
        String message = request.getParameter("message");

        // Compulsory field server-side validation
        if (name == null || name.trim().isEmpty() ||
            contactNumber == null || contactNumber.trim().isEmpty() ||
            gender == null || gender.trim().isEmpty() ||
            email == null || email.trim().isEmpty() ||
            source == null || source.trim().isEmpty() ||
            message == null || message.trim().isEmpty()) {
            
            request.getSession().setAttribute("errorMessage", "All fields are compulsory!");
            response.sendRedirect("contact.jsp");
            return;
        }

        String sql = "INSERT INTO inquiries (name, contact_number, gender, email, source, message) VALUES (?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, name.trim());
            ps.setString(2, contactNumber.trim());
            ps.setString(3, gender.trim());
            ps.setString(4, email.trim());
            ps.setString(5, source.trim());
            ps.setString(6, message.trim());
            
            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                request.getSession().setAttribute("successMessage", "Inquiry Sent Successfully!");
            } else {
                request.getSession().setAttribute("errorMessage", "Failed to submit inquiry. Please try again.");
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", "Database Error: " + e.getMessage());
        }
        
        response.sendRedirect("contact.jsp");
    }
}
