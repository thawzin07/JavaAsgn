<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import ="java.sql.*"%>
     <%@ page import="java.util.*" %>
      <%@ page import="servlets.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
	String bookId= request.getParameter("bookId");
String title;
String image;
Float price;

try {
    // Step1: Load JDBC Driver
     Class.forName("com.mysql.jdbc.Driver");  

    // Step 2: Define Connection URL
    String connURL = "jdbc:mysql://localhost/javaassignment?user=root&password=root1234&serverTimezone=UTC";

    // Step 3: Establish connection to URL
    Connection conn = DriverManager.getConnection(connURL); 
    // Step 4: Create Statement object
    Statement stmt = conn.createStatement();
    // Step 5: Execute SQL Command
    String sqlStr = "SELECT title,price,image FROM book WHERE id=?";  
 
  System.out.println(sqlStr);
  PreparedStatement pstmt=conn.prepareStatement(sqlStr);
  pstmt.setString(1,bookId);

    ResultSet rs = pstmt.executeQuery();
  while(rs.next()){
  	
  	
  	title=rs.getString("title");
  	price=rs.getFloat("price");
  	image=rs.getString("image");
  	
  	out.println(title+price+image);
  
  
  	
  	
  	
  
  	
  }
  
    // Step 7: Close connection
    conn.close();
    
} catch (Exception e) {
    out.println("Error :" + e);
 }

 

	
	Book b=new Book(title,price,image);
	
	@SuppressWarnings("unchecked")
	
	ArrayList<Book> bookList=(ArrayList<Book>)session.getAttribute("bookCart");
	
	if(bookList==null){
		bookList=new ArrayList<Book>();
	}
	bookList.add(b);
	session.setAttribute("bookCart",bookList);
	response.sendRedirect("ViewCart.jsp");
%>
</body>
</html>