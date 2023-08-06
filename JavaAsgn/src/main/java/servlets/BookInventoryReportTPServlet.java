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
        String restUrl = "http://localhost:8081/bookshopws/ListTopSales";
        WebTarget target = client.target(restUrl);
        Invocation.Builder invocationBuilder = target.request(MediaType.APPLICATION_JSON);
        Response resp = invocationBuilder.get();
        System.out.println("status: " + resp.getStatus());

        if (resp.getStatus() == Response.Status.OK.getStatusCode()) {
            System.out.println("success");

            ArrayList<Book> bookal = resp.readEntity(new GenericType<ArrayList<Book>>() {});
            //ArrayList<Book> bookal2 = new ArrayList<>();
            //ArrayList<Book> bookal3 = new ArrayList<>();

            try {
                // You can remove the following lines since you have already obtained the data from the response
                // BookDB bdb = new BookDB();
                // bookal2 = bdb.listLeastSales();
                // bookal3 = bdb.listLowStock();

                request.setAttribute("topsales", bookal);
                //request.setAttribute("leastsales", bookal2);
                //request.setAttribute("lowstock", bookal3);

                String url = "ThirdParty/BookInventoryReportTp.jsp";

                // Forward the request to the JSP
                RequestDispatcher rd = request.getRequestDispatcher(url);
                rd.forward(request, response);

            } catch (Exception e) {
                e.printStackTrace();
            }

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