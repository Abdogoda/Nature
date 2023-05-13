package cd.abdogoda.servlet;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.ArrayList;

import cd.abdogoda.conn.DBCon;
import cd.abdogoda.dao.OrderDao;
import cd.abdogoda.model.Cart;
import cd.abdogoda.model.Order;
import cd.abdogoda.model.User;

@WebServlet("/check-out")
public class CheckOutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String city = request.getParameter("city"); 
		String state = request.getParameter("state"); 
		String street = request.getParameter("street"); 
		String building = request.getParameter("building"); 
		String flat = request.getParameter("flat"); 
		String payment_method = request.getParameter("payment_method"); 
		String card_number = request.getParameter("card_number"); 
		String card_holder = request.getParameter("card_holder"); 
		String card_cvv = request.getParameter("card_cvv"); 
		String expiration_date = request.getParameter("expiration_date");
		Double sub_total = Double.parseDouble(request.getParameter("sub_total"));
		Double shipping_tax = Double.parseDouble(request.getParameter("shipping_tax"));
		Double total = Double.parseDouble(request.getParameter("total"));
		String status = "pending";

		try (PrintWriter out = response.getWriter()) {
			ArrayList<Cart> cart_list = (ArrayList<Cart>) request.getSession().getAttribute("cart-list");
			User user = (User) request.getSession().getAttribute("auth");
			OrderDao odao = new OrderDao(DBCon.getConnection());
			
			if (user != null) {
				if (cart_list != null && !cart_list.isEmpty()) {
					// ############### INSERT ORDER DETAILS  #################
					int id = odao.insertOrderDetails(user.getId(), city, state, street, building, flat, payment_method, sub_total, shipping_tax, total);
					if(id != 0) { // ORDER DETAILS ADDED SUCCESSFULLY
						// #################### CHECK IF PAYMENT METHOD IS CREDIT CARD ####################
						String pay_with_credit_card = "pay_with_credit_card";
						if(pay_with_credit_card.equals(payment_method)) {
							boolean payment_method_result = odao.insertOrderPayment(id, card_number, card_holder, card_cvv, expiration_date);
							if(payment_method_result) {
								status = "completed";
							}
						}
						// ######################## ADD ORDER STATUS TO TABLE ##########################
						boolean order_status = odao.insertOrderStatus(1, id, status);
						// ######################## ADD PRODUCT ORDER TO TABLE #########################
						for (Cart c : cart_list) {
							Order order = new Order();
							order.setOrderId(id);
							order.setProductId(c.getId());
							order.setQuantity(c.getQuantity());
							order.setOrderPrice(c.getPrice());
							order.setOrderTotal(c.getQuantity() * c.getPrice());
							boolean result = odao.insertOrder(order);
							if(!result) break;
						}
						cart_list.clear();
						// send message and redirect
					    request.setAttribute("type", "success");
					    request.setAttribute("message", "You Have Ordered Successfully!");
					    RequestDispatcher dispatcher = request.getRequestDispatcher("my_orders.jsp");
					    dispatcher.forward(request, response);
					}else {
						// send message and redirect
					    request.setAttribute("type", "error");
					    request.setAttribute("message", "Some Thing Went Wrong!");
					    RequestDispatcher dispatcher = request.getRequestDispatcher("checkout.jsp");
					    dispatcher.forward(request, response);
					}
					
				} else {
					// send message and redirect
				    request.setAttribute("type", "error");
				    request.setAttribute("message", "Your Cart Is Empty!");
				    RequestDispatcher dispatcher = request.getRequestDispatcher("cart.jsp");
				    dispatcher.forward(request, response);
				}
			} else {
				// send message and redirect
			    request.setAttribute("type", "warning");
			    request.setAttribute("message", "Your Have To Login First!");
			    RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
			    dispatcher.forward(request, response);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
