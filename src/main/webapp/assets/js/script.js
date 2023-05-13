// ACTIVE SIDE MENUE LINK
const allSideMenu = document.querySelectorAll("#sidebar .side-menu li a");
allSideMenu.forEach((item) => {
 const li = item.parentElement;
 const page = window.location.href;
 if (item.href == window.location.href) {
  li.classList.add("active");
 }
});

// TOGGLE SIDEBAR
const menuBar = document.querySelector("nav .sidebar-toggler");
const sidebar = document.getElementById("sidebar");
menuBar.addEventListener("click", function () {
 if (window.innerWidth > 576) {
  sidebar.classList.toggle("hide");
 } else {
  sidebar.classList.toggle("show");
  menuBar.classList.toggle("fa-x");
 }
});

// SEARCH FORM
const searchButton = document.querySelector(
 "#content nav form .form-input button"
);
const searchButtonIcon = document.querySelector(
 "#content nav form .form-input button .fas"
);
const searchForm = document.querySelector("#content nav form");
searchButton.addEventListener("click", function (e) {
 if (window.innerWidth < 576) {
  e.preventDefault();
  searchForm.classList.toggle("show");
  if (searchForm.classList.contains("show")) {
   searchButtonIcon.classList.replace("fa-search", "fa-x");
  } else {
   searchButtonIcon.classList.replace("fa-x", "fa-search");
  }
 }
});

if (window.innerWidth < 768 && window.innerWidth > 576) {
 sidebar.classList.add("hide");
} else if (window.innerWidth > 576) {
 searchButtonIcon.classList.replace("fa-x", "fa-search");
 searchForm.classList.remove("show");
}

window.addEventListener("resize", function () {
 if (this.innerWidth > 576) {
  searchButtonIcon.classList.replace("fa-x", "fa-search");
  searchForm.classList.remove("show");
 }
});

// TOGGLE THEME
const switchMode = document.getElementById("switch-mode");
const theme = localStorage.getItem("theme");
if (theme === "dark") {
 document.body.classList.add("dark");
 switchMode.checked = true;
} else {
 document.body.classList.remove("dark");
 switchMode.checked = false;
}
switchMode.addEventListener("change", function () {
 if (this.checked) {
  localStorage.setItem("theme", "dark");
  document.body.classList.add("dark");
 } else {
  localStorage.setItem("theme", "light");
  document.body.classList.remove("dark");
 }
});

// TOGGLE NOTIFICATION
const notificationBtn = document.querySelector(".notification");
const notificationBox = document.querySelector(".notification-box");
notificationBtn.addEventListener("click", () => {
 notificationBox.classList.toggle("show");
});

//FILTER PRODUCTS
const filterBtns = document.querySelectorAll(".filter-con ul li");
const productCategories = document.querySelectorAll(".product-card p.category");
filterBtns.forEach((filterBtn) => {
 filterBtn.addEventListener("click", () => {
  filterBtns.forEach((f) => {
   f.classList.remove("active");
  });
  filterBtn.classList.add("active");
  var categoryFilter = filterBtn.dataset.filter.toLowerCase();
  productCategories.forEach((productCategory) => {
   var productCard = productCategory.parentElement.parentElement;
   if (categoryFilter == "all") {
    productCard.style.display = "block";
   } else {
    if (productCategory.dataset.category.toLowerCase() != categoryFilter) {
     productCard.style.display = "none";
    } else {
     productCard.style.display = "block";
    }
   }
  });
 });
});
