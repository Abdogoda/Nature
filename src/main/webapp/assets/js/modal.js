var modalsBtn = document.querySelectorAll(".open-modal");
modalsBtn.forEach((modalBtn) => {
 modalBtn.addEventListener("click", () => {
  let modal = document.getElementById(`${modalBtn.dataset.modal}`);
  let closeModal = modal.querySelector(".close-modal");
  modal.style.display = "block";
  closeModal.onclick = function () {
   modal.style.display = "none";
  };
  window.onclick = function (event) {
   if (event.target == modal) {
    modal.style.display = "none";
   }
  };
  //Edit Product Modal
  if(modal.id == "editProductModal" && modalBtn.dataset.modal == "editProductModal"){
	  modal.querySelector("#o_id").value = modalBtn.getAttribute("data-id");
	  modal.querySelector("#o_name").value = modalBtn.getAttribute("data-name");
	  modal.querySelector("#o_price").value = modalBtn.getAttribute("data-price");
	  modal.querySelector("#o_img_src").src = "uploaded_img/products/"+modalBtn.getAttribute("data-image");
	  modal.querySelector("#o_description").textContent = modalBtn.getAttribute("data-description");
	  modal.querySelector("#o_category").innerHTML += `<option value="${modalBtn.getAttribute("data-category")}" selected>${modalBtn.getAttribute("data-category")}</option>`;
  }
  //Edit User Modal
  if(modal.id == "editUserModal" && modalBtn.dataset.modal == "editUserModal"){
	  modal.querySelector("#id").value = modalBtn.getAttribute("data-id");
	  modal.querySelector("#name").value = modalBtn.getAttribute("data-name");
	  modal.querySelector("#phone").value = modalBtn.getAttribute("data-phone");
	  modal.querySelector("#email").value = modalBtn.getAttribute("data-email");
	  modal.querySelector("#img_src").src = "uploaded_img/users/"+modalBtn.getAttribute("data-image");
  }
  //Edit Permission Modal
  if(modal.id == "editPermissionModal" && modalBtn.dataset.modal == "editPermissionModal"){
	  modal.querySelector("#id").value = modalBtn.getAttribute("data-id");
	  modal.querySelector("#name").value = modalBtn.getAttribute("data-name");
  }
 });
});
