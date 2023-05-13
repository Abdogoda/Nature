<%@page import="java.text.DecimalFormat"%>
<%@page import="cd.abdogoda.model.Product"%>
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
} else {
	response.sendRedirect("login.jsp");
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
<%@include file="includes/header.jsp"%>
<title>Checkout Page</title>
</head>

<body onload="showNotificationOnLoad()">
	<ul class="notifications"></ul>

	<!-- START NAV -->
	<%@include file="includes/navbar.jsp"%>
	<!-- END NAV -->

	<% if(auth != null){ %>
	<main>
		<div class="container cart">
			<%
			if (cart_list != null && !cart_list.isEmpty()) {
			%>
			<form action="check-out" method="post" class="cart-layout" id="checkout_form">
				<div class="cart-products billing-details">
					<h3>
						Billing Details <i class="fas fa-truck-fast"></i>
					</h3>
					<div class="input-flex-boxes">
						<div class="input-box">
							<label for="name">Your Name</label> <input type="text" readonly id="name" name="name"
								value="<%=auth.getName()%>" >
						</div>
						<div class="input-box">
							<label for="phone">Your Phone</label> <input type="text" readonly id="phone" name="phone"
								value="<%=auth.getPhone()%>" >
						</div>
					</div>
					<div class="input-flex-boxes">
						<div class="input-box ">
							<label for="city">City</label> <input type="text" name="city"
								id="city" >
						</div>
						<div class="input-box ">
							<label for="state">State</label> <input type="text" name="state"
								id="state" >
						</div>
					</div>
					<div class="input-flex-boxes">
						<div class="input-box ">
							<label for="street">Street</label> <input type="text" id="street"
								name="street" >
						</div>
						<div class="input-box ">
							<label for="building">Building</label> <input type="text"
								name="building" id="building" >
						</div>
						<div class="input-box ">
							<label for="flat">Flat</label> <input type="text" name="flat"
								id="flat" >
						</div>
					</div>
					<div class=" payment-boxes">
						<label for="name">Payment Method</label>
						<div class="input-flex-boxes">
							<div class="input-box">
								<input type="radio" name="payment_method" id="cash_on_delivery"
									value="cash_on_delivery" > <label
									for="cash_on_delivery">Cash On Delivery</label>
							</div>
							<div class="input-box">
								<input type="radio" name="payment_method"
									id="pay_with_credit_card" value="pay_with_credit_card" >
								<label for="pay_with_credit_card">Pay With Credit Card</label>
							</div>
						</div>
					</div>
					<div class="visa_c" id="visa_c"></div>
					<div class="input-box">
					<input type="hidden" name="sub_total" value="${dcf.format(totalPrice)}">
					<input type="hidden" name="shipping_tax" value="${dcf.format(totalPrice / 10)}">
					<input type="hidden" name="total" value="${dcf.format(totalPrice + (totalPrice / 10))}">
						<button type="submit" class="btn btn2">Order Now</button>
					</div>
				</div>
				<div class="cart-summary">
					<div class="summary">
						<h3>Order Summary</h3>
						<p class="d-flex flex-between">
							Subtotal <span>${(totalPrice>0)?dcf.format(totalPrice):0}
								EGP</span>
						</p>
						<p class="d-flex flex-between">
							Delivery Tax <span>${((totalPrice / 10)>0)?dcf.format((totalPrice / 10)):0} EGP</span>
						</p>
						<p class="total d-flex flex-between">
							Total Amount <span>${((totalPrice / 10)>0)?dcf.format(totalPrice + (totalPrice / 10)):0} EGP</span>
						</p>
					</div>
				</div>
			</form>

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
	<% } %>
	<!-- START FOOTER -->
	<%@include file="includes/footer.jsp"%>
	<script type="text/javascript" src="assets/js/visa.js"></script>
	<!-- END FOOTER -->
</body>
</html>
