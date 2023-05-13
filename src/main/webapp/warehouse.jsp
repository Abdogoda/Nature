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
  <title>Admin | WareHouse</title>
 </head>
 <body>
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
      <h1>Products</h1>
      <ul class="breadcrumb">
       <li>
        <a href="dashboard.jsp">Dashboard</a>
       </li>
       <li><i class="fas fa-chevron-right"></i></li>
       <li>
        <a class="active" href="products.jsp">Products</a>
       </li>
      </ul>
     </div>
    </div>

    <!-- START DASHBOARD TABLE -->
    <div class="flex-boxes">
     <div class="table">
      <div class="head">
       <h3>All Products</h3>
       <a href="" class="btn">Add New Product <i class="fa fa-plus"></i></a>
      </div>
      <div class="products">
       <div class="filter-con">
        <ul>
         <li class="filter-box" data-filter="friuts">Friuts</li>
         <li class="filter-box" data-filter="Vegetables">Vegetables</li>
         <li class="filter-box" data-filter="Flowers">Flowers</li>
         <li class="filter-box" data-filter="Plants">Plants</li>
         <li class="filter-box" data-filter="all">all</li>
        </ul>
       </div>
       <ul>
        <li class="product-box">
         <div class="product-card">
          <a href="product.jsp"
           ><img src="assets/img/products/1.png" alt="product-img" />
           <h6 class="name">Fresh Red Apple</h6></a
          >
          <p class="category" data-category="Friuts">Category: Friuts</p>
          <p class="price">$20</p>
          <div class="btns">
           <a href="#" class="btn btn-success"
            >Edit <i class="fa fa-edit"></i
           ></a>
           <a href="#" class="btn btn-danger"
            >Delete <i class="fa fa-trash"></i
           ></a>
          </div>
         </div>
        </li>
        <li class="product-box">
         <div class="product-card">
          <a href="product.jsp"
           ><img src="assets/img/products/2.png" alt="product-img" />
           <h6 class="name">Fresh Red Apple</h6></a
          >
          <p class="category" data-category="Vegetables">
           Category: Vegetables
          </p>
          <p class="price">$20</p>
          <div class="btns">
           <a href="#" class="btn btn-success"
            >Edit <i class="fa fa-edit"></i
           ></a>
           <a href="#" class="btn btn-danger"
            >Delete <i class="fa fa-trash"></i
           ></a>
          </div>
         </div>
        </li>
        <li class="product-box">
         <div class="product-card">
          <a href="product.jsp"
           ><img src="assets/img/products/3.png" alt="product-img" />
           <h6 class="name">Fresh Red Apple</h6></a
          >
          <p class="category" data-category="Flowers">Category: Flowers</p>
          <p class="price">$20</p>
          <div class="btns">
           <a href="#" class="btn btn-success"
            >Edit <i class="fa fa-edit"></i
           ></a>
           <a href="#" class="btn btn-danger"
            >Delete <i class="fa fa-trash"></i
           ></a>
          </div>
         </div>
        </li>
        <li class="product-box">
         <div class="product-card">
          <a href="product.jsp"
           ><img src="assets/img/products/4.png" alt="product-img" />
           <h6 class="name">Fresh Red Apple</h6></a
          >
          <p class="category" data-category="Friuts">Category: Friuts</p>
          <p class="price">$20</p>
          <div class="btns">
           <a href="#" class="btn btn-success"
            >Edit <i class="fa fa-edit"></i
           ></a>
           <a href="#" class="btn btn-danger"
            >Delete <i class="fa fa-trash"></i
           ></a>
          </div>
         </div>
        </li>
        <li class="product-box">
         <div class="product-card">
          <a href="product.jsp"
           ><img src="assets/img/products/5.png" alt="product-img" />
           <h6 class="name">Fresh Red Apple</h6></a
          >
          <p class="category" data-category="Plants">Category: Plants</p>
          <p class="price">$20</p>
          <div class="btns">
           <a href="#" class="btn btn-success"
            >Edit <i class="fa fa-edit"></i
           ></a>
           <a href="#" class="btn btn-danger"
            >Delete <i class="fa fa-trash"></i
           ></a>
          </div>
         </div>
        </li>
        <li class="product-box">
         <div class="product-card">
          <a href="product.jsp"
           ><img src="assets/img/products/6.png" alt="product-img" />
           <h6 class="name">Fresh Red Apple</h6></a
          >
          <p class="category" data-category="Friuts">Category: Friuts</p>
          <p class="price">$20</p>
          <div class="btns">
           <a href="#" class="btn btn-success"
            >Edit <i class="fa fa-edit"></i
           ></a>
           <a href="#" class="btn btn-danger"
            >Delete <i class="fa fa-trash"></i
           ></a>
          </div>
         </div>
        </li>
        <li class="product-box">
         <div class="product-card">
          <a href="product.jsp"
           ><img src="assets/img/products/7.png" alt="product-img" />
           <h6 class="name">Fresh Red Apple</h6></a
          >
          <p class="category" data-category="Vegetables">
           Category: Vegetables
          </p>
          <p class="price">$20</p>
          <div class="btns">
           <a href="#" class="btn btn-success"
            >Edit <i class="fa fa-edit"></i
           ></a>
           <a href="#" class="btn btn-danger"
            >Delete <i class="fa fa-trash"></i
           ></a>
          </div>
         </div>
        </li>
        <li class="product-box">
         <div class="product-card">
          <a href="product.jsp"
           ><img src="assets/img/products/8.png" alt="product-img" />
           <h6 class="name">Fresh Red Apple</h6></a
          >
          <p class="category" data-category="Flowers">Category: Flowers</p>
          <p class="price">$20</p>
          <div class="btns">
           <a href="#" class="btn btn-success"
            >Edit <i class="fa fa-edit"></i
           ></a>
           <a href="#" class="btn btn-danger"
            >Delete <i class="fa fa-trash"></i
           ></a>
          </div>
         </div>
        </li>
        <li class="product-box">
         <div class="product-card">
          <a href="product.jsp"
           ><img src="assets/img/products/9.png" alt="product-img" />
           <h6 class="name">Fresh Red Apple</h6></a
          >
          <p class="category" data-category="Plants">Category: Plants</p>
          <p class="price">$20</p>
          <div class="btns">
           <a href="#" class="btn btn-success"
            >Edit <i class="fa fa-edit"></i
           ></a>
           <a href="#" class="btn btn-danger"
            >Delete <i class="fa fa-trash"></i
           ></a>
          </div>
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
