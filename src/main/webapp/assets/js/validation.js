	function isMoreThanThree(input) {
		return input.value.length >= 3;
    }
    function isMoreThanSix(input) {
		return input.value.length >= 6;
	   }
	   function isSelectOption(option) {
			return option.value != 0;
	   }
	   function isValidNumber(input) {
			return !isNaN(parseFloat(input.value));
		}
	   function isValidImage(image) {
		if (image.files[0].length > 0) {
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
		 
		 function isValidEmail(email) {
			const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
			return emailRegex.test(email.value);
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


function isAcceptedDate(birthDate) {
  const currentDate = new Date();
  const twentyYearsAgo = new Date();
  twentyYearsAgo.setFullYear(currentDate.getFullYear() - 18);
  const day = birthDate.value.split('-')[0];
  const month = birthDate.value.split('-')[1];
  const year = birthDate.value.split('-')[2];
  const inputDate = new Date(year, month - 1, day);
  return inputDate <= twentyYearsAgo;
}
	 
		 
//===========================
//=== Add Product Validation
//===========================
const addProductForm = document.getElementById('addProductForm');
if(addProductForm){
	const name = document.getElementById("name");
	  const description = document.getElementById("description");
	  const category = document.getElementById("category");
	  const price = document.getElementById("price");
	  const image = document.getElementById("image");
	  addProductForm.addEventListener('submit', function(event) {
	   	event.preventDefault();
	   	 document.querySelectorAll(".error").forEach(element => {
	   	    element.classList.remove("error")
	   	  });
	   	if (!isMoreThanThree(name)) {
		    createToast("warning", "Name Must Be More Than 3 Characters!");
		    name.classList.add("error");
		}else if (!isMoreThanThree(description)) {
		    createToast("warning", "Description Must Be More Than 3 Characters!");
		    description.classList.add("error");
		}else if (!isSelectOption(category)) {
		    createToast("warning", "Please Select A Category!");
		    category.classList.add("error");
		}else if (!isValidNumber(price)) {
		    createToast("warning", "Please Enter A Valid Pirce: 'Integer - Float' Values!");
		    price.classList.add("error");
		}else if (!isValidImage(image)) {
		    createToast("warning", "Invalid Image!");
		}else{
			addProductForm.submit();
		}
	  });
}	
	  	 
//===========================
//=== Add Product Validation
//===========================
const editProductForm = document.getElementById('editProductForm');
if(editProductForm){
  const o_name = document.getElementById("o_name");
  const o_description = document.getElementById("o_description");
  const o_category = document.getElementById("o_category");
  const o_price = document.getElementById("o_price");
  const o_image = document.getElementById("o_image");
  editProductForm.addEventListener('submit', function(event) {
   	event.preventDefault();
   	 document.querySelectorAll(".error").forEach(element => {
   	    element.classList.remove("error")
   	  });
   	if (!isMoreThanThree(o_name)) {
	    createToast("warning", "Name Must Be More Than 3 Characters!");
	    o_name.classList.add("error");
	}else if (!isMoreThanThree(o_description)) {
	    createToast("warning", "Description Must Be More Than 3 Characters!");
	    o_description.classList.add("error");
	}else if (!isSelectOption(o_category)) {
	    createToast("warning", "Please Select A Category!");
	    o_category.classList.add("error");
	}else if (!isValidNumber(o_price)) {
	    createToast("warning", "Please Enter A Valid Pirce: 'Integer - Float' Values!");
	    o_price.classList.add("error");
	}else{
		editProductForm.submit();
	}
  });
}
//===========================
//=== Edit User Validation
//===========================
const editUserForm = document.getElementById('editUserForm');
  if(editUserForm){
	  const o_u_name = document.getElementById("name");
	  const o_u_email = document.getElementById("email");
	  const o_u_phone = document.getElementById("phone");
	  editUserForm.addEventListener('submit', function(event) {
	   	event.preventDefault();
	   	 document.querySelectorAll(".error").forEach(element => {
	   	    element.classList.remove("error")
	   	  });
	   	if (!isMoreThanThree(o_u_name)) {
		    createToast("warning", "Name Must Be More Than 3 Characters!");
		    o_u_name.classList.add("error");
		}else if (!isValidEmail(o_u_email)) {
		    createToast("warning", "Please Enter Avalid Email!");
		    o_description.classList.add("error");
		}else if (!isValidPhone(o_u_phone)) {
		    createToast("warning", "Please Enter A Valid Phone!");
		    o_category.classList.add("error");
		}else{
			editUserForm.submit();
		}
	  });
  }

//===========================
//=== Add User Validation
//===========================
const addUserForm = document.getElementById('addUserForm');
  if(addUserForm){
	  const u_name = document.getElementById("name");
	  const u_email = document.getElementById("email");
	  const u_phone = document.getElementById("phone");
	  const u_password = document.getElementById("password");
	  const u_image = document.getElementById("image");
	  addUserForm.addEventListener('submit', function(event) {
	   	event.preventDefault();
	   	 document.querySelectorAll(".error").forEach(element => {
	   	    element.classList.remove("error")
	   	  });
	   	if (!isMoreThanThree(u_name)) {
		    createToast("warning", "Name Must Be More Than 3 Characters!");
		    u_name.classList.add("error");
		}else if (!isValidEmail(u_email)) {
		    createToast("warning", "Please Enter Avalid Email!");
		    u_email.classList.add("error");
		}else if (!isValidPhone(u_phone)) {
		    createToast("warning", "Please Enter A Valid Phone!");
		    u_phone.classList.add("error");
		}else if (!isMoreThanSix(u_password)) {
		    createToast("warning", "Password Must Be More Than 3 Characters!");
		    u_password.classList.add("error");
		}else if (!isValidImage(u_image)) {
		    createToast("warning", "Invalid Image!");
		}else{
			addUserForm.submit();
		}
	  });
  }
//===========================
//=== Add Admin Validation
//===========================
const addAdminForm = document.getElementById('addAdminForm');
  if(addAdminForm){
	  const a_name = document.getElementById("name");
	  const a_email = document.getElementById("email");
	  const a_phone = document.getElementById("phone");
	  const a_address = document.getElementById("address");
	  const a_ssn = document.getElementById("ssn");
	  const a_birth_date = document.getElementById("birth_date");
	  const a_gender = document.getElementById("gender");
	  const a_password = document.getElementById("password");
	  const a_image = document.getElementById("image");
	  addAdminForm.addEventListener('submit', function(event) {
	   	event.preventDefault();
	   	document.querySelectorAll(".error").forEach(element => {
	   	    element.classList.remove("error")
	   	  });
	   	if (!isMoreThanThree(a_name)) {
		    createToast("warning", "Name Must Be More Than 3 Characters!");
		    a_name.classList.add("error");
		}else if (!isValidEmail(a_email)) {
		    createToast("warning", "Please Enter Avalid Email!");
		    a_email.classList.add("error");
		}else if (!isValidPhone(a_phone)) {
		    createToast("warning", "Please Enter A Valid Phone!");
		    a_phone.classList.add("error");
		}else if (!isMoreThanThree(a_password)) {
		    createToast("warning", "Password Must Be More Than 3 Characters!");
		    a_password.classList.add("error");
		}else if (!isMoreThanSix(a_address)) {
		    createToast("warning", "Address Must Be More Than 6 Characters!");
		    a_address.classList.add("error");
		}else if (!isAcceptedDate(a_birth_date)) {
		    createToast("warning", "Admin Age Must Be More Than 18!");
		    a_birth_date.classList.add("error");
		}else if (!isValidImage(a_image)) {
		    createToast("warning", "Invalid Image!");
		}else{
			addAdminForm.submit();
		}
	  });
  }

//===========================
//=== Add Message Validation
//===========================
const sendMessageForm = document.getElementById('sendMessageForm');
  if(sendMessageForm){
	  const m_name = document.getElementById("name");
	  const m_email = document.getElementById("email");
	  const m_phone = document.getElementById("phone");
	  const m_message = document.getElementById("message");
	  sendMessageForm.addEventListener('submit', function(event) {
	   	event.preventDefault();
	   	 document.querySelectorAll(".error").forEach(element => {
	   	    element.classList.remove("error")
	   	  });
	   	if (!isMoreThanThree(m_name)) {
		    createToast("warning", "Name Must Be More Than 3 Characters!");
		    m_name.classList.add("error");
		}else if (!isValidEmail(m_email)) {
		    createToast("warning", "Please Enter Avalid Email!");
		    m_email.classList.add("error");
		}else if (!isValidPhone(m_phone)) {
		    createToast("warning", "Please Enter A Valid Phone!");
		    m_phone.classList.add("error");
		}else if (!isMoreThanSix(m_message)) {
		    createToast("warning", "Message Must Be More Than 6 Characters!");
		    m_message.classList.add("error");
		}else{
			sendMessageForm.submit();
		}
	  });
  }