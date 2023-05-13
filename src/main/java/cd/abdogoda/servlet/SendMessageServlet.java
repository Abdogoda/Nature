package cd.abdogoda.servlet;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.PreparedStatement;

import cd.abdogoda.conn.DBCon;
import cd.abdogoda.dao.MessageDao;
import cd.abdogoda.dao.ProductDao;

@WebServlet("/send-message")
public class SendMessageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		try (PrintWriter out = response.getWriter()){
			String name = request.getParameter("name");
			String email = request.getParameter("email");
			String phone = request.getParameter("phone");
			String message = request.getParameter("message");
			try {
				MessageDao mdao = new MessageDao(DBCon.getConnection());
				boolean status = mdao.addMessage(name, email, phone, message);
				if(status) {
					// send message and redirect
				    request.setAttribute("type", "success");
				    request.setAttribute("message", "Your Message Sent Successfully!");
				    RequestDispatcher dispatcher = request.getRequestDispatcher("contact.jsp");
				    dispatcher.forward(request, response);	
				}else {
					// send message and redirect
				    request.setAttribute("type", "warning");
				    request.setAttribute("message", "Message Already Sent!");
				    RequestDispatcher dispatcher = request.getRequestDispatcher("contact.jsp");
				    dispatcher.forward(request, response);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
