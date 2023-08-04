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
import dbaccess.PurchaseItem;
import dbaccess.User;

/**
 * Servlet implementation class GetTopTenUsers
 */
@WebServlet("/GetTopTenUsers")
public class GetTopTenUsers extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetTopTenUsers() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		

	        try {
	            Connection conn = DBConnection.getConnection();
	            String sqlSelect = "SELECT username,phone,email,total_spend FROM javaassignment.user ORDER BY total_spend DESC";
	            PreparedStatement selectStmt = conn.prepareStatement(sqlSelect);
	           
	           
	            ResultSet rs = selectStmt.executeQuery();

	            ArrayList<User> toptenUsers=new ArrayList<>();
	            float grandTotal = 0;

	            while (rs.next()) {
	            	 User userBean=new User();
	          	   userBean.setUsername(rs.getString("username"));
	          	   userBean.setPhone(rs.getString("phone"));
	          	   userBean.setEmail(rs.getString("email"));
	          	   userBean.setTotalSpent(rs.getFloat("total_spend"));
	          	   toptenUsers.add(userBean);
	            }

	            rs.close();
	            selectStmt.close();
	            conn.close();

	            // Set the attributes in the request object
	            request.setAttribute("toptenusers", toptenUsers);
	           
	           
	            

	            // Forward the request to the JSP
	            request.getRequestDispatcher("MainWebsite/GetTopTenUsers.jsp").forward(request, response);
	        } catch (Exception e) {
	            e.printStackTrace();
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
