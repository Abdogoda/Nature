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
if(auth != null){
	favs = new ProductDao(DBCon.getConnection()).getUserFavs(auth.getId());
	request.setAttribute("favs", favs);
}
//DOUBLE FORMAT
DecimalFormat dcf = new DecimalFormat("#.##");
request.setAttribute("dcf", dcf);

%>
<!DOCTYPE html>
<html lang="en">

<head>
<%@include file="includes/header.jsp"%>
<title>Cart</title>
</head>

<body onload="showNotificationOnLoad()">
	<!-- START NAV -->
	<%@include file="includes/navbar.jsp"%>
	<!-- END NAV -->

	<main>
		<!-- Cart Items -->
		<div class="container cart">
			<h1 class="heading">Your Cart</h1>
			<%
			if (cart_list != null && !cart_list.isEmpty()) {
			%>
			<div class="cart-layout">
				<div class="cart-products">
					<%
					for (Cart c : cartProduct) {
					%>
					<div class="product-box d-flex flex-between">
						<div class="content d-flex">
							<img src="uploaded_img/products/<%=c.getImage()%>" alt="">
							<div class="text">
								<p class="name"><%=c.getName()%></p>
								<span class="price"><%=c.getPrice()%> EGP</span>
							</div>
						</div>
						<div class="quantity">
							<div class="d-flex flex-between">
								<a href="quantity-change?action=dec&id=<%=c.getId()%>"
									class="warning-btn minus"> <i class="fa fa-minus"></i>
								</a> <span class="qty"><%=c.getQuantity()%></span> <a
									href="quantity-change?action=inc&id=<%=c.getId()%>"
									class="success-btn plus"> <i class="fa fa-plus"></i>
								</a>
							</div>
							<a href="remove-from-cart?id=<%=c.getId()%>" class="delete-btn">
								<i class="fa fa-trash"></i>
							</a>
						</div>
					</div>
					<%
					}
					%>
				</div>
				<div class="cart-summary">
					<div class="summary">
						<h3>Basket Summary</h3>
						<p class="d-flex flex-between">
							Subtotal <span>${(totalPrice>0)?dcf.format(totalPrice):0}
								EGP</span>
						</p>
						<p class="d-flex flex-between">
							Delivery Tax <span>${((totalPrice / 10)>0)?dcf.format((totalPrice / 10)):0}
								EGP</span>
						</p>
						<p class="total d-flex flex-between">
							Total Amount <span>${((totalPrice / 10)>0)?dcf.format(totalPrice + (totalPrice / 10)):0}
								EGP</span>
						</p>
					</div>
					<a href="checkout.jsp" class="btn btn2">Checkout And Order</a>
				</div>
			</div>

			<%
			} else {
			%>
			<div class="empty">
				<p>
					NO PRODUCT IN CART YET! <br> <a href="shop.jsp"
						class="btn btn2">Start Shopping Now <i
						class="fa fa-shopping-cart"></i></a>
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
