package servlets;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import dbaccess.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.geronimo.microprofile.openapi.impl.processor.spi.NamingStrategy.Http;

/**
 * Servlet implementation class GetPurchaseHistoryServlet
 */
@WebServlet("/GetPurchaseHistoryServlet")
public class GetPurchaseHistoryServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetPurchaseHistoryServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session=request.getSession();
		Object attributeValue = session.getAttribute("someAttribute");
		if (attributeValue != null) {
		    int someVariable = Integer.parseInt(attributeValue.toString());
		    // Use the 'someVariable' integer as needed
		} else {
		    // Handle the case when the attribute is not set or is null
		}
		 int userId = Integer.parseInt((String)request.getParameter("userid"));

	        try {
	            // Call the method to get all purchases for the user
	            Purchase purchaseDAO = new Purchase();
	            ArrayList<PurchaseItem> purchaseList = purchaseDAO.getAllPurchasesByUserId(userId);

	            // Now you have the purchaseList, you can use it to display the data in your JSP
	            // Set the attribute in the request object
	            request.setAttribute("purchaseList", purchaseList);

	            // Forward the request to your JSP
	            request.getRequestDispatcher("MainWebsite/GetPurchaseHistory.jsp").forward(request, response);

	        } catch (SQLException | ClassNotFoundException e) {
	            e.printStackTrace();
	            // Handle the exception as needed
	        }
	    }
	

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		 int userId = Integer.parseInt((String)request.getParameter("userid"));

	        try {
	            // Call the method to get all purchases for the user
	            Purchase purchaseDAO = new Purchase();
	            ArrayList<PurchaseItem> purchaseList = purchaseDAO.getAllPurchasesByUserId(userId);

	            // Now you have the purchaseList, you can use it to display the data in your JSP
	            // Set the attribute in the request object
	            request.setAttribute("purchaseList", purchaseList);

	            // Forward the request to your JSP
	            request.getRequestDispatcher("MainWebsite/GetPurchaseHistory.jsp").forward(request, response);

	        } catch (SQLException | ClassNotFoundException e) {
	            e.printStackTrace();
	            // Handle the exception as needed
	        }
	}

}
