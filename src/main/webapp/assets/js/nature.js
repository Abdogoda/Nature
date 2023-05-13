//======== TOGGLE NAVBAR ==============
const openNav = document.querySelector(".open-nav");
const closeNav = document.querySelector(".close-nav");
const nav = document.querySelector("nav");
const navTop = document.querySelector(".nav-top");
const navBottom = document.querySelector(".nav-bottom");
const main = document.querySelector("main");
openNav.addEventListener("click", () => {
 navBottom.classList.toggle("active");
});
closeNav.addEventListener("click", () => {
 navBottom.classList.remove("active");
});
//======== TOGGLE SEARSH ==============
const openSearch = document.querySelector(".open-search");
const searchBox = document.querySelector(".search-box");
openSearch.addEventListener("click", () => {
 openSearch.querySelector("i").classList.toggle("fa-x");
 searchBox.classList.toggle("active");
});
//========== BACK TO UP =========
const backTopBtn = document.querySelector(".back-to-top");
backTopBtn.addEventListener("click", () => {
 document.documentElement.scrollTop = 0;
});

//======== WINDOW SCROLL =======
let lastScrolledPos = 0;
window.addEventListener("scroll", () => {
 if (window.innerWidth > 567) {
  //======== STICKY HEADER =======
  if (window.scrollY > 0) {
   navBottom.classList.add("hide");
   nav.classList.add("hideNav");
   main.classList.add("hideNav");
  } else {
   nav.classList.remove("hideNav");
   main.classList.remove("hideNav");
   backTopBtn.classList.remove("active");
  }
  if (lastScrolledPos >= window.scrollY) {
   navBottom.classList.remove("hide");
   nav.classList.remove("hideNav");
   main.classList.remove("hideNav");
  } else {
   navBottom.classList.add("hide");
   nav.classList.add("hideNav");
   main.classList.add("hideNav");
  }
  lastScrolledPos = window.scrollY;
 }
 if (window.scrollY > 150) {
  backTopBtn.classList.add("active");
 } else {
  navBottom.classList.remove("hide");
 }
});

// ########## ACTIVE NAV LINK
const currentUrl = window.location.href;
document.querySelectorAll(".nav-bottom ul li a").forEach((navLink) => {
 if (navLink.href == currentUrl) {
  navLink.parentElement.classList.add("active");
 }
});
