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
List<OrderDetails> orders = null;
if (auth != null) {
	request.setAttribute("auth", auth);
	//GET ALL ORDERS
	orders = new OrderDao(DBCon.getConnection()).userOrderDetails(auth.getId());
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
	
	<% if(auth != null){ %>
	<main>
		<!-- Cart Items -->
		<div class="container orders">
			<h1 class="heading">My Orders</h1>
			<div class="order_table">
				<%
				if (orders != null && !orders.isEmpty()) {
				%>
				<table id="table">
				  <tr>
				  	<th>Order ID</th>
				    <th>Status</th>
				    <th>Sub Total</th>
				    <th>Shipping Tax</th>
				    <th>Total</th>
				    <th>Order Date</th>
				    <th>Operation</th>
				  </tr>
				<%
				for (OrderDetails o : orders) {
					OrderDao odao = new OrderDao(DBCon.getConnection());
					String status = odao.getLastStatus(o.getOrderId());
				%>
				<tr>
				    <td><a href="my_order.jsp?id=<%=o.getOrderId()%>"><%=o.getOrderId()%></a></td>
				    <td><span class="status <%= status %>"><%= status %></span></td>
				    <td><%=o.getSub_total()%> EGP</td>
				    <td><%=o.getShipping_tax()%> EGP</td>
				    <td><%=dcf.format(o.getTotal())%> EGP</td>
				    <td><%=o.getDate()%></td>
				    <td>
					    <a href=""><i class="fa fa-trash"></i></a> 
					    <a href="invoice.jsp?id=<%= o.getOrderId() %>" style="margin-left: 1rem;"><i class="fa fa-print"></i></a></td>
				  </tr>
				<%
				}
				%>
				</table>
				<%
				} else {
				%>
				<div class="empty">
				<p>
					You Have No Orders! <br> <a href="shop.jsp"
						class="btn btn2">Start Shopping Now <i
						class="fa fa-shopping-cart"></i></a>
			</div>
				<%
				}
				%>
				
			</div>
		</div>
	</main>
	<% } %>

	<!-- START FOOTER -->
	<%@include file="includes/footer.jsp"%>
	<!-- END FOOTER -->
</body>
</html>
