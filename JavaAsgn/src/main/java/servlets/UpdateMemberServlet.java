package servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import dbaccess.Book;

import dbaccess.UserDB;

/**
 * Servlet implementation class UpdateMemberServlet
 */
@WebServlet("/UpdateMemberServlet")
public class UpdateMemberServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateMemberServlet() {
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
		
		String username , phone , role , email , joinedDate  , id;
		try {
			// Retrieving the values of the input fields using request.getParameter
			id = request.getParameter("id");
			phone = request.getParameter("phone");
			role = request.getParameter("role");
			email = request.getParameter("email");
			joinedDate = request.getParameter("joinedDate");
			username = request.getParameter("username");
			
			out.print(username);
			out.print(id);
			
			
			// Handling the image upload
	       // Part imagePart = request.getPart("image");
	        //String imageFileName = getUniqueFileName(imagePart);

	       // String storeFileName = "../Graphics/" + imageFileName ;
	        // Save the uploaded image to the server's directory
	       // String imagePath = UPLOAD_DIRECTORY  +  imageFileName;
	       // imagePart.write(imagePath);
	        	        
	        UserDB bdb = new UserDB();
			boolean isUpdated = bdb.updateUser(username , phone ,  email ,  role , joinedDate , id );
			
			request.setAttribute("isUpdated", isUpdated);
			out.print("all is well...userid=" + isUpdated);
			
			HttpSession session = request.getSession();
			session.setAttribute("user_id", id);
			session.setAttribute("role" , "admin"); 
			 // Get a reference to the RequestDispatcher
		    RequestDispatcher dispatcher = request.getRequestDispatcher("/ViewMemberServlet");
		    
		    // Forward the request to the SecondServlet
		    dispatcher.forward(request, response);


		}catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("MainWebsite/AdminViewMembers.jsp");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
		
		
	}

}
