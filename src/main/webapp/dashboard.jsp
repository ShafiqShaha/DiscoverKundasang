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

    /* Custom sorting arrows */
    table.dataTable thead th.sorting::before,
    table.dataTable thead th.sorting_asc::before,
    table.dataTable thead th.sorting_desc::before,
    table.dataTable thead th.sorting::after,
    table.dataTable thead th.sorting_asc::after,
    table.dataTable thead th.sorting_desc::after {
        color: #d2e3c8 !important;
        opacity: 0.35 !important;
    }
    table.dataTable thead th.sorting_asc::before,
    table.dataTable thead th.sorting_desc::after {
        color: var(--white) !important;
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

    /* DataTable overrides */
    .dataTables_wrapper .dataTables_paginate {
        margin-top: 20px !important;
        padding-top: 15px !important;
    }

    .dataTables_wrapper .dataTables_paginate .paginate_button {
        border-radius: 0.5rem !important;
        padding: 0.55rem 1.1rem !important;
        margin: 0 4px !important;
        border: 1px solid rgba(255, 255, 255, 0.25) !important;
        background: rgba(255, 255, 255, 0.05) !important;
        color: #ffffff !important; /* Force pure white for readable text */
        font-size: 0.85rem !important;
        font-weight: 600 !important;
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
        color: rgba(255, 255, 255, 0.55) !important; /* Brightened from 0.2 to 0.55 for high contrast */
        border-color: rgba(255, 255, 255, 0.08) !important;
        box-shadow: none;
        transform: none;
        cursor: not-allowed !important;
    }

    .dataTables_wrapper .dataTables_filter input {
        border: 1.5px solid rgba(255, 255, 255, 0.3) !important; /* Brighter border */
        border-radius: 2rem !important;
        padding: 0.6rem 1.4rem !important;
        margin-left: 0.5em !important;
        outline: none !important;
        font-family: inherit;
        font-size: 0.9rem !important;
        background-color: rgba(255, 255, 255, 0.12) !important; /* Brighter background */
        transition: all 0.3s cubic-bezier(0.16, 1, 0.3, 1);
        width: 250px;
        color: #ffffff !important; /* Force solid white text */
        box-shadow: inset 0 2px 4px rgba(0,0,0,0.15);
    }
    .dataTables_wrapper .dataTables_filter input::placeholder {
        color: rgba(255, 255, 255, 0.65) !important; /* Highly visible placeholder */
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
    .dataTables_wrapper .dataTables_filter label,
    .dataTables_wrapper .dataTables_length,
    .dataTables_wrapper .dataTables_length label {
        color: var(--white) !important;
        font-weight: 500 !important;
        font-size: 0.9rem !important;
        margin-bottom: 10px;
    }
    .dataTables_wrapper .dataTables_info {
        color: #ccd7cc !important;
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

    .tag-replied {
        background-color: rgba(46, 204, 113, 0.2) !important;
        color: #2ecc71 !important;
        border: 1px solid rgba(46, 204, 113, 0.3) !important;
    }
    .tag-pending {
        background-color: rgba(241, 196, 15, 0.2) !important;
        color: #f1c40f !important;
        border: 1px solid rgba(241, 196, 15, 0.3) !important;
    }
    .action-btn {
        padding: 6px 12px;
        border-radius: 6px;
        border: 1px solid rgba(255,255,255,0.15);
        background: rgba(255,255,255,0.06);
        color: var(--white) !important;
        cursor: pointer;
        font-size: 0.82rem;
        display: inline-flex;
        align-items: center;
        gap: 6px;
        font-weight: 600;
        transition: all 0.2s ease;
    }
    .action-btn:hover {
        background: #d2e3c8;
        color: #111e12 !important;
        border-color: #d2e3c8;
        transform: translateY(-1px);
    }
    .action-btn i {
        width: 14px;
        height: 14px;
    }
    .btn-row {
        display: flex;
        gap: 8px;
        align-items: center;
    }

    /* Modal Styling */
    .reply-modal {
        display: none;
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0, 0, 0, 0.65);
        z-index: 100000;
        align-items: center;
        justify-content: center;
        backdrop-filter: blur(5px);
        -webkit-backdrop-filter: blur(5px);
    }
    .reply-modal.active {
        display: flex;
    }
    .reply-modal-content {
        background: rgba(17, 30, 18, 0.98);
        border: 2px solid rgba(210, 227, 200, 0.35);
        border-radius: 1.5rem;
        width: 90%;
        max-width: 550px;
        padding: 30px;
        color: var(--white);
        box-shadow: 0 25px 60px rgba(0,0,0,0.6);
        position: relative;
        animation: modalSlideIn 0.3s cubic-bezier(0.165, 0.84, 0.44, 1);
    }
    @keyframes modalSlideIn {
        from { opacity: 0; transform: translateY(-20px); }
        to { opacity: 1; transform: translateY(0); }
    }
    .close-modal-btn {
        position: absolute;
        top: 20px;
        right: 20px;
        background: transparent;
        border: none;
        color: #d2e3c8;
        font-size: 1.6rem;
        cursor: pointer;
        transition: color 0.2s;
    }
    .close-modal-btn:hover {
        color: var(--white);
    }
    .reply-modal-content h3 {
        font-size: 1.45rem;
        margin-bottom: 20px;
        color: #d2e3c8 !important;
        border-bottom: 1px solid rgba(255,255,255,0.12);
        padding-bottom: 12px;
    }
    .modal-field {
        margin-bottom: 16px;
        font-size: 0.95rem;
        line-height: 1.5;
        background: rgba(255,255,255,0.03);
        padding: 12px;
        border-radius: 0.8rem;
        border: 1px solid rgba(255,255,255,0.05);
    }
    .modal-field strong {
        color: #d2e3c8;
        display: inline-block;
        margin-bottom: 4px;
    }
    .modal-field p {
        color: #e2e8f0;
        font-size: 0.9rem;
    }
    .reply-textarea {
        width: 100%;
        height: 130px;
        background: rgba(255,255,255,0.06);
        border: 1.5px solid rgba(255,255,255,0.18);
        border-radius: 0.8rem;
        padding: 12px;
        color: var(--white);
        font-family: inherit;
        font-size: 0.92rem;
        outline: none;
        resize: none;
        transition: border-color 0.3s;
        box-shadow: inset 0 2px 4px rgba(0,0,0,0.1);
    }
    .reply-textarea:focus {
        border-color: #d2e3c8;
    }
    .modal-actions {
        display: flex;
        justify-content: flex-end;
        gap: 12px;
        margin-top: 20px;
    }
    .btn-cancel {
        padding: 0.7rem 1.4rem;
        background: rgba(255,255,255,0.1);
        border: 1px solid rgba(255,255,255,0.15);
        color: var(--white);
        border-radius: 0.5rem;
        font-weight: 600;
        cursor: pointer;
        transition: background 0.2s;
    }
    .btn-cancel:hover {
        background: rgba(255,255,255,0.15);
    }
    .btn-submit {
        padding: 0.7rem 1.4rem;
        background: var(--primary);
        border: none;
        color: var(--white);
        border-radius: 0.5rem;
        font-weight: 600;
        cursor: pointer;
        display: inline-flex;
        align-items: center;
        gap: 6px;
        transition: background 0.2s;
    }
    .btn-submit:hover {
        background: var(--secondary);
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
                        <th>Status</th>
                        <th>Action</th>
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
                        
                        String replyMsg = inquiry.get("reply_message");
                        boolean isReplied = replyMsg != null && !replyMsg.trim().isEmpty();

                        // Null-safe strings for attributes
                        String inqId = inquiry.get("id");
                        if (inqId == null) inqId = "";

                        String inqName = inquiry.get("name");
                        if (inqName == null) inqName = "";
                        String escapedName = inqName.replace("\"", "&quot;").replace("'", "\\'");

                        String inqEmail = inquiry.get("email");
                        if (inqEmail == null) inqEmail = "";

                        String inqMsg = inquiry.get("message");
                        if (inqMsg == null) inqMsg = "";
                        String escapedMsg = inqMsg.replace("\"", "&quot;").replace("'", "\\'").replace("\n", " ").replace("\r", " ");

                        String escapedReply = "";
                        if (isReplied) {
                            escapedReply = replyMsg.replace("\"", "&quot;").replace("'", "\\'").replace("\n", " ").replace("\r", " ");
                        }
                        
                        String repTime = inquiry.get("replied_at");
                        if (repTime == null) repTime = "";
                    %>
                        <tr>
                            <td><%= inquiry.get("created_at") != null ? inquiry.get("created_at") : "-" %></td>
                            <td><strong><%= inqName %></strong></td>
                            <td><%= inquiry.get("contact_number") != null ? inquiry.get("contact_number") : "-" %></td>
                            <td><%= inquiry.get("gender") != null ? inquiry.get("gender") : "-" %></td>
                            <td><a href="mailto:<%= inqEmail %>" style="color: #d2e3c8; text-decoration: underline; text-underline-offset: 4px;"><%= inqEmail %></a></td>
                            <td><span class="tag <%= srcClass %>"><%= source != null ? source : "-" %></span></td>
                            <td><%= inqMsg %></td>
                            <td>
                                <% if (isReplied) { %>
                                    <span class="tag tag-replied">Replied</span>
                                <% } else { %>
                                    <span class="tag tag-pending">Pending</span>
                                <% } %>
                            </td>
                            <td>
                                <div class="btn-row">
                                    <% if (isReplied) { %>
                                        <button class="action-btn view-reply-btn" 
                                                data-name="<%= escapedName %>" 
                                                data-msg="<%= escapedMsg %>" 
                                                data-reply="<%= escapedReply %>" 
                                                data-time="<%= repTime %>">
                                            <i data-feather="eye"></i> View
                                        </button>
                                    <% } else { %>
                                        <button class="action-btn reply-btn" 
                                                data-id="<%= inqId %>" 
                                                data-name="<%= escapedName %>" 
                                                data-email="<%= inqEmail %>" 
                                                data-msg="<%= escapedMsg %>">
                                            <i data-feather="corner-up-left"></i> Reply
                                        </button>
                                    <% } %>
                                </div>
                            </td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>

</div>

<!-- Initialize jQuery DataTable -->
<script>
    // Reply Modal Controls
    function openReplyModal(id, name, email, msg) {
        document.getElementById("modalInquiryId").value = id;
        document.getElementById("modalToName").innerText = name;
        document.getElementById("modalToEmail").innerText = email;
        document.getElementById("modalVisitorMsg").innerText = msg;
        document.getElementById("modalReplyText").value = "";
        
        document.getElementById("replyModal").classList.add("active");
    }
    
    function closeReplyModal() {
        document.getElementById("replyModal").classList.remove("active");
    }
    
    function handleReplySubmit(event) {
        const email = document.getElementById("modalToEmail").innerText;
        const name = document.getElementById("modalToName").innerText;
        const replyText = document.getElementById("modalReplyText").value;
        
        const subject = "Discover Kundasang Support Team - Reply to your inquiry";
        const body = "Hi " + name + ",\n\nThank you for reaching out to us.\n\nHere is our suggestion/reply to your inquiry:\n\"" + replyText + "\"\n\nPlease let us know if you need further assistance!\n\nWarm regards,\nDiscover Kundasang Admin Team";
        
        const mailtoUri = "mailto:" + email + "?subject=" + encodeURIComponent(subject) + "&body=" + encodeURIComponent(body);
        
        window.open(mailtoUri, '_blank');
    }
    
    // View Reply Modal Controls
    function openViewReplyModal(name, msg, reply, time) {
        document.getElementById("viewModalName").innerText = name;
        document.getElementById("viewModalMsg").innerText = msg;
        document.getElementById("viewModalReply").innerText = reply;
        document.getElementById("viewModalTime").innerText = time;
        
        document.getElementById("viewReplyModal").classList.add("active");
    }
    
    function closeViewReplyModal() {
        document.getElementById("viewReplyModal").classList.remove("active");
    }

    $(document).ready(      function() {
        $('#inquiriesTable').DataTable({
            "order": [[ 0, "desc" ]],
            "pageLength": 5,
            "lengthMenu": [5, 10, 25, 50],
            "language": {
                "searchPlaceholder": "Search inquiries...",
                "search": ""
            }
        });

        // Event delegation for dynamically paging table rows
        $('#inquiriesTable').on('click', '.reply-btn', function() {
            const btn = $(this);
            openReplyModal(
                btn.attr('data-id'),
                btn.attr('data-name'),
                btn.attr('data-email'),
                btn.attr('data-msg')
            );
        });

        $('#inquiriesTable').on('click', '.view-reply-btn', function() {
            const btn = $(this);
            openViewReplyModal(
                btn.attr('data-name'),
                btn.attr('data-msg'),
                btn.attr('data-reply'),
                btn.attr('data-time')
            );
        });
    });
</script>

<!-- Modal for replying to inquiries -->
<div id="replyModal" class="reply-modal">
    <div class="reply-modal-content">
        <button class="close-modal-btn" onclick="closeReplyModal()">&times;</button>
        <h3>Send Suggestion / Reply</h3>
        
        <div class="modal-field">
            <strong>To:</strong> <span id="modalToName"></span> (<span id="modalToEmail"></span>)
        </div>
        
        <div class="modal-field">
            <strong>Visitor Message:</strong>
            <p id="modalVisitorMsg"></p>
        </div>
        
        <form action="DashboardServlet" method="POST" onsubmit="handleReplySubmit(event)">
            <input type="hidden" name="action" value="reply">
            <input type="hidden" name="id" id="modalInquiryId">
            
            <label style="font-weight: 600; display: block; margin-bottom: 8px; font-size: 0.95rem; color: #d2e3c8;">Your Suggestion / Reply:</label>
            <textarea name="replyMessage" id="modalReplyText" class="reply-textarea" placeholder="Type your advice, suggestion, or answer here..." required></textarea>
            
            <div class="modal-actions">
                <button type="button" class="btn-cancel" onclick="closeReplyModal()">Cancel</button>
                <button type="submit" class="btn-submit">
                    <i data-feather="send"></i> Save &amp; Email
                </button>
            </div>
        </form>
    </div>
</div>

<!-- Modal for viewing sent replies -->
<div id="viewReplyModal" class="reply-modal">
    <div class="reply-modal-content">
        <button class="close-modal-btn" onclick="closeViewReplyModal()">&times;</button>
        <h3>Sent Suggestion / Reply</h3>
        
        <div class="modal-field">
            <strong>Visitor:</strong> <span id="viewModalName"></span>
        </div>
        
        <div class="modal-field">
            <strong>Visitor Message:</strong>
            <p id="viewModalMsg"></p>
        </div>
        
        <div class="modal-field" style="border-left: 3px solid #2ecc71; background: rgba(46, 204, 113, 0.05);">
            <strong>Your Suggestion (Replied at <span id="viewModalTime"></span>):</strong>
            <p id="viewModalReply"></p>
        </div>
        
        <div class="modal-actions">
            <button type="button" class="btn-submit" onclick="closeViewReplyModal()">Close</button>
        </div>
    </div>
</div>

<%@ include file="includes/footer.jsp" %>
