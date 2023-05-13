<%@page import="cd.abdogoda.model.OrderStatus"%>
<%@page import="cd.abdogoda.model.OrderDetails"%>
<%@page import="cd.abdogoda.dao.OrderDao"%>
<%@page import="cd.abdogoda.model.Order"%>
<%@page import="cd.abdogoda.model.Favorite"%>
<%@page import="java.text.DecimalFormat"%>
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
List<Order> orders = null;
OrderDetails orderDetails = null;
String last_status = null;
User user = null;
String id_s = request.getParameter("id");
if (id_s != null) {
	//GET ORDER Information
	orders = new OrderDao(DBCon.getConnection()).userOrdersWithDetailsId(Integer.parseInt(id_s));
	orderDetails = new OrderDao(DBCon.getConnection()).getOrderDetails(Integer.parseInt(id_s));
	last_status = new OrderDao(DBCon.getConnection()).getLastStatus(Integer.parseInt(id_s));
	user = new UserDao(DBCon.getConnection()).getUser(orderDetails.getUserId());
} else {
	response.sendRedirect("my_orders.jsp");
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
<!-- Required meta tags -->
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />

<!--  CSS -->
<link rel="stylesheet" href="assets/css/bootstrap.min.css" />
<link href="assets/css/all.min.css" rel="stylesheet">
<link rel="stylesheet" href="assets/css/invoice.css" />
<link rel="shortcut icon" href="assets/img/favicon.png" type="image/png" />
    <style>
      /* Define a print style that hides all elements except the target section */
      @media print {
        body * {
          visibility: hidden;
        }
        .page, .page * {
          visibility: visible;
        }
      }
    </style>

<title>Invoice</title>
</head>

<body>
	<%
	if (id_s != null && user != null && orders != null && orderDetails != null && last_status != null) {
	%>
	<div class="my-5 page" size="A4">
		<div class="p-5">
			<section class="top-content bb d-flex justify-content-between">
				<div class="logo">
					<img src="assets/img/logo.png" alt="" class="img-fluid" />
				</div>
				<div class="top-left">
					<div class="graphic-path">
						<p>Invoice</p>
					</div>
					<div class="position-relative">
						<p>
							Invoice No. <span><%=orderDetails.getOrderId()%></span>
						</p>
					</div>
				</div>
			</section>

			<section class="store-user mt-5">
				<div class="col-12">
					<div class="row bb pb-3">
						<div class="col">
							<p>Supplier,</p>
							<h2>Nature Store</h2>
							<p class="address">
								777 Brockton Avenue, <br /> Abington MA 2351, <br />Vestavia
								Hills AL
							</p>
							<div class="txn mt-2">Phone: 012545456214</div>
						</div>
						<div class="col">
							<p>Client,</p>
							<h2><%=user.getName()%></h2>
							<p class="address">
								<%=orderDetails.getFlat()%>
								<%=orderDetails.getBuilding()%>
								-
								<%=orderDetails.getStreet()%>
								<br />
								<%=orderDetails.getCity()%> , <%=orderDetails.getState()%>
							</p>
							<div class="txn mt-2">
								Phone:
								<%=user.getPhone()%></div>
						</div>
					</div>
					<div class="row extra-info pt-3">
						<div class="col-7">
							<p>
								Payment Method: <span><%=orderDetails.getPayment_method()%></span>
							</p>
							<p>
								Order Number: <span>#<%=orderDetails.getOrderId()%></span>
							</p>
						</div>
						<div class="col-5">
							<p>
								Order Date: <span><%=orderDetails.getDate()%></span>
							</p>
						</div>
					</div>
				</div>
			</section>

			<section class="product-area mt-4">
				<table class="table table-hover">
					<thead>
						<tr>
							<td>Item Description</td>
							<td>Price</td>
							<td>Quantity</td>
							<td>Total</td>
						</tr>
					</thead>
					<tbody>
						<%
						if (!orders.isEmpty()) {
							for (Order order : orders) {
						%>
						<tr>
							<td>
								<div class="media">
									<img class="mr-3 img-fluid"
										src="uploaded_img/products/<%=order.getImage()%>"
										alt="<%=order.getName()%>" />
									<div class="media-body">
										<p class="mt-0 title"><%=order.getName()%></p>
										<%=order.getCategory()%>.
									</div>
								</div>
							</td>
							<td><%=order.getOrderPrice()%> EGP</td>
							<td><%=order.getQuantity()%></td>
							<td><%=order.getOrderTotal()%> EGP</td>
						</tr>
						<%
						}
						}
						%>
					</tbody>
				</table>
			</section>

			<section class="balance-info">
				<div class="row">
					<div class="col-8">

					</div>
					<div class="col-4">
						<table class="table border-0 table-hover">
							<tr>
								<td>Sub Total:</td>
								<td><%=orderDetails.getSub_total()%> EGP</td>
							</tr>
							<tr>
								<td>Delivery Tax:</td>
								<td><%=orderDetails.getShipping_tax()%> EGP</td>
							</tr>
							<tfoot>
								<tr>
									<td>Total:</td>
									<td><%=orderDetails.getTotal()%> EGP</td>
								</tr>
							</tfoot>
						</table>

						<!-- Signature -->
						<div class="col-12">
							<img src="assets/img/signature.png" class="img-fluid" alt="" />
							<p class="text-center m-0">Director Signature</p>
						</div>
					</div>
				</div>
			</section>
			<footer>
				<hr />
				<p class="m-0 text-center">
					View THis Invoice Online At - <a
						href="http://localhost:8080/Nature/invoice.jsp?id=<%=orderDetails.getOrderId()%>">
						http://localhost:8080/Nature/invoice.jsp?id=<%=orderDetails.getOrderId()%>
					</a>
				</p>
			</footer>
		</div>
	</div>
	<%
	}
	%>
	    <script>
      window.onload = function() {
        window.print();
      };
    </script>
</body>
</html>
