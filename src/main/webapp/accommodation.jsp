<%
    String pageTitle = "Accommodations";
%>

<%@ include file="includes/header.jsp" %>

<style>
    /* Accommodation Page Styles */
    .accommodation-section {
        padding: 140px 7% 80px;
        background-image: linear-gradient(rgba(17, 30, 18, 0.82), rgba(17, 30, 18, 0.92)), url("img/gallery/topofkinabalu.jpg");
        background-attachment: fixed;
        background-size: cover;
        background-position: center;
        position: relative;
    }

    .accommodation-title {
        text-align: center;
        margin-bottom: 50px;
    }

    .accommodation-title h2 {
        font-size: 3.5rem;
        margin-bottom: 15px;
        color: var(--white);
    }

    .accommodation-title span {
        color: #d2e3c8;
    }

    .accommodation-title p {
        max-width: 700px;
        margin: auto;
        line-height: 1.8;
        color: #e2e8f0;
    }

    .accommodation-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
        gap: 35px;
        margin-top: 40px;
    }

    .accommodation-card {
        background: rgba(255, 255, 255, 0.08); /* glassmorphic translucent white */
        backdrop-filter: blur(16px);
        -webkit-backdrop-filter: blur(16px);
        border: 1px solid rgba(255, 255, 255, 0.15);
        border-radius: 1.5rem;
        overflow: hidden;
        box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
        transition: transform 0.4s cubic-bezier(0.165, 0.84, 0.44, 1), box-shadow 0.4s cubic-bezier(0.165, 0.84, 0.44, 1);
        display: flex;
        flex-direction: column;
        position: relative;
    }

    .accommodation-card:hover {
        transform: translateY(-10px);
        box-shadow: 0 30px 60px rgba(0, 0, 0, 0.35);
        border-color: rgba(210, 227, 200, 0.3);
    }

    .card-img-container {
        position: relative;
        height: 250px;
        width: 100%;
        overflow: hidden;
    }

    .card-img-container::after {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background: linear-gradient(to bottom, rgba(0, 0, 0, 0) 50%, rgba(0, 0, 0, 0.65) 100%);
        z-index: 1;
        transition: opacity 0.3s ease;
    }

    .accommodation-card:hover .card-img-container::after {
        opacity: 0.8;
    }

    .card-img-container img {
        width: 100%;
        height: 100%;
        object-fit: cover;
        transition: transform 0.8s cubic-bezier(0.165, 0.84, 0.44, 1);
    }

    .accommodation-card:hover .card-img-container img {
        transform: scale(1.1);
    }

    .card-badge {
        position: absolute;
        top: 20px;
        right: 20px;
        background-color: rgba(79, 111, 82, 0.9);
        backdrop-filter: blur(8px);
        -webkit-backdrop-filter: blur(8px);
        border: 1px solid rgba(255, 255, 255, 0.2);
        color: var(--white);
        padding: 0.5rem 1.2rem;
        border-radius: 2rem;
        font-size: 0.8rem;
        font-weight: 600;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.15);
        z-index: 2;
    }

    .card-details {
        padding: 30px;
        display: flex;
        flex-direction: column;
        flex-grow: 1;
        background: rgba(17, 30, 18, 0.45); /* translucent natural dark backdrop */
        color: var(--white);
    }

    .card-rating {
        display: flex;
        align-items: center;
        gap: 6px;
        color: #f1c40f;
        font-size: 0.9rem;
        font-weight: 600;
        margin-bottom: 12px;
    }

    .card-rating i {
        fill: #f1c40f;
        width: 16px;
        height: 16px;
    }

    .card-details h3 {
        font-size: 1.45rem;
        color: var(--white);
        margin-bottom: 10px;
        font-weight: 600;
        letter-spacing: -0.3px;
    }

    .card-location {
        display: flex;
        align-items: center;
        gap: 6px;
        color: #ccd7cc;
        font-size: 0.88rem;
        margin-bottom: 18px;
    }

    .card-location i {
        color: #d2e3c8;
        width: 16px;
        height: 16px;
    }

    .card-desc {
        font-size: 0.92rem;
        line-height: 1.65;
        color: #e2e8f0;
        margin-bottom: 25px;
        flex-grow: 1;
    }

    .card-amenities {
        display: flex;
        gap: 20px;
        margin-bottom: 25px;
        padding-top: 20px;
        border-top: 1px solid rgba(255, 255, 255, 0.1);
    }

    .amenity-item {
        display: flex;
        align-items: center;
        gap: 6px;
        font-size: 0.85rem;
        color: #e2e8f0;
    }

    .amenity-item i {
        width: 16px;
        height: 16px;
        color: #d2e3c8;
    }

    .card-footer {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-top: auto;
    }

    .card-price {
        display: flex;
        flex-direction: column;
    }

    .price-value {
        font-size: 1.5rem;
        font-weight: 700;
        color: #d2e3c8;
    }

    .price-label {
        font-size: 0.8rem;
        color: #ccd7cc;
    }

    .book-btn {
        padding: 0.8rem 1.8rem;
        background-color: var(--primary);
        color: var(--white);
        border-radius: 0.6rem;
        font-size: 0.9rem;
        font-weight: 600;
        transition: all 0.3s cubic-bezier(0.165, 0.84, 0.44, 1);
        box-shadow: 0 4px 10px rgba(79, 111, 82, 0.3);
    }

    .book-btn:hover {
        background-color: var(--secondary);
        transform: translateY(-2px);
        box-shadow: 0 6px 15px rgba(115, 144, 114, 0.45);
    }

    @media (max-width: 768px) {
        .accommodation-section {
            padding: 120px 5% 60px;
        }
        .accommodation-title h2 {
            font-size: 2.5rem;
        }
        .accommodation-grid {
            gap: 25px;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
        }
        .card-img-container {
            height: 220px;
        }
    }
</style>

<section class="accommodation-section page-fade-in">

    <div class="accommodation-title">
        <h2>Stay in <span>Kundasang</span></h2>
        <p>
            Experience the legendary cool climate of the Sabah highlands. From luxury alpine resorts 
            with panoramic views of Mount Kinabalu to cozy valley cottages and glamping domes, 
            find your perfect home away from home.
        </p>
    </div>

    <div class="accommodation-grid">

        <!-- Accommodation 1: Mountain Valley Resort -->
        <div class="accommodation-card">
            <div class="card-img-container">
                <img src="img/accommodations/Mountain Valley Resort.jpg" alt="Mountain Valley Resort">
                <span class="card-badge">Eco-Luxury</span>
            </div>
            <div class="card-details">
                <div class="card-rating">
                    <i data-feather="star"></i>
                    <span>4.8 (192 reviews)</span>
                </div>
                <h3>Mountain Valley Resort</h3>
                <div class="card-location">
                    <i data-feather="map-pin"></i>
                    <span>Jalan Tenompok, Bundu Tuhan, Kundasang</span>
                </div>
                <p class="card-desc">
                    Perched 1,200 meters above sea level in the foothills of Mount Kinabalu. Offers a serene mountain escape with private balconies overlooking the majestic peak and lush valleys.
                </p>
                <div class="card-amenities">
                    <span class="amenity-item" title="Free Wi-Fi">
                        <i data-feather="wifi"></i> Wi-Fi
                    </span>
                    <span class="amenity-item" title="Restaurant">
                        <i data-feather="coffee"></i> KLOUD Cafe
                    </span>
                    <span class="amenity-item" title="Private Balcony">
                        <i data-feather="wind"></i> Balcony
                    </span>
                </div>
                <div class="card-footer">
                    <div class="card-price">
                        <span class="price-value">RM 288</span>
                        <span class="price-label">per night</span>
                    </div>
                    <a href="https://www.booking.com/hotel/my/mountain-valley-resort.html" target="_blank" rel="noopener noreferrer" class="book-btn">More Info</a>
                </div>
            </div>
        </div>

        <!-- Accommodation 2: Bayu Senja -->
        <div class="accommodation-card">
            <div class="card-img-container">
                <img src="img/accommodations/bayusenja.jpg" alt="Bayu Senja Lodge">
                <span class="card-badge">Tranquil Cabin</span>
            </div>
            <div class="card-details">
                <div class="card-rating">
                    <i data-feather="star"></i>
                    <span>4.9 (112 reviews)</span>
                </div>
                <h3>Bayu Senja Lodge</h3>
                <div class="card-location">
                    <i data-feather="map-pin"></i>
                    <span>Kg. Dumpiring, Kundasang</span>
                </div>
                <p class="card-desc">
                    A peaceful cabin retreat in the scenic highlands, offering stunning panoramic mountain views and a cozy, home-like shared kitchen for a relaxing holiday.
                </p>
                <div class="card-amenities">
                    <span class="amenity-item" title="Shared Kitchen">
                        <i data-feather="home"></i> Kitchen
                    </span>
                    <span class="amenity-item" title="Flat-screen TV">
                        <i data-feather="tv"></i> Smart TV
                    </span>
                    <span class="amenity-item" title="Terrace">
                        <i data-feather="sunset"></i> Terrace
                    </span>
                </div>
                <div class="card-footer">
                    <div class="card-price">
                        <span class="price-value">RM 120</span>
                        <span class="price-label">per night</span>
                    </div>
                    <a href="https://www.booking.com/hotel/my/bayu-senja-lodge.html" target="_blank" rel="noopener noreferrer" class="book-btn">More Info</a>
                </div>
            </div>
        </div>

        <!-- Accommodation 3: Umea Glamping -->
        <div class="accommodation-card">
            <div class="card-img-container">
                <img src="img/accommodations/Glamping.jpg" alt="Umea Glam Kundasang">
                <span class="card-badge">Nordic Style</span>
            </div>
            <div class="card-details">
                <div class="card-rating">
                    <i data-feather="star"></i>
                    <span>4.8 (145 reviews)</span>
                </div>
                <h3>Umea Glam Kundasang</h3>
                <div class="card-location">
                    <i data-feather="map-pin"></i>
                    <span>Jalan Golf Course Mesilau, Kundasang</span>
                </div>
                <p class="card-desc">
                    Kundasang's premier glamping dome site. Stay in beautifully themed, cozy domes inspired by Swedish cities, offering spectacular 180-degree valley views and stargazing.
                </p>
                <div class="card-amenities">
                    <span class="amenity-item" title="Themed Dome">
                        <i data-feather="gift"></i> Luxury
                    </span>
                    <span class="amenity-item" title="Heater">
                        <i data-feather="wind"></i> Heater
                    </span>
                    <span class="amenity-item" title="BBQ Area">
                        <i data-feather="sunset"></i> BBQ Area
                    </span>
                </div>
                <div class="card-footer">
                    <div class="card-price">
                        <span class="price-value">RM 290</span>
                        <span class="price-label">per night</span>
                    </div>
                    <a href="https://umeaglam-kundasang.com/" target="_blank" rel="noopener noreferrer" class="book-btn">More Info</a>
                </div>
            </div>
        </div>

        <!-- Accommodation 4: Sutera Sanctuary Laban Rata -->
        <div class="accommodation-card">
            <div class="card-img-container">
                <img src="img/accommodations/suterasanctuarylabanrata.jpg" alt="Sutera Sanctuary Laban Rata">
                <span class="card-badge">Climbers Base</span>
            </div>
            <div class="card-details">
                <div class="card-rating">
                    <i data-feather="star"></i>
                    <span>4.8 (340 reviews)</span>
                </div>
                <h3>Sutera Sanctuary Laban Rata</h3>
                <div class="card-location">
                    <i data-feather="map-pin"></i>
                    <span>Mount Kinabalu (3,272m Alt), Ranau</span>
                </div>
                <p class="card-desc">
                    The essential high-altitude base camp for climbers scaling Mount Kinabalu. Offers comfortable rooms and full-board dining to rest and refuel before the midnight summit push.
                </p>
                <div class="card-amenities">
                    <span class="amenity-item" title="Restaurant">
                        <i data-feather="coffee"></i> Buffet Dining
                    </span>
                    <span class="amenity-item" title="Climbing Base">
                        <i data-feather="trending-up"></i> 3,272m Alt
                    </span>
                    <span class="amenity-item" title="Dormitories & Rooms">
                        <i data-feather="home"></i> Cozy Rooms
                    </span>
                </div>
                <div class="card-footer">
                    <div class="card-price">
                        <span class="price-value">RM 1,240</span>
                        <span class="price-label">per night</span>
                    </div>
                    <a href="https://suterasanctuarylodges.com.my/" target="_blank" rel="noopener noreferrer" class="book-btn">More Info</a>
                </div>
            </div>
        </div>

    </div>

</section>

<%@ include file="includes/footer.jsp" %>
