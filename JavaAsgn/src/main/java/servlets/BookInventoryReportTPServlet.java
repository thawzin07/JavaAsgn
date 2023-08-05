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
import javax.servlet.http.HttpSession;
import javax.ws.rs.client.Client;
import javax.ws.rs.client.ClientBuilder;
import javax.ws.rs.client.Invocation;
import javax.ws.rs.client.WebTarget;
import javax.ws.rs.core.GenericType;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import dbaccess.Book;
import dbaccess.BookDB;
import dbaccess.User;

/**
 * Servlet implementation class BookInventoryReportTPServlet
 */
@WebServlet("/BookInventoryReportTPServlet")
public class BookInventoryReportTPServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BookInventoryReportTPServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        Client client = ClientBuilder.newClient();
        String restUrlTopSales = "http://localhost:8081/bookshopws/ListTopSales";
        String restUrlLeastSales = "http://localhost:8081/bookshopws/ListLeastSales";
        String restUrlLowStock = "http://localhost:8081/bookshopws/ListLowStocks";

        WebTarget targetTopSales = client.target(restUrlTopSales);
        WebTarget targetLeastSales = client.target(restUrlLeastSales);
        WebTarget targetLowStock = client.target(restUrlLowStock);

        Invocation.Builder invocationBuilderTopSales = targetTopSales.request(MediaType.APPLICATION_JSON);
        Invocation.Builder invocationBuilderLeastSales = targetLeastSales.request(MediaType.APPLICATION_JSON);
        Invocation.Builder invocationBuilderLowStock = targetLowStock.request(MediaType.APPLICATION_JSON);

        Response respTopSales = invocationBuilderTopSales.get();
        Response respLeastSales = invocationBuilderLeastSales.get();
        Response respLowStock = invocationBuilderLowStock.get();

        System.out.println("status: " + respTopSales.getStatus());
        System.out.println("status: " + respLeastSales.getStatus());
        System.out.println("status: " + respLowStock.getStatus());

        if (respTopSales.getStatus() == Response.Status.OK.getStatusCode() &&
            respLeastSales.getStatus() == Response.Status.OK.getStatusCode() &&
            respLowStock.getStatus() == Response.Status.OK.getStatusCode()) {
            
            ArrayList<Book> bookal = respTopSales.readEntity(new GenericType<ArrayList<Book>>() {});
            ArrayList<Book> bookal2 = respLeastSales.readEntity(new GenericType<ArrayList<Book>>() {});
            ArrayList<Book> bookal3 = respLowStock.readEntity(new GenericType<ArrayList<Book>>() {});

            request.setAttribute("topsales", bookal);
            request.setAttribute("leastsales", bookal2);
            request.setAttribute("lowstock", bookal3);

            String url = "ThirdParty/BookInventoryReportTp.jsp";

            // Forward the request to the JSP
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

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
