<%@page import="cd.abdogoda.model.Favorite"%>
<%@page import="cd.abdogoda.dao.UserDao"%>
<%@page import="cd.abdogoda.model.Cart"%>
<%@page import="java.util.ArrayList"%>
<%@page import="cd.abdogoda.model.Product"%>
<%@page import="java.util.List"%>
<%@page import="cd.abdogoda.dao.ProductDao"%>
<%@page import="cd.abdogoda.conn.DBCon"%>
<%@page import="cd.abdogoda.model.User"%>
<% 
//GET USER AUTH
User auth = (User) request.getSession().getAttribute("auth");
if (auth != null) {
	request.setAttribute("auth", auth);
}
//NOTIFICATIONS
String message = (String) request.getAttribute("message");
String type = (String) request.getAttribute("type");
if (type == null && message == null) {
	type = "";
	message = "";
}
//GET ALL PRODUCTS
ProductDao pdao = new ProductDao(DBCon.getConnection());
List<Product> allProducts = pdao.getAllProducts();
if(request.getParameter("order_by") != null && request.getParameter("price_range") != null){
	allProducts = pdao.orderAndRangeAllProducts(request.getParameter("order_by"),Integer.parseInt(request.getParameter("price_range")));
}
//GET ALL CART PRODUCTS
ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
List<Cart> cartProduct = null;
if (cart_list != null) {
	cartProduct = pdao.getCartProducts(cart_list);
	request.setAttribute("cart_list", cart_list);
}
//GET ALL FAVORITE PRODUCTS
int favs = 0;
if(auth != null){
	favs = new ProductDao(DBCon.getConnection()).getUserFavs(auth.getId());
	request.setAttribute("favs", favs);
}
%>
<!DOCTYPE html>
<html lang="en">

<head>
   <%@include file="includes/header.jsp" %>
  <title>Nature</title>
</head>

<body onload="showNotificationOnLoad()">
  <!-- START NAV -->
  <%@include file="includes/navbar.jsp" %>
  <!-- END NAV -->

   <main>
    
  <!-- PRODUCTS -->
  <section class="section products">
    <div class="products-layout container">
      <button class="open-filters"><i class="fa fa-filter"></i></button>
      <div class="col-1-of-4">
        <div class="close-filters">
          &times;
        </div>
        <div class="product-filters">
          <div class="block-title">
            <h3>Category</h3>
          </div>
          <ul class="block-content">
            <li>
              <input type="checkbox" name="category" onchange="FilterCategory(`vegetables`)" id="vegetables">
              <label for="vegetables">Vegetables</label>
            </li>
            <li>
              <input type="checkbox" name="category" onchange="FilterCategory(`fruits`)" id="fruits">
              <label for="fruits">Fruits</label>
            </li>
            <li>
              <input type="checkbox" name="category" onchange="FilterCategory(`flowers`)" id="flowers">
              <label for="flowers">Flowers</label>
            </li>
            <li>
              <input type="checkbox" name="category" onchange="FilterCategory(`plants`)" id="plants">
              <label for="plants">Plants </label>
            </li>
          </ul>
        </div>
        <form action="" method="get">
          <div class="product-filters">
            <div class="block-title">
              <h3>Order By</h3>
            </div>
              <ul class="block-content">
                <select name="order_by" id="sort-by">
                  <option value="date">Newness</option>
                  <option value="name">Name</option>
                  <option value="price">Price</option>
                  <option value="category">Category</option>
                </select>
            </ul>
          </div>
          <div class="product-filters">
            <div class="block-title">
              <h3>Price Range</h3>
            </div>
              <ul class="block-content price_range">
                <label for="price_range">$</label>
                <input type="range" name="price_range" id="price_range" min="1" value="100" max="200">
                <span id="price_range_value">100</span>
            </ul>
            <button type="submit" class="btn btn2">Applay</button>
          </div>
        </form>
      </div>
      <div class="col-3-of-4">
        <h1 class="heading">Our Products</h1>
        <div class="product-layout">
          <% if(allProducts != null && !allProducts.isEmpty()){ 
          	for(Product product : allProducts){
          		boolean isFav = false;
          		if(auth != null){
          			isFav = pdao.checkIsFav(product.getId(),auth.getId());
          		}
          	%>
          	<div class="product">
            <div class="img-container">
              <img src="uploaded_img/products/<%= product.getImage() %>" alt="" />
              <a href="add-to-cart?id=<%= product.getId() %>" class="addCart">
                <i class="fas fa-shopping-cart"></i>
              </a>
              <ul class="side-icons">
                <a href="add-to-favorite?id=<%= product.getId()%>" class="<%= isFav ? "active" : "" %>"><i class="far fa-heart"></i></a>
                <a href=""><i class="fas fa-sliders-h"></i></a>
              </ul>
            </div>
            <div class="bottom">
              <a href="productDetails.jsp?id=<%= product.getId()%>"><%= product.getName() %></a>
              <h3 class="category" data-category="<%= product.getCategory() %>"><%= product.getCategory() %></h3>
              <div class="price">
                <span><%= product.getPrice() %>EGP</span>
              </div>
            </div>
          </div>
          <% }}else{ %>
          <div class="empty"><p>NO PRODUCTS FOUND!</p></div>
          <% } %>
        </div>
      </div>
    </div>
  </section>
   </main>

	<!-- START FOOTER -->
	<%@include file="includes/footer.jsp" %>
	<!-- END FOOTER -->

  <!-- Custom Scripts -->
  <script src="assets/js/products.js"></script>
</body>

</html>