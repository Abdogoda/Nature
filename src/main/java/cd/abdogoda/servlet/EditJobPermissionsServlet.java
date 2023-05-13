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
import cd.abdogoda.dao.JobDao;
import cd.abdogoda.dao.PermissionDao;

@WebServlet("/edit-job-permissions")
public class EditJobPermissionsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		try (PrintWriter out = response.getWriter()){
			String j_id = request.getParameter("j_id");
			String[] job_permissions = request.getParameterValues("job_permissions");
			if(j_id != null && job_permissions != null) {
				try {
					boolean status = new PermissionDao(DBCon.getConnection()).removeJobPermissions(Integer.parseInt(j_id));
					if(status) {
						for(String jb : job_permissions) {
							boolean s = new JobDao(DBCon.getConnection()).addJobPermission(Integer.parseInt(j_id),Integer.parseInt(jb));
						}
						// send message and redirect
					    request.setAttribute("type", "success");
					    request.setAttribute("message", "Job Permission Updated Successfully!");
					    RequestDispatcher dispatcher = request.getRequestDispatcher("job.jsp?id="+Integer.parseInt(j_id));
					    dispatcher.forward(request, response);
					}else {
						// send message and redirect
					    request.setAttribute("type", "error");
					    request.setAttribute("message", "Job Permission Not Exits!");
					    RequestDispatcher dispatcher = request.getRequestDispatcher("job.jsp?id="+Integer.parseInt(j_id));
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

}
