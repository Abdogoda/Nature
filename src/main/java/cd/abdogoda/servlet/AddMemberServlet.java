package cd.abdogoda.servlet;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import cd.abdogoda.conn.DBCon;
import cd.abdogoda.dao.UserDao;
import cd.abdogoda.model.User;

@WebServlet("/add-member")
@MultipartConfig
public class AddMemberServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.sendRedirect("team.jsp");
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		try (PrintWriter out = response.getWriter()){
			String name = request.getParameter("name");
			String email = request.getParameter("email");
			String phone = request.getParameter("phone");
			String address = request.getParameter("address");
			String gender = request.getParameter("gender");
			String ssn = request.getParameter("ssn");
			String job_id_s = request.getParameter("job_id");
			String birth_date = request.getParameter("birth_date");
			String password = request.getParameter("password");
			Part image = request.getPart("image");
			int group_id = 0;
			String fileName = "";
			if(image != null) {
				fileName = image.getSubmittedFileName();
			}
			try {
				UserDao udao = new UserDao(DBCon.getConnection());
				boolean status = udao.addUser(name, email, phone, address, password, fileName, group_id);
				if(status) {
					//Upload Image to folder
					if(image != null && fileName != "") {
					    String path = getServletContext().getRealPath("/uploaded_img/users");
					    File file = new File(path);
					    if(!file.exists()) {
					    	file.mkdir();
					    }
					    image.write(path+File.separator+fileName);
					}
					//
					User user = udao.userLogin(email, password);
					if(user != null) {
						boolean s = udao.addAdmin(user.getId(),ssn, birth_date, Integer.parseInt(gender), Integer.parseInt(job_id_s));	
						if(s) {
							// send message and redirect
							request.setAttribute("type", "success");
							request.setAttribute("message", "Member Created Successfully!");
							RequestDispatcher dispatcher = request.getRequestDispatcher("team.jsp");
							dispatcher.forward(request, response);
						}else {
							// send message and redirect
						    request.setAttribute("type", "error");
						    request.setAttribute("message", "SomeThing Went Wrong 1!");
						    RequestDispatcher dispatcher = request.getRequestDispatcher("team.jsp");
						    dispatcher.forward(request, response);
						}
					}else {
						// send message and redirect
					    request.setAttribute("type", "error");
					    request.setAttribute("message", "SomeThing Went Wrong 2!");
					    RequestDispatcher dispatcher = request.getRequestDispatcher("team.jsp");
					    dispatcher.forward(request, response);
					}
				}else {
					// send message and redirect
				    request.setAttribute("type", "error");
				    request.setAttribute("message", "Email Or Phone Already Exits!");
				    RequestDispatcher dispatcher = request.getRequestDispatcher("team.jsp");
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
