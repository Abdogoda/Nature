<%@page import="cd.abdogoda.model.Message"%>
<%@page import="java.util.List"%>
<%@page import="cd.abdogoda.conn.DBCon"%>
<%@page import="cd.abdogoda.dao.MessageDao"%>
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
//GET MESSAGES
List<Message> messages = null;
int messagesCount = 0;
if (admin != null) {
	messages = new MessageDao(DBCon.getConnection()).getAllMessages();
	messagesCount = new MessageDao(DBCon.getConnection()).getMessagesCount();
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

<title>Admin | Messages</title>
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
					<h1>Notifications</h1>
					<ul class="breadcrumb">
						<li><a href="dashboard.jsp">Dashboard</a></li>
						<li><i class="fas fa-chevron-right"></i></li>
						<li><a class="active" href="messages.jsp">Messages</a></li>
					</ul>
				</div>
			</div>
			<!-- START DASHBOARD TABLE -->
			<div class="flex-boxes">
				<div class="table">
					<div class="head">
						<h3>New Messages (<%= messagesCount %>)</h3>
						<a href="all-messages-read" class="btn">Mark All As Read <i
							class="fa fa-check"></i></a>
					</div>

					<div class="notification-box messages-box">
						<ul>
						<% if(messages != null){
							for(Message m : messages){%>
							<li class="<%= m.getIsRead() ? "" : "notread" %>">
								<div class="top">
									<div class="left">
										<div class="message-icon">
											<i class="fa fa-message"></i>
										</div>
										<div class="content">
											<span class="title"><%= m.getName() %></span> <a href="mailto:<%= m.getEmail() %>"
												class="email"><%= m.getEmail() %></a>
										</div>
									</div>
									<div class="right">
										<div class="time">
											<i class="fa fa-clock"></i><%= m.getDate() %>
										</div>
										<a href="remove-message?id=<%= m.getId() %>" class="trash-box">
											<i class="fa fa-trash"></i>
										</a>
									</div>
								</div>
								<p class="message"><%= m.getMessage() %></p>
							</li>
							<% }}else{ %>
							<li>There Is No Messages For You!</li>
							<% } %>
						</ul>
					</div>
				</div>
			</div>
			<!-- END DASHBOARD TABLE -->
		</main>
		<!-- MAIN -->
	</section>
	<!-- CONTENT -->

	<!-- MAIN JS -->
	<%@include file="includes/admin_footer.jsp"%>
</body>
</html>
