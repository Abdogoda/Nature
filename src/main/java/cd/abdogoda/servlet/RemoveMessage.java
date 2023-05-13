package cd.abdogoda.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

import cd.abdogoda.conn.DBCon;
import cd.abdogoda.dao.MessageDao;

@WebServlet("/remove-message")
public class RemoveMessage extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		String id_s = request.getParameter("id");
		if(id_s == null) {
			response.sendRedirect("messages.jsp");
		}else {
			try (PrintWriter out = response.getWriter()){
				MessageDao mdao = new MessageDao(DBCon.getConnection());
				mdao.removeMessages(Integer.parseInt(id_s));
				response.sendRedirect("messages.jsp");
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
