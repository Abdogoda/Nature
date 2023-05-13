const sign_in_btn = document.querySelector("#sign-in-btn");
const sign_up_btn = document.querySelector("#sign-up-btn");
const container = document.querySelector(".container");

sign_up_btn.addEventListener("click", () => {
 container.classList.add("sign-up-mode");
});

sign_in_btn.addEventListener("click", () => {
 container.classList.remove("sign-up-mode");
});

// sign in validation
const sign_in_form = document.getElementById("sign-in-form");
sign_in_form.addEventListener("submit", (e) => {
	 e.preventDefault();
	 document.querySelectorAll(".error").forEach(element => {
		element.classList.remove("error")
	   	  });
	   	const l_email = document.getElementById("l_email");
		const l_password = document.getElementById("l_password");
	    if (!isValidEmail(l_email)) {
		    createToast("warning", "Please Enter A Valid Email!");
		    email.classList.add("error");
		}else if (!isValidPassword(l_password)) {
		    createToast("warning", "Password Must Be More Than 6 Characters!");
		    password.classList.add("error");
		}else{
			sign_in_form.submit();
		}
});
	   	 
	  
const sign_up_form = document.getElementById("sign-up-form");
sign_up_form.addEventListener("submit", (e) => {
	 e.preventDefault();
	 document.querySelectorAll(".error").forEach(element => {
	   	    element.classList.remove("error")
	   	  });
		const name = document.getElementById("name"); 
		const email = document.getElementById("email");
		const phone = document.getElementById("phone");
		const address = document.getElementById("address");
		const password = document.getElementById("password");
	    if (!isValidName(name)) {
		    createToast("warning", "Name Must Be More Than 3 Characters!");
		    name.classList.add("error");
		}else if (!isValidEmail(email)) {
		    createToast("warning", "Please Enter A Valid Email!");
		    email.classList.add("error");
		}else if (!isValidPhone(phone)) {
		    createToast("warning", "Please Enter A Valid Phone!");
		    phone.classList.add("error");
		}else if (!isValidAddress(address)) {
		    createToast("warning", "Address Must Be More Than 6 Characters!");
		    address.classList.add("error");
		} if (!isValidPassword(password)) {
		    createToast("warning", "Password Must Be More Than 6 Characters!");
		    password.classList.add("error");
		}else if (!isValidImage()) {
		    createToast("warning", "Invalid Image!");
		}else{
			sign_up_form.submit();
		}
 });

	   function isValidPassword(password) {
    		return password.value.length >= 6;
	   }
	   function isValidEmail(email) {
			const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
			return emailRegex.test(email.value);
		}
	   function isValidName(name) {
			return name.value.length > 3;
		}
		function isValidAddress(address) {
			return address.value.length > 6;
		}
	   function isValidPhone(number) {
		   if (number.value.length !== 11) {
		     return false;
		   }
		   if (!number.value.startsWith('01')) {
		     return false;
		   }
		   if (!/^\d+$/.test(number.value)) {
		     return false;
		   }
		   return true;
		 }
	   function isValidImage() {
		   const image = document.getElementById('image');
		   if (image.files.length > 0) {
		     const fileType = image.files[0].type;
		     const fileSize = image.files[0].size;
		     const maxSize = 5 * 1024 * 1024; // 5 MB
		     if (!fileType.startsWith('image/')) {
				createToast("warning", "Invalid Image Type!");
				image.classList.add("error");
		       	return false;
		     }
		     if (fileSize > maxSize) {
			    createToast("warning", "Image Size Must Be Less Than 5MB!");
			    image.classList.add("error");		       
			    return false;
		     }
		   }
		   return true;
		 }