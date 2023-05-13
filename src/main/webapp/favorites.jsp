<%@page import="cd.abdogoda.model.Favorite"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="cd.abdogoda.dao.UserDao"%>
<%@page import="cd.abdogoda.model.Cart"%>
<%@page import="java.util.ArrayList"%>
<%@page import="cd.abdogoda.model.Product"%>
<%@page import="java.util.List"%>
<%@page import="cd.abdogoda.dao.ProductDao"%>
<%@page import="cd.abdogoda.conn.DBCon"%>
<%@page import="cd.abdogoda.model.User"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
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
//GET ALL PRODUCTS
ProductDao pdao = new ProductDao(DBCon.getConnection());
List<Product> allProducts = pdao.getAllProducts();
//GET RECENT PRODUCTS
List<Product> recentProducts = pdao.getAllProducts();
//GET ALL CART PRODUCTS
ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
List<Cart> cartProduct = null;
if (cart_list != null) {
	cartProduct = pdao.getCartProducts(cart_list);
	double totalPrice = pdao.getTotalCartPrice(cart_list);
	request.setAttribute("cart_list", cart_list);
	request.setAttribute("totalPrice", totalPrice);
}
//GET ALL FAVORITE PRODUCTS
int favs = 0;
List<Favorite> allFavs = null;
if(auth != null){
	favs = new ProductDao(DBCon.getConnection()).getUserFavs(auth.getId());
	request.setAttribute("favs", favs);
	allFavs = new ProductDao(DBCon.getConnection()).getUserProductFavs(auth.getId());
}
//DOUBLE FORMAT
DecimalFormat dcf = new DecimalFormat("#.##");
request.setAttribute("dcf", dcf);

%>
<!DOCTYPE html>
<html lang="en">

<head>
<%@include file="includes/header.jsp"%>
<title>Favorite Products</title>
</head>

<body onload="showNotificationOnLoad()">
	<!-- START NAV -->
	<%@include file="includes/navbar.jsp"%>
	<!-- END NAV -->

	<main>
		<!-- Cart Items -->
		<div class="container cart">
			<h1 class="heading">Your Favorite Products</h1>
			<%
			if (favs != 0) {
				for (Favorite f : allFavs) {
					Product product = pdao.getProduct(f.getP_id());
			%>
			<div class="cart-layout w-100">
				<div class="cart-products">
					<div class="product-box d-flex flex-between">
						<div class="content d-flex">
							<img src="uploaded_img/products/<%=product.getImage()%>" alt="">
							<div class="text">
								<p class="name"><%=product.getName()%></p>
								<span class="price"><%=product.getCategory()%></span>
							</div>
						</div>
						<div>
							<a href="add-to-favorite?id=<%=f.getId()%>" class="btn danger-btn">Remove From Favorites <i
								class="fa fa-trash"></i></a>
						</div>
					</div>
					<%
					}
					%>
				</div>
			</div>
			<%
			} else {
			%>
			<div class="empty">
				<p>
					NO PRODUCT IN Favorite YET! <br> <a href="shop.jsp"
						class="btn btn2">Shop Now <i class="fa fa-shopping-cart"></i></a>
			</div>
			<%
			}
			%>
		</div>
	</main>

	<!-- START FOOTER -->
	<%@include file="includes/footer.jsp"%>
	<!-- END FOOTER -->
</body>
</html>
