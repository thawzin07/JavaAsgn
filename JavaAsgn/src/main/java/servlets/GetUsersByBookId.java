package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dbaccess.DBConnection;
import dbaccess.User;

/**
 * Servlet implementation class GetUsersByBookId
 */
@WebServlet("/GetUsersByBookId")
public class GetUsersByBookId extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetUsersByBookId() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	
	    }
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		  int bookid = Integer.parseInt((String)request.getParameter("bookid"));
		  String bookTitle="";
			
	        try {
	            Connection conn = DBConnection.getConnection();
	            String sqlSelect = "SELECT DISTINCT p.user_id, u.username, u.phone, u.email, b.title, b.id "
	                    + "FROM purchase p "
	                    + "JOIN user u ON u.id = p.user_id "
	                    + "JOIN book b ON b.id = p.book_id "
	                    + "WHERE p.book_id = ?";
	            		
	            PreparedStatement selectStmt = conn.prepareStatement(sqlSelect);
	            selectStmt.setInt(1, bookid);
	           
	           
	            ResultSet rs = selectStmt.executeQuery();

	            ArrayList<User> usersByBookId=new ArrayList<>();
	           
	            

	            while (rs.next()) {
	            	 User userBean=new User();
	          	   userBean.setUsername(rs.getString("username"));
	          	   userBean.setPhone(rs.getString("phone"));
	          	   userBean.setEmail(rs.getString("email"));
	          	   bookTitle=rs.getString("title");
	          	   
	          	   
	          	  
	          	   usersByBookId.add(userBean);
	            }

	            rs.close();
	            selectStmt.close();
	            conn.close();

	            // Set the attributes in the request object
	            request.setAttribute("usersByBookId", usersByBookId);
	            request.setAttribute("bookid",bookid);
	            request.setAttribute("bookTitle",bookTitle);           
	           
	            

	            // Forward the request to the JSP
	            request.getRequestDispatcher("MainWebsite/GetUsersByBookId.jsp").forward(request, response);
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	}

}
