<%@page import="cd.abdogoda.conn.DBCon"%>
<%@page import="cd.abdogoda.model.User"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
User auth = (User) request.getSession().getAttribute("auth");
User admin = (User) request.getSession().getAttribute("admin");
if (auth != null) {
	request.setAttribute("auth", auth);
	response.sendRedirect("index.jsp");
}else if(admin != null){
	request.setAttribute("admin", admin);
	response.sendRedirect("dashboard.jsp");
}
//NOTIFICATIONS
String message = (String) request.getAttribute("message");
String type = (String) request.getAttribute("type");
if (type == null && message == null) {
	type = "";
	message = "";
}
%>
<!DOCTYPE html>
<html lang="en">
 <head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Login | Register</title>
  <link rel="stylesheet" href="assets/css/login.css" />
	<link href="assets/css/alert.css" rel="stylesheet">
	<link href="assets/css/all.min.css" rel="stylesheet">
<link rel="shortcut icon" href="assets/img/favicon.png" type="image/png" />
	<script src="assets/js/alert.js" defer></script>
	<script>function showNotificationOnLoad() {createToast('<%=type%>', '<%=message%>')}</script>
<style type="text/css">.error{border-color:red}</style>
</head>
<body onload="showNotificationOnLoad()">
	<ul class="notifications"></ul>
  <div class="container">
   <div class="forms-container">
    <div class="signin-signup">
     <form
      action="user-login"
      method="post"
      class="sign-in-form"
      id="sign-in-form"
     >
      <h2 class="title">Sign in</h2>
      <div class="input-field">
       <label for="l_email" class="fas fa-envelope"></label>
       <input type="text" name="l_email" id="l_email" placeholder="Email Address" required/>
      </div>
      <div class="input-field">
       <label for="l_password" class="fas fa-lock"></label>
       <input
        type="password"
        placeholder="Password"
        name="l_password"
        id="l_password" required
       />
      </div>
      <input type="submit" value="Login" class="btn solid" />
      <p class="social-text">Or Sign in with social platforms</p>
      <div class="social-media">
       <a href="#" class="social-icon">
        <i class="fab fa-facebook-f"></i>
       </a>
       <a href="#" class="social-icon">
        <i class="fab fa-twitter"></i>
       </a>
       <a href="#" class="social-icon">
        <i class="fab fa-google"></i>
       </a>
       <a href="#" class="social-icon">
        <i class="fab fa-linkedin-in"></i>
       </a>
      </div>
     </form>
     <form
      action="user-register"
      method="post"
      class="sign-up-form"
      id="sign-up-form"
      enctype="multipart/form-data"
     >
      <h2 class="title">Sign up</h2>
      <div class="input-field">
       <label for="name" class="fa fa-user"></label
       ><input type="text" name="name" id="name" placeholder="Username" required/>
      </div>
      <div class="input-field">
       <label for="email" class="fa fa-envelope"></label
       ><input type="email" name="email" id="email" placeholder="Email Address" required/>
      </div>
      <div class="input-field">
       <label for="phone" class="fa fa-phone"></label
       ><input type="tel" name="phone" id="phone" placeholder="Phone Number" required/>
      </div>
      <div class="input-field">
       <label for="address" class="fa fa-location-dot"></label
       ><input type="text" name="address" id="address" placeholder="Your Address" required/>
      </div>
      <div class="input-field">
       <label for="password" class="fa fa-lock"></label
       ><input
        type="password"
        name="password"
        id="password"
        placeholder="Password" required
       />
      </div>
      <div class="input-field">
       <label class="fa fa-image"></label><input type="file" name="image" id="image" accept=".png, .gif, .jpeg, .jpg"/>
      </div>
      <input type="submit" class="btn" value="Sign up" />
     </form>
    </div>
   </div>

   <div class="panels-container">
    <div class="panel left-panel">
     <div class="content">
      <h3>New here ?</h3>
      <p>
       Lorem ipsum, dolor sit amet consectetur adipisicing elit. Debitis, ex
       ratione. Aliquid!
      </p>
      <button class="btn transparent" id="sign-up-btn">Sign up</button>
     </div>
     <img src="assets/img/img2.svg" class="image" alt="" />
    </div>
    <div class="panel right-panel">
     <div class="content">
      <h3>One of us ?</h3>
      <p>
       Lorem ipsum dolor sit amet consectetur adipisicing elit. Nostrum
       laboriosam ad deleniti.
      </p>
      <button class="btn transparent" id="sign-in-btn">Sign in</button>
     </div>
     <img src="assets/img/img1.svg" class="image" alt="" />
    </div>
   </div>
  </div>

  <script src="assets/js/login.js"></script>
 </body>
</html>
