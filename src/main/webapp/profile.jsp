<%@page import="cd.abdogoda.dao.JobDao"%>
<%@page import="cd.abdogoda.model.Job"%>
<%@page import="cd.abdogoda.model.Employee"%>
<%@page import="cd.abdogoda.model.Permission"%>
<%@page import="cd.abdogoda.dao.PermissionDao"%>
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
//GET USER
String idString = request.getParameter("id");
if (idString == null) {
	response.sendRedirect("dashboard.jsp");
}
UserDao pd = new UserDao(DBCon.getConnection());
User user = pd.getUser(Integer.parseInt(idString));
if (user == null) {
	response.sendRedirect("dashboard.jsp");
}
//GET EMPLOYEE
Employee employee = null;
Job job = null;
if(user.getGroup_id() == 0){
	employee = new UserDao(DBCon.getConnection()).getEmployee(user.getId());
	job = new JobDao(DBCon.getConnection()).getJob(employee.getJob_id());
}
//GET USER ORDERS
List<OrderDetails> orders = null;
OrderDao odao = new OrderDao(DBCon.getConnection());
if (user != null && user.getGroup_id() == 1) {
	orders = odao.userOrderDetails(user.getId());
}
//GET PERSMMISONS
List<Permission> permissions = null;
if(user != null && user.getGroup_id() == 0 && employee != null){
	permissions = new PermissionDao(DBCon.getConnection()).getJobPermissions(employee.getJob_id());	
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@include file="includes/admin_header.jsp"%>
<script>function showNotificationOnLoad() {createToast('<%=type%>', '<%=message%>
	')
	}
</script>
<title>Admin | Profile</title>
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
			<%
			if (admin != null) {
			%>
			<div class="head-title">
				<div class="left">
					<h1>User Profile</h1>
					<ul class="breadcrumb">
						<li><a href="dashboard.jsp">Dashboard</a></li>
						<li><i class="fas fa-chevron-right"></i></li>
						<li><a class="active" href="profile.jsp">Profile</a></li>
					</ul>
				</div>
			</div>
			<!-- START PROFILE -->
			<div class="flex-boxes">
				<div class="table">
					<div class="head">
						<h3>User Profile</h3>
					</div>
					<div class="profile-box">
						<div class="image">
							<%
							if (user.getImage() != null && !user.getImage().isEmpty()) {
							%>
							<img src="uploaded_img/users/<%=user.getImage()%>"
								alt="user_image" />
							<%
							} else {
							%>
							<img src="assets/img/profile.png" alt="user_image" />
							<%
							}
							%>
						</div>
						<div class="content">
							<h3><%=user.getName()%></h3>
							<span class="type"><%=user.getGroup_id() == 0 ? "Admin ("+job.getTitle()+")" : "Customer"%></span>
							<p class="email"><%=user.getEmail()%></p>
							<p class="phone"><%=user.getPhone()%></p>
							<p class="phone"><%=user.getAddress()%></p>
							<% if (user.getGroup_id() == 0){ %>
							<p class="phone">Birth Of Date: <%=employee.getBirth_date()%></p>
							<p class="phone">Gender: <%=employee.getGender() == 0 ? "Male" : "Female"%></p>
							<p class="phone">SSN: <%=employee.getSsn()%></p>
							<% } %>
							<div class="btns">
								<%
								if (user.getId() == admin.getId()) {
								%>
								<button data-modal="editUserModal" data-id="<%=user.getId()%>"
									data-name="<%=user.getName()%>"
									data-email="<%=user.getEmail()%>"
									data-phone="<%=user.getPhone()%>"
									data-image="<%=user.getImage()%>" class="btn open-modal">
									Edit Profile <i class="fa fa-edit"></i>
								</button>
								<a href="logout" onclick="confirm('Sure You Want Logout?')"
									class="btn btn-danger">Logout <i
									class="fa fa-right-from-bracket"></i></a>
								<%
								} else if (user.getGroup_id() == 0) {
								%>
								<button data-modal="editUserModal" data-id="<%=user.getId()%>"
									data-name="<%=user.getName()%>"
									data-email="<%=user.getEmail()%>"
									data-phone="<%=user.getPhone()%>"
									data-image="<%=user.getImage()%>" class="btn open-modal">
									Edit Profile <i class="fa fa-edit"></i>
								</button>
							
								<%
								}
								%>
							</div>
						</div>
					</div>
				</div>
			</div>
			<% if(user.getGroup_id() == 1){ %>
						<div class="flex-boxes">
				<div class="table">
					<div class="head">
						<h3><%= user.getName() %> Orders</h3>
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
									String status = odao.getLastStatus(order.getOrderId());
							%>
							<tr>
								<td><a href="order_details.jsp?id=<%=order.getOrderId()%>"><%=order.getOrderId()%></a></td>
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
			<% }else if(user.getGroup_id() == 0 && employee != null){ %>
			<div class="flex-boxes">
				<div class="table">
					<div class="head">
						<h3>Admin Permissions (<%= job.getTitle() %>)</h3>
						<a href="job.jsp?id=<%= employee.getJob_id() %>" class="btn">Edit <%= job.getTitle() %> Permissions <i class="fa fa-edit"></i></a>
					</div>
					<div class="permissions-container">
						<ul class="flex">
							<% if(!permissions.isEmpty()){
								for(Permission perm : permissions){%>
								<li class="permission-box"><%= perm.getName() %></li>
							<%}}else{ %>
								<li>No Permission Found</li>
							<%} %>
						</ul>
					</div>
				</div>
			</div>
			<% } %>
			<!-- END PROFILE -->
			<%
			}
			%>
		</main>
		<!-- MAIN -->
	</section>
	<!-- CONTENT -->

	<!-- MODAL -->
	<div id="editUserModal" class="modal">
		<div class="modal-content">
			<h2>Edit User</h2>
			<form id="editUserForm" action="edit-user" method="post"
				enctype="multipart/form-data">
				<input type="hidden" name="id" id="id" required />
				<div class="input-group">
					<label for="name">User Name</label> <input type="text" name="name"
						id="name" required />
				</div>
				<div class="input-group">
					<label for="email">Email Address</label> <input type="email"
						name="email" id="email" required />
				</div>
				<div class="input-group">
					<label for="phone">Phone Number</label> <input type="text"
						name="phone" id="phone" required />
				</div>
				<div class="input-group">
					<label for="image">User Image</label> <img src="" alt=""
						id="img_src"> <input type="file" name="image" id="image"
						accept=".png, .gif, .jpeg, .jpg" />
				</div>
				<div class="btns">
					<input type="submit" class="btn" value="Edit User" />
					<button type="button" class="btn btn-danger close-modal">Cancel</button>
				</div>
			</form>
		</div>
	</div>
	<!-- MODAL -->

	<!-- MAIN JS -->
	<script src="assets/js/modal.js"></script>
	<script src="assets/js/validation.js"></script>
	<%@include file="includes/admin_footer.jsp"%>
</body>
</html>
