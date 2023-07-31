package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.client.Client;
import javax.ws.rs.client.ClientBuilder;
import javax.ws.rs.client.Invocation;
import javax.ws.rs.client.WebTarget;
import javax.ws.rs.core.GenericType;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import dbaccess.Book;
import dbaccess.User;

/**
 * Servlet implementation class ListBookSales2
 */
@WebServlet("/ListBookSales2")
public class ListBookSales2 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ListBookSales2() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		
		PrintWriter out = response.getWriter();
		Client client = ClientBuilder.newClient();
		String restUrl = "http://localhost:8081/user-ws/ListBookSales";
		
		WebTarget target = client.target(restUrl);
		Invocation.Builder invocationBuilder = target.request(MediaType.APPLICATION_JSON);
		Response resp = invocationBuilder.get();
		System.out.print("status: " + resp.getStatus());
		
		if (resp.getStatus() == Response.Status.OK.getStatusCode() ){
			System.out.print("success");
			
			ArrayList<Book> books = resp.readEntity(new GenericType<ArrayList<Book>>() {} );
			
			for (Book  book : books) {
				System.out.print(book.getTitle());
				//out.print("<br>Userid: "+ user.getUserid());
				//out.print("<br>Age: "+ user.getAge());
				//out.print("<br>Gender: "+ user.getGender() + "<br>");
				
			}
			
			request.setAttribute("bookdata", books);
			System.out.print("...requestObj set...forwarding..");
			String url = "MainWebsite/ListBookSales.jsp";
			RequestDispatcher rd = request.getRequestDispatcher(url);
			rd.forward(request, response);
		} else {
			System.out.print("failed");
			String url = "pract8/testweb.jsp";
			request.setAttribute("err", "NotFound");
			RequestDispatcher rd = request.getRequestDispatcher(url);
			rd.forward(request, response);
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
