package servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.client.Client;
import javax.ws.rs.client.ClientBuilder;
import javax.ws.rs.client.Entity;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import dbaccess.BookTP;

/**
 * Servlet implementation class UpdateBookTpServlet
 */
@WebServlet("/UpdateBookTpServlet")
public class UpdateBookTpServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateBookTpServlet() {
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
		//final String UPLOAD_DIRECTORY = "C:/Users/thawz/git/JavaAsgn/JavaAsgn/src/main/webapp/Graphics/";
		
		String  isbn , title , author ,  publisher , publication_date ;
		try {
			// Retrieving the values of the input fields using request.getParameter
			
			isbn = (String)request.getParameter("isbn");
			title = request.getParameter("title");
			author = request.getParameter("author");
			String priceStr = request.getParameter("price");
			float price=Float.parseFloat(priceStr);
			publisher = request.getParameter("publisher");
			String catIdStr = request.getParameter("cat_id");
			int catid=Integer.parseInt(catIdStr);
			String quantityStr = request.getParameter("quantity");
			int qty=Integer.parseInt(quantityStr);
			publication_date = request.getParameter("publication_date");
			int sold_count=0;
			String idStr=request.getParameter("bookid");
			int bookid=Integer.parseInt(idStr);
			
			
			

	        String storeFileName = "../Graphics/ShopIcon.jpg" ;
	       
	        BookTP book=new BookTP();
	        book.setId(bookid);
	        book.setISBN(isbn);
	        book.setAuthor(author);
	        book.setTitle(title);
	        book.setPrice(price);
	        book.setPublisher(publisher);
	        book.setCat_id(catid);
	        book.setSold_count(sold_count);
	        book.setQuantity(qty);
	        book.setPublication_date(publication_date);
	        
	        
	        //BookTP book = new BookTP(isbn , title , author , publisher, quantity , price , publication_date , cat_id ,storeFileName,sold_count) ;
	        
	        String restUrl = "http://localhost:8081/bookshopws/updateBook/" + bookid;
	        Client client = ClientBuilder.newClient();

	        // Change the HTTP method to PUT for updating the book
	        Response resp = client.target(restUrl)
	                .request(MediaType.APPLICATION_JSON)
	                .put(Entity.entity(book, MediaType.APPLICATION_JSON));

	        if (resp.getStatus() == Response.Status.OK.getStatusCode()) {
	            // Book updated successfully
	            System.out.println("Book updated successfully");
	            String url = "ThirdParty/success.jsp";

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
