<%
    String pageTitle = "Developer Profile";
%>

<%@ include file="includes/header.jsp" %>

<style>
    /* Developer Profile Styles */
    .developer-container {
        padding: 140px 7% 80px;
        min-height: 100vh;
        background-image: linear-gradient(rgba(17, 30, 18, 0.82), rgba(17, 30, 18, 0.92)), url("img/gallery/labanrata.jpg");
        background-attachment: fixed;
        background-size: cover;
        background-position: center;
        position: relative;
    }

    .developer-card {
        background: rgba(255, 255, 255, 0.08); /* glassmorphic translucent white */
        backdrop-filter: blur(16px);
        -webkit-backdrop-filter: blur(16px);
        border: 1px solid rgba(255, 255, 255, 0.15);
        border-radius: 1.5rem;
        box-shadow: 0 20px 50px rgba(0, 0, 0, 0.25);
        padding: 40px;
        margin-top: 20px;
    }

    .profile-grid {
        display: grid;
        grid-template-columns: 1fr 2fr;
        gap: 50px;
        align-items: start;
    }

    /* Left Column: Avatar & Basic Info */
    .profile-sidebar {
        text-align: center;
        border-right: 1px solid rgba(255, 255, 255, 0.1);
        padding-right: 30px;
    }

    .avatar-wrapper {
        width: 180px;
        height: 180px;
        border-radius: 50%;
        margin: 0 auto 20px;
        overflow: hidden;
        border: 4px solid #d2e3c8;
        box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
        display: flex;
        align-items: center;
        justify-content: center;
        background-color: rgba(255, 255, 255, 0.1);
    }

    .avatar-wrapper i {
        width: 80px;
        height: 80px;
        color: #d2e3c8;
    }

    .avatar-img {
        width: 100%;
        height: 100%;
        object-fit: cover;
        object-position: center 35%;
    }

    .profile-sidebar h3 {
        font-size: 1.8rem;
        color: var(--white);
        margin-bottom: 5px;
    }

    .profile-sidebar p {
        color: #d2e3c8;
        font-weight: 600;
        font-size: 0.95rem;
        margin-bottom: 20px;
    }

    .student-badge-info {
        background-color: rgba(255, 255, 255, 0.05);
        border-radius: 0.8rem;
        padding: 15px;
        margin-bottom: 20px;
        text-align: left;
        border: 1px solid rgba(255, 255, 255, 0.1);
    }

    .student-badge-info div {
        margin-bottom: 8px;
        font-size: 0.9rem;
        color: #e2e8f0;
    }

    .student-badge-info div:last-child {
        margin-bottom: 0;
    }

    .student-badge-info strong {
        color: #d2e3c8;
    }

    .social-links {
        display: flex;
        justify-content: center;
        gap: 15px;
        margin-top: 15px;
    }

    .social-links a {
        width: 40px;
        height: 40px;
        border-radius: 50%;
        background-color: rgba(255, 255, 255, 0.1);
        color: #d2e3c8;
        display: flex;
        justify-content: center;
        align-items: center;
        transition: 0.3s;
        border: 1px solid rgba(255, 255, 255, 0.1);
    }

    .social-links a:hover {
        background-color: var(--primary);
        color: var(--white);
        transform: translateY(-3px);
        border-color: var(--primary);
    }

    /* Right Column: Bio & Skills */
    .profile-main h2 {
        font-size: 2.2rem;
        color: var(--white);
        margin-bottom: 15px;
    }

    .profile-main h2 span {
        color: #d2e3c8;
    }

    .bio-text {
        font-size: 1.05rem;
        line-height: 1.8;
        color: #e2e8f0;
        margin-bottom: 30px;
    }

    .section-subtitle {
        font-size: 1.3rem;
        color: var(--white);
        margin-bottom: 20px;
        border-bottom: 2px solid rgba(255, 255, 255, 0.1);
        padding-bottom: 8px;
        font-weight: 600;
    }

    .skills-grid {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 20px;
        margin-bottom: 30px;
    }

    .skill-card {
        background-color: rgba(255, 255, 255, 0.05);
        border: 1px solid rgba(255, 255, 255, 0.1);
        padding: 15px;
        border-radius: 0.8rem;
        display: flex;
        align-items: center;
        gap: 15px;
        transition: all 0.3s ease;
    }

    .skill-card:hover {
        background-color: rgba(255, 255, 255, 0.1);
        border-color: rgba(210, 227, 200, 0.2);
        transform: translateY(-2px);
    }

    .skill-card i {
        color: #d2e3c8;
        width: 24px;
        height: 24px;
        flex-shrink: 0;
    }

    .skill-info h4 {
        font-size: 1rem;
        color: var(--white);
        margin-bottom: 2px;
    }

    .skill-info p {
        font-size: 0.85rem;
        color: #ccd7cc;
        margin: 0;
    }

    .projects-summary {
        line-height: 1.7;
        color: #e2e8f0;
    }

    .projects-summary ul {
        margin-top: 10px;
        list-style-position: inside;
    }

    .projects-summary li {
        margin-bottom: 8px;
    }

    /* Responsive */
    @media (max-width: 992px) {
        .profile-grid {
            grid-template-columns: 1fr;
            gap: 40px;
        }

        .profile-sidebar {
            border-right: none;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            padding-right: 0;
            padding-bottom: 30px;
        }
    }

    @media (max-width: 768px) {
        .developer-container {
            padding: 120px 5% 40px;
        }
        .skills-grid {
            grid-template-columns: 1fr;
        }
    }
</style>

<div class="developer-container page-fade-in">

    <div class="developer-card">

        <div class="profile-grid">

            <!-- Sidebar -->
            <div class="profile-sidebar">
                <div class="avatar-wrapper">
                    <img src="img/developer.jpg" alt="Developer Photo" class="avatar-img">
                </div>
                <h3>Shafiq Shaharuddin</h3>
                <p>Computer Science Student</p>
                
                <!-- Student Credentials Area -->
                <div class="student-badge-info">
                    <div><strong>Student ID:</strong> 2023618226</div>
                    <div><strong>Course:</strong> CSC230 (Computer Science)</div>
                    <div><strong>Class:</strong> NBCS2306A</div>
                    <div><strong>Institution:</strong> UiTM Shah Alam</div>
                </div>

                <div class="social-links">
                    <a href="https://github.com/ShafiqShaha" target="_blank" title="GitHub"><i data-feather="github"></i></a>
                    <a href="https://www.linkedin.com/in/muhammad-shafiq-bin-shaharuddin-15b997196" target="_blank" title="LinkedIn"><i data-feather="linkedin"></i></a>
                    <a href="mailto:2023618226@student.uitm.edu.my" title="Mail"><i data-feather="mail"></i></a>
                </div>
            </div>

            <!-- Main Content -->
            <div class="profile-main">
                <h2>About the <span>Developer</span></h2>
                <p class="bio-text">
                    Hi! I'm Shafiq Shaha, the creator of the <strong>DiscoverKundasang</strong> tourism platform. 
                    I am a Computer Science student from Seremban, Negeri Sembilan. I love designing clean, modern, and highly
                    responsive web systems that connect users with nature, travel guides, and unforgettable highland experiences.
                </p>

                <h3 class="section-subtitle">Core Skills &amp; Tech Stack</h3>
                <div class="skills-grid">
                    <div class="skill-card">
                        <i data-feather="code"></i>
                        <div class="skill-info">
                            <h4>Java &amp; JSP</h4>
                            <p>Backend Logic &amp; Dynamic Templates</p>
                        </div>
                    </div>
                    <div class="skill-card">
                        <i data-feather="layout"></i>
                        <div class="skill-info">
                            <h4>HTML5 &amp; CSS3</h4>
                            <p>Semantic Layouts &amp; Responsive Web Design</p>
                        </div>
                    </div>
                    <div class="skill-card">
                        <i data-feather="database"></i>
                        <div class="skill-info">
                            <h4>MySQL Database</h4>
                            <p>Data persistence, Queries &amp; Relations</p>
                        </div>
                    </div>
                    <div class="skill-card">
                        <i data-feather="terminal"></i>
                        <div class="skill-info">
                            <h4>Maven &amp; Git</h4>
                            <p>Dependency Management &amp; Version Control</p>
                        </div>
                    </div>
                </div>

                <h3 class="section-subtitle">Project Highlights</h3>
                <div class="projects-summary">
                    <p style="margin-bottom: 15px;">
                        This portal is designed using standard Java Web technologies (JSP &amp; Servlets) combined with customized CSS, 
                        incorporating semantic markup, search engine optimizations, and modern aesthetics like:
                    </p>
                    <ul style="list-style: none; padding-left: 0;">
                        <li style="display: flex; align-items: center; gap: 10px; margin-bottom: 12px; font-size: 1.02rem; color: #e2e8f0;"><i data-feather="star" style="color: #d2e3c8; width: 18px; height: 18px; flex-shrink: 0;"></i> Dynamic CSS animations and cards hover transitions.</li>
                        <li style="display: flex; align-items: center; gap: 10px; margin-bottom: 12px; font-size: 1.02rem; color: #e2e8f0;"><i data-feather="smartphone" style="color: #d2e3c8; width: 18px; height: 18px; flex-shrink: 0;"></i> Full responsive break-points for mobile, tablet, and desktop viewing.</li>
                        <li style="display: flex; align-items: center; gap: 10px; margin-bottom: 12px; font-size: 1.02rem; color: #e2e8f0;"><i data-feather="feather" style="color: #d2e3c8; width: 18px; height: 18px; flex-shrink: 0;"></i> Earthy/nature-centric color palettes emphasizing Kundasang's natural beauty.</li>
                    </ul>
                </div>
            </div>

        </div>

    </div>

</div>

<%@ include file="includes/footer.jsp" %>
