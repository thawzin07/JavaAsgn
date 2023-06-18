<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
<<<<<<< HEAD
    pageEncoding="ISO-8859-1"%>
    <%@page import ="java.sql.*"%>
     <%@ page import="java.util.*" %>
      <%@ page import="mybooks.*" %>
=======
	pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="servlets.*"%>
>>>>>>> branch 'main' of https://github.com/thawzin07/JavaAsgn
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>AddToCart</title>
<<<<<<< HEAD
<%--
    
Author             : Thet Htar San
Date                 : 5/06/2023
Copyright Notice     : NA
@(#)
Description         : JavaAsgn
Admission no        : P2235077
Class             : DIT/FT/2A/03

--%>
=======
>>>>>>> branch 'main' of https://github.com/thawzin07/JavaAsgn
</head>
<body>
<<<<<<< HEAD
<%
	String bookId= request.getParameter("bookId");
String title="";
String image="";
float price=0.0f;
int qty=0;
int id=0;

=======
	<%
	String bookId = request.getParameter("bookId");
	String title;
	String image;
	Float price;
>>>>>>> branch 'main' of https://github.com/thawzin07/JavaAsgn

	try {
		// Step1: Load JDBC Driver
		Class.forName("com.mysql.jdbc.Driver");

		// Step 2: Define Connection URL
		String connURL = "jdbc:mysql://localhost/javaassignment?user=root&password=root1234&serverTimezone=UTC";

<<<<<<< HEAD
    // Step 3: Establish connection to URL
    Connection conn = DriverManager.getConnection(connURL); 
    // Step 4: Create Statement object
    Statement stmt = conn.createStatement();
    // Step 5: Execute SQL Command
    String sqlStr = "SELECT title,price,quantity,image FROM book WHERE id=?";  
 
  System.out.println(sqlStr);
  PreparedStatement pstmt=conn.prepareStatement(sqlStr);
  pstmt.setString(1,bookId);
=======
		// Step 3: Establish connection to URL
		Connection conn = DriverManager.getConnection(connURL);
		// Step 4: Create Statement object
		Statement stmt = conn.createStatement();
		// Step 5: Execute SQL Command
		String sqlStr = "SELECT title,price,image FROM book WHERE id=?";
>>>>>>> branch 'main' of https://github.com/thawzin07/JavaAsgn

<<<<<<< HEAD
    ResultSet rs = pstmt.executeQuery();
  while(rs.next()){
  	
  	qty=rs.getInt("quantity");
  	
  	title=rs.getString("title");
  	price=rs.getFloat("price");
  	image=rs.getString("image");
  	
  	
  
  
  	
  	
  	
  
  	
  }
  
    // Step 7: Close connection
    conn.close();
    
} catch (Exception e) {
    out.println("Error :" + e);
 }
=======
		System.out.println(sqlStr);
		PreparedStatement pstmt = conn.prepareStatement(sqlStr);
		pstmt.setString(1, bookId);
>>>>>>> branch 'main' of https://github.com/thawzin07/JavaAsgn

		ResultSet rs = pstmt.executeQuery();
		while (rs.next()) {

<<<<<<< HEAD
	
	cartBooks b=new cartBooks(title,price,qty,image);
	
=======
			title = rs.getString("title");
			price = rs.getFloat("price");
			image = rs.getString("image");

			out.println(title + price + image);

		}

		// Step 7: Close connection
		conn.close();

	} catch (Exception e) {
		out.println("Error :" + e);
	}

	Book b = new Book(title, price, image);

>>>>>>> branch 'main' of https://github.com/thawzin07/JavaAsgn
	@SuppressWarnings("unchecked")
<<<<<<< HEAD
	
	ArrayList<cartBooks> bookList=(ArrayList<cartBooks>)session.getAttribute("bookCart");
	
	if(bookList==null){
		bookList=new ArrayList<cartBooks>();
=======

	ArrayList<Book> bookList = (ArrayList<Book>) session.getAttribute("bookCart");

	if (bookList == null) {
		bookList = new ArrayList<Book>();
>>>>>>> branch 'main' of https://github.com/thawzin07/JavaAsgn
	}
	bookList.add(b);
	session.setAttribute("bookCart", bookList);
	response.sendRedirect("ViewCart.jsp");
	%>
</body>
</html>