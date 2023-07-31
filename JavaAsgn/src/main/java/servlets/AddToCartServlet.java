package servlets;
/**Author             : Thet Htar San
Date                 : 30/07/2023
Copyright Notice     : NA
@(#)
Description         : JavaAsgn
Admission no        : P2235077
Class             : DIT/FT/2A/03
**/
import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import dbaccess.AddToCart;

/**
 * Servlet implementation class AddToCartServlet
 */
@WebServlet("/AddToCartServlet")
public class AddToCartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddToCartServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		  int userId = Integer.parseInt(request.getParameter("userid"));
		    int bookId = Integer.parseInt(request.getParameter("bookid"));
		    int count = Integer.parseInt(request.getParameter("count"));

		    // Call the addToCart method from the AddToCart class to add the book to the cart
		    AddToCart addToCart = new AddToCart();
		    try {
		        int rowsAffected = addToCart.addToCart(userId, bookId, count);
		        // Handle the success case or any additional processing if needed
		        // For example, you can set a success message and redirect the user to a different page.
		        response.sendRedirect("testing.jsp");
		    } catch (SQLException e) {
		        e.printStackTrace();
		        // Handle the error case or show an error message to the user.
		        response.sendRedirect("error.jsp");
		    } catch (ClassNotFoundException e) {
		        e.printStackTrace();
		        // Handle the error case or show an error message to the user.
		        response.sendRedirect("error.jsp");
		    }
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		
	}

}
