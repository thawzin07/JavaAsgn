package servlets;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dbaccess.AddToCart;

/**
 * Servlet implementation class ChangeQuantityServlet
 */
@WebServlet("/ChangeQuantityServlet")
public class ChangeQuantityServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ChangeQuantityServlet() {
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
	    Enumeration<String> parameterNames = request.getParameterNames();
	    HttpSession session = request.getSession();
	    int userId = Integer.parseInt(session.getAttribute("sessUserID").toString());

	    // Iterate through the parameter names
	    while (parameterNames.hasMoreElements()) {
	        String paramName = parameterNames.nextElement();

	        // Check if the parameter starts with "quantity_"
	        if (paramName.startsWith("quantity_")) {
	            // Extract the book ID from the parameter name
	            String bookIdStr = paramName.substring("quantity_".length());
	            int bookId = Integer.parseInt(bookIdStr);

	            int updatedQuantity = Integer.parseInt(request.getParameter(paramName));

	            AddToCart addToCart = new AddToCart();
	            try {
	                int rowsAffected = addToCart.updateQuantity(bookId, updatedQuantity, userId);
	            } catch (SQLException e) {
	                e.printStackTrace();
	                // Handle the error case or show an error message to the user.
	                response.sendRedirect("error.jsp");
	                return;
	            } catch (ClassNotFoundException e) {
	                e.printStackTrace();
	                response.sendRedirect("error.jsp");
	                return;
	            }
	        }
	    }

	    // Redirect to the View Cart page after updating the quantities
	    response.sendRedirect("MainWebsite/ViewCart.jsp");
	}

}
