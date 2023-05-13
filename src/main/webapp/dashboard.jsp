<%@page import="cd.abdogoda.model.OrderDetails"%>
<%@page import="java.util.List"%>
<%@page import="cd.abdogoda.dao.OrderDao"%>
<%@page import="cd.abdogoda.conn.DBCon"%>
<%@page import="cd.abdogoda.dao.UserDao"%>
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
//GET DASHBOARD COUNTS
int CustomersCount = new UserDao(DBCon.getConnection()).usersCount(1);
int OrdersCount = new OrderDao(DBCon.getConnection()).ordersCount();
int TotalSales = new OrderDao(DBCon.getConnection()).totalSales();
//GET RECENT ORDRES
List<OrderDetails> recentOrders = new OrderDao(DBCon.getConnection()).recentOrderDetails();
%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@include file="includes/admin_header.jsp"%>
<link href="assets/css/calendar.css" rel="stylesheet" />
<script>function showNotificationOnLoad() {createToast('<%=type%>', '<%=message%>
	')
	}
</script>
<title>Admin | Dashboard</title>
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
					<h1>Dashboard</h1>
					<ul class="breadcrumb">
						<li><a href="dashboard.jsp">Dashboard</a></li>
						<li><i class="fas fa-chevron-right"></i></li>
						<li><a class="active" href="dashboard.jsp">Home</a></li>
					</ul>
				</div>
			</div>

			<!-- START DASHBOARD BOXES -->
			<ul class="box-info">
				<li><i class="fas fa-calendar-check"></i> <span class="text">
						<h3><%=OrdersCount%></h3>
						<p>New Order</p>
				</span></li>
				<li><i class="fas fa-users"></i> <span class="text">
						<h3><%=CustomersCount%></h3>
						<p>Visitors</p>
				</span></li>
				<li><i class="fas fa-dollar-sign"></i> <span class="text">
						<h3><%=TotalSales%>
							EGP
						</h3>
						<p>Total Sales</p>
				</span></li>
			</ul>
			<!-- END DASHBOARD BOXES -->

			<!-- START DASHBOARD TABLE -->
			<div class="flex-boxes">
				<div class="table">
					<div class="head">
						<h3>Recent Orders</h3>
					</div>
					<table id="example" class="table table-striped" style="width: 100%">
						<thead>
							<tr>
								<th>ID</th>
								<th>Customer</th>
								<th>Status</th>
								<th>Total</th>
								<th>Date</th>
							</tr>
						</thead>
						<tbody>
							<%
							if (recentOrders != null && !recentOrders.isEmpty()) {
								for (OrderDetails order : recentOrders) {
									User user = new UserDao(DBCon.getConnection()).getUser(order.getUserId());
									String status = new OrderDao(DBCon.getConnection()).getLastStatus(order.getOrderId());
							%>
							<tr>
								<td><a href="order_details.jsp?id=<%=order.getOrderId()%>"><%=order.getOrderId()%></a></td>
								<td><a href="profile.jsp?id=<%=user.getId()%>"><%=user.getName()%></a></td>
								<td class="status-td status-<%=status%>"><p><%=status%></td>
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

				<div class="chart-box">
					<div class="chart">
						<div class="head">
							<h3>Orders Status</h3>
							<i class="fas fa-plus"></i> <i class="fas fa-filter"></i>
						</div>
						<canvas id="myChart"></canvas>
					</div>
				</div>
			</div>

			<div class="flex-boxes">
				<div class="chart-box">
					<div class="chart">
						<div class="head">
							<h3>Sold Products</h3>
							<i class="fas fa-plus"></i> <i class="fas fa-filter"></i>
						</div>
						<canvas id="myChart2"></canvas>
					</div> 
				</div>
				<div class="chart-box">
					<div class="calendar">
						<div class="calendar-header">
							<span class="month-picker" id="month-picker">February</span>
							<div class="year-picker">
								<span class="year-change" id="prev-year"> <pre><</pre>
								</span> <span id="year">2021</span> <span class="year-change"
									id="next-year"> <pre>></pre>
								</span>
							</div>
						</div>
						<div class="calendar-body">
							<div class="calendar-week-day">
								<div>Sun</div>
								<div>Mon</div>
								<div>Tue</div>
								<div>Wed</div>
								<div>Thu</div>
								<div>Fri</div>
								<div>Sat</div>
							</div>
							<div class="calendar-days"></div>
						</div>
						<div class="month-list"></div>
					</div>
				</div>
			</div>
			<!-- END DASHBOARD TABLE -->
		</main>
		<!-- MAIN -->
	</section>
	<!-- CONTENT -->
	<!-- CHART JS -->
	<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
	<script>
		const ctx = document.getElementById("myChart");

		new Chart(ctx, {
			type : "polarArea",
			data : {
				labels : [ "Completed", "Pending", "Cancelled" ],
				datasets : [ {
					label : "# of Votes",
					data : [ 12, 19, 5 ],
					borderWidth : 1,
				}, ],
			},
			options : {
				scales : {
					y : {
						beginAtZero : true,
					},
				},
			},
		});
	</script>
	<script>
		const ctx2 = document.getElementById("myChart2");

		new Chart(ctx2, {
			type : "bar",
			data : {
				labels : [ "Apple", "Tomato", "Carrots", "Orange",
						"Watermelon", "Banana" ],
				datasets : [ {
					label : "# of Killo",
					data : [ 100, 50, 10, 90, 15, 20 ],
					borderWidth : 1,
				}, ],
			},
			options : {
				scales : {
					y : {
						beginAtZero : true,
					},
				},
			},
		});
	</script>

	<!-- MAIN JS -->
	<%@include file="includes/admin_footer.jsp"%>
	<script src="assets/js/calendar.js" defer></script>
</body>
</html>
