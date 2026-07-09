<%
    String pageTitle = "Home";
%>

<%@ include file="includes/header.jsp" %>

<style>
    /* Critical inline path style to prevent Flicker of Unstyled Content (FOUC) */
    #preloader:not(.fade-out) {
        position: fixed !important;
        top: 0 !important;
        left: 0 !important;
        width: 100% !important;
        height: 100% !important;
        background: #111e12 !important;
        z-index: 999999 !important;
        display: flex !important;
        justify-content: center !important;
        align-items: center !important;
        opacity: 1 !important;
        visibility: visible !important;
    }
    body:not(.loaded) {
        overflow: hidden !important;
        height: 100vh !important;
    }
</style>

<!-- Cinematic Preloader -->
<div id="preloader">
    <div class="preloader-bg-media"></div>
    <div class="preloader-content">
        <div class="preloader-icon-wrapper">
            <svg class="preloader-svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.2" stroke-linecap="round" stroke-linejoin="round">
                <!-- Majestic mountain peak outline -->
                <path d="M2 20L10 6L18 20" />
                <path d="M12 20L16 13L21 20" />
                <!-- Sun rising behind the peak -->
                <circle cx="17" cy="8" r="2.5" fill="rgba(210, 227, 200, 0.15)" stroke="#d2e3c8" stroke-width="1" />
                <!-- Subtle wind line -->
                <path d="M1 17h4" />
                <path d="M20 16h3" />
            </svg>
        </div>
        <h1 class="preloader-logo">Discover<span>Kundasang</span></h1>
        <div class="preloader-line">
            <div class="preloader-progress"></div>
        </div>
        <p class="preloader-subtitle">Preparing your mountain getaway...</p>
    </div>
</div>

<!-- ==========================================
                 HERO SECTION
=========================================== -->

<section class="hero">

    <main class="content">

        <h1>

            Discover the Beauty of

            <span>Kundasang</span>

        </h1>

        <p>

            Escape into the peaceful highlands of Sabah surrounded by breathtaking
            mountain scenery, cool weather, eco-tourism attractions and unforgettable
            nature experiences.

        </p>

        <a href="gallery.jsp" class="cta">

            Explore Now

        </a>

    </main>

</section>

<style>
    /* Cinematic About Section */
    .about {
        background-image: linear-gradient(rgba(17, 30, 18, 0.82), rgba(17, 30, 18, 0.92)), url("img/gallery/ranaukali.jpg");
        background-attachment: fixed;
        background-size: cover;
        background-position: center;
        position: relative;
        overflow: hidden;
        padding: 100px 7% 100px;
    }

    .about h2 {
        text-align: center;
        font-size: 3rem;
        margin-bottom: 50px;
        color: var(--white);
    }

    .about h2 span {
        color: #d2e3c8;
    }

    .about .row {
        display: flex;
        align-items: stretch;
        gap: 60px;
    }

    .about-img-wrapper {
        flex: 1.6;
        position: relative;
        border-radius: 2rem;
        overflow: hidden;
        box-shadow: 0 20px 40px rgba(0, 0, 0, 0.25);
        border: 1px solid rgba(255, 255, 255, 0.1);
    }

    .about-img-wrapper::after {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background: linear-gradient(to bottom, rgba(0,0,0,0) 60%, rgba(0,0,0,0.5) 100%);
        pointer-events: none;
    }

    .about-img-wrapper img {
        width: 100%;
        height: 100%;
        min-height: 480px;
        object-fit: cover;
        object-position: center 10%;
        display: block;
        transition: transform 1.2s cubic-bezier(0.165, 0.84, 0.44, 1);
    }

    .about-img-wrapper:hover img {
        transform: scale(1.06);
    }

    .about .content {
        flex: 1;
        display: flex;
        flex-direction: column;
        justify-content: center;
    }

    .about .content h3 {
        font-size: 2.2rem;
        color: var(--white);
        font-weight: 700;
        margin-bottom: 20px;
        letter-spacing: -0.5px;
        line-height: 1.3;
    }

    .about .content p {
        font-size: 1.05rem;
        line-height: 1.8;
        color: #e2e8f0;
        margin-bottom: 20px;
    }

    .about-grid {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 15px;
        margin-top: 25px;
    }

    .about-feature-card {
        background: rgba(255, 255, 255, 0.08); /* glassmorphic translucent white */
        backdrop-filter: blur(16px);
        -webkit-backdrop-filter: blur(16px);
        border: 1px solid rgba(255, 255, 255, 0.15);
        border-radius: 1.2rem;
        padding: 12px 15px;
        display: flex;
        align-items: center;
        gap: 12px;
        box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
        transition: transform 0.3s ease, box-shadow 0.3s ease;
    }

    .about-feature-card:hover {
        transform: translateY(-3px);
        box-shadow: 0 15px 30px rgba(79, 111, 82, 0.2);
    }

    .about-icon {
        width: 48px;
        height: 48px;
        border-radius: 1rem;
        background: rgba(255, 255, 255, 0.1);
        display: flex;
        align-items: center;
        justify-content: center;
        color: #d2e3c8;
        flex-shrink: 0;
        box-shadow: 0 4px 10px rgba(79, 111, 82, 0.08);
        border: 1px solid rgba(255, 255, 255, 0.1);
    }

    .about-icon i {
        width: 22px;
        height: 22px;
    }

    .about-info h4 {
        font-size: 1rem;
        font-weight: 700;
        color: var(--white);
        margin: 0 0 2px 0;
    }

    .about-info p {
        font-size: 0.85rem !important;
        margin: 0 !important;
        line-height: 1.4 !important;
        color: #ccd7cc !important;
    }

    @media (max-width: 992px) {
        .about .row {
            gap: 40px;
        }
        .about-img-wrapper img {
            min-height: 380px;
        }
    }

    @media (max-width: 768px) {
        .about {
            padding: 80px 5% 60px;
        }
        .about h2 {
            font-size: 2.5rem;
        }
        .about .row {
            flex-direction: column;
            gap: 30px;
        }
        .about-img-wrapper {
            width: 100%;
        }
        .about-img-wrapper img {
            min-height: 300px;
            height: 300px;
        }
        .about-grid {
            grid-template-columns: 1fr !important;
            gap: 15px;
        }
    }
</style>

<section class="about">

    <h2>About <span>Kundasang</span></h2>

    <div class="row">

        <div class="about-img-wrapper">
            <img src="img/about-kundasang.jpg" alt="Kundasang">
        </div>

        <div class="content">

            <h3>A Beautiful Nature Destination in Sabah</h3>

            <p>
                Kundasang is one of Sabah's most famous tourism destinations,
                located near Mount Kinabalu. It is well known for its cool
                climate, peaceful atmosphere and breathtaking scenery.
            </p>

            <p>
                Visitors can enjoy mountain resorts, fresh local markets,
                eco-tourism attractions, beautiful sunrise views and many
                outdoor activities suitable for families and nature lovers.
            </p>

            <div class="about-grid">
                <div class="about-feature-card">
                    <div class="about-icon">
                        <i data-feather="thermometer"></i>
                    </div>
                    <div class="about-info">
                        <h4>Cool Climate</h4>
                        <p>15°C - 21°C year-round</p>
                    </div>
                </div>
                <div class="about-feature-card">
                    <div class="about-icon">
                        <i data-feather="image"></i>
                    </div>
                    <div class="about-info">
                        <h4>Scenic Peaks</h4>
                        <p>Majestic Kinabalu views</p>
                    </div>
                </div>
                <div class="about-feature-card">
                    <div class="about-icon">
                        <i data-feather="map"></i>
                    </div>
                    <div class="about-info">
                        <h4>Local Produce</h4>
                        <p>Fresh dairy & markets</p>
                    </div>
                </div>
                <div class="about-feature-card">
                    <div class="about-icon">
                        <i data-feather="heart"></i>
                    </div>
                    <div class="about-info">
                        <h4>Nature Haven</h4>
                        <p>Highland eco-tourism</p>
                    </div>
                </div>
            </div>

        </div>

    </div>

</section>

<%@ include file="includes/footer.jsp" %>