package servlets;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dbaccess.Book;
import dbaccess.BookDB;
import dbaccess.User;
import dbaccess.UserDB;

/**
 * Servlet implementation class ViewMemberServlet
 */
@WebServlet("/ViewMemberServlet")
public class ViewMemberServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ViewMemberServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		try {
			ArrayList<User> userArray = new ArrayList<User>();
			UserDB udb = new UserDB();
			userArray = udb.getAllUsers();
			
			
			HttpSession session = request.getSession();
            session.setAttribute("userArray", userArray);
            
			
			//request.setAttribute("topsales", bookal);
			//request.setAttribute("leastsales", bookal2);
			//request.setAttribute("lowstock", bookal3);
			
			String url = "MainWebsite/AdminViewMembers.jsp";
			response.sendRedirect(url);
			
			//RequestDispatcher rd = request.getRequestDispatcher(url);
			//rd.forward(request , response);
			
			
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
