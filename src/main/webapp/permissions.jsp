<%@page import="cd.abdogoda.model.Permission"%>
<%@page import="java.security.Permissions"%>
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
//GET PERSMMISONS
List<Permission> permissions = new PermissionDao(DBCon.getConnection()).allPermission();
%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@include file="includes/admin_header.jsp"%>
<script>
	function showNotificationOnLoad() {createToast('<%=type%>', '<%=message%>')}
</script>
<title>Admin | Permissions</title>
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
					<h1>Admin Permissions</h1>
					<ul class="breadcrumb">
						<li><a href="dashboard.jsp">Dashboard</a></li>
						<li><i class="fas fa-chevron-right"></i></li>
						<li><a href="team.jsp">Team</a></li>
						<li><i class="fas fa-chevron-right"></i></li>
						<li><a class="active" href="permissions.jsp">Permissions</a></li>
					</ul>
				</div>
			</div>
			<!-- START PERMISSIONS -->
			<div class="flex-boxes">
				<div class="table">
					<div class="head">
						<h3>Admin Permissions</h3>
						<button data-modal="addPermissionModal" class="btn open-modal">
							Add Permission <i class="fa fa-plus"></i>
						</button>
					</div>
					<div class="permissions-container">
						<ul class="flex">
							<% if(!permissions.isEmpty()){
								for(Permission perm : permissions){%>
								<li class="permission-box"><%= perm.getName() %>
									<button data-modal="editPermissionModal" data-id="<%= perm.getId() %>"
										data-name="<%= perm.getName() %>" class=" open-modal">
										<i class="fa fa-edit"></i>
									</button>
									<a href="delete-permission?id=<%= perm.getId() %>" onclick="confirm('Sure You Want To Delete This Permission?')"><i class="fa fa-trash"></i></a>
								</li>
							<%}}else{ %>
								<li>No Permission Found</li>
							<%} %>
						</ul>
					</div>
				</div>
			</div>
			<!-- END PERMISSIONS -->
			<%
			}
			%>
		</main>
		<!-- MAIN -->
	</section>
	<!-- CONTENT -->

	<!-- MODAL -->
	<div id="addPermissionModal" class="modal">
		<div class="modal-content">
			<h2>Create New Permission</h2>
			<form id="addPermissionForm" action="add-permission" method="post">
				<div class="input-group">
					<label for="name">Permission Name</label> <input type="text"
						name="name" id="name" required />
				</div>
				<div class="btns">
					<input type="submit" class="btn" value="Create Permission" />
					<button type="button" class="btn btn-danger close-modal">Cancel</button>
				</div>
			</form>
		</div>
	</div>
	<!-- MODAL -->
	<!-- MODAL -->
	<div id="editPermissionModal" class="modal">
		<div class="modal-content">
			<h2>Edit User</h2>
			<form id="editPermissionForm" action="edit-permission" method="post">
				<input type="hidden" name="id" id="id" required />
				<div class="input-group">
					<label for="name">Permission Name</label> <input type="text"
						name="name" id="name" required />
				</div>
				<div class="btns">
					<input type="submit" class="btn" value="Edit Permission" />
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
