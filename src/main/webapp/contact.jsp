<%
    String pageTitle = "Contact";
    String successMessage = (String) session.getAttribute("successMessage");
    String errorMessage = (String) session.getAttribute("errorMessage");
    session.removeAttribute("successMessage");
    session.removeAttribute("errorMessage");
%>

<%@ include file="includes/header.jsp" %>

<style>
    /* Contact External Link Styles */
    .map-link-container {
        text-align: center;
        margin-top: 15px;
        margin-bottom: 25px;
    }

    .map-link {
        display: inline-flex;
        align-items: center;
        gap: 8px;
        color: #d2e3c8;
        font-weight: 600;
        font-size: 1rem;
        transition: 0.3s;
        border: 2px solid #d2e3c8;
        padding: 0.6rem 1.2rem;
        border-radius: 0.5rem;
    }

    .map-link:hover {
        background-color: #d2e3c8;
        color: #111e12;
    }

    .map-link i {
        width: 18px;
        height: 18px;
    }

    .btn-clear {
        background-color: #888888 !important;
    }

    .btn-clear:hover {
        background-color: #666666 !important;
    }
</style>

<!-- ==========================================
                 CONTACT SECTION
=========================================== -->

<section class="contact page-fade-in">

    <h2><span>Contact</span> Us</h2>

    <p>
        Have questions or want to plan your trip to Kundasang? Fill out the form below
        or locate us on the map. We look forward to welcoming you to the Sabah highlands!
    </p>

    <!-- Success Message Alert -->
    <% if (successMessage != null) { %>
        <div class="success-alert" style="background-color: var(--accent); color: var(--primary); padding: 1.2rem; border-radius: 0.5rem; margin-bottom: 2rem; display: flex; align-items: center; gap: 0.8rem; font-weight: 500; border: 1px solid var(--secondary); max-width: 90rem; margin-left: auto; margin-right: auto;">
            <i data-feather="check-circle" style="flex-shrink: 0;"></i>
            <span><%= successMessage %></span>
        </div>
    <% } %>

    <!-- Error Message Alert -->
    <% if (errorMessage != null) { %>
        <div class="error-alert" style="background-color: #fce8e6; color: #c5221f; padding: 1.2rem; border-radius: 0.5rem; margin-bottom: 2rem; display: flex; align-items: center; gap: 0.8rem; font-weight: 500; border: 1px solid #fad2cf; max-width: 90rem; margin-left: auto; margin-right: auto;">
            <i data-feather="alert-circle" style="flex-shrink: 0;"></i>
            <span><%= errorMessage %></span>
        </div>
    <% } %>

    <div class="row">

        <!-- Google Map Embedding (Kundasang, Sabah, Malaysia) -->
        <div style="flex: 1 1 45rem; display: flex; flex-direction: column;">
            <iframe
                src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d63507.82885910486!2d116.52988358249826!3d6.002246736207865!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x323b374bc73c4ec5%3A0x8670df5ea947bb3f!2sKundasang%2C%20Sabah!5e0!3m2!1sen!2smy!4v1720000000000!5m2!1sen!2smy"
                class="map"
                style="border:0; border-radius: 1rem 1rem 0 0;"
                allowfullscreen=""
                loading="lazy"
                referrerpolicy="no-referrer-when-downgrade">
            </iframe>
            
            <div class="map-link-container">
                <a href="https://maps.google.com/?q=Kundasang,+Sabah" target="_blank" class="map-link">
                    <i data-feather="external-link"></i>
                    View on Google Maps (New Tab)
                </a>
            </div>
        </div>

        <!-- Contact Form -->
        <form action="InquiryServlet" method="POST">

            <!-- Name -->
            <div class="input-group">
                <i data-feather="user"></i>
                <input type="text" name="name" placeholder="Full Name" required>
            </div>

            <!-- Contact Number -->
            <div class="input-group">
                <i data-feather="phone"></i>
                <input type="tel" name="contact_number" placeholder="Contact Number" required>
            </div>

            <!-- Gender -->
            <div class="input-group">
                <i data-feather="users"></i>
                <select name="gender" required>
                    <option value="" disabled selected hidden>Select Gender</option>
                    <option value="Male">Male</option>
                    <option value="Female">Female</option>
                    <option value="Prefer not to say">Prefer not to say</option>
                </select>
            </div>

            <!-- Email Address -->
            <div class="input-group">
                <i data-feather="mail"></i>
                <input type="email" name="email" placeholder="Email Address" required>
            </div>

            <!-- Source (How did you know about us?) -->
            <div class="input-group">
                <i data-feather="help-circle"></i>
                <select name="source" required>
                    <option value="" disabled selected hidden>How did you know about us?</option>
                    <option value="Social Media">Social Media</option>
                    <option value="Friend or Family">Friend or Family</option>
                    <option value="Search Engine">Search Engine</option>
                    <option value="Newspaper or Magazine">Newspaper or Magazine</option>
                    <option value="Other">Other</option>
                </select>
            </div>

            <!-- Message -->
            <div class="input-group">
                <i data-feather="message-square"></i>
                <textarea name="message" rows="5" placeholder="Your Message" required></textarea>
            </div>

            <!-- Actions -->
            <div style="margin-top: 2rem; display: flex; gap: 15px;">
                <button type="submit" class="btn">Submit</button>
                <button type="reset" class="btn btn-clear">Clear</button>
            </div>

        </form>

    </div>

</section>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        const urlParams = new URLSearchParams(window.location.search);
        const resort = urlParams.get('resort');
        
        const resorts = {
            'mountain-valley': 'Mountain Valley Resort',
            'bayu-senja': 'Bayu Senja Lodge',
            'umea-glamping': 'Umea Glam Kundasang',
            'sutera-sanctuary': 'Sutera Sanctuary Laban Rata'
        };
        
        if (resort && resorts[resort]) {
            const selectedName = resorts[resort];
            
            // Pre-fill message box
            const messageArea = document.querySelector("textarea[name='message']");
            if (messageArea) {
                messageArea.value = `Hi, I would like to book a stay at ${selectedName}. Please assist me with availability, rates, and the booking process. Thank you!`;
            }
            
            // Add a small tag/badge above map to show selected resort
            const mapIframe = document.querySelector(".map");
            if (mapIframe) {
                const mapContainer = mapIframe.parentElement;
                const heading = document.createElement("div");
                heading.style.padding = "15px";
                heading.style.background = "var(--primary)";
                heading.style.color = "white";
                heading.style.fontWeight = "600";
                heading.style.fontSize = "1.05rem";
                heading.style.borderRadius = "1rem 1rem 0 0";
                heading.style.textAlign = "center";
                heading.style.letterSpacing = "0.5px";
                heading.style.boxShadow = "0 4px 10px rgba(0,0,0,0.05)";
                heading.innerText = `Booking Inquiry: ${selectedName}`;
                
                mapIframe.style.borderRadius = "0";
                mapContainer.insertBefore(heading, mapIframe);
            }
        }
    });
</script>

<%@ include file="includes/footer.jsp" %>
