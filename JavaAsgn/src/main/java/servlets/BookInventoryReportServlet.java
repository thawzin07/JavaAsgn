package servlets;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dbaccess.*;

/**
 * Servlet implementation class BookInventoryReportServlet
 */
@WebServlet("/BookInventoryReportServlet")
@MultipartConfig
public class BookInventoryReportServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BookInventoryReportServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		
		ArrayList<Book> bookal = new ArrayList<Book>();
		
		ArrayList<Book> bookal2 = new ArrayList<Book>();
		
		ArrayList<Book> bookal3 = new ArrayList<Book>();
		
		try {
			BookDB bdb = new BookDB();
			bookal = bdb.listTopSales();
			bookal2 = bdb.listLeastSales();
			bookal3 = bdb.listLowStock();
			
			HttpSession session = request.getSession();
            session.setAttribute("topsales", bookal);
            session.setAttribute("leastsales", bookal2);
            session.setAttribute("lowstock", bookal3);
			
			//request.setAttribute("topsales", bookal);
			//request.setAttribute("leastsales", bookal2);
			//request.setAttribute("lowstock", bookal3);
			
			String url = "MainWebsite/BookInventoryReport.jsp";
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
