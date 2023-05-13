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

@WebServlet("/edit-user")
@MultipartConfig
public class EditUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		try (PrintWriter out = response.getWriter()){
			String id_s = request.getParameter("id");
			int id = Integer.parseInt(id_s);
			String name = request.getParameter("name");
			String email = request.getParameter("email");
			String phone = request.getParameter("phone");
			Part image = request.getPart("image");
			String fileName = "";
			if(image != null) {
				fileName = image.getSubmittedFileName();
			}
			try {
				UserDao udao = new UserDao(DBCon.getConnection());
				boolean status = udao.editUser(id, name, email, phone, fileName);
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
					// send message and redirect
				    request.setAttribute("type", "success");
				    request.setAttribute("message", "User Updated Successfully!");
				    RequestDispatcher dispatcher = request.getRequestDispatcher("profile.jsp");
				    dispatcher.forward(request, response);	
				}else {
					// send message and redirect
				    request.setAttribute("type", "error");
				    request.setAttribute("message", "Email Address Already Exist!");
				    RequestDispatcher dispatcher = request.getRequestDispatcher("profile.jsp");
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
