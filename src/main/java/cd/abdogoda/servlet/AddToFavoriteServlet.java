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
import cd.abdogoda.model.Favorite;
import cd.abdogoda.model.User;

@WebServlet("/add-to-favorite")
public class AddToFavoriteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id_s = request.getParameter("id");
		User user = (User) request.getSession().getAttribute("auth");
		if(user == null) {
			// send message and redirect
		    request.setAttribute("type", "warning");
		    request.setAttribute("message", "Your Have To Login First!");
		    RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
		    dispatcher.forward(request, response);
		}else {
			if(id_s == null ) {
				response.sendRedirect("shop.jsp");
			}else{
				int u_id = user.getId();
				int p_id = Integer.parseInt(id_s);
				try (PrintWriter out = response.getWriter()){
					boolean isFav = new ProductDao(DBCon.getConnection()).checkIsFav(p_id,u_id);
					if(isFav) {
						boolean removeFromFav = new ProductDao(DBCon.getConnection()).removeFromFav(p_id,u_id);
					}else {
						boolean addToFav = new ProductDao(DBCon.getConnection()).addToFav(p_id,u_id);
					}
					response.sendRedirect("shop.jsp");
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
