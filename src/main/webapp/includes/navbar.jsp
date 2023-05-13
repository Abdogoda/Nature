<ul class="notifications"></ul>
  <!-- NAVBAR SECTION -->
  <nav class="nav">
   <div class="container">
    <div class="nav-top">
     <div class="logo">
      <a href="index.jsp">
       <img src="assets/img/logo.png" alt="" />
      </a>
     </div>
     <form action="" method="post" class="search-box">
      <input
       type="search"
       name="search"
       id="search"
       placeholder="Search Product"
      />
      <button type="submit"><i class="fa fa-search"></i></button>
     </form>
     <div class="icons">
      <a class="open-nav"><i class="fas fa-bars"></i></a>
      <a class="open-search"><i class="fas fa-search"></i></a>
      <a href="cart.jsp" class="badge">
       <i class="fa fa-shopping-bag"></i>
	       <% if(cart_list!= null && cart_list.size()>0){ %>
	       	<small class="count d-flex">${ cart_list.size() }</small>
	       <% } %>
      </a>
      <a href="favorites.jsp" class="badge">
       <i class="fa fa-star"></i>
            <% if(favs != 0){ %>
		      <small class="count d-flex">${ favs }</small>
		    <% } %>
      </a>
      	<a href="myprofile.jsp"><i class="fa fa-user"></i></a>
     </div>
    </div>
    <div class="nav-bottom">
     <div class="top">
      <div class="logo">
       <a href="index.jsp">
        <img src="assets/img/logo.png" alt="" />
       </a>
      </div>
      <label for="" class="close-nav"><i class="fas fa-times"></i></label>
     </div>
     <ul>
      <li><a href="index.jsp">Home</a></li>
      <li><a href="shop.jsp">Products</a></li>
      <li><a href="cart.jsp">Cart</a></li>
      <% if(auth != null){ %>
      <li><a href="my_orders.jsp">Orders</a></li>
      <% } %>
      <li><a href="about.jsp">About</a></li>
      <li><a href="contact.jsp">Contact</a></li>
     </ul>
    </div>
   </div>
  </nav>
  <button class="back-to-top"><i class="fa fa-chevron-up"></i></button>
