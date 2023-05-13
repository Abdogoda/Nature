package cd.abdogoda.servlet;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import cd.abdogoda.conn.DBCon;
import cd.abdogoda.dao.ProductDao;
import cd.abdogoda.model.Cart;
import cd.abdogoda.model.Product;

@WebServlet("/add-to-cart")
public class AddToCartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		try (PrintWriter out = response.getWriter()) {
			ArrayList<Cart> cartList = new ArrayList<>();
			int id = Integer.parseInt(request.getParameter("id"));
			ProductDao pdao = new ProductDao(DBCon.getConnection());
			Product product = pdao.getProduct(id);
			if(product != null) {
				Cart cm = new Cart();
				cm.setId(id);
				cm.setQuantity(1);
				cm.setPrice(product.getPrice());

				HttpSession session = request.getSession();
				ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
				if (cart_list == null) {
					cartList.add(cm); //add the product to list
					session.setAttribute("cart-list", cartList); //start cart session
					response.sendRedirect("shop.jsp");
				} else {
					cartList = cart_list;
					boolean exist = false;
					for (Cart c : cart_list) {
						if (c.getId() == id) {
							c.setQuantity(c.getQuantity() + 1);
							exist = true;
						}
					}
					if (!exist) {
						cartList.add(cm); //add the product to list
					} 
					response.sendRedirect("shop.jsp");
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
