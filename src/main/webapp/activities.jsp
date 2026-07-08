<%
    String pageTitle = "Activities";
%>

<%@ include file="includes/header.jsp" %>

<style>
    /* Cinematic Activities Page Styles */
    .activities-page {
        padding: 140px 7% 80px;
        background-image: linear-gradient(rgba(17, 30, 18, 0.82), rgba(17, 30, 18, 0.92)), url("img/gallery/sosodikon hill.jpg");
        background-attachment: fixed;
        background-size: cover;
        background-position: center;
        position: relative;
    }

    .activities-title {
        text-align: center;
        margin-bottom: 80px;
    }

    .activities-title h2 {
        font-size: 3.5rem;
        margin-bottom: 20px;
        color: var(--white);
        font-weight: 700;
        letter-spacing: -1px;
    }

    .activities-title span {
        color: #d2e3c8;
    }

    .activities-title p {
        max-width: 700px;
        margin: auto;
        line-height: 1.8;
        font-size: 1.1rem;
        color: #e2e8f0;
    }

    .activity-row {
        display: flex;
        align-items: center;
        gap: 80px;
        margin-bottom: 100px;
        opacity: 0;
        transform: translateY(30px);
        animation: fadeInUp 0.8s cubic-bezier(0.165, 0.84, 0.44, 1) forwards;
        background: rgba(255, 255, 255, 0.05); /* subtle backdrop panel */
        backdrop-filter: blur(12px);
        -webkit-backdrop-filter: blur(12px);
        border: 1px solid rgba(255, 255, 255, 0.1);
        border-radius: 2.5rem;
        padding: 40px;
        box-shadow: 0 20px 50px rgba(0, 0, 0, 0.2);
    }

    .activity-row:nth-child(even) {
        animation-delay: 0.1s;
    }
    .activity-row:nth-child(odd) {
        animation-delay: 0.3s;
    }

    @keyframes fadeInUp {
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }

    .activity-row.reverse {
        flex-direction: row-reverse;
    }

    .activity-image-wrapper {
        flex: 1.1;
        position: relative;
        border-radius: 2rem;
        overflow: hidden;
        box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
        border: 1px solid rgba(255, 255, 255, 0.1);
    }

    .activity-image-wrapper::after {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background: linear-gradient(to bottom, rgba(0, 0, 0, 0) 60%, rgba(0, 0, 0, 0.5) 100%);
        z-index: 1;
        pointer-events: none;
        transition: opacity 0.5s ease;
    }

    .activity-image-wrapper:hover::after {
        background: linear-gradient(to bottom, rgba(0, 0, 0, 0) 40%, rgba(0, 0, 0, 0.6) 100%);
    }

    .activity-image-wrapper img {
        width: 100%;
        height: 420px;
        object-fit: cover;
        display: block;
        transition: transform 1.2s cubic-bezier(0.165, 0.84, 0.44, 1);
    }

    .activity-image-wrapper:hover img {
        transform: scale(1.08);
    }

    .activity-content {
        flex: 0.9;
        display: flex;
        flex-direction: column;
        justify-content: center;
    }

    .activity-header {
        display: flex;
        align-items: center;
        gap: 15px;
        margin-bottom: 20px;
    }

    .activity-icon-container {
        display: flex;
        align-items: center;
        justify-content: center;
        width: 50px;
        height: 50px;
        background-color: rgba(255, 255, 255, 0.12);
        backdrop-filter: blur(8px);
        -webkit-backdrop-filter: blur(8px);
        border: 1px solid rgba(255, 255, 255, 0.2);
        border-radius: 1.2rem;
        color: #d2e3c8;
        box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
    }

    .activity-icon-container i {
        width: 24px;
        height: 24px;
    }

    .activity-content h3 {
        font-size: 2.2rem;
        color: var(--white);
        font-weight: 700;
        margin: 0;
        letter-spacing: -0.5px;
    }

    .activity-content p {
        font-size: 1.05rem;
        line-height: 1.85;
        color: #e2e8f0;
        margin-bottom: 25px;
    }

    .activity-features {
        list-style: none;
        padding: 0;
        margin: 0;
    }

    .activity-features li {
        display: flex;
        align-items: center;
        gap: 12px;
        margin-bottom: 15px;
        font-size: 1.05rem;
        color: #e2e8f0;
        font-weight: 500;
    }

    .activity-features li i {
        color: #d2e3c8;
        width: 18px;
        height: 18px;
        flex-shrink: 0;
    }

    @media (max-width: 992px) {
        .activity-row,
        .activity-row.reverse {
            gap: 40px;
            padding: 30px;
        }
        .activity-image-wrapper img {
            height: 350px;
        }
        .activity-content h3 {
            font-size: 1.8rem;
        }
    }

    @media (max-width: 768px) {
        .activities-page {
            padding: 120px 5% 40px;
        }
        .activities-title {
            margin-bottom: 50px;
        }
        .activities-title h2 {
            font-size: 2.8rem;
        }
        .activity-row,
        .activity-row.reverse {
            flex-direction: column;
            gap: 30px;
            margin-bottom: 60px;
            border-radius: 1.5rem;
            padding: 20px;
        }
        .activity-image-wrapper {
            width: 100%;
        }
        .activity-image-wrapper img {
            height: 280px;
        }
    }
</style>

<section class="activities-page page-fade-in">

    <div class="activities-title">
        <h2>Experience <span>Kundasang</span></h2>
        <p>
            From breathtaking mountain adventures to peaceful countryside
            experiences, discover the unforgettable activities waiting for you
            in Kundasang.
        </p>
    </div>

    <!-- Activity 1 -->
    <div class="activity-row">
        <div class="activity-image-wrapper">
            <img src="img/activity1.jpg" alt="Farm Visit">
        </div>
        <div class="activity-content">
            <div class="activity-header">
                <div class="activity-icon-container">
                    <i data-feather="compass"></i>
                </div>
                <h3>Farm Visit</h3>
            </div>
            <p>
                Visit the famous Desa Cattle Dairy Farm, often referred to as the "Little New Zealand" of Sabah. Enjoy delicious fresh milk and gelato, feed the friendly calves and goats, and soak in the relaxing green meadow pastures under the cool highland breeze.
            </p>
            <ul class="activity-features">
                <li><i data-feather="check-circle"></i> Fresh dairy products</li>
                <li><i data-feather="check-circle"></i> Feed friendly animals</li>
                <li><i data-feather="check-circle"></i> Stunning mountain scenery</li>
            </ul>
        </div>
    </div>

    <!-- Activity 2 -->
    <div class="activity-row reverse">
        <div class="activity-image-wrapper">
            <img src="img/activity2.jpg" alt="Hiking">
        </div>
        <div class="activity-content">
            <div class="activity-header">
                <div class="activity-icon-container">
                    <i data-feather="trending-up"></i>
                </div>
                <h3>Hiking Adventure</h3>
            </div>
            <p>
                Embark on an exhilarating hiking journey up scenic trails like Sosodikon Hill and Maragang Hill. Walk through misty paths surrounded by exotic cool-climate flora, and reward yourself with spectacular, uninterrupted panoramic views of Mount Kinabalu.
            </p>
            <ul class="activity-features">
                <li><i data-feather="check-circle"></i> Nature trails</li>
                <li><i data-feather="check-circle"></i> Fresh mountain breeze</li>
                <li><i data-feather="check-circle"></i> Perfect for outdoor lovers</li>
            </ul>
        </div>
    </div>

    <!-- Activity 3 -->
    <div class="activity-row">
        <div class="activity-image-wrapper">
            <img src="img/activity3.jpg" alt="Camping">
        </div>
        <div class="activity-content">
            <div class="activity-header">
                <div class="activity-icon-container">
                    <i data-feather="wind"></i>
                </div>
                <h3>Camping</h3>
            </div>
            <p>
                Spend a peaceful night camping under a blanket of stars in the crisp highland mountain air. Set up your camp or luxury glamping dome at popular spots in Mesilau, enjoy a cozy barbecue evening, and wake up to a magical misty sunrise over the valley.
            </p>
            <ul class="activity-features">
                <li><i data-feather="check-circle"></i> Cool climate</li>
                <li><i data-feather="check-circle"></i> Beautiful sunrise</li>
                <li><i data-feather="check-circle"></i> Family friendly</li>
            </ul>
        </div>
    </div>

    <!-- Activity 4 -->
    <div class="activity-row reverse">
        <div class="activity-image-wrapper">
            <img src="img/activity4.jpg" alt="Photography">
        </div>
        <div class="activity-content">
            <div class="activity-header">
                <div class="activity-icon-container">
                    <i data-feather="camera"></i>
                </div>
                <h3>Photography</h3>
            </div>
            <p>
                Capture breathtaking panoramic shots and create lifelong memories with the dramatic, sweeping mountain ranges. Whether you are chasing the golden sunrise, the pink sunset hues, or postcard-perfect frames, Kundasang offers endless scenic viewpoints.
            </p>
            <ul class="activity-features">
                <li><i data-feather="check-circle"></i> Instagram-worthy spots</li>
                <li><i data-feather="check-circle"></i> Sunrise & sunset views</li>
                <li><i data-feather="check-circle"></i> Amazing landscapes</li>
            </ul>
        </div>
    </div>

</section>

<%@ include file="includes/footer.jsp" %>