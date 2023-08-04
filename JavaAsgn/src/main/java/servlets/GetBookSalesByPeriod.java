package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dbaccess.DBConnection;
import dbaccess.Purchase;
import dbaccess.PurchaseItem;

/**
 * Servlet implementation class GetBookSalesByPeriod
 */
@WebServlet("/GetBookSalesByPeriod")
public class GetBookSalesByPeriod extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetBookSalesByPeriod() {
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
	        String dateFrom = request.getParameter("datefrom");
	        String dateTo = request.getParameter("dateto");

	        try {
	            Connection conn = DBConnection.getConnection();
	            String sqlSelect = "SELECT p.book_id, b.title AS book_name, b.price, u.username, p.count, p.purchased_date "
	                    + "FROM purchase p JOIN book b ON p.book_id = b.id JOIN user u ON p.user_id = u.id "
	                    + "WHERE p.purchased_date BETWEEN ? AND ?";
	            PreparedStatement selectStmt = conn.prepareStatement(sqlSelect);
	            selectStmt.setString(1, dateFrom);
	            selectStmt.setString(2, dateTo);
	            ResultSet rs = selectStmt.executeQuery();

	            ArrayList<PurchaseItem> purchasedItems = new ArrayList<>();
	            float grandTotal = 0;

	            while (rs.next()) {
	                PurchaseItem purchaseBean = new PurchaseItem();
	                purchaseBean.setBookid(Integer.parseInt(rs.getString("book_id")));
	                purchaseBean.setBookname(rs.getString("book_name"));
	                purchaseBean.setUsername(rs.getString("username"));
	                purchaseBean.setCount(rs.getInt("count"));
	                purchaseBean.setDatePurchased(rs.getString("purchased_date"));

	                float price = rs.getFloat("price");
	                int count = rs.getInt("count");
	                float total = price * count;
	                grandTotal += total;
	                purchasedItems.add(purchaseBean);
	            }

	            rs.close();
	            selectStmt.close();
	            conn.close();

	            // Set the attributes in the request object
	            request.setAttribute("purchasedItems", purchasedItems);
	            request.setAttribute("grandTotal", grandTotal);
	            request.setAttribute("datefrom",dateFrom);
	            request.setAttribute("dateto", dateTo);
	            

	            // Forward the request to the JSP
	            request.getRequestDispatcher("MainWebsite/GetBookSalesByPeriod.jsp").forward(request, response);
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	    }
	}


