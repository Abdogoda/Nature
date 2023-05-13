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
 <title>About Us</title>
</head>

<body onload="showNotificationOnLoad()">
   <!-- START NAV -->
  <%@include file="includes/navbar.jsp" %>
  <!-- END NAV -->

 <!-- START MAIN -->
 <main>
  <div class="container about">
   <div class="about-con">
    <div class="left">
     <h1>ABOUT PAGE</h1>
     <p>Welcome to our online farm store, where you can find fresh and locally sourced produce straight from the farm. We specialize in providing high-quality fruits, vegetables, and other farm products that are grown and harvested with care. You can conveniently shop our selection of farm-fresh goods online and have them delivered right to your door. Thank you for supporting local farmers and choosing us as your go-to source for fresh, nutritious food!</p>
     <div class="btns">
      <a href="login.jsp" class="btn btn2">Get Started </a>
      <a href="shop.jsp" class="btn btn2">Shop Now <i class="fa fa-shopping-cart"></i></a>
     </div>
    </div>
    <div class="right"><img src="assets/img/about.svg" alt=""></div>
   </div>
  </div>
 </main>

 	<!-- START FOOTER -->
	<%@include file="includes/footer.jsp" %>
	<!-- END FOOTER -->
</body>

</html>