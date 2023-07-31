package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import dbaccess.DBConnection;
import dbaccess.UpdateCartItem;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class UpdateCartServlet
 */
@WebServlet("/UpdateCartServlet")
public class UpdateCartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateCartServlet() {
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
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
		 HttpSession session = request.getSession();
        int userId = Integer.parseInt(session.getAttribute("sessUserID").toString());
        int bookId = Integer.parseInt(request.getParameter("bookId"));
        int newQuantity = Integer.parseInt(request.getParameter("newQuantity"));

        // Update the cart item in the database
        //UpdateCartItem updateCartItem=new UpdateCartItem();
        updateCartItem(userId,bookId,newQuantity);

        response.sendRedirect("MainWebsite/ViewCart.jsp");
    }

	private void updateCartItem(int userId, int bookId, int newQuantity) {
		// TODO Auto-generated method stub

        try {
            Connection conn = DBConnection.getConnection();
            String updateCartSQL = "UPDATE cart SET count = ? WHERE user_id = ? AND book_id = ?";
            PreparedStatement updateCartStmt = conn.prepareStatement(updateCartSQL);
            updateCartStmt.setInt(1, newQuantity);
            updateCartStmt.setInt(2, userId);
            updateCartStmt.setInt(3, bookId);
            updateCartStmt.executeUpdate();
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
	}

	

}
