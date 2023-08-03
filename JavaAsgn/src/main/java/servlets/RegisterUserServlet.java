package servlets;

import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dbaccess.UserDAO;

/**
 * Servlet implementation class RegisterUserServlet
 */
@WebServlet("/RegisterUserServlet")
public class RegisterUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterUserServlet() {
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
		   Date currentDate = new Date();
	        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	        String formattedDate = dateFormat.format(currentDate);

	        String username = request.getParameter("username");
	        String phone = request.getParameter("phone");
	        String email = request.getParameter("email");
	        String password = request.getParameter("password1");
	        String address=request.getParameter("address");
	        String postal=request.getParameter("postalCode");
	        String role = "user";
	        String image = "../Graphics/DefaultProfile.jpg";
	        String dateJoined = formattedDate;

	        UserDAO userDAO = new UserDAO();
	        try {
	            boolean isDuplicate = userDAO.checkDuplicateUser(username, phone, email);
	            if (isDuplicate) {
	                // A record with the same username, phone, or email already exists
	                response.sendRedirect(response.encodeRedirectURL("MainWebsite/Register.jsp?msgCode=duplicate")); // Redirect with an error code
	            } else {
	                // No duplicate found, insert the new user record
	            	int addressid=userDAO.insertAddress(address, postal);
	            	
	                int rowsAffected = userDAO.insertUser(username, email, phone, password, role, image, dateJoined,addressid);
	                if (rowsAffected > 0) {
	                    // Data inserted successfully
	                    response.sendRedirect(response.encodeRedirectURL("MainWebsite/Login2.jsp?msgCode=successRegister"));
	                } else {
	                    // Error occurred during insertion
	                    response.sendRedirect(response.encodeRedirectURL("MainWebsite/Register.jsp?msgCode=invalidRegister"));
	                }
	            }
	        } 
	        catch (SQLException e) {
		        e.printStackTrace();
		        // Handle the error case or show an error message to the user.
		        response.sendRedirect("MainWebsite/Register.jsp?msgCode=errorRegister");
		    } catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} 
	    }
	}


