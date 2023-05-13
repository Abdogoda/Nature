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
import cd.abdogoda.dao.ProductDao;

@WebServlet("/edit-product")
@MultipartConfig
public class EditProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.sendRedirect("products.jsp");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		try (PrintWriter out = response.getWriter()){
			String idString = request.getParameter("o_id");
			int id = Integer.parseInt(idString);
			String name = request.getParameter("o_name");
			String category = request.getParameter("o_category");
			String priceString = request.getParameter("o_price");
			Double price = Double.parseDouble(priceString);
			Part image = request.getPart("o_image");
			String fileName = "";
			if(image != null) {
				fileName = image.getSubmittedFileName();
			}
			try {
				ProductDao pdao = new ProductDao(DBCon.getConnection());
				boolean status = pdao.editProduct(id, name, category, price, fileName);
				if(status) {
					//Upload Image to folder
					if(image != null && fileName != "") {
					    String path = getServletContext().getRealPath("/uploaded_img/products");
					    File file = new File(path);
					    if(!file.exists()) {
					    	file.mkdir();
					    }
					    image.write(path+File.separator+fileName);
					}
					// send message and redirect
				    request.setAttribute("type", "success");
				    request.setAttribute("message", "Product Edited Successfully!");
				    RequestDispatcher dispatcher = request.getRequestDispatcher("products.jsp");
				    dispatcher.forward(request, response);	
				}else {
					// send message and redirect
				    request.setAttribute("type", "error");
				    request.setAttribute("message", "Product Name Already Exist!");
				    RequestDispatcher dispatcher = request.getRequestDispatcher("products.jsp");
				    dispatcher.forward(request, response);	
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
	}

}
