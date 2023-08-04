package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dbaccess.Purchase;

/**
 * Servlet implementation class MakePaymentServlet
 */
@WebServlet("/MakePaymentServlet")
public class MakePaymentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MakePaymentServlet() {
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
		  int userId = Integer.parseInt(request.getParameter("userid"));
		  

	        try {
	            // Create an instance of the Purchase class
	            Purchase purchase = new Purchase();
	            // Call the insertPurchaseRecord method with the userId
	            purchase.insertPurchaseRecord(userId);

	            // Redirect to a success page or display a success message
	            response.sendRedirect("MainWebsite/PaymentSuccess.jsp");
	        } catch (Exception e) {
	            e.printStackTrace();
	            // Redirect to an error page or display an error message
	            response.sendRedirect("Error.jsp");
	        }
	    }
	
	






		
	}


