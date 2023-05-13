<%@page import="cd.abdogoda.model.Job"%>
<%@page import="cd.abdogoda.dao.JobDao"%>
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
//GET JOBS
List<Job> jobs = new JobDao(DBCon.getConnection()).allJobs();
//GET PERSMMISONS
List<Permission> permissions = new PermissionDao(DBCon.getConnection()).allPermission();
%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@include file="includes/admin_header.jsp"%>
<script>
	function showNotificationOnLoad() {createToast('<%=type%>', '<%=message%>
	')
	}
</script>
<title>Admin | Jobs</title>
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
					<h1>Admin Jobs</h1>
					<ul class="breadcrumb">
						<li><a href="dashboard.jsp">Dashboard</a></li>
						<li><i class="fas fa-chevron-right"></i></li>
						<li><a class="" href="team.jsp">Team</a></li>
						<li><i class="fas fa-chevron-right"></i></li>
						<li><a class="active" href="jobs.jsp">Jobs</a></li>
					</ul>
				</div>
			</div>
			<!-- START PERMISSIONS -->
			<div class="flex-boxes">
				<div class="table">
					<div class="head">
						<h3>Admin Jobs</h3>
						<button data-modal="addJobModal" class="btn open-modal">
							Add Job <i class="fa fa-plus"></i>
						</button>
					</div>
					<table id="example" class="table table-striped" style="width: 100%">
						<thead>
							<tr>
								<th>Job ID</th>
								<th>Job Title</th>
								<th>View Job</th>
							</tr>
						</thead>
						<tbody>
							<%
							if (jobs != null || !jobs.isEmpty()) {
								for (Job job : jobs) {
							%>
							<tr>
								<td><%=job.getId()%></td>
								<td><%=job.getTitle()%></td>
								<td><a href="job.jsp?id=<%=job.getId()%>">View <i
										class="fa fa-eye"></i></a></td>
							</tr>
							<%
							}
							} else {
							%>
							<tr>
								<td colspan="5" class="not-found">No Jobs Found!</td>
							</tr>
							<%
							}
							%>
						</tbody>
					</table>
				</div>
			</div>
			<!-- END Jobs -->
			<%
			}
			%>
		</main>
		<!-- MAIN -->
	</section>
	<!-- CONTENT -->

	<!-- MODAL -->
	<div id="addJobModal" class="modal">
		<div class="modal-content">
			<h2>Create New Job</h2>
			<form id="addJobForm" action="add-job" method="post">
				<div class="input-group">
					<label for="title">Job Title</label> <input type="text"
						name="title" id="title" required />
				</div>
				<div class="input-group">
					<label for="">Job Permissions</label>
					<div class="chek-box-container">
					<%
					if (permissions != null && !permissions.isEmpty()) {
						for (Permission per : permissions) {
					%>
						<div class="check-box">
							<input
								type="checkbox" name="job_permissions" id="<%=per.getId()%>"
								value="<%=per.getId()%>">
							<label for="<%=per.getId()%>"><%=per.getName()%></label> 
						</div>
					<%
					}
					}
					%>
					</div>
				</div>
				<div class="btns">
					<input type="submit" class="btn" value="Create Job" />
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
