<%@page import="cd.abdogoda.conn.DBCon"%>
<%@page import="java.util.List"%>
<%@page import="cd.abdogoda.dao.UserDao"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@page import="cd.abdogoda.model.User"%>
<%
User admin = (User) request.getSession().getAttribute("admin");
if (admin != null) {
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
//GET ALL PRODUCTS
UserDao pd = new UserDao(DBCon.getConnection());
List<User> users = pd.getAllUsers();
%>
<!DOCTYPE html>
<html lang="en">
 <head>
  <link rel="stylesheet" href="assets/dataTablesFolder/css/jquery.dataTables.min.css"/>
  <link rel="stylesheet" href="assets/dataTablesFolder/css/buttons.dataTables.min.css"/>
  <%@include file="includes/admin_header.jsp"%>
  <script>function showNotificationOnLoad() {createToast('<%=type%>', '<%=message%>')}</script>
  <title>Admin | Team</title>
 </head>
 <body>
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
      <h1>Customers</h1>
      <ul class="breadcrumb">
       <li>
        <a href="dashboard.jsp">Dashboard</a>
       </li>
       <li><i class="fas fa-chevron-right"></i></li>
       <li>
        <a class="active" href="customers.jsp">Customers</a>
       </li>
      </ul>
     </div>
    </div>
    <!-- START DASHBOARD TABLE -->
    <div class="flex-boxes">
     <div class="table">
      <div class="head">
       <h3>Customers</h3>
      </div>
      <table id="example" class="table table-striped" style="width: 100%">
       <thead>
        <tr>
         <th>ID</th>
         <th>Name</th>
         <th>Email</th>
         <th>Phone</th>
        </tr>
       </thead>
       <tbody>
        <% if(users != null){
        	for(User user : users){
        		if(user.getGroup_id() == 1){%>
	        		<tr>
			         <td><%= user.getId() %></td>
			         <td>
			          <a href="profile.jsp?id=<%= user.getId() %>"><%= user.getName() %></a>
			         </td>
			         <td><%= user.getEmail() %></td>
			         <td><%= user.getPhone() %></td>
			        </tr>
        		<% }}}else{ %>
			        <tr>
			         <td colspan="5" class="not-found">No Members Yet!</td>
			        </tr>
        		<% } %>
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
   $(document).ready(function () {
    $("#example").DataTable({
     responsive: true,
     dom: "Bfrtip",
     buttons: ["copy", "csv", "excel", "pdf", "print"],
    });
   });
  </script>

  <!-- MAIN JS -->
  <%@include file="includes/admin_footer.jsp" %>
 </body>
</html>
