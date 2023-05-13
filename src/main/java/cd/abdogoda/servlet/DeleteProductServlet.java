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
import cd.abdogoda.dao.ProductDao;

@WebServlet("/delete-product")
public class DeleteProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String idString = request.getParameter("id");
		if(idString != null) {
			try (PrintWriter out = response.getWriter()){
				int id = Integer.parseInt(idString);
				ProductDao pdao = new ProductDao(DBCon.getConnection());
				Boolean result = pdao.deleteProduct(id);
				if(result) {
					request.setAttribute("type", "success");
				    request.setAttribute("message", "Product Deleted Successfully!");
				    RequestDispatcher dispatcher = request.getRequestDispatcher("products.jsp");
				    dispatcher.forward(request, response);	
				}else {
					request.setAttribute("type", "warning");
				    request.setAttribute("message", "Product Not Exist!");
				    RequestDispatcher dispatcher = request.getRequestDispatcher("products.jsp");
				    dispatcher.forward(request, response);	
				}
			    
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
