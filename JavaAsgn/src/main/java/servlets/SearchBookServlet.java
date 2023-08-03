package servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dbaccess.Book;
import dbaccess.BookDB;

/**
 * Servlet implementation class SearchBookServlet
 */
@WebServlet("/SearchBookServlet")
public class SearchBookServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SearchBookServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		
		PrintWriter out = response.getWriter();
		out.print("SearchBook is called");
	    
	    try {
	    	String title = (String) request.getParameter("searchtext");

			BookDB bdb = new BookDB();
			
			Book book = bdb.bookSearchBar(title);
			
			HttpSession session = request.getSession();
            session.setAttribute("searchresult", book);
			
            //request.setAttribute("searchresult", book);

			String url = "MainWebsite/BookSearchResult.jsp";
			response.sendRedirect(url);
			//RequestDispatcher rd = request.getRequestDispatcher(url);
			//rd.forward(request, response);
			
		} catch (Exception e) {
			e.printStackTrace();		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
