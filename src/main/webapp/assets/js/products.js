//======== TOGGLE FILTERS ==============
const openFilters = document.querySelector(".open-filters");
const closeFilters = document.querySelector(".close-filters");
const filters = document.querySelector(".col-1-of-4");
if (openFilters && closeFilters) {
 openFilters.addEventListener("click", () => {
  filters.classList.add("show");
 });
 closeFilters.addEventListener("click", () => {
  filters.classList.remove("show");
 });
}
// ######### FILTERATION CATEGORY
var checkboxes = document.querySelectorAll(
 '.block-content input[type="checkbox"]'
);
var checkedBoxes = [];
var allCategories = document.querySelectorAll(
 ".product-layout .product .category"
);
var allProducts = document.querySelectorAll(".product-layout .product");
FilterCategory = function (categoryValue) {
 if (checkedBoxes.includes(categoryValue.toLowerCase())) {
  checkedBoxes = checkedBoxes.filter((e) => e != categoryValue.toLowerCase());
 } else {
  checkedBoxes.push(categoryValue.toLowerCase());
 }
 if (checkedBoxes.length > 0) {
  allProducts.forEach((p) => {
   p.style.display = "none";
  });
  allCategories.forEach((c) => {
   if (checkedBoxes.includes(c.dataset.category.toLowerCase())) {
    c.parentElement.parentElement.style.display = "block";
   }
  });
 } else {
  allProducts.forEach((p) => {
   p.style.display = "block";
  });
 }
};

// ########## SET PRICE RANGE VALUE
document.getElementById("price_range").oninput = function () {
 document.getElementById("price_range_value").textContent = this.value;
};
