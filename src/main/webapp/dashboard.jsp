<%
    // Session check - must be logged in to view dashboard
    String user = (String) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    // Retrieve inquiries and connectionError from request attributes
    java.util.List<java.util.Map<String, String>> dbInquiries = 
        (java.util.List<java.util.Map<String, String>>) request.getAttribute("inquiries");
    String connectionError = (String) request.getAttribute("connectionError");

    // If accessed directly without going through DashboardServlet, redirect to it
    if (dbInquiries == null) {
        response.sendRedirect("DashboardServlet");
        return;
    }
    
    String pageTitle = "Dashboard";
%>

<%@ include file="includes/header.jsp" %>

<!-- Load DataTables Stylesheet and jQuery -->
<link rel="stylesheet" href="https://cdn.datatables.net/1.13.5/css/jquery.dataTables.min.css">
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<script src="https://cdn.datatables.net/1.13.5/js/jquery.dataTables.min.js"></script>

<style>
    /* Dashboard Page Styles */
    /* Dashboard Page Styles */
    .dashboard-container {
        padding: 140px 7% 80px;
        min-height: 100vh;
        background-image: linear-gradient(rgba(14, 23, 15, 0.88), rgba(20, 28, 21, 0.94)), url("img/gallery/gallery1-new.jpg?v=3");
        background-attachment: fixed;
        background-size: cover;
        background-position: center;
        position: relative;
    }

    .dashboard-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 40px;
        flex-wrap: wrap;
        gap: 20px;
    }

    .dashboard-header h2 {
        font-size: 2.5rem;
        color: var(--white);
    }

    .dashboard-header h2 span {
        color: #d2e3c8;
    }

    .dashboard-header p {
        color: #e2e8f0;
    }

    .logout-btn {
        padding: 0.8rem 1.6rem;
        background-color: #c5221f;
        color: white;
        border-radius: 0.6rem;
        font-weight: 600;
        display: flex;
        align-items: center;
        gap: 8px;
        transition: 0.3s;
        box-shadow: 0 4px 15px rgba(197, 34, 31, 0.2);
    }

    .logout-btn:hover {
        background-color: #a51b18;
        transform: translateY(-2px);
        box-shadow: 0 8px 20px rgba(197, 34, 31, 0.35);
    }

    /* Stats Grid */
    .stats-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
        gap: 25px;
        margin-bottom: 40px;
    }

    .stat-card {
        background: rgba(255, 255, 255, 0.06); /* Translucent glass */
        backdrop-filter: blur(12px);
        -webkit-backdrop-filter: blur(12px);
        border: 1px solid rgba(255, 255, 255, 0.1);
        padding: 25px;
        border-radius: 1.2rem;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
        display: flex;
        align-items: center;
        gap: 20px;
        transition: transform 0.3s cubic-bezier(0.16, 1, 0.3, 1), border-color 0.3s;
    }

    .stat-card:hover {
        transform: translateY(-4px);
        border-color: rgba(210, 227, 200, 0.25);
        box-shadow: 0 15px 35px rgba(0, 0, 0, 0.25);
    }

    .stat-icon {
        width: 60px;
        height: 60px;
        border-radius: 1rem;
        background-color: rgba(255, 255, 255, 0.1);
        display: flex;
        justify-content: center;
        align-items: center;
        color: #d2e3c8;
        flex-shrink: 0;
        border: 1px solid rgba(255, 255, 255, 0.1);
    }

    .stat-icon i {
        width: 28px;
        height: 28px;
    }

    .stat-info {
        display: flex;
        flex-direction: column;
    }

    .stat-value {
        font-size: 1.8rem;
        font-weight: 700;
        color: var(--white);
    }

    .stat-label {
        font-size: 0.9rem;
        color: #ccd7cc;
        margin-top: 2px;
    }

    /* Table & Content Section */
    .dashboard-content {
        background: rgba(255, 255, 255, 0.08); /* glassmorphic translucent white */
        backdrop-filter: blur(16px);
        -webkit-backdrop-filter: blur(16px);
        border: 1px solid rgba(255, 255, 255, 0.12);
        border-radius: 1.5rem;
        box-shadow: 0 30px 60px rgba(0, 0, 0, 0.25);
        padding: 30px;
        overflow: hidden;
    }

    .content-title {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 25px;
        border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        padding-bottom: 15px;
    }

    .content-title h3 {
        font-size: 1.4rem;
        color: var(--white);
        display: flex;
        align-items: center;
        gap: 8px;
    }

    .content-title h3 i {
        color: #d2e3c8;
    }

    .table-container {
        width: 100%;
        overflow-x: auto;
        padding: 5px;
    }

    table.dataTable {
        width: 100% !important;
        border-collapse: separate !important;
        border-spacing: 0 12px !important;
        text-align: left;
        margin-top: 15px !important;
        margin-bottom: 15px !important;
    }

    table.dataTable thead th {
        padding: 14px 35px 14px 20px !important; /* Extra padding on the right for sort indicators */
        background-color: transparent !important;
        color: #d2e3c8 !important;
        font-weight: 700 !important;
        font-size: 0.8rem !important;
        text-transform: uppercase !important;
        letter-spacing: 1.5px !important;
        border-bottom: 2px solid #d2e3c8 !important;
        position: relative !important;
        cursor: pointer !important;
        transition: color 0.2s ease;
    }

    table.dataTable thead th:hover {
        color: var(--white) !important;
    }

    /* Style the sorting arrows to be clear, visible, and modern */
    table.dataTable thead th.sorting::before,
    table.dataTable thead th.sorting_asc::before,
    table.dataTable thead th.sorting_desc::before {
        right: 15px !important;
        content: "▲" !important;
        font-size: 0.6rem !important;
        color: #d2e3c8 !important;
        opacity: 0.25 !important;
        transition: opacity 0.3s ease;
    }
    table.dataTable thead th.sorting::after,
    table.dataTable thead th.sorting_asc::after,
    table.dataTable thead th.sorting_desc::after {
        right: 15px !important;
        content: "▼" !important;
        font-size: 0.6rem !important;
        color: #d2e3c8 !important;
        opacity: 0.25 !important;
        transition: opacity 0.3s ease;
    }
    
    /* Highlight the active sorting direction */
    table.dataTable thead th.sorting_asc::before {
        opacity: 1 !important;
    }
    table.dataTable thead th.sorting_desc::after {
        opacity: 1 !important;
    }

    table.dataTable tbody tr {
        background-color: rgba(255, 255, 255, 0.05) !important;
        border-radius: 12px !important;
        transition: all 0.3s cubic-bezier(0.16, 1, 0.3, 1);
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
    }

    table.dataTable tbody tr:hover {
        transform: translateY(-3px);
        box-shadow: 0 12px 24px rgba(0, 0, 0, 0.3);
        background-color: rgba(255, 255, 255, 0.09) !important;
    }

    table.dataTable tbody td {
        padding: 18px 20px !important;
        border: none !important;
        font-size: 0.95rem !important;
        color: #e2e8f0 !important;
        vertical-align: middle !important;
        background-color: transparent !important;
    }

    table.dataTable tbody td:first-child {
        border-top-left-radius: 12px !important;
        border-bottom-left-radius: 12px !important;
        border-left: 1px solid rgba(255, 255, 255, 0.05) !important;
        position: relative;
    }

    table.dataTable tbody td:last-child {
        border-top-right-radius: 12px !important;
        border-bottom-right-radius: 12px !important;
        border-right: 1px solid rgba(255, 255, 255, 0.05) !important;
    }

    /* Left green accent bar on hover */
    table.dataTable tbody tr:hover td:first-child::before {
        content: '';
        position: absolute;
        left: 0;
        top: 15%;
        height: 70%;
        width: 4px;
        background-color: #d2e3c8;
        border-radius: 0 4px 4px 0;
    }

    /* Custom DataTables Style Override to Match Site Theme */
    .dataTables_wrapper .dataTables_paginate {
        margin-top: 20px !important;
        padding-top: 15px !important;
    }

    .dataTables_wrapper .dataTables_paginate .paginate_button {
        border-radius: 0.5rem !important;
        padding: 0.55rem 1.1rem !important;
        margin: 0 4px !important;
        border: 1px solid rgba(255, 255, 255, 0.15) !important;
        background: rgba(255, 255, 255, 0.05) !important;
        color: #e2e8f0 !important;
        font-size: 0.85rem !important;
        font-weight: 550 !important;
        transition: all 0.3s cubic-bezier(0.16, 1, 0.3, 1) !important;
        box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    }

    .dataTables_wrapper .dataTables_paginate .paginate_button.current, 
    .dataTables_wrapper .dataTables_paginate .paginate_button.current:hover {
        background: var(--primary) !important;
        color: white !important;
        border-color: var(--primary) !important;
        box-shadow: 0 6px 12px rgba(79, 111, 82, 0.25) !important;
    }

    .dataTables_wrapper .dataTables_paginate .paginate_button:hover {
        background: rgba(255, 255, 255, 0.12) !important;
        color: #d2e3c8 !important;
        border-color: #d2e3c8 !important;
        transform: translateY(-1px);
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
    }

    .dataTables_wrapper .dataTables_paginate .paginate_button.disabled,
    .dataTables_wrapper .dataTables_paginate .paginate_button.disabled:hover {
        background: rgba(255, 255, 255, 0.02) !important;
        color: rgba(255, 255, 255, 0.2) !important;
        border-color: rgba(255, 255, 255, 0.05) !important;
        box-shadow: none;
        transform: none;
        cursor: not-allowed !important;
    }

    .dataTables_wrapper .dataTables_filter input {
        border: 1.5px solid rgba(255, 255, 255, 0.15) !important;
        border-radius: 2rem !important;
        padding: 0.6rem 1.4rem !important;
        margin-left: 0.5em !important;
        outline: none !important;
        font-family: inherit;
        font-size: 0.9rem !important;
        background-color: rgba(255, 255, 255, 0.05) !important;
        transition: all 0.3s cubic-bezier(0.16, 1, 0.3, 1);
        width: 250px;
        color: var(--white) !important;
        box-shadow: inset 0 2px 4px rgba(0,0,0,0.1);
    }

    .dataTables_wrapper .dataTables_filter input:focus {
        border-color: #d2e3c8 !important;
        background-color: rgba(255, 255, 255, 0.1) !important;
        box-shadow: 0 0 0 4px rgba(210, 227, 200, 0.18), inset 0 2px 4px rgba(0,0,0,0.05) !important;
    }

    .dataTables_wrapper .dataTables_length select {
        border: 1.5px solid rgba(255, 255, 255, 0.15) !important;
        border-radius: 0.5rem !important;
        padding: 0.5rem 1.5rem 0.5rem 0.8rem !important;
        outline: none !important;
        font-family: inherit;
        font-size: 0.9rem !important;
        transition: all 0.3s ease;
        cursor: pointer;
        background-color: rgba(255, 255, 255, 0.05) !important;
        color: var(--white) !important;
    }

    .dataTables_wrapper .dataTables_length select option {
        background-color: #111e12 !important;
        color: var(--white) !important;
    }

    .dataTables_wrapper .dataTables_length select:focus {
        border-color: #d2e3c8 !important;
        box-shadow: 0 0 0 3px rgba(210, 227, 200, 0.15) !important;
    }

    .dataTables_wrapper .dataTables_info,
    .dataTables_wrapper .dataTables_filter,
    .dataTables_wrapper .dataTables_length {
        color: #ccd7cc !important;
        font-size: 0.9rem !important;
        margin-bottom: 10px;
    }

    .tag {
        padding: 0.4rem 0.9rem;
        border-radius: 2rem;
        font-size: 0.78rem;
        font-weight: 600;
        display: inline-block;
        letter-spacing: 0.3px;
        box-shadow: 0 2px 6px rgba(0,0,0,0.03);
        transition: all 0.3s ease;
    }

    .tag:hover {
        transform: translateY(-1px);
        box-shadow: 0 4px 10px rgba(0,0,0,0.06);
    }

    .tag-blue {
        background-color: rgba(227, 242, 253, 0.7);
        color: #0b4b8a;
        border: 1px solid rgba(11, 75, 138, 0.15);
    }

    .tag-green {
        background-color: rgba(232, 245, 233, 0.7);
        color: #1b5e20;
        border: 1px solid rgba(27, 94, 32, 0.15);
    }

    .tag-orange {
        background-color: rgba(255, 243, 224, 0.7);
        color: #c43e00;
        border: 1px solid rgba(196, 62, 0, 0.15);
    }

    .tag-purple {
        background-color: rgba(243, 229, 245, 0.7);
        color: #5e179e;
        border: 1px solid rgba(94, 23, 158, 0.15);
    }

    @media (max-width: 768px) {
        .dashboard-container {
            padding: 100px 5% 40px;
        }
        .dashboard-header h2 {
            font-size: 2rem;
        }
    }
</style>

<div class="dashboard-container">

    <div class="dashboard-header">
        <div>
            <h2>Admin <span>Dashboard</span></h2>
            <p>Welcome back, <strong><%= user %></strong>! Here is the dynamic overview of visitor inquiries.</p>
        </div>
        <a href="LogoutServlet" class="logout-btn">
            <i data-feather="log-out"></i>
            Logout
        </a>
    </div>

    <!-- Error Banner if JDBC connection failed -->
    <% if (connectionError != null) { %>
        <div style="background-color: #fdf2f2; color: #9b1c1c; padding: 20px; border-radius: 1rem; border: 1px solid #fde8e8; margin-bottom: 30px; font-size: 0.95rem; line-height: 1.6;">
            <div style="font-weight: 700; font-size: 1.1rem; margin-bottom: 5px; display: flex; align-items: center; gap: 8px;">
                <i data-feather="alert-triangle"></i>
                Database Connection Error
            </div>
            Failed to connect to MySQL. The database could be offline or the web application container cannot locate your configuration.
            <div style="font-family: monospace; font-size: 0.85rem; margin-top: 10px; background-color: rgba(0,0,0,0.03); padding: 10px; border-radius: 0.4rem;">
                <strong>Details:</strong> <%= connectionError %>
            </div>
        </div>
    <% } %>

    <!-- Stats Cards -->
    <div class="stats-grid">
        <div class="stat-card">
            <div class="stat-icon">
                <i data-feather="mail"></i>
            </div>
            <div class="stat-info">
                <span class="stat-value"><%= dbInquiries.size() %></span>
                <span class="stat-label">Total Inquiries</span>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-icon">
                <i data-feather="users"></i>
            </div>
            <div class="stat-info">
                <span class="stat-value">
                    <% 
                        int m = 0, f = 0;
                        for (java.util.Map<String, String> inq : dbInquiries) {
                            if ("Male".equalsIgnoreCase(inq.get("gender"))) m++;
                            if ("Female".equalsIgnoreCase(inq.get("gender"))) f++;
                        }
                    %>
                    <%= m %>M / <%= f %>F
                </span>
                <span class="stat-label">Gender Ratio</span>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-icon">
                <i data-feather="eye"></i>
            </div>
            <div class="stat-info">
                <span class="stat-value">1,540</span>
                <span class="stat-label">Page Views</span>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-icon">
                <i data-feather="star"></i>
            </div>
            <div class="stat-info">
                <span class="stat-value">4.9</span>
                <span class="stat-label">Rating</span>
            </div>
        </div>
    </div>

    <!-- Contact Submissions Table -->
    <div class="dashboard-content">
        <div class="content-title">
            <h3>
                <i data-feather="list"></i>
                Visitor Inquiries (Data Table)
            </h3>
            <span style="font-size: 0.85rem; color: #777;">
                <%= connectionError != null ? "Offline Fallback Mode" : "Database Live Connected" %>
            </span>
        </div>

        <div class="table-container">
            <table id="inquiriesTable" class="display">
                <thead>
                    <tr>
                        <th>Date &amp; Time</th>
                        <th>Name</th>
                        <th>Contact Number</th>
                        <th>Gender</th>
                        <th>Email</th>
                        <th>Source Channel</th>
                        <th>Message</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (java.util.Map<String, String> inquiry : dbInquiries) { 
                        String srcClass = "tag-purple";
                        String source = inquiry.get("source");
                        if (source != null) {
                            if (source.contains("Social")) srcClass = "tag-blue";
                            else if (source.contains("Search")) srcClass = "tag-green";
                            else if (source.contains("Friend")) srcClass = "tag-orange";
                        }
                    %>
                        <tr>
                            <td><%= inquiry.get("created_at") %></td>
                            <td><strong><%= inquiry.get("name") %></strong></td>
                            <td><%= inquiry.get("contact_number") %></td>
                            <td><%= inquiry.get("gender") %></td>
                            <td><a href="mailto:<%= inquiry.get("email") %>" style="color: #d2e3c8; text-decoration: underline; text-underline-offset: 4px;"><%= inquiry.get("email") %></a></td>
                            <td><span class="tag <%= srcClass %>"><%= source %></span></td>
                            <td><%= inquiry.get("message") %></td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>

</div>

<!-- Initialize jQuery DataTable -->
<script>
    $(document).ready(function() {
        $('#inquiriesTable').DataTable({
            "order": [[ 0, "desc" ]],
            "pageLength": 5,
            "lengthMenu": [5, 10, 25, 50],
            "language": {
                "searchPlaceholder": "Search inquiries...",
                "search": ""
            }
        });
    });
</script>

<%@ include file="includes/footer.jsp" %>
