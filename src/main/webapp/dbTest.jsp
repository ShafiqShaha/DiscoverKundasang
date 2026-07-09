<%@ page import="java.sql.*, com.discoverkundasang.util.DBConnection" %>
<%
    String pageTitle = "Database Diagnostic Test";
%>

<%@ include file="includes/header.jsp" %>

<%
    String status = "Testing connection...";
    boolean connected = false;
    boolean inquiriesTableExists = false;
    boolean adminsTableExists = false;
    String error = null;
    String initStatus = null;

    // Handle initialization POST request
    if ("POST".equalsIgnoreCase(request.getMethod()) && "initialize".equals(request.getParameter("action"))) {
        Connection initConn = null;
        Statement stmt = null;
        try {
            initConn = DBConnection.getConnection();
            stmt = initConn.createStatement();
            
            // Create inquiries table
            stmt.executeUpdate("CREATE TABLE IF NOT EXISTS inquiries (" +
                "id INT AUTO_INCREMENT PRIMARY KEY," +
                "name VARCHAR(100) NOT NULL," +
                "contact_number VARCHAR(20) NOT NULL," +
                "gender VARCHAR(20) NOT NULL," +
                "email VARCHAR(100) NOT NULL," +
                "source VARCHAR(50) NOT NULL," +
                "message TEXT NOT NULL," +
                "reply_message TEXT NULL," +
                "replied_at TIMESTAMP NULL," +
                "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP" +
                ")");
                
            // Create admins table
            stmt.executeUpdate("CREATE TABLE IF NOT EXISTS admins (" +
                "id INT AUTO_INCREMENT PRIMARY KEY," +
                "username VARCHAR(50) NOT NULL UNIQUE," +
                "password VARCHAR(100) NOT NULL" +
                ")");
                
            // Insert default admin
            stmt.executeUpdate("INSERT INTO admins (username, password) " +
                "VALUES ('admin', 'admin123') " +
                "ON DUPLICATE KEY UPDATE username=username");
                
            // Seed inquiries table if it is currently empty
            ResultSet checkRs = stmt.executeQuery("SELECT COUNT(*) FROM inquiries");
            checkRs.next();
            int count = checkRs.getInt(1);
            checkRs.close();
            
            if (count == 0) {
                stmt.executeUpdate("INSERT INTO inquiries (name, contact_number, gender, email, source, message, reply_message, replied_at, created_at) VALUES " +
                    "('Alif Daniel', '+6012-3456789', 'Male', 'alif.daniel@gmail.com', 'Social Media', 'Hello, I want to book the Mountain Pine Resort from July 10th to 12th. Is it available?', NULL, NULL, '2026-07-04 10:00:00')," +
                    "('Siti Aminah', '+6019-8765432', 'Female', 'siti.aminah@gmail.com', 'Search Engine', 'What is the best time to see Mount Kinabalu without cloud cover? Thank you.', 'We highly recommend visiting early in the morning between 6:00 AM and 8:30 AM for the clearest views of the peak. Clouds usually form by mid-morning!', '2026-07-03 16:00:00', '2026-07-03 14:30:00')," +
                    "('Johnathan Doe', '+6011-2345678', 'Male', 'john.doe@gmail.com', 'Friend or Family', 'Awesome website! The gallery photos of Kundasang are absolutely breathtaking.', NULL, NULL, '2026-07-01 09:15:00')," +
                    "('Raziq Ramli', '+6013-4567890', 'Prefer not to say', 'raziq.ramli@gmail.com', 'Newspaper or Magazine', 'Do you offer customizable tour guide packages for groups of 10 people?', NULL, NULL, '2026-06-28 17:45:00')," +
                    "('Farhan Nordin', '+6014-9871234', 'Male', 'farhan.nordin@gmail.com', 'Social Media', 'Is there any public transport from Kota Kinabalu to Kundasang? Or do we need to hire a car?', 'We strongly recommend renting a car or hiring a private driver. Public transport options to Kundasang are very limited and not flexible.', '2026-06-25 14:00:00', '2026-06-25 11:30:00')," +
                    "('Jessica Wong', '+6017-3344556', 'Female', 'jessica.wong@gmail.com', 'Search Engine', 'Are the walking trails around Desa Dairy Farm wheelchair accessible? Planning to bring my grandparents.', NULL, NULL, '2026-06-22 09:00:00')," +
                    "('Muhammad Syahmi', '+6018-8765431', 'Male', 'syahmi.yusof@gmail.com', 'Friend or Family', 'What is the entrance fee for the Kundasang War Memorial? Do we need to book tickets online?', 'The ticket fee is RM4 for Malaysian adults and RM10 for international visitors. You can purchase them directly at the entrance counter.', '2026-06-20 16:30:00', '2026-06-20 15:20:00')," +
                    "('Nurul Aishah', '+6016-5544332', 'Female', 'nurulaishah@gmail.com', 'Newspaper or Magazine', 'Is it possible to view Mount Kinabalu clearly from the Umea Glam stay?', NULL, NULL, '2026-06-18 08:45:00')," +
                    "('Logesh Kumar', '+6015-9988776', 'Male', 'logesh.kumar@gmail.com', 'Social Media', 'Do we need warm clothing for a stay in Kundasang during July? What is the average night temperature?', NULL, NULL, '2026-06-15 19:10:00')");
            }
                
            initStatus = "Database tables initialized successfully!";
        } catch (Exception e) {
            initStatus = "Failed to initialize tables: " + e.getMessage();
        } finally {
            if (stmt != null) try { stmt.close(); } catch (Exception e) {}
            if (initConn != null) try { initConn.close(); } catch (Exception e) {}
        }
    }

    // Run connection checks and query tables status
    Connection testConn = null;
    try {
        testConn = DBConnection.getConnection();
        connected = true;
        status = "Connected successfully to MySQL!";
        
        DatabaseMetaData dbm = testConn.getMetaData();
        
        // Check inquiries table
        ResultSet tables = dbm.getTables(null, null, "inquiries", null);
        if (tables.next()) {
            inquiriesTableExists = true;
        }
        tables.close();
        
        // Check admins table
        tables = dbm.getTables(null, null, "admins", null);
        if (tables.next()) {
            adminsTableExists = true;
        }
        tables.close();
        
    } catch (Exception e) {
        status = "Connection Failed!";
        error = e.getMessage();
    } finally {
        if (testConn != null) try { testConn.close(); } catch (Exception e) {}
    }
%>

<style>
    .dbtest-container {
        padding: 120px 7% 60px;
        min-height: 100vh;
        background-color: var(--bg);
    }
    .dbtest-card {
        background-color: var(--white);
        border-radius: 1.5rem;
        box-shadow: 0 10px 25px rgba(0, 0, 0, 0.05);
        padding: 40px;
        max-width: 650px;
        margin: 20px auto;
    }
    .dbtest-card h2 {
        font-size: 2rem;
        color: var(--text);
        margin-bottom: 20px;
        border-bottom: 2px solid var(--accent);
        padding-bottom: 10px;
    }
    .dbtest-card h2 span {
        color: var(--primary);
    }
    .status-badge {
        display: inline-block;
        padding: 0.5rem 1rem;
        border-radius: 2rem;
        font-weight: 600;
        font-size: 0.9rem;
        margin-bottom: 20px;
    }
    .status-connected {
        background-color: #e8f5e9;
        color: #1b5e20;
        border: 1px solid #c8e6c9;
    }
    .status-disconnected {
        background-color: #fce8e6;
        color: #c5221f;
        border: 1px solid #fad2cf;
    }
    .table-check {
        margin: 15px 0;
        display: flex;
        align-items: center;
        gap: 10px;
        font-size: 1rem;
    }
    .table-check i {
        width: 20px;
        height: 20px;
    }
    .text-success {
        color: #2ecc71;
    }
    .text-danger {
        color: #e74c3c;
    }
    .btn-init {
        margin-top: 25px;
        padding: 1rem 2rem;
        background-color: var(--primary);
        color: white;
        border-radius: 0.5rem;
        font-weight: 600;
        cursor: pointer;
        border: none;
        transition: 0.3s;
        display: inline-flex;
        align-items: center;
        gap: 8px;
    }
    .btn-init:hover {
        background-color: var(--secondary);
    }
</style>

<div class="dbtest-container">
    <div class="dbtest-card">
        <h2>Database <span>Connection Checker</span></h2>
        
        <div class="status-badge <%= connected ? "status-connected" : "status-disconnected" %>">
            Status: <%= status %>
        </div>
        
        <% if (error != null) { %>
            <div style="background-color: #fdf2f2; color: #9b1c1c; padding: 15px; border-radius: 0.5rem; margin-bottom: 20px; font-size: 0.9rem; font-family: monospace;">
                <strong>Error Details:</strong><br><%= error %>
            </div>
            
            <div style="margin-top: 20px; line-height: 1.6; color: #555;">
                <p><strong>Troubleshooting Guide:</strong></p>
                <ol style="margin-left: 20px; padding-top: 5px;">
                    <li style="margin-bottom: 8px;">Ensure your local MySQL database server is running.</li>
                    <li style="margin-bottom: 8px;">Make sure you have created the schema (e.g., run the command <code>CREATE DATABASE discover_kundasang;</code>).</li>
                    <li style="margin-bottom: 8px;">Verify that the URL, user, and password in your <a href="file:///C:/Sandbox/TourismProjectDK/sql.env">sql.env</a> match your MySQL instance credentials.</li>
                </ol>
            </div>
        <% } %>
        
        <% if (connected) { %>
            <div class="table-check">
                <i data-feather="<%= inquiriesTableExists ? "check-circle" : "x-circle" %>" class="<%= inquiriesTableExists ? "text-success" : "text-danger" %>"></i>
                <span>Table <strong>inquiries</strong>: <%= inquiriesTableExists ? "Exists" : "Not Found" %></span>
            </div>
            
            <div class="table-check">
                <i data-feather="<%= adminsTableExists ? "check-circle" : "x-circle" %>" class="<%= adminsTableExists ? "text-success" : "text-danger" %>"></i>
                <span>Table <strong>admins</strong>: <%= adminsTableExists ? "Exists" : "Not Found" %></span>
            </div>
            
            <% if (!inquiriesTableExists || !adminsTableExists) { %>
                <form action="dbTest.jsp" method="POST">
                    <input type="hidden" name="action" value="initialize">
                    <button type="submit" class="btn-init">
                        <i data-feather="database"></i>
                        Initialize Database Tables
                    </button>
                </form>
            <% } else { %>
                <p style="color: #2ecc71; font-weight: 600; margin-top: 20px; display: flex; align-items: center; gap: 8px;">
                    <i data-feather="check-circle"></i>
                    All database tables are connected and initialized correctly!
                </p>
            <% } %>
        <% } %>
        
        <% if (initStatus != null) { %>
            <div style="margin-top: 20px; padding: 15px; border-radius: 0.5rem; background-color: var(--accent); color: var(--primary); font-weight: 600;">
                <%= initStatus %>
            </div>
            <script>
                setTimeout(function() {
                    window.location.href = 'dbTest.jsp';
                }, 2000);
            </script>
        <% } %>
    </div>
</div>

<%@ include file="includes/footer.jsp" %>
