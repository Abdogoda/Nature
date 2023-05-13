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
import cd.abdogoda.dao.PermissionDao;

@WebServlet("/delete-permission")
public class DeletePermission extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		try (PrintWriter out = response.getWriter()){
			String id_s = request.getParameter("id");
			if(id_s != null) {
				try {
					boolean status = new PermissionDao(DBCon.getConnection()).deletePermission(Integer.parseInt(id_s));
					if(status) {
						// send message and redirect
					    request.setAttribute("type", "success");
					    request.setAttribute("message", "Permission Deleted Successfully!");
					    RequestDispatcher dispatcher = request.getRequestDispatcher("permissions.jsp");
					    dispatcher.forward(request, response);
					}else {
						// send message and redirect
					    request.setAttribute("type", "error");
					    request.setAttribute("message", "Permission Not Exits!");
					    RequestDispatcher dispatcher = request.getRequestDispatcher("permissions.jsp");
					    dispatcher.forward(request, response);
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
			}else {
				response.sendRedirect("permissions.jsp");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
