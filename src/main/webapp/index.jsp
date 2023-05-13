<%@page import="cd.abdogoda.model.Favorite"%>
<%@page import="cd.abdogoda.dao.UserDao"%>
<%@page import="cd.abdogoda.model.Cart"%>
<%@page import="java.util.ArrayList"%>
<%@page import="cd.abdogoda.model.Product"%>
<%@page import="java.util.List"%>
<%@page import="cd.abdogoda.dao.ProductDao"%>
<%@page import="cd.abdogoda.conn.DBCon"%>
<%@page import="cd.abdogoda.model.User"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
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
//GET RECENT PRODUCTS
List<Product> recentProducts = pdao.getAllProducts();
//GET ALL CART PRODUCTS
ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
List<Cart> cartProduct = null;
if (cart_list != null) {
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
<title>Nature</title>
<%@include file="includes/header.jsp"%>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/6.7.5/swiper-bundle.min.css" />
</head>
<body onload="showNotificationOnLoad()">
	<!-- START NAV -->
	<%@include file="includes/navbar.jsp"%>
	<!-- END NAV -->

	<!-- START MAIN -->
	<main>
		<!-- HERO SECTION  -->
		<div class="hero">
			<div class="row">
				<div class="swiper-container slider-1">
					<div class="swiper-wrapper">
						<div class="swiper-slide">
							<img src="assets/img/hero-1.png" alt="" />
							<div class="content">
								<h1>
									Super market vegbox <br /> start from <span>9EGP</span>
								</h1>
								<p>Lorem ipsum dolor, sit amet consectetur adipisicing elit.
									Corrupti ad natus facilis magni corporis alias.</p>

								<a href="#">Shop Now</a>
							</div>
						</div>

						<div class="swiper-slide">
							<img src="assets/img/hero-2.png" alt="hero image" />
							<div class="content">
								<h1>
									You first Order <br /> <span>20% off</span> at Juice
								</h1>
								<p>Lorem ipsum dolor, sit amet consectetur adipisicing elit.
									Corrupti ad natus facilis magni corporis alias.</p>
								<a href="#">Shop Now</a>
							</div>
						</div>

						<div class="swiper-slide">
							<img src="assets/img/hero-3.png" alt="hero image" />
							<div class="content">
								<h1>
									You first Order <br /> <span>20% off</span> at Juice
								</h1>
								<p>Lorem ipsum dolor, sit amet consectetur adipisicing elit.
									Corrupti ad natus facilis magni corporis alias.</p>
								<a href="#">Shop Now</a>
							</div>
						</div>
					</div>
				</div>
			</div>

			<!-- Carousel Navigation -->
			<div class="arrows d-flex">
				<div class="swiper-prev d-flex">
					<i class="fa fa-chevron-left swiper-icon"></i>
				</div>
				<div class="swiper-next d-flex">
					<i class="fa fa-chevron-right swiper-icon"></i>
				</div>
			</div>
		</div>

		<!-- Featured -->
		<section class="section featured">
			<div class="title">
				<h2>Featured Products</h2>
				<span>Select from the premium product brands and save plenty
					money</span>
			</div>
			<div class="row container">
				<div class="swiper-container slider-2">
					<div class="swiper-wrapper">
						<%
						if (recentProducts != null && !recentProducts.isEmpty()) {
							for (Product product : recentProducts) {
								boolean isFav = false;
								if (auth != null) {
							isFav = pdao.checkIsFav(product.getId(), auth.getId());
								}
						%>
						<div class="swiper-slide">
							<div class="product">
								<div class="img-container">
									<img src="uploaded_img/products/<%=product.getImage()%>"
										alt="" /> <a href="add-to-cart?id=<%=product.getId()%>"
										class="addCart"> <i class="fas fa-shopping-cart"></i>
									</a>
									<ul class="side-icons">
										<a href="add-to-favorite?id=<%=product.getId()%>"
											class="<%=isFav ? "active" : ""%>"><i
											class="far fa-heart"></i></a>
										<a href=""><i class="fas fa-sliders-h"></i></a>
									</ul>
								</div>
								<div class="bottom">
									<a href="productDetails.jsp?id=<%=product.getId()%>"><%=product.getName()%></a>
									<h3 class="category" data-category="vegetables"><%=product.getCategory()%></h3>
									<div class="price">
										<span><%=product.getPrice()%>EGP</span>
									</div>
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
				</div>
			</div>

			<!-- Carousel Navigation -->
			<div class="arrows d-flex">
				<div class="custom-next d-flex">
					<i class="fa fa-chevron-right swiper-icon"></i>
				</div>
				<div class="custom-prev d-flex">
					<i class="fa fa-chevron-left swiper-icon"></i>
				</div>
			</div>
		</section>

		<!-- Promotion -->
		<section class="section promotion">
			<div class="title">
				<h2>Shop Collections</h2>
				<span>Select from the premium product and save plenty money</span>
			</div>
			<div class="promotion-layout container">
				<div class="promotion-item">
					<img src="assets/img/promo1.jpg" alt="" />
					<div class="promotion-content">
						<h3>JUICE</h3>
						<a href="shop.jsp">SHOP NOW</a>
					</div>
				</div>
				<div class="promotion-item">
					<img src="assets/img/promo2.jpg" alt="" />
					<div class="promotion-content">
						<h3>MANGO</h3>
						<a href="shop.jsp">SHOP NOW</a>
					</div>
				</div>
				<div class="promotion-item">
					<img src="assets/img/promo3.jpg" alt="" />
					<div class="promotion-content">
						<h3>GRAPES</h3>
						<a href="shop.jsp">SHOP NOW</a>
					</div>
				</div>
				<div class="promotion-item">
					<img src="assets/img/promo4.jpg" alt="" />
					<div class="promotion-content">
						<h3>POTATOE</h3>
						<a href="shop.jsp">SHOP NOW</a>
					</div>
				</div>
				<div class="promotion-item">
					<img src="assets/img/promo5.jpg" alt="" />
					<div class="promotion-content">
						<h3>ORANGE</h3>
						<a href="shop.jsp">SHOP NOW</a>
					</div>
				</div>
				<div class="promotion-item">
					<img src="assets/img/promo6.jpg" alt="" />
					<div class="promotion-content">
						<h3>PINEAPPLE</h3>
						<a href="shop.jsp">SHOP NOW</a>
					</div>
				</div>
			</div>
		</section>

		<!-- Products -->
		<section class="section products">
			<div class="title">
				<h2>New Products</h2>
				<span>Select from the premium product brands and save plenty
					money</span>
			</div>

			<div class="row container">
				<div class="product-layout">
					<%
					if (recentProducts != null && !recentProducts.isEmpty()) {
						for (Product product : recentProducts) {
							boolean isFav = false;
							if (auth != null) {
						isFav = pdao.checkIsFav(product.getId(), auth.getId());
							}
					%>
					<div class="product">
						<div class="img-container">
							<img src="uploaded_img/products/<%=product.getImage()%>" alt="" />
							<div class="addCart">
								<i class="fas fa-shopping-cart"></i>
							</div>
							<ul class="side-icons">
								<a href="add-to-favorite?id=<%=product.getId()%>"
									class="<%=isFav ? "active" : ""%>"><i
									class="far fa-heart"></i></a>
								<a href=""><i class="fas fa-sliders-h"></i></a>
							</ul>
						</div>
						<div class="bottom">
							<a href="productDetails.jsp?id=<%=product.getId()%>"><%=product.getName()%></a>
							<h3 class="category" data-category="vegetables"><%=product.getCategory()%></h3>
							<div class="price">
								<span><%=product.getPrice()%>EGP</span>
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
			</div>
		</section>

		<!-- ADVERT -->
		<section class="section advert">
			<div class="advert-layout container">
				<div class="item ">
					<img src="assets/img/banner1.jpg" alt="">
					<div class="content left">
						<span>Exclusive Sales</span>
						<h3>Spring Collections</h3>
						<a href="">View Collection</a>
					</div>
				</div>
				<div class="item">
					<img src="assets/img/banner2.jpg" alt="">
					<div class="content  right">
						<span>New Trending</span>
						<h3>Designer Bags</h3>
						<a href="">Shop Now </a>
					</div>
				</div>
			</div>
		</section>

		<!-- BRANDS -->
		<section class="section brands">
			<div class="title">
				<h2>Shop by Brand</h2>
				<span>Select from the premium product brands and save plenty
					money</span>
			</div>

			<div class="brand-layout container">
				<div class="swiper-container slider-3">
					<div class="swiper-wrapper">
						<div class="swiper-slide">
							<img src="assets/img/brand1.png" alt="">
						</div>
						<div class="swiper-slide">
							<img src="assets/img/brand2.png" alt="">
						</div>
						<div class="swiper-slide">
							<img src="assets/img/brand3.png" alt="">
						</div>
						<div class="swiper-slide">
							<img src="assets/img/brand4.png" alt="">
						</div>
						<div class="swiper-slide">
							<img src="assets/img/brand5.png" alt="">
						</div>
						<div class="swiper-slide">
							<img src="assets/img/brand6.png" alt="">
						</div>
						<div class="swiper-slide">
							<img src="assets/img/brand7.png" alt="">
						</div>

					</div>
				</div>
			</div>
		</section>
	</main>

	<!-- START FOOTER -->
	<%@include file="includes/footer.jsp"%>
	<!-- END FOOTER -->


	<!-- ======== SwiperJS ======= -->
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/6.7.5/swiper-bundle.min.js"></script>
	<!-- Custom Scripts -->
	<script src="assets/js/slider.js"></script>
</body>
</html>
