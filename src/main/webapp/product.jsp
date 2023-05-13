<%@page import="java.util.List"%>
<%@page import="cd.abdogoda.model.Product"%>
<%@page import="cd.abdogoda.conn.DBCon"%>
<%@page import="cd.abdogoda.dao.ProductDao"%>
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
//GET PRODUCT
String idString = request.getParameter("id");
if(idString == null){
	response.sendRedirect("products.jsp");
}
ProductDao pd = new ProductDao(DBCon.getConnection());
Product product = pd.getProduct(Integer.parseInt(idString));
if(product == null){
	response.sendRedirect("products.jsp");
}
//GET SIMILLER PRODUCTS
List<Product> products = pd.getSimillerProducts(product.getCategory());
%>
<!DOCTYPE html>
<html lang="en">
 <head>
  <%@include file="includes/admin_header.jsp"%>
  <script>function showNotificationOnLoad() {createToast('<%=type%>', '<%=message%>')}</script>
  <title>Admin | Product</title>
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
      <h1>Product</h1>
      <ul class="breadcrumb">
       <li>
        <a href="dashboard.jsp">Dashboard</a>
       </li>
       <li><i class="fas fa-chevron-right"></i></li>
       <li>
        <a href="products.jsp">Products</a>
       </li>
       <li><i class="fas fa-chevron-right"></i></li>
       <li>
        <a class="active" href="product.jsp">Product</a>
       </li>
      </ul>
     </div>
    </div>

    <!-- START DASHBOARD TABLE -->
    <div class="flex-boxes">
     <div class="table">
      <div class="product-details">
       <div class="img">
       <% if(product.getImage() == null && product.getImage() == ""){ %>
           <img src="assets/img/no-image.jpg" alt="product-img" />
          <% }else{ %>
          <img src="uploaded_img/products/<%= product.getImage() %>" alt="Proudct-img" />
          <% } %>
       </div>
       <div class="content">
        <h1 class="name"><%= product.getName() %></h1>
        <p class="category"><%= product.getCategory() %></p>
        <p class="price">$<%= product.getPrice() %></p>
        <p class="description">Lorem ipsum dolor, sit amet consectetur adipisicing elit. Numquam iste
         fugiat enim sint quibusdam quisquam soluta, assumenda aliquid? Adipisci
         praesentium quod voluptas velit perspiciatis labore earum dignissimos
         delectus exercitationem officia </p>
        <div class="btns">
          <button data-modal="editProductModal" data-id="<%= product.getId() %>" data-name="<%= product.getName() %>" data-category="<%= product.getCategory() %>" data-price="<%= product.getPrice() %>" data-image="<%= product.getImage() %>" data-description="This is an example product description." class="btn btn-success open-modal">
	        Edit <i class="fa fa-edit"></i>
	       </button>
           <a href="delete-product?id=<%= product.getId() %>" onclick="alert('Sure You Want To Deleted This Product!')" class="btn btn-danger"
            >Delete <i class="fa fa-trash"></i
           ></a>
        </div>
       </div>
      </div>
      <div class="head" style="margin-top: 3rem">
       <h3>Similler Products</h3>
      </div>
      <div class="products">
       <ul>
        <%
			if (!products.isEmpty()) {
				for (Product p : products) {
		%>
        <li class="product-box">
         <div class="product-card">
          <a href="product.jsp?id=<%= p.getId() %>"
           ><img src="uploaded_img/products/<%= p.getImage() %>" alt="product-img" />
           <h6 class="name"><%= p.getName() %></h6></a
          >
          <p class="category" data-category="<%= p.getCategory() %>">Category: <%= p.getCategory() %></p>
          <p class="price">$<%= p.getPrice() %></p>
          <div class="btns">
            <button data-modal="editProductModal" data-id="<%= p.getId() %>" data-name="<%= p.getName() %>" data-category="<%= p.getCategory() %>" data-price="<%= p.getPrice() %>" data-image="<%= p.getImage() %>" data-description="This is an example product description." class="btn btn-success open-modal">
	        Edit <i class="fa fa-edit"></i>
	       </button>
           <a href="delete-product?id=<%= p.getId() %>" onclick="alert('Sure You Want To Deleted This Product!')" class="btn btn-danger"
            >Delete <i class="fa fa-trash"></i
           ></a>
          </div>
         </div>
        </li>
        <%
			}
			} else {
			%>
				<li class="not-found" >No Products Found</li>
			<%
			}
			%>
       </ul>
      </div>
     </div>
    </div>
    <!-- END DASHBOARD TABLE -->
   </main>
   <!-- MAIN -->
  </section>
  <!-- CONTENT -->

    <!-- MODAL -->
   <div id="editProductModal" class="modal">
   <div class="modal-content">
    <h2>Edit Product</h2>
    <form id="editProductForm" action="edit-product" method="post" enctype="multipart/form-data">
      <input type="hidden" name="o_id" id="o_id" required />
     <div class="input-group">
      <label for="o_name">Product Name</label>
      <input type="text" name="o_name" id="o_name" required />
     </div>
     <div class="input-group">
      <label for="odescription">Product Desciption</label>
      <textarea name="odescription" id="o_description"></textarea>
     </div>
     <div class="input-group">
      <label for="o_category">Product Category</label>
      <select name="o_category" id="o_category">
       <option value="0">Select Product Category</option>
       <option value="friuts">friuts</option>
       <option value="Vegetables">Vegetables</option>
       <option value="flowers">flowers</option>
       <option value="plants">plants</option>
      </select>
      </div>
     <div class="input-group">
      <label for="o_price">Product Price</label>
      <input type="text" name="o_price" id="o_price" required />
     </div>
     <div class="input-group">
      <label for="o_image">Product Image</label>
      <img src="" alt="" id="o_img_src">
      <input type="file" name="o_image" id="o_image" accept=".png, .gif, .jpeg, .jpg" />
     </div>
     <div class="btns">
      <input type="submit" class="btn" value="Edit Product" />
      <button type="button" class="btn btn-danger close-modal">Cancel</button>
     </div>
    </form>
   </div>
  </div>
  <!-- MODAL -->
  <!-- MAIN JS -->
  <script src="assets/js/modal.js"></script>
  <script src="assets/js/validation.js"></script>
  <%@include file="includes/admin_footer.jsp" %>
 </body>
</html>
