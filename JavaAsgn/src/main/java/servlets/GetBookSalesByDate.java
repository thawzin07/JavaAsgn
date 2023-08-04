package servlets;
/**Author             : Thet Htar San
Date                 : 30/07/2023
Copyright Notice     : NA
@(#)
Description         : JavaAsgn
Admission no        : P2235077
Class             : DIT/FT/2A/03
Sales Management
**/
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dbaccess.Purchase;
import dbaccess.PurchaseItem;

/**
 * Servlet implementation class GetBookSalesByDate
 */
@WebServlet("/GetBookSalesByDate")
public class GetBookSalesByDate extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetBookSalesByDate() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		  try {
		        Purchase purchase = new Purchase();
		        float totalPrice = purchase.getTotalPriceOfAllPurchases();
		        ArrayList<PurchaseItem> purchasedItems = purchase.getAllPurchases();

		        // Create the HTML content with the data
		        String htmlContent = "<p>Total Price of All Purchases: $" + totalPrice + "</p>\n";
		        htmlContent += "<h3>Purchased Items</h3>\n";
		        htmlContent += "<table border=\"1\">\n";
		        htmlContent += "<tr>\n";
		        htmlContent += "<th>Book ID</th>\n";
		        htmlContent += "<th>Book Name</th>\n";
		        htmlContent += "<th>Username</th>\n";
		        htmlContent += "<th>Count</th>\n";
		        htmlContent += "<th>Date Purchased</th>\n";
		        htmlContent += "<th>Total Price</th>\n";
		        htmlContent += "</tr>\n";

		        for (PurchaseItem item : purchasedItems) {
		            htmlContent += "<tr>\n";
		            htmlContent += "<td>" + item.getBookid() + "</td>\n";
		            htmlContent += "<td>" + item.getBookname() + "</td>\n";
		            htmlContent += "<td>" + item.getUsername() + "</td>\n";
		            htmlContent += "<td>" + item.getCount() + "</td>\n";
		            htmlContent += "<td>" + item.getDatePurchased() + "</td>\n";
		            htmlContent += "<td>" + item.getTotal() + "</td>\n";
		            htmlContent += "</tr>\n";
		        }

		        htmlContent += "</table>\n";

		        // Send the HTML content as the response
		        response.setContentType("text/html");
		        PrintWriter out = response.getWriter();
		        out.println(htmlContent);
		    } catch (SQLException | ClassNotFoundException e) {
		        e.printStackTrace();
		        // Handle the exception appropriately
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
