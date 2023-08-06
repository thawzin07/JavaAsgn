package servlets;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.ws.rs.client.Client;
import javax.ws.rs.client.ClientBuilder;
import javax.ws.rs.client.Entity;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import com.myshop.bookshopws.controller.*;

/**
 * Servlet implementation class DeleteBookServletTp
 */
@WebServlet("/DeleteBookServletTp")
public class DeleteBookServletTp extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteBookServletTp() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		
		boolean isDeleted = false ;
		
		try {
			String id = request.getParameter("deleteid");
			
			 String restUrl = "http://localhost:8081/bookshopws/deleteBook/" + id;
			    Client client = ClientBuilder.newClient();
			    Response resp = client.target(restUrl)
			        .request(MediaType.APPLICATION_JSON)
			        .delete();

			    if (resp.getStatus() == Response.Status.OK.getStatusCode()) {
			        // Book deleted successfully
			        System.out.println("Book deleted successfully");

			        
			        response.sendRedirect("ThirdParty/success.jsp");
			    } else {
			        // Failed to delete book
			        System.out.println("Failed to delete book");
			        String url = "ThirdParty/error.jsp";
			        request.setAttribute("err", "Failed to delete book");
			        RequestDispatcher rd = request.getRequestDispatcher(url);
			        rd.forward(request, response);
			    }
		} catch (Exception e) {
			e.printStackTrace();		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
