<%@page import="cd.abdogoda.model.Employee"%>
<%@page import="cd.abdogoda.model.Job"%>
<%@page import="cd.abdogoda.dao.JobDao"%>
<%@page import="java.util.List"%>
<%@page import="cd.abdogoda.conn.DBCon"%>
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
//GET ALL Users
UserDao pd = new UserDao(DBCon.getConnection());
List<User> users = pd.getAllUsers();
//GET ALL JOBS
List<Job> jobs = new JobDao(DBCon.getConnection()).allJobs();
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
      <h1>Team</h1>
      <ul class="breadcrumb">
       <li>
        <a href="dashboard.jsp">Dashboard</a>
       </li>
       <li><i class="fas fa-chevron-right"></i></li>
       <li>
        <a class="active" href="team.jsp">Team</a>
       </li>
      </ul>
     </div>
    </div>

    <div class="links-box">
     <a href="jobs.jsp" class="btn">Admin Jobs</a>
     <a href="permissions.jsp" class="btn">Admin Permission</a>
    </div>
    <!-- START DASHBOARD TABLE -->
    <div class="flex-boxes">
     <div class="table">
      <div class="head">
       <h3>Team Members</h3>
        <button data-modal="addUserModal" class="btn open-modal">
	        Add Member <i class="fa fa-user-plus"></i>
	    </button>
      </div>
      <table id="example" class="table table-striped" style="width: 100%">
       <thead>
        <tr>
         <th>ID</th>
         <th>User</th>
         <th>Membership</th>
         <th>Email</th>
         <th>Phone</th>
        </tr>
       </thead>
       <tbody>
        <% if(users != null){
        	for(User user : users){
        		if(user.getGroup_id() == 0){
        		Employee employee = new UserDao(DBCon.getConnection()).getEmployee(user.getId());
				Job job = new JobDao(DBCon.getConnection()).getJob(employee.getJob_id());%>
        	<tr>
	         <td><%= user.getId() %></td>
	         <td><a href="profile.jsp?id=<%= user.getId() %>"><%= user.getName() %></a></td>
	         <td><%= job.getTitle() %></td>
	         <td><%= user.getEmail() %></td>
	         <td><%= user.getPhone() %></td>
	        </tr>
        <%} }}else{%>
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
      <!-- MODAL -->
   <div id="addUserModal" class="modal">
   <div class="modal-content">
    <h2>Create New Admin</h2>
    <form id="addAdminForm" action="add-member" method="post" enctype="multipart/form-data">
     <div class="input-group">
      <label for="name">Admin Name</label>
      <input type="text" name="name" id="name" required />
     </div>
     <div class="input-group-flex">
     	<div class="input-group">
	      <label for="email">Email Address</label>
	      <input type="email" name="email" id="email" required />
	     </div>
	     <div class="input-group">
	      <label for="phone">Phone Number</label>
	      <input type="text" name="phone" id="phone" required />
	     </div> 
     </div>    
	 <div class="input-group">
	   <label for="address">Admin Address</label>
	   <input type="text" name="address" id="address" required />
	 </div>
     <div class="input-group-flex">
	     <div class="input-group">
		   <label for="password">Admin Password</label>
		   <input type="text" name="password" id="password" required />
		 </div>
		 <div class="input-group">
	      <label for="gender">Admin Job</label>
			<select name="job_id" id="job_id" required>
			<% if(jobs != null && !jobs.isEmpty()){
				for(Job job : jobs){%>
				<option value="<%= job.getId() %>"><%= job.getTitle() %></option>
				<%}} %>
			</select>
	     </div>
     </div>
     <div class="input-group-flex">
     	<div class="input-group">
	      <label for="ssn">Admin SSN</label>
	      <input type="text" name="ssn" id="ssn" required maxlength="14" length=14" minlength="14" />
	     </div>
	     <div class="input-group">
	      <label for="birth_date">Birth Of Date</label>
	      <input type="date" name="birth_date" id="birth_date" required />
	     </div>
     </div>
     <div class="input-group-flex">
	     <div class="input-group">
	      <label for="gender">Admin Gender</label>
			<select name="gender" id="gender" required>
				<option value="0">Male</option>
				<option value="1">Female</option>
			</select>
	     </div>
	     <div class="input-group">
	      <label for="image">Admin Image</label>
	      <input type="file" name="image" id="image" accept=".png, .gif, .jpeg, .jpg" required />
	     </div>
     </div>
     <div class="btns">
      <input type="submit" class="btn" value="Create Admin" />
      <button type="button" class="btn btn-danger close-modal">Cancel</button>
     </div>
    </form>
   </div>
  </div>
  <!-- MODAL -->
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
  <script src="assets/js/modal.js"></script>
  <script src="assets/js/validation.js"></script>
  <%@include file="includes/admin_footer.jsp" %>
 </body>
</html>
