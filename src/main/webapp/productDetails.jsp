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
//GET PRODUCT
String idString = request.getParameter("id");
if (idString == null) {
	response.sendRedirect("shop.jsp");
}
ProductDao pd = new ProductDao(DBCon.getConnection());
Product product = pd.getProduct(Integer.parseInt(idString));
if (product == null) {
	response.sendRedirect("shop.jsp");
}
//GET SIMILLER PRODUCTS
List<Product> products = pd.getSimillerProducts(product.getCategory());
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
if (auth != null) {
	favs = new ProductDao(DBCon.getConnection()).getUserFavs(auth.getId());
	request.setAttribute("favs", favs);
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@include file="includes/header.jsp"%>
<title>Product Details</title>
</head>

<body onload="showNotificationOnLoad()">

	<!-- START NAV -->
	<%@include file="includes/navbar.jsp"%>
	<!-- END NAV -->


	<main>
		<!-- Product Details -->
		<section class="section product-detail">
			<div class="details container">
				<div class="left">
					<div class="main">
						<img src="uploaded_img/products/<%=product.getImage()%>" alt="" />
					</div>
					<div class="thumbnails">
						<div class="thumbnail">
							<img src="uploaded_img/products/<%=product.getImage()%>" alt="" />
						</div>
						<div class="thumbnail">
							<img src="uploaded_img/products/<%=product.getImage()%>" alt="" />
						</div>
						<div class="thumbnail">
							<img src="uploaded_img/products/<%=product.getImage()%>" alt="" />
						</div>
						<div class="thumbnail">
							<img src="uploaded_img/products/<%=product.getImage()%>" alt="" />
						</div>
					</div>
				</div>
				<div class="right">
					<h1><%=product.getName()%></h1>
					<span><%=product.getCategory()%></span>
					<div class="price"><%=product.getPrice()%>EGP
					</div>
					<div class="btns">
						<a href="add-to-cart?id=<%=product.getId()%>" class="btn btn2">Add
							To Cart <i class="fa fa-shopping-cart"></i>
						</a> <a href="shop.jsp" class="btn btn2">Back To Shop</a>
					</div>
					<h3>Product Description</h3>
					<p>Grown with care on our family-run farm, these sweet and
						succulent berries are bursting with flavor. Perfect for snacking,
						baking, or adding to your favorite smoothie, our strawberries are
						100% organic and pesticide-free. Order now and enjoy the taste of
						summer all year round!</p>
				</div>
			</div>
		</section>

		<!-- Related Products -->

		<section class="section related-products">
			<div class="title">
				<h2>Related Products</h2>
				<span>Select from the premium product brands and save plenty
					money</span>
			</div>
			<div class="product-layout container">
				<%
				if (products != null && !products.isEmpty()) {
					for (Product p : products) {
						boolean isFav = false;
						if (auth != null) {
					isFav = new ProductDao(DBCon.getConnection()).checkIsFav(p.getId(), auth.getId());
						}
				%>
				<div class="product">
					<div class="img-container">
						<img src="uploaded_img/products/<%=p.getImage()%>" alt="" />
						<div class="addCart">
							<i class="fas fa-shopping-cart"></i>
						</div>
						<ul class="side-icons">
							<a href="add-to-favorite?id=<%=p.getId()%>"
								class="<%=isFav ? "active" : ""%>"><i class="far fa-heart"></i></a>
							<a href=""><i class="fas fa-sliders-h"></i></a>
						</ul>
					</div>
					<div class="bottom">
						<a href="productDetails.jsp?id=<%=p.getId()%>"><%=p.getName()%></a>
						<h3 class="category" data-category="vegetables"><%=p.getCategory()%></h3>
						<div class="price">
							<span><%=p.getPrice()%>EGP</span>
						</div>
					</div>
				</div>
				<%
				}
				} else {
				%>
				<p class="empty">NO PRODUCTS ADDED YET!</p>
				<%
				}
				%>
			</div>
		</section>
	</main>

	<!-- START FOOTER -->
	<%@include file="includes/footer.jsp"%>
	<!-- END FOOTER -->
</body>

</html>