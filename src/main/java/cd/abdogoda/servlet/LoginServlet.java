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
import cd.abdogoda.dao.UserDao;
import cd.abdogoda.model.User;

@WebServlet("/user-login")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
  
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.sendRedirect("login.jsp");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		try (PrintWriter out = response.getWriter()){
			String email = request.getParameter("l_email");
			String password  = request.getParameter("l_password");
			try {
				UserDao udao = new UserDao(DBCon.getConnection());
				User user = udao.userLogin(email, password);
				if(user != null) {
					if(user.getGroup_id() == 1) {
						request.getSession().setAttribute("auth", user);
						// send message and redirect
					    request.setAttribute("type", "success");
					    request.setAttribute("message", "Welcome Back "+user.getName()+"!");
					    RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
					    dispatcher.forward(request, response);
					}else if(user.getGroup_id() == 0){
						request.getSession().setAttribute("admin", user);
						// send message and redirect
					    request.setAttribute("type", "success");
					    request.setAttribute("message", "Welcome Back "+user.getName()+"!");
					    RequestDispatcher dispatcher = request.getRequestDispatcher("dashboard.jsp");
					    dispatcher.forward(request, response);
					}
				}else {
					// send message and redirect
				    request.setAttribute("type", "error");
				    request.setAttribute("message", "Incorrect Username Or Password!");
				    RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
				    dispatcher.forward(request, response);
				}
			} catch (Exception e) {
				out.print(e.getMessage());
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
	}

}
