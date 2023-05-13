<%@page import="cd.abdogoda.model.OrderStatus"%>
<%@page import="cd.abdogoda.model.OrderDetails"%>
<%@page import="cd.abdogoda.dao.UserDao"%>
<%@page import="cd.abdogoda.model.Order"%>
<%@page import="java.util.List"%>
<%@page import="cd.abdogoda.conn.DBCon"%>
<%@page import="cd.abdogoda.dao.OrderDao"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@page import="cd.abdogoda.model.User"%>
<%
User admin = (User) request.getSession().getAttribute("admin");
String order_id_s = request.getParameter("id");
List<Order> orders = null;
List<OrderStatus> orderStatus = null;
OrderDetails orderDetails = null;
String last_status = null;
int order_id = 0;
if (admin != null && order_id_s != null) {
	//GET  ORDER
	order_id = Integer.parseInt(order_id_s);
	OrderDao odao = new OrderDao(DBCon.getConnection());
	OrderDetails order_details = odao.getOrderDetails(order_id);
	orders = new OrderDao(DBCon.getConnection()).userOrdersWithDetailsId(order_id);
	orderStatus = new OrderDao(DBCon.getConnection()).getOrderStatus(order_id);
	orderDetails = new OrderDao(DBCon.getConnection()).getOrderDetails(order_id);
	last_status = new OrderDao(DBCon.getConnection()).getLastStatus(order_id);
	request.setAttribute("admin", admin);
}else{
	response.sendRedirect("login.jsp");
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
  <link rel="stylesheet" href="assets/dataTablesFolder/css/jquery.dataTables.min.css"/>
  <link rel="stylesheet" href="assets/dataTablesFolder/css/buttons.dataTables.min.css"/>
  <%@include file="includes/admin_header.jsp"%>
  <script>function showNotificationOnLoad() {createToast('<%=type%>', '<%=message%>')}</script>
  <title>Admin | Order</title>
 </head>
 <body onload="showNotificationOnLoad()">
	<ul class="notifications"></ul>
  <!-- SIDEBAR -->
	<%@include file="includes/admin_navbar.jsp"%>  
  <!-- SIDEBAR -->

  <!-- CONTENT -->
  <section id="content">
   <!-- NAVBAR -->
	<%@include file="includes/admin_navbar2.jsp"%>  
   <!-- NAVBAR -->

   <!-- MAIN -->
   <main>
    <% if(admin != null && orders != null && orderDetails != null && last_status != null){ %>
    <div class="head-title">
     <div class="left">
      <h1>order</h1>
      <ul class="breadcrumb">
       <li>
        <a href="dashboard.jsp">Dashboard</a>
       </li>
       <li><i class="fas fa-chevron-right"></i></li>
       <li>
        <a class="active" href="orders.jsp">Orders</a>
       </li>
       <li><i class="fas fa-chevron-right"></i></li>
       <li>
        <a class="active" href="orders.jsp"><%= order_id %></a>
       </li>
      </ul>
     </div>
    </div>
    <!-- START DASHBOARD TABLE -->
    <div class="flex-boxes">
     <div class="table">
      <div class="head">
       <h3>Order (<%= order_id %>)</h3>
      </div>
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
				<div class="btns">
					<a href="" class="btn btn-danger">Cancel Order <i class="fa fa-trash"></i></a>
					<a href="invoice.jsp?id=<%= orderDetails.getOrderId() %>" class="btn btn-success">Print Invoice <i class="fa fa-print"></i></a>
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
    </div>
    <% } %>
   </main>
   <!-- MAIN -->
  </section>
  <!-- CONTENT -->
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

  <!-- MAIN JS -->
  <%@include file="includes/admin_footer.jsp" %>
 </body>
</html>
