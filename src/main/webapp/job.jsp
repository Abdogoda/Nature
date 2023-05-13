<%@page import="cd.abdogoda.dao.JobDao"%>
<%@page import="cd.abdogoda.model.Job"%>
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
//GET JOB
String id_s = request.getParameter("id");
if(id_s == null){
	response.sendRedirect("jobs.jsp");
}
Job job = new JobDao(DBCon.getConnection()).getJob(Integer.parseInt(id_s));
if(job == null){
	response.sendRedirect("jobs.jsp");
}
//GET PERSMMISONS
List<Permission> permissions = new PermissionDao(DBCon.getConnection()).allPermission();
List<Permission> jobPermissions = null;
if(id_s != null){
	jobPermissions = new PermissionDao(DBCon.getConnection()).getJobPermissions(Integer.parseInt(id_s));	
}
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
			if (admin != null && job != null) {
			%>
			<div class="head-title">
				<div class="left">
					<h1>Admin Permissions</h1>
					<ul class="breadcrumb">
						<li><a href="dashboard.jsp">Dashboard</a></li>
						<li><i class="fas fa-chevron-right"></i></li>
						<li><a class="" href="team.jsp">Team</a></li>
						<li><i class="fas fa-chevron-right"></i></li>
						<li><a class="" href="jobs.jsp">Jobs</a></li>
						<li><i class="fas fa-chevron-right"></i></li>
						<li><a class="active" href="job.jsp?id=<%= job.getId() %>"><%= job.getTitle() %></a></li>
					</ul>
				</div>
			</div>
			<!-- START PERMISSIONS -->
			<div class="flex-boxes">
				<div class="table">
					<div class="head">
						<h3><%= job.getTitle() %> Permissions</h3>
						<button data-modal="editJobPermissionsModal" class="btn open-modal">
							Edit Job Permission <i class="fa fa-edit"></i>
						</button>
					</div>
					<div class="permissions-container">
						<ul class="flex">
							<% if(!jobPermissions.isEmpty()){
								for(Permission perm : jobPermissions){%>
								<li class="permission-box"><%= perm.getName() %></li>
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
	<div id="editJobPermissionsModal" class="modal">
		<div class="modal-content">
			<h2>Edit Job Permission</h2>
			<form id="editJobPermissionsForm" action="edit-job-permissions" method="post">
			<input type="hidden" name="j_id" value="<%= job.getId()%>">
				<div class="input-group">
					<div class="chek-box-container">
					<%
					if (permissions != null && !permissions.isEmpty()) {
						for (Permission per : permissions) { 
							boolean exist = false;
							for(Permission p : jobPermissions){
								if(p.getId() == per.getId()){
									exist = true;
								}
							}
					%>
						<div class="check-box">
							<input
								type="checkbox" name="job_permissions" id="<%=per.getId()%>"
								value="<%=per.getId()%>"  <%= exist ? "checked" : "" %>>
							<label for="<%=per.getId()%>"><%=per.getName()%></label> 
						</div>
					<%
					}
					}
					%>
					</div>
				</div>
				<div class="btns">
					<input type="submit" class="btn" value="Edit Job Permissions" />
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
