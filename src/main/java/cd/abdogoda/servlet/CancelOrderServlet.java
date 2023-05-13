package cd.abdogoda.servlet;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

import cd.abdogoda.conn.DBCon;
import cd.abdogoda.dao.OrderDao;

@WebServlet("/cancel-order")
public class CancelOrderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try (PrintWriter out = response.getWriter()){
			String id = request.getParameter("id");
			if(id != null) {
				OrderDao odao = new OrderDao(DBCon.getConnection());
				odao.cancelOrder(Integer.parseInt(id));
			}
			// send message and redirect
		    request.setAttribute("type", "info");
		    request.setAttribute("message", "Order Cancelled!");
		    RequestDispatcher dispatcher = request.getRequestDispatcher("order.jsp");
		    dispatcher.forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
