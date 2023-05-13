package cd.abdogoda.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import cd.abdogoda.model.Cart;

@WebServlet("/quantity-change")
public class QuantityChangeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		String action = request.getParameter("action");
		String id_s = request.getParameter("id");
		if(id_s == null) {
			response.sendRedirect("cart.jsp");
		}
		int id = Integer.parseInt(id_s);
		try (PrintWriter out = response.getWriter()){
			ArrayList<Cart> cart_list = (ArrayList<Cart>) request.getSession().getAttribute("cart-list");
			if (action != null && id >= 1) {
				if (action.equals("inc")) {
					for (Cart c : cart_list) {
						if (c.getId() == id) {
							c.setQuantity(c.getQuantity() + 1);
							response.sendRedirect("cart.jsp");
						}
					}
				}
				if (action.equals("dec")) {
					for (Cart c : cart_list) {
						if (c.getId() == id) {
							if (c.getQuantity() > 1) {
								c.setQuantity(c.getQuantity() - 1);
							}
							response.sendRedirect("cart.jsp");
						}
					}
				}
			}else {
				response.sendRedirect("cart.jsp");
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
	}

}
