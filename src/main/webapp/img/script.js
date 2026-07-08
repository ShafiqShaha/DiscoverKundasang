// ========================================
// MOBILE NAVIGATION
// ========================================

// Navbar menu
const navbarNav = document.querySelector(".navbar-nav");

// Menu toggle button
const menuToggle = document.querySelector("#menu-toggle");

// Toggle navbar on mobile
menuToggle.onclick = (e) => {
  e.preventDefault();

  navbarNav.classList.toggle("active");
};

// ========================================
// CLOSE NAVBAR WHEN CLICK OUTSIDE
// ========================================

document.addEventListener("click", function (e) {
  if (!menuToggle.contains(e.target) && !navbarNav.contains(e.target)) {
    navbarNav.classList.remove("active");
  }
});

// ========================================
// LOGIN MODAL
// ========================================

// Get elements
const loginButton = document.querySelector("#login-button");

const loginModal = document.querySelector("#login-modal");

const closeLogin = document.querySelector("#close-login");

// Open login modal
loginButton.onclick = (e) => {
  e.preventDefault();

  loginModal.style.display = "flex";
};

// Close login modal
closeLogin.onclick = () => {
  loginModal.style.display = "none";
};

// Close modal when clicking outside
window.onclick = (e) => {
  if (e.target === loginModal) {
    loginModal.style.display = "none";
  }
};
