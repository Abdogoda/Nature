<%@page import="cd.abdogoda.model.Favorite"%>
<%@page import="cd.abdogoda.conn.DBCon"%>
<%@page import="cd.abdogoda.dao.ProductDao"%>
<%@page import="cd.abdogoda.model.User"%>
<%@page import="java.util.List"%>
<%@page import="cd.abdogoda.model.Cart"%>
<%@page import="java.util.ArrayList"%>
<% 
//GET USER AUTH
User auth = (User) request.getSession().getAttribute("auth");
if (auth != null) {
	request.setAttribute("auth", auth);
}
//NOTIFICATIONS
String message = (String) request.getAttribute("message");
String type = (String) request.getAttribute("type");
if (type == null && message == null) {
	type = "";
	message = "";
}
//GET ALL CART PRODUCTS
ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
List<Cart> cartProduct = null;
if (cart_list != null) {
	ProductDao pdao = new ProductDao(DBCon.getConnection());
	cartProduct = pdao.getCartProducts(cart_list);
	request.setAttribute("cart_list", cart_list);
}
//GET ALL FAVORITE PRODUCTS
int favs = 0;
if(auth != null){
	favs = new ProductDao(DBCon.getConnection()).getUserFavs(auth.getId());
	request.setAttribute("favs", favs);
}
%>
<!DOCTYPE html>
<html lang="en">

<head>
   <%@include file="includes/header.jsp" %>
 <title>Contact Us</title>
</head>

<body onload="showNotificationOnLoad()">

  <!-- START NAV -->
  <%@include file="includes/navbar.jsp" %>
  <!-- END NAV -->

 <!-- START MAIN -->
 <main>
  <div class="container contact">
   <div class="contact-box">
    <div class="left">
     <h2>Let's Get In Touch</h2>
     <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Debitis qui ullam iure at quia reiciendis.</p>
     <p><i class="fa fa-store"></i> 92 Altahrer Street Qairo Egypt</p>
     <p><i class="fa fa-envelope"></i> nature@gmail.com</p>
     <p><i class="fa fa-phone"></i> 0123245485</p>
     <h4>Contact With Us:</h4>
     <div class="icons d-flex">
      <a href=""><i class="fab fa-facebook"></i></a>
      <a href=""><i class="fab fa-twitter"></i></a>
      <a href=""><i class="fab fa-instagram"></i></a>
      <a href=""><i class="fab fa-tiktok"></i></a>
     </div>
    </div>
    <div class="right">
     <h2>Contact Us</h2>
     <form action="send-message" method="post" id="sendMessageForm">
     <input type="text" id="name" name="name" placeholder="Username" required>
      <input type="email" id="email" name="email" placeholder="Email" required>
      <input type="tel" id="phone" name="phone" placeholder="Phone" required>
      <textarea name="message" id="message" placeholder="Message" required></textarea>
      <input type="submit" name="send" value="Send Message">
     </form>
    </div>
   </div>
  </div>
 </main>

	<!-- START FOOTER -->
	<%@include file="includes/footer.jsp" %>
 	 <script src="assets/js/validation.js"></script>
	<!-- END FOOTER -->
</body>

</html>