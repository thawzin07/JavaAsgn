package servlets;

import java.io.IOException;


import java.io.PrintWriter;
import java.io.File;
import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import dbaccess.Book;
import dbaccess.BookDB;
import dbaccess.UserDAO;



/**
 * Servlet implementation class CreateBookServlet
 */
@WebServlet("/CreateBookServlet")
@MultipartConfig
public class CreateBookServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CreateBookServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		PrintWriter out = response.getWriter() ;
		//final String UPLOAD_DIRECTORY = "C:/Users/thawz/git/JavaAsgn/JavaAsgn/src/main/webapp/Graphics/";
		final String UPLOAD_DIRECTORY="C:/Users/Ren/eclipse-workspace/JavaAsgn/JavaAsgn/src/main/webapp/Graphics/";
		
		String  isbn , title , author , price , publisher , publication_date, quantity , cat_id ;
		try {
			// Retrieving the values of the input fields using request.getParameter
			
			isbn = request.getParameter("isbn");
			title = request.getParameter("title");
			author = request.getParameter("author");
			price = request.getParameter("price");
			publisher = request.getParameter("publisher");
			cat_id = request.getParameter("cat_id");
			quantity = request.getParameter("quantity");
			publication_date = request.getParameter("publication_date");
			
			
			// Handling the image upload
	        Part imagePart = request.getPart("image");
	        String imageFileName = getUniqueFileName(imagePart);

	        String storeFileName = "../Graphics/" + imageFileName ;
	        // Save the uploaded image to the server's directory
	        String imagePath = UPLOAD_DIRECTORY  +  imageFileName;
	        imagePart.write(imagePath);
	        Book book = new Book(isbn , title , author , publisher, Integer.parseInt(quantity) , Double.parseDouble(price) , publication_date , Integer.parseInt(cat_id) ,storeFileName) ;
	        
	        BookDB bdb = new BookDB();
			boolean isSuccess = bdb.createBook(book);
			
			request.setAttribute("isSuccess", isSuccess);
			out.print("all is well...userid=" + isSuccess);
			String url = "MainWebsite/AdminCreateBookForm.jsp";
			HttpSession session = request.getSession();

			session.setAttribute("role" , "admin");
			response.sendRedirect("MainWebsite/AdminLanding.jsp");


		}catch (Exception e) {
			e.printStackTrace();
		}
	}

	private String getUniqueFileName(Part part) {
		// Get the submitted file name from the Part
	    String submittedFileName = part.getSubmittedFileName();
	    
	    if (submittedFileName == null || submittedFileName.trim().isEmpty()) {
	        submittedFileName = "ShopIcon.jpg"; // Replace with your desired default name
	    }

	    return submittedFileName;
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
