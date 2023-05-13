package cd.abdogoda.servlet;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import cd.abdogoda.model.Cart;

@WebServlet("/remove-from-cart")
public class RemoveItemServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		String id = request.getParameter("id");
		try (PrintWriter out = response.getWriter()) {
			if (id != null) {
				ArrayList<Cart> cart_list = (ArrayList<Cart>) request.getSession().getAttribute("cart-list");
				if (cart_list != null) {
					boolean exist = false;
					for (Cart c : cart_list) {
						if (c.getId() == Integer.parseInt(id)) {
							cart_list.remove(cart_list.indexOf(c));
							exist = true;
							// send message and redirect
						    request.setAttribute("type", "info");
						    request.setAttribute("message", "Item Removed From Cart!");
						    RequestDispatcher dispatcher = request.getRequestDispatcher("cart.jsp");
						    dispatcher.forward(request, response);
						}
					}
					if(!exist) {
						// send message and redirect
					    request.setAttribute("type", "info");
					    request.setAttribute("message", "Item Not Found In Cart!");
					    RequestDispatcher dispatcher = request.getRequestDispatcher("cart.jsp");
					    dispatcher.forward(request, response);
					}
				}
			} else {
				response.sendRedirect("cart.jsp");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
