package servlets;

import dbaccess.BookTP;

import java.io.IOException;
import java.io.PrintWriter;

import javax.json.Json;
import javax.json.JsonObject;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import javax.ws.rs.client.Client;
import javax.ws.rs.client.ClientBuilder;
import javax.ws.rs.client.Entity;
import javax.ws.rs.client.Invocation;
import javax.ws.rs.client.WebTarget;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

/**

Author             : Thet Htar San
Date                 : 5/08/2023
Copyright Notice     : NA
@(#)
Description         : JavaAsgn
Admission no        : P2235077
Class             : DIT/FT/2A/03

**/
/**
 * Servlet implementation class CreateBookTpServlet
 */
@WebServlet("/CreateBookTpServlet")
public class CreateBookTpServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CreateBookTpServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		PrintWriter out = response.getWriter() ;
		final String UPLOAD_DIRECTORY = "C:/Users/thawz/git/JavaAsgn/JavaAsgn/src/main/webapp/Graphics/";
		
		String  isbn , title , author ,  publisher , publication_date ;
		try {
			// Retrieving the values of the input fields using request.getParameter
			
			isbn = (String)request.getParameter("isbn");
			title = request.getParameter("title");
			author = request.getParameter("author");
			String priceStr = request.getParameter("price");
			publisher = request.getParameter("publisher");
			String catIdStr = request.getParameter("cat_id");
			String quantityStr = request.getParameter("quantity");
			publication_date = request.getParameter("publication_date");
			int sold_count=0;
			
			

	        String storeFileName = "../Graphics/ShopIcon.jpg" ;
	        // Save the uploaded image to the server's directory
	        
	        int quantity = 1;
	        if (quantityStr != null && !quantityStr.isEmpty()) {
	            try {
	                quantity = Integer.parseInt(quantityStr);
	            } catch (NumberFormatException e) {
	                
	                quantity = 1; 
	            }
	        }

	        double price = 1;
	        if (priceStr != null && !priceStr.isEmpty()) {
	            try {
	                price = Double.parseDouble(priceStr);
	            } catch (NumberFormatException e) {
	                // Handle the case when the price is not a valid double
	                // For example, set a default value or show an error message
	                 price = 1; // Set a default value or handle the error as needed
	            }
	        }

	        int cat_id = 0;
	        if (catIdStr != null && !catIdStr.isEmpty()) {
	            try {
	                cat_id = Integer.parseInt(catIdStr);
	            } catch (NumberFormatException e) {
	               
	                cat_id = 1; // Set a default value or handle the error as needed
	            }
	        }
	        
	        
	        BookTP book = new BookTP(isbn , title , author , publisher, quantity , price , publication_date , cat_id ,storeFileName,sold_count) ;
	        
	        String restUrl = "http://localhost:8081/bookshopws/createBook";
	        Client client = ClientBuilder.newClient();
	        Response resp = client.target(restUrl)
	                .request(MediaType.APPLICATION_JSON)
	                .post(Entity.entity(book, MediaType.APPLICATION_JSON));

	        if (resp.getStatus() == Response.Status.CREATED.getStatusCode()) {
	            // Book created successfully
	            System.out.println("Book created successfully");
	            String url = "ThirdParty/BookCreateSuccessful.jsp";

	            
	            RequestDispatcher rd = request.getRequestDispatcher(url);
	            rd.forward(request, response);
	            
	            
	        } else {
	        	System.out.println("failed");
	            String url = "ThirdParty/error.jsp";
	            request.setAttribute("err", "Not Found");
	            RequestDispatcher rd = request.getRequestDispatcher(url);
	            rd.forward(request, response);
	        }
	    }


		catch (Exception e) {
			e.printStackTrace();
		}
		
		
		
		
		
		
	}
	
}

