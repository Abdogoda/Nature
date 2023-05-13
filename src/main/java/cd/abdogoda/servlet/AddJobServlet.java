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
import cd.abdogoda.model.Job;

@WebServlet("/add-job")
public class AddJobServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		try (PrintWriter out = response.getWriter()){
			String title = request.getParameter("title");
			String[] job_permissions = request.getParameterValues("job_permissions");
			try {
				
				boolean status = new JobDao(DBCon.getConnection()).addJob(title);
				if(status) {
					Job job = new JobDao(DBCon.getConnection()).getJobByTitle(title);
					if(job != null) {
						for(String jb : job_permissions) {
							boolean s = new JobDao(DBCon.getConnection()).addJobPermission(job.getId(),Integer.parseInt(jb));
						}			
						// send message and redirect
					    request.setAttribute("type", "success");
					    request.setAttribute("message", "Job Created Successfully!");
					    RequestDispatcher dispatcher = request.getRequestDispatcher("jobs.jsp");
					    dispatcher.forward(request, response);
					}else {
						// send message and redirect
					    request.setAttribute("type", "error");
					    request.setAttribute("message", "Some Thing Went Wrong!");
					    RequestDispatcher dispatcher = request.getRequestDispatcher("jobs.jsp");
					    dispatcher.forward(request, response);
					}
				}else {
					// send message and redirect
				    request.setAttribute("type", "error");
				    request.setAttribute("message", "Job Already Exits!");
				    RequestDispatcher dispatcher = request.getRequestDispatcher("jobs.jsp");
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
