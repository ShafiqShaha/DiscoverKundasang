// ========================================
// MOBILE NAVIGATION
// ========================================

// Navbar menu
const navbarNav = document.querySelector(".navbar-nav");

// Menu toggle button
const menuToggle = document.querySelector("#menu-toggle");

if (menuToggle && navbarNav) {
  // Toggle navbar on mobile
  menuToggle.onclick = (e) => {
    e.preventDefault();
    navbarNav.classList.toggle("active");
  };

  // Close navbar when click outside
  document.addEventListener("click", function (e) {
    if (!menuToggle.contains(e.target) && !navbarNav.contains(e.target)) {
      navbarNav.classList.remove("active");
    }
  });
}

// ========================================
// CINEMATIC PRELOADER & PAGE REVEAL
// ========================================
function initPreloader() {
  const preloader = document.getElementById("preloader");
  if (preloader) {
    // Elegant fade out after a brief dramatic loading progress (1.2s)
    setTimeout(() => {
      preloader.classList.add("fade-out");
      document.body.classList.add("loaded");
    }, 1200);
  } else {
    // Immediate activation for other pages
    document.body.classList.add("loaded");
  }
}

if (document.readyState === "loading") {
  document.addEventListener("DOMContentLoaded", initPreloader);
} else {
  initPreloader();
}
