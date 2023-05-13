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
if (admin != null) {
	request.setAttribute("admin", admin);
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
//GET ALL ORDERS
OrderDao odao = new OrderDao(DBCon.getConnection());
List<OrderDetails> orders = odao.allOrderDetails();
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <link href="assets/css/all.min.css" rel="stylesheet" />
<link rel="stylesheet"
	href="assets/dataTablesFolder/css/jquery.dataTables.min.css" />
<link rel="stylesheet"
	href="assets/dataTablesFolder/css/buttons.dataTables.min.css" />
<%@include file="includes/admin_header.jsp"%>
<script>function showNotificationOnLoad() {createToast('<%=type%>', '<%=message%>')}</script>
<title>Admin | Orders</title>
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
			<div class="head-title">
				<div class="left">
					<h1>orders</h1>
					<ul class="breadcrumb">
						<li><a href="dashboard.jsp">Dashboard</a></li>
						<li><i class="fas fa-chevron-right"></i></li>
						<li><a class="active" href="orders.jsp">Orders</a></li>
					</ul>
				</div>
			</div>
			<!-- START DASHBOARD TABLE -->
			<div class="flex-boxes">
				<div class="table">
					<div class="head">
						<h3>Orders</h3>
					</div>
					<table id="example" class="table table-striped" style="width: 100%">
						<thead>
							<tr>
								<th>ID</th>
								<th>Customer</th>
								<th>Status</th>
								<th>SubTotal</th>
								<th>ShippingTax</th>
								<th>Total</th>
								<th>Date</th>
							</tr>
						</thead>
						<tbody>
							<%
							if (orders != null && !orders.isEmpty()) {
								for (OrderDetails order : orders) {
									User user = new UserDao(DBCon.getConnection()).getUser(order.getUserId());
									String status = odao.getLastStatus(order.getOrderId());
							%>
							<tr>
								<td><a
									href="order_details.jsp?id=<%=order.getOrderId()%>"><%=order.getOrderId()%></a></td>
								<td><a href="profile.jsp?id=<%=user.getId()%>"><%=user.getName()%></a></td>
								<td class="status-td status-<%=status%>"><p><%=status%></td>
								<td><%=order.getSub_total()%> EGP</td>
								<td><%=order.getShipping_tax()%> EGP</td>
								<td><%=order.getTotal()%> EGP</td>
								<td><%=order.getDate()%></td>
							</tr>
							<%
							}
							} else {
							%>
							<tr>
								<td colspan="7">No Orders!</td>
							</tr>
							<%
							}
							%>

						</tbody>
					</table>
				</div>
			</div>
			<!-- END DASHBOARD TABLE -->
		</main>
		<!-- MAIN -->
	</section>
	<!-- CONTENT -->
	<!-- DATATABLES -->
	<script src="assets/dataTablesFolder/js/jquery-3.5.1.js"></script>
	<script src="assets/dataTablesFolder/js/jquery.dataTables.min.js"></script>
	<script src="assets/dataTablesFolder/js/dataTables.buttons.min.js"></script>
	<script src="assets/dataTablesFolder/js/jszip.min.js"></script>
	<script src="assets/dataTablesFolder/js/pdfmake.min.js"></script>
	<script src="assets/dataTablesFolder/js/vfs_fonts.js"></script>
	<script src="assets/dataTablesFolder/js/buttons.html5.min.js"></script>
	<script src="assets/dataTablesFolder/js/buttons.print.min.js"></script>
	<script>
		$(document).ready(function() {
			$("#example").DataTable({
				responsive : true,
				dom : "Bfrtip",
				buttons : [ "copy", "csv", "excel", "pdf", "print" ],
			});
		});
	</script>

	<!-- MAIN JS -->
	<%@include file="includes/admin_footer.jsp"%>
</body>
</html>
