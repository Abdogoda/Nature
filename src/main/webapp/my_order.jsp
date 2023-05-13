<%@page import="cd.abdogoda.model.OrderStatus"%>
<%@page import="cd.abdogoda.model.OrderDetails"%>
<%@page import="cd.abdogoda.dao.OrderDao"%>
<%@page import="cd.abdogoda.model.Order"%>
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
List<Order> orders = null;
List<OrderStatus> orderStatus = null;
OrderDetails orderDetails = null;
String last_status = null;
String id_s = request.getParameter("id");
if (id_s == null) {
	response.sendRedirect("my_orders.jsp");
}
if (auth != null) {
	request.setAttribute("auth", auth);
	//GET ORDER Information
	orders = new OrderDao(DBCon.getConnection()).userOrdersWithDetailsId(Integer.parseInt(id_s));
	orderStatus = new OrderDao(DBCon.getConnection()).getOrderStatus(Integer.parseInt(id_s));
	orderDetails = new OrderDao(DBCon.getConnection()).getOrderDetails(Integer.parseInt(id_s));
	last_status = new OrderDao(DBCon.getConnection()).getLastStatus(Integer.parseInt(id_s));
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

<head>
<%@include file="includes/header.jsp"%>
<title>My Orders</title>
</head>

<body onload="showNotificationOnLoad()">
	<!-- START NAV -->
	<%@include file="includes/navbar.jsp"%>
	<!-- END NAV -->

	<%
	if (id_s != null && orders != null && orderDetails != null && orderStatus != null) {
	%>
	<main>
		<div class="container orders">
			<h1 class="heading">
				Order (<%=orderDetails.getOrderId()%>)
			</h1>
			<div class="tab">
				<button class="tablinks active"
					onclick="openCity(event, 'order_details')">Order Details</button>
				<button class="tablinks" onclick="openCity(event, 'order_products')">Order
					Products</button>
				<button class="tablinks" onclick="openCity(event, 'order_status')">Order
					Status</button>
			</div>

			<div id="order_details" class="tabcontent" style="display: block;">
				<h2>Order Details</h2>
				<p>
					<b>Sub Total</b> : <span><%=orderDetails.getSub_total()%>
						EGP</span>
				</p>
				<p>
					<b>Shipping Tax</b> : <span><%=orderDetails.getShipping_tax()%>
						EGP</span>
				</p>
				<p>
					<b>Total</b> : <span><%=orderDetails.getTotal()%> EGP</span>
				</p>
				<p>
					<b>Status</b> : <span class="status <%=last_status%>"><%=last_status%></span>
				</p>
				<p>
					<b>Date</b> :
					<%=orderDetails.getDate()%></p>
				<br>
				<h2>Billing Details</h2>
				<p>
					<b>City</b>:
					<%=orderDetails.getCity()%></p>
				<p>
					<b>State</b>:
					<%=orderDetails.getState()%></p>
				<p>
					<b>Street</b>:
					<%=orderDetails.getStreet()%></p>
				<p>
					<b>Building</b>:
					<%=orderDetails.getBuilding()%></p>
				<p>
					<b>Flat</b>:
					<%=orderDetails.getFlat()%></p>
				<p>
					<b>Payment Method</b>:
					<%=orderDetails.getPayment_method()%></p>
				<br>
				<div class="btns">
					<a href="" class="btn danger-btn">Cancel Order <i class="fa fa-trash"></i></a>
					<a href="invoice.jsp?id=<%= orderDetails.getOrderId() %>" class="btn success-btn">Print Invoice <i class="fa fa-print"></i></a>
				</div>
			</div>

			<div id="order_products" class="tabcontent">
				<h2>Order Products</h2>
				<%
				//if (!orders.isEmpty()) {
				for (Order order : orders) {
				%>
				<div class="order_product">
					<div class="info">
						<img alt="product-img"
							src="uploaded_img/products/<%=order.getImage()%>">
						<div>
							<h2><%=order.getName()%></h2>
							<h4><%=order.getCategory()%></h4>
						</div>
					</div>
					<div class="price">
						<div><%= order.getQuantity() %> × <span><%= order.getOrderPrice() %> EGP</span> </div>
						<p>Total: <span><%= order.getOrderTotal() %> EGP</span></p>
					</div>
				</div>
				<%
				}
				//}
				%>
			</div>

			<div id="order_status" class="tabcontent">
				<h2>Order Status</h2>
				<%
				if (!orderStatus.isEmpty()) {
					for (OrderStatus order_status : orderStatus) {
				%>
				<div class="order_status">
					<p>
						The Status Of Order Changed To <span
							class="status <%=order_status.getStatus()%>"><%=order_status.getStatus()%></span>
					</p>
					<p><%=order_status.getStatus_date()%></p>
				</div>
				<%
				}
				}
				%>
			</div>
		</div>
	</main>
	<%
	}
	%>

	<!-- START FOOTER -->
	<%@include file="includes/footer.jsp"%>
	<script type="text/javascript">
		function openCity(evt, cityName) {
			var i, tabcontent, tablinks;
			tabcontent = document.getElementsByClassName("tabcontent");
			for (i = 0; i < tabcontent.length; i++) {
				tabcontent[i].style.display = "none";
			}
			tablinks = document.getElementsByClassName("tablinks");
			for (i = 0; i < tablinks.length; i++) {
				tablinks[i].className = tablinks[i].className.replace(
						" active", "");
			}
			document.getElementById(cityName).style.display = "block";
			evt.currentTarget.className += " active";
		}
	</script>
	<!-- END FOOTER -->
</body>
</html>
