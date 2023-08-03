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
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dbaccess.AddToCart;
import dbaccess.CartItem;
import dbaccess.DBConnection;
import mybooks.CartItems;

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
		 
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		 int userId = Integer.parseInt(request.getParameter("userid"));
		    int bookId = Integer.parseInt(request.getParameter("bookid"));
		    int count = Integer.parseInt(request.getParameter("count"));
		    CartItem c= new CartItem(userId,bookId,count);

		    // Call the addToCart method from the AddToCart class to add the book to the cart
		    AddToCart addToCart = new AddToCart();
		    try {
		        int rowsAffected = addToCart.addToCart(c);
		        
		        List<CartItems> cartItems = AddToCart.getCartItems(userId);

	            // Store the cart items in the session attribute
	            HttpSession session = request.getSession();
	            session.setAttribute("cartItems", cartItems);

		        response.sendRedirect("MainWebsite/ViewCart.jsp");
		    } catch (SQLException e) {
		        e.printStackTrace();
		        // Handle the error case or show an error message to the user.
		        response.sendRedirect("error.jsp");
		    } catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} 
	}

}
