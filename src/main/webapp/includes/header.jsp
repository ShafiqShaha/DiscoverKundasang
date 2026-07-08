<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title><%= pageTitle %> | Discover Kundasang</title>

    <!-- Google Font -->
    <link rel="preconnect" href="https://fonts.googleapis.com">

    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>

    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
          rel="stylesheet">

    <!-- Feather Icons -->
    <script src="https://unpkg.com/feather-icons"></script>

    <!-- CSS -->
    <link rel="stylesheet" href="css/style.css?v=<%= System.currentTimeMillis() %>">

</head>

<body>

<!-- ==========================================
                NAVIGATION BAR
=========================================== -->

<nav class="navbar">

    <a href="index.jsp" class="navbar-logo">
        Discover<span>Kundasang</span>
    </a>

    <div class="navbar-nav">

        <a href="index.jsp" class="<%= "Home".equals(pageTitle) ? "active" : "" %>">Home</a>

        <a href="gallery.jsp" class="<%= "Gallery".equals(pageTitle) ? "active" : "" %>">Gallery</a>

        <a href="activities.jsp" class="<%= "Activities".equals(pageTitle) ? "active" : "" %>">Activities</a>

        <a href="accommodation.jsp" class="<%= "Accommodations".equals(pageTitle) ? "active" : "" %>">Accommodation</a>

        <a href="contact.jsp" class="<%= "Contact".equals(pageTitle) ? "active" : "" %>">Contact</a>

        <a href="developer.jsp" class="<%= "Developer Profile".equals(pageTitle) ? "active" : "" %>">Developer</a>

    </div>

    <div class="navbar-extra">

        <a href="login.jsp" class="nav-btn">
            Login
        </a>

        <a href="#" id="menu-toggle">
            <i data-feather="menu"></i>
        </a>

    </div>

</nav>