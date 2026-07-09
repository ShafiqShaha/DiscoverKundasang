<!-- ==========================================
                    FOOTER
=========================================== -->

<footer>

    <div class="socials">

        <a href="#">
            <i data-feather="facebook"></i>
        </a>

        <a href="#">
            <i data-feather="instagram"></i>
        </a>

        <a href="#">
            <i data-feather="twitter"></i>
        </a>

    </div>

    <div class="links">

        <a href="index.jsp">Home</a>

        <a href="gallery.jsp">Gallery</a>

        <a href="activities.jsp">Activities</a>

        <a href="accommodation.jsp">Accommodation</a>

        <a href="contact.jsp">Contact</a>

        <a href="developer.jsp">Developer</a>

    </div>

    <div class="credit">

        <p>

            Created by
            <strong>Shafiq Shaha</strong>

            | &copy; 2026

        </p>

    </div>

</footer>

<!-- Feather Icons -->

<script>
    feather.replace();
</script>

<%
    boolean isPublicPageForMusic = "Home".equals(pageTitle) ||
                                   "Gallery".equals(pageTitle) ||
                                   "Activities".equals(pageTitle) ||
                                   "Accommodations".equals(pageTitle) ||
                                   "Contact".equals(pageTitle) ||
                                   "Developer Profile".equals(pageTitle);

    if (isPublicPageForMusic) {
%>
    <!-- Background Music Player -->
    <div class="music-player-container">
        <audio id="bg-music" src="audio/lofi.mp3" loop></audio>
        <button id="music-toggle" class="music-btn" title="Toggle Background Music">
            <i id="music-icon" data-feather="volume-x"></i>
        </button>
    </div>
    
    <style>
        .music-player-container {
            position: fixed;
            bottom: 30px;
            right: 30px;
            z-index: 99999;
        }
        .music-btn {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background: rgba(17, 30, 18, 0.75);
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            border: 2px solid rgba(210, 227, 200, 0.4);
            color: #d2e3c8;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.25);
            transition: all 0.3s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            outline: none;
        }
        .music-btn:hover {
            transform: scale(1.1);
            border-color: #d2e3c8;
            background: rgba(17, 30, 18, 0.9);
            box-shadow: 0 12px 30px rgba(79, 111, 82, 0.4);
        }
        .music-btn i {
            width: 22px;
            height: 22px;
            pointer-events: none;
        }
        
        /* Animation when playing */
        .music-btn.playing {
            animation: musicPulseWave 2s infinite;
        }
        @keyframes musicPulseWave {
            0% {
                box-shadow: 0 0 0 0 rgba(210, 227, 200, 0.4), 0 10px 25px rgba(0, 0, 0, 0.25);
            }
            70% {
                box-shadow: 0 0 0 12px rgba(210, 227, 200, 0), 0 10px 25px rgba(0, 0, 0, 0.25);
            }
            100% {
                box-shadow: 0 0 0 0 rgba(210, 227, 200, 0), 0 10px 25px rgba(0, 0, 0, 0.25);
            }
        }
    </style>

    <script>
        document.addEventListener("DOMContentLoaded", function() {
            const audio = document.getElementById("bg-music");
            const btn = document.getElementById("music-toggle");
            const icon = document.getElementById("music-icon");

            // Set volume
            audio.volume = 0.35;

            // Load saved state
            const savedState = localStorage.getItem("musicPlaying");
            const savedTime = localStorage.getItem("musicTime");

            if (savedTime) {
                audio.currentTime = parseFloat(savedTime);
            }

            // Sync UI state
            if (savedState === "true") {
                audio.play().then(() => {
                    btn.classList.add("playing");
                    icon.setAttribute("data-feather", "volume-2");
                    if (window.feather) feather.replace();
                }).catch(e => {
                    // Browser blocked autoplay, default to muted state
                    btn.classList.remove("playing");
                    icon.setAttribute("data-feather", "volume-x");
                    localStorage.setItem("musicPlaying", "false");
                    if (window.feather) feather.replace();
                });
            } else {
                btn.classList.remove("playing");
                icon.setAttribute("data-feather", "volume-x");
                if (window.feather) feather.replace();
            }

            // Play / Pause toggle
            btn.addEventListener("click", function(e) {
                e.stopPropagation();
                if (audio.paused) {
                    audio.play().then(() => {
                        btn.classList.add("playing");
                        icon.setAttribute("data-feather", "volume-2");
                        localStorage.setItem("musicPlaying", "true");
                        if (window.feather) feather.replace();
                    });
                } else {
                    audio.pause();
                    btn.classList.remove("playing");
                    icon.setAttribute("data-feather", "volume-x");
                    localStorage.setItem("musicPlaying", "false");
                    if (window.feather) feather.replace();
                }
            });

            // Save playback time
            audio.addEventListener("timeupdate", function() {
                if (!audio.paused) {
                    localStorage.setItem("musicTime", audio.currentTime);
                }
            });
        });
    </script>
<% } %>

<!-- JavaScript -->

<script src="js/script.js?v=<%= System.currentTimeMillis() %>"></script>

</body>
</html>