<%@page import="java.text.DecimalFormat"%>
<%@page import="cd.abdogoda.dao.OrderDao"%>
<%@page import="cd.abdogoda.model.OrderDetails"%>
<%@page import="cd.abdogoda.model.Favorite"%>
<%@page import="cd.abdogoda.model.Cart"%>
<%@page import="java.util.ArrayList"%>
<%@page import="cd.abdogoda.model.User"%>
<%@page import="java.util.List"%>
<%@page import="cd.abdogoda.model.Product"%>
<%@page import="cd.abdogoda.conn.DBCon"%>
<%@page import="cd.abdogoda.dao.ProductDao"%>
<% 
//GET USER AUTH
User auth = (User) request.getSession().getAttribute("auth");
List<OrderDetails> orders = null;
if (auth != null) {
	request.setAttribute("auth", auth);
	//GET ALL ORDERS
	orders = new OrderDao(DBCon.getConnection()).userOrderDetails(auth.getId());
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

//GET ALL CART PRODUCTS
ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
List<Cart> cartProduct = null;
if (cart_list != null) {
	ProductDao pdao = new ProductDao(DBCon.getConnection());
	cartProduct = pdao.getCartProducts(cart_list);
	request.setAttribute("cart_list", cart_list);
}
//GET ALL FAVORITE PRODUCTS
int favs = 0;
if(auth != null){
	favs = new ProductDao(DBCon.getConnection()).getUserFavs(auth.getId());
	request.setAttribute("favs", favs);
}
//DOUBLE FORMAT
DecimalFormat dcf = new DecimalFormat("#.##");
request.setAttribute("dcf", dcf);
%>
<!DOCTYPE html>
<html lang="en">
<head>
   <%@include file="includes/header.jsp" %>
  <title>My Profile</title>
</head>

<body onload="showNotificationOnLoad()">

  <!-- START NAV -->
  <%@include file="includes/navbar.jsp" %>
  <!-- END NAV -->

  
  <% if(auth != null){ %>
   <main>
    <div class="container profile">
   	      <div class="profile-box">
       <div class="image">
       <% if(auth.getImage() != null && !auth.getImage().isEmpty()){ %>
        <img src="uploaded_img/users/<%= auth.getImage() %>" alt="user_image" />
       <% }else{ %>
        <img src="assets/img/profile.png" alt="user_image" />
        <% } %>
       </div>
       <div class="content">
        <h3><%= auth.getName() %></h3>
        <p class="email"><%= auth.getEmail() %></p>
        <p class="phone"><%= auth.getPhone() %></p>
        <p class="address"><%= auth.getAddress() %></p>
        <div class="btns">
        	<button data-modal="editUserModal" data-id="<%= auth.getId() %>" data-name="<%= auth.getName() %>" data-email="<%= auth.getEmail() %>" data-phone="<%= auth.getPhone() %>" data-image="<%= auth.getImage() %>" class="btn success-btn open-modal">
		        Edit Profile <i class="fa fa-edit"></i>
		    </button>
		    <a href="logout" onclick="confirm('Sure You Want Logout?')" class="btn danger-btn">Logout <i class="fa fa-right-from-bracket"></i></a>
        </div>
       </div>
      </div>
   </div>
  <div class="container orders profiel_orders">
			<h1 class="heading">My Orders</h1>
			<div class="order_table">
				<%
				if (orders != null && !orders.isEmpty()) {
				%>
				<table id="table">
				  <tr>
				  	<th>Order ID</th>
				    <th>Status</th>
				    <th>Sub Total</th>
				    <th>Shipping Tax</th>
				    <th>Total</th>
				    <th>Order Date</th>
				    <th>Operation</th>
				  </tr>
				<%
				for (OrderDetails o : orders) {
					OrderDao odao = new OrderDao(DBCon.getConnection());
					String status = odao.getLastStatus(o.getOrderId());
				%>
				<tr>
				    <td><a href="my_order.jsp?id=<%=o.getOrderId()%>"><%=o.getOrderId()%></a></td>
				    <td><span class="status <%= status %>"><%= status %></span></td>
				    <td><%=o.getSub_total()%> EGP</td>
				    <td><%=o.getShipping_tax()%> EGP</td>
				    <td><%=dcf.format(o.getTotal())%> EGP</td>
				    <td><%=o.getDate()%></td>
				    <td>
					    <a href=""><i class="fa fa-trash"></i></a> 
					    <a href="invoice.jsp?id=<%= o.getOrderId() %>" style="margin-left: 1rem;"><i class="fa fa-print"></i></a></td>
				  </tr>
				<%
				}
				%>
				</table>
				<%
				} else {
				%>
				<div class="empty">
				<p>
					You Have No Orders! <br> <a href="shop.jsp"
						class="btn btn2">Start Shopping Now <i
						class="fa fa-shopping-cart"></i></a>
			</div>
				<%
				}
				%>
				
			</div>
		</div>
	</main>
	 <!-- MODAL -->
   <div id="editUserModal" class="modal">
   <div class="modal-content">
    <h2>Edit Your Profile</h2>
    <form id="editUserForm" action="edit-user" method="post" enctype="multipart/form-data">
      <input type="hidden" name="id" id="id" required />
     <div class="input-group">
      <label for="name">User Name</label>
      <input type="text" name="name" id="name" required />
     </div>
     <div class="input-group">
      <label for="email">Email Address</label>
      <input type="email" name="email" id="email" required />
     </div>
     <div class="input-group">
      <label for="phone">Phone Number</label>
      <input type="text" name="phone" id="phone" required />
     </div>
     <div class="input-group">
      <label for="image">User Image</label>
      <img src="" alt="" id="img_src">
      <input type="file" name="image" id="image" accept=".png, .gif, .jpeg, .jpg" />
     </div>
     <div class="btns">
      <input type="submit" class="btn success-btn" value="Edit User" />
      <button type="button" class="btn danger-btn close-modal">Cancel</button>
     </div>
    </form>
   </div>
  </div>
  <!-- MODAL -->
  <% } %>
	<!-- START FOOTER -->
	 <script src="assets/js/modal.js"></script>
 	 <script src="assets/js/validation.js"></script>
	<%@include file="includes/footer.jsp" %>
	<!-- END FOOTER -->
</body>

</html>