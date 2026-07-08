<%
    String pageTitle = "Login";
    
    // Check if the user is already logged in, except when we just completed a successful login
    if (session.getAttribute("user") != null && request.getParameter("success") == null) {
        response.sendRedirect("DashboardServlet");
        return;
    }
    
    // Read error from session (set by LoginServlet)
    String error = (String) session.getAttribute("error");
    session.removeAttribute("error");
    
    // Check success status passed from LoginServlet
    boolean loginSuccess = "true".equals(request.getParameter("success"));
    String loggedInUser = (String) session.getAttribute("user");
%>

<%@ include file="includes/header.jsp" %>

<style>
    /* Hide global site navigation and footer for a clean cinematic admin portal */
    .navbar, footer {
        display: none !important;
    }

    body {
        background-color: #121a13 !important;
        overflow: hidden;
    }

    /* Cinematic Split Layout Container */
    .login-page-wrapper {
        display: flex;
        min-height: 100vh;
        width: 100vw;
        overflow: hidden;
    }

    /* Left Side: Cinematic Image Panel */
    .login-image-panel {
        flex: 1.2;
        position: relative;
        overflow: hidden;
        display: flex;
        flex-direction: column;
        justify-content: space-between;
        padding: 4rem;
        color: var(--white);
        z-index: 1;
    }

    /* Background image with slow zoom transition */
    .login-image-panel::before {
        content: "";
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background-image: 
            linear-gradient(135deg, rgba(18, 26, 19, 0.95) 0%, rgba(79, 111, 82, 0.45) 100%),
            url('img/login.jpg');
        background-size: cover;
        background-position: center;
        z-index: -1;
        transform: scale(1.02);
        animation: slowZoom 25s infinite alternate ease-in-out;
    }

    @keyframes slowZoom {
        0% {
            transform: scale(1.02);
        }
        100% {
            transform: scale(1.12);
        }
    }

    .brand-logo {
        font-size: 2.2rem;
        font-weight: 700;
        color: var(--white);
        letter-spacing: -0.5px;
        text-shadow: 0 4px 10px rgba(0,0,0,0.3);
        animation: fadeInUp 0.8s ease-out forwards;
    }

    .brand-logo span {
        color: var(--accent);
    }

    .brand-quote {
        max-width: 480px;
        margin-bottom: 2rem;
        animation: fadeInUp 1s 0.2s ease-out forwards;
        opacity: 0;
    }

    .brand-quote h3 {
        font-size: 2.5rem;
        font-weight: 600;
        line-height: 1.2;
        margin-bottom: 15px;
        text-shadow: 0 4px 12px rgba(0,0,0,0.4);
    }

    .brand-quote p {
        font-size: 1.1rem;
        color: rgba(255, 255, 255, 0.85);
        line-height: 1.6;
        text-shadow: 0 2px 8px rgba(0,0,0,0.3);
    }

    .brand-footer {
        font-size: 0.85rem;
        color: rgba(255, 255, 255, 0.6);
        animation: fadeInUp 1s 0.4s ease-out forwards;
        opacity: 0;
    }

    /* Right Side: Login Form Panel */
    .login-form-panel {
        flex: 0.8;
        background-color: var(--white);
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 4rem;
        position: relative;
        z-index: 2;
        box-shadow: -10px 0 35px rgba(0, 0, 0, 0.2);
    }

    .login-form-container {
        width: 100%;
        max-width: 420px;
        animation: fadeInRight 0.8s cubic-bezier(0.16, 1, 0.3, 1) forwards;
    }

    .form-header {
        margin-bottom: 35px;
    }

    .back-to-home {
        display: inline-flex;
        align-items: center;
        gap: 8px;
        color: var(--primary);
        font-weight: 500;
        font-size: 0.9rem;
        margin-bottom: 30px;
        transition: 0.3s;
    }

    .back-to-home i {
        width: 16px;
        height: 16px;
        transition: transform 0.3s;
    }

    .back-to-home:hover {
        color: var(--secondary);
    }

    .back-to-home:hover i {
        transform: translateX(-4px);
    }

    .form-header h2 {
        font-size: 2.4rem;
        font-weight: 700;
        color: var(--text);
        margin-bottom: 10px;
        letter-spacing: -0.5px;
    }

    .form-header h2 span {
        color: var(--primary);
    }

    .form-header p {
        color: #666;
        font-size: 0.95rem;
        line-height: 1.5;
    }

    .error-alert {
        background-color: #fdf2f2;
        color: #de350b;
        padding: 1.1rem;
        border-radius: 0.8rem;
        margin-bottom: 25px;
        font-size: 0.9rem;
        font-weight: 500;
        display: flex;
        align-items: center;
        gap: 10px;
        text-align: left;
        border: 1px solid #fbd5d5;
        box-shadow: 0 4px 6px rgba(222, 53, 11, 0.05);
        animation: shake 0.4s ease-in-out;
    }

    .error-alert i {
        flex-shrink: 0;
        width: 18px;
        height: 18px;
    }

    /* Form Fields */
    .login-form .input-group {
        display: flex;
        flex-direction: column;
        gap: 8px;
        margin-bottom: 22px;
    }

    .login-form .input-group label {
        font-size: 0.9rem;
        font-weight: 600;
        color: var(--text);
        letter-spacing: 0.2px;
    }

    .login-form .input-wrapper {
        display: flex;
        align-items: center;
        background-color: #f7f9f7;
        border-radius: 0.8rem;
        padding-left: 18px;
        border: 2px solid #e2e8e2;
        transition: all 0.3s cubic-bezier(0.16, 1, 0.3, 1);
    }

    .login-form .input-wrapper:focus-within {
        border-color: var(--primary);
        background-color: var(--white);
        box-shadow: 0 0 0 4px rgba(79, 111, 82, 0.12);
    }

    .login-form .input-wrapper i {
        color: #8c9c8e;
        width: 18px;
        height: 18px;
        transition: color 0.3s;
    }

    .login-form .input-wrapper:focus-within i {
        color: var(--primary);
    }

    .login-form .input-wrapper input {
        width: 100%;
        padding: 1.1rem 1.1rem 1.1rem 12px;
        background: none;
        font-size: 0.95rem;
        color: var(--text);
        border: none;
        outline: none;
        font-family: inherit;
    }

    .login-form input::placeholder {
        color: #a0ada2;
    }

    .login-btn {
        width: 100%;
        padding: 1.1rem;
        background-color: var(--primary);
        color: var(--white);
        border-radius: 0.8rem;
        font-size: 1rem;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.3s cubic-bezier(0.16, 1, 0.3, 1);
        margin-top: 15px;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        gap: 10px;
        box-shadow: 0 8px 20px rgba(79, 111, 82, 0.25);
    }

    .login-btn i {
        width: 18px;
        height: 18px;
        transition: transform 0.3s;
    }

    .login-btn:hover {
        background-color: var(--secondary);
        transform: translateY(-2px);
        box-shadow: 0 10px 25px rgba(115, 144, 114, 0.35);
    }

    .login-btn:hover i {
        transform: translateX(3px);
    }

    .login-btn:active {
        transform: translateY(0);
    }

    /* Success Overlay and Modal */
    .success-overlay {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(15, 23, 17, 0.85);
        backdrop-filter: blur(10px);
        display: flex;
        align-items: center;
        justify-content: center;
        z-index: 10000;
        opacity: 0;
        animation: fadeIn 0.4s forwards cubic-bezier(0.16, 1, 0.3, 1);
    }

    .success-modal {
        background: var(--white);
        padding: 3rem;
        border-radius: 1.5rem;
        text-align: center;
        max-width: 420px;
        width: 90%;
        box-shadow: 0 25px 60px rgba(0, 0, 0, 0.4);
        transform: translateY(40px) scale(0.95);
        animation: modalReveal 0.6s 0.1s forwards cubic-bezier(0.34, 1.56, 0.64, 1);
    }

    .success-icon {
        margin-bottom: 25px;
    }

    .success-modal h3 {
        font-size: 1.8rem;
        color: var(--text);
        font-weight: 700;
        margin-bottom: 10px;
    }

    .success-modal p {
        color: #555;
        font-size: 1rem;
        line-height: 1.5;
        margin-bottom: 8px;
    }

    .success-modal p strong {
        color: var(--primary);
    }

    .redirect-text {
        font-size: 0.9rem !important;
        color: #888 !important;
        margin-top: 15px;
    }

    .progress-bar-container {
        width: 100%;
        height: 5px;
        background: #f0f4f0;
        border-radius: 10px;
        margin-top: 25px;
        overflow: hidden;
    }

    .progress-bar {
        height: 100%;
        width: 0%;
        background: var(--primary);
        border-radius: 10px;
        animation: fillProgress 2.3s linear forwards;
    }

    /* Cinematic SVG checkmark drawing animation */
    .checkmark {
        width: 80px;
        height: 80px;
        border-radius: 50%;
        display: block;
        stroke-width: 2;
        stroke: var(--primary);
        stroke-miterlimit: 10;
        margin: 0 auto;
        box-shadow: inset 0px 0px 0px var(--primary);
        animation: fill .4s ease-in-out .4s forwards, scale .3s ease-in-out .9s alternate both;
    }

    .checkmark__circle {
        stroke-dasharray: 166;
        stroke-dashoffset: 166;
        stroke-width: 2;
        stroke-miterlimit: 10;
        stroke: var(--primary);
        fill: none;
        animation: stroke .6s cubic-bezier(0.65, 0, 0.45, 1) forwards;
    }

    .checkmark__check {
        transform-origin: 50% 50%;
        stroke-dasharray: 48;
        stroke-dashoffset: 48;
        stroke: #fff;
        animation: stroke .3s cubic-bezier(0.65, 0, 0.45, 1) .8s forwards;
    }

    /* Keyframe Animations */
    @keyframes fadeInUp {
        from {
            opacity: 0;
            transform: translateY(30px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }

    @keyframes fadeInRight {
        from {
            opacity: 0;
            transform: translateX(30px);
        }
        to {
            opacity: 1;
            transform: translateX(0);
        }
    }

    @keyframes fadeIn {
        to {
            opacity: 1;
        }
    }

    @keyframes modalReveal {
        to {
            opacity: 1;
            transform: translateY(0) scale(1);
        }
    }

    @keyframes stroke {
        100% {
            stroke-dashoffset: 0;
        }
    }

    @keyframes scale {
        0%, 100% {
            transform: none;
        }
        50% {
            transform: scale3d(1.15, 1.15, 1);
        }
    }

    @keyframes fill {
        100% {
            box-shadow: inset 0px 0px 0px 40px var(--primary);
        }
    }

    @keyframes fillProgress {
        100% {
            width: 100%;
        }
    }

    @keyframes shake {
        0%, 100% { transform: translateX(0); }
        25% { transform: translateX(-8px); }
        75% { transform: translateX(8px); }
    }

    /* Responsive adjustments */
    @media (max-width: 991px) {
        body {
            overflow: auto;
            background-color: var(--white) !important;
        }
        .login-page-wrapper {
            flex-direction: column;
        }
        .login-image-panel {
            display: none;
        }
        .login-form-panel {
            flex: 1;
            padding: 3rem 1.5rem;
            min-height: 100vh;
            box-shadow: none;
        }
    }
</style>

<div class="login-page-wrapper">
    <!-- Left Side: Cinematic Image Panel -->
    <div class="login-image-panel">
        <a href="index.jsp" class="brand-logo">
            Discover<span>Kundasang</span>
        </a>
        <div class="brand-quote">
            <h3>Experience the Majestic Peaks</h3>
            <p>Manage the gateway to Kundasang's most beautiful destinations, activities, and accommodations.</p>
        </div>
        <div class="brand-footer">
            <p>&copy; 2026 Discover Kundasang. All rights reserved.</p>
        </div>
    </div>

    <!-- Right Side: Login Form Panel -->
    <div class="login-form-panel">
        <div class="login-form-container">
            <div class="form-header">
                <a href="index.jsp" class="back-to-home">
                    <i data-feather="arrow-left"></i> Back to Homepage
                </a>
                <h2><span>Admin</span> Portal</h2>
                <p>Welcome back! Please sign in to access the administrator dashboard.</p>
            </div>

            <!-- Error message display -->
            <% if (error != null) { %>
                <div class="error-alert">
                    <i data-feather="alert-circle"></i>
                    <span><%= error %></span>
                </div>
            <% } %>

            <form class="login-form" action="LoginServlet" method="POST">
                <div class="input-group">
                    <label for="username">Username</label>
                    <div class="input-wrapper">
                        <i data-feather="user"></i>
                        <input type="text" id="username" name="username" placeholder="Enter your username" required autocomplete="username">
                    </div>
                </div>

                <div class="input-group">
                    <label for="password">Password</label>
                    <div class="input-wrapper">
                        <i data-feather="lock"></i>
                        <input type="password" id="password" name="password" placeholder="Enter your password" required autocomplete="current-password">
                    </div>
                </div>

                <button type="submit" class="login-btn">
                    <span>Sign In</span>
                    <i data-feather="log-in"></i>
                </button>
            </form>
        </div>
    </div>
</div>

<!-- Successful Login Popup Modal -->
<% if (loginSuccess) { %>
    <div class="success-overlay" id="successOverlay">
        <div class="success-modal">
            <div class="success-icon">
                <svg class="checkmark" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 52 52">
                    <circle class="checkmark__circle" cx="26" cy="26" r="25" fill="none"/>
                    <path class="checkmark__check" fill="none" d="M14.1 27.2l7.1 7.2 16.7-16.8"/>
                </svg>
            </div>
            <h3>Login Successful!</h3>
            <p>Welcome back, <strong><%= loggedInUser %></strong>.</p>
            <p class="redirect-text">Redirecting to management dashboard...</p>
            <div class="progress-bar-container">
                <div class="progress-bar" id="progressBar"></div>
            </div>
        </div>
    </div>
    <script>
        // Disable form inputs and buttons to prevent duplicate submission during redirect transition
        document.querySelectorAll('.login-form input, .login-btn').forEach(el => el.disabled = true);
        
        // Wait for the popup and progress bar animation to run before redirecting
        setTimeout(function() {
            window.location.href = "DashboardServlet";
        }, 2300);
    </script>
<% } %>

<%@ include file="includes/footer.jsp" %>
