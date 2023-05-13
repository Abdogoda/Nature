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
%>
<!DOCTYPE html>
<html lang="en">
 <head>
  <%@include file="includes/admin_header.jsp"%>
  <script>function showNotificationOnLoad() {createToast('<%=type%>', '<%=message%>')}</script>

  <title>Admin | Notifications</title>
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
       <li>
        <a href="dashboard.jsp">Dashboard</a>
       </li>
       <li><i class="fas fa-chevron-right"></i></li>
       <li>
        <a class="active" href="notifications.jsp">Notifications</a>
       </li>
      </ul>
     </div>
    </div>
    <!-- START DASHBOARD TABLE -->
    <div class="flex-boxes">
     <div class="table">
      <div class="head">
       <h3>Notifications</h3>
       <a href="" class="btn"
        >Mark All As Read <i class="fa fa-check"></i
       ></a>
      </div>

      <div class="notification-box">
       <ul>
        <li>
         <div class="left">
          <i class="fa fa-bell"></i>
          <a href="#" class="content">
           <span class="title">WareHouse</span>
           <p class="message">There is a new product in warehouse</p>
          </a>
         </div>
         <div class="right">
          <div class="time">
           <i class="fa fa-clock"></i>2 Nov 2022 at 9:30 AM
          </div>
          <div class="trash-box"><i class="fa fa-trash"></i></div>
         </div>
        </li>
        <li>
         <div class="left">
          <i class="fa fa-bell"></i>
          <a href="#" class="content">
           <span class="title">WareHouse</span>
           <p class="message">There is a new product in warehouse</p>
          </a>
         </div>
         <div class="right">
          <div class="time">
           <i class="fa fa-clock"></i>2 Nov 2022 at 9:30 AM
          </div>
          <div class="trash-box"><i class="fa fa-trash"></i></div>
         </div>
        </li>
        <li>
         <div class="left">
          <i class="fa fa-bell"></i>
          <a href="#" class="content">
           <span class="title">WareHouse</span>
           <p class="message">There is a new product in warehouse</p>
          </a>
         </div>
         <div class="right">
          <div class="time">
           <i class="fa fa-clock"></i>2 Nov 2022 at 9:30 AM
          </div>
          <div class="trash-box"><i class="fa fa-trash"></i></div>
         </div>
        </li>
        <li>
         <div class="left">
          <i class="fa fa-bell"></i>
          <a href="#" class="content">
           <span class="title">WareHouse</span>
           <p class="message">There is a new product in warehouse</p>
          </a>
         </div>
         <div class="right">
          <div class="time">
           <i class="fa fa-clock"></i>2 Nov 2022 at 9:30 AM
          </div>
          <div class="trash-box"><i class="fa fa-trash"></i></div>
         </div>
        </li>
        <li>
         <div class="left">
          <i class="fa fa-bell"></i>
          <a href="#" class="content">
           <span class="title">WareHouse</span>
           <p class="message">There is a new product in warehouse</p>
          </a>
         </div>
         <div class="right">
          <div class="time">
           <i class="fa fa-clock"></i>2 Nov 2022 at 9:30 AM
          </div>
          <div class="trash-box"><i class="fa fa-trash"></i></div>
         </div>
        </li>
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
  <%@include file="includes/admin_footer.jsp" %>
 </body>
</html>
