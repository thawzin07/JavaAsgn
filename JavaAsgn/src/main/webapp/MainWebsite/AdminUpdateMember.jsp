<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import ="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<%
String isbn , title , author , price , publisher , publication_date, quantity , id , cat_id ;

String image = "../Graphics/DefaultProfile.jpg";


id = request.getParameter("id");
cat_id = request.getParameter("cat_id");
isbn = request.getParameter("isbn");
title = request.getParameter("title");
author = request.getParameter("author");
price = request.getParameter("price");
publisher = request.getParameter("publisher");
quantity= request.getParameter("quantity");
publication_date = request.getParameter("publication_date");

session.setAttribute("id", id);


//Create a prepared statement to check for existing records
//String query = "SELECT COUNT(*) FROM book WHERE ISBN = ? OR  title = ?";
//PreparedStatement statement = conn.prepareStatement(query);
//statement.setString(1, isbn);
//statement.setString(2, title);

//Execute the query
//ResultSet resultSet = statement.executeQuery();


//Retrieve the count of matching records
//int count = 0;
//if (resultSet.next()) {
//count = resultSet.getInt(1);
//}

//Check the count and take appropriate action
//if (count > 0) {
// A record with the same username, phone, or email already exists
// Perform any necessary error handling or redirection
//response.sendRedirect("BookDetailsAdmin.jsp?errCode=duplicate"); // Redirect with an error code
//}


	try {
		Class.forName("com.mysql.jdbc.Driver");  

		//Step 2: Define Connection URL
		String connURL = "jdbc:mysql://localhost/javaassignment?user=root&password=root1234&serverTimezone=UTC";

		//Step 3: Establish connection to URL
		Connection conn = DriverManager.getConnection(connURL); 
		//Step 4: Create Statement object
		Statement stmt = conn.createStatement();
		   
	    // Step 4: Create a PreparedStatement
	    String sql = "UPDATE javaassignment.book SET ISBN=? , title=?, author=?, price=?, quantity = ?, publisher =?, publication_date=? , cat_id=? , image=? where id = ?";
	    PreparedStatement pstmt = conn.prepareStatement(sql);

	    // Step 5: Set parameter values
	    pstmt.setString(1, isbn);
	    pstmt.setString(2, title);
	    pstmt.setString(3, author);
	    pstmt.setString(4, price);
	    pstmt.setString(5, quantity);
	    pstmt.setString(6, publisher);
	    pstmt.setString(7, publication_date);
	    pstmt.setString(8, cat_id);
	    pstmt.setString(9, image);
	    pstmt.setString(10, id);

	    // Step 6: Execute the INSERT query
	    int rowsAffected = pstmt.executeUpdate();

	    // Step 7: Close resources
	    pstmt.close();
	    conn.close();

	    response.sendRedirect("BookDetailsAdmin.jsp");
	} 
	catch (Exception e) {
	    e.printStackTrace();
	    response.reset();
	    response.sendRedirect("BookDetailsAdmin.jsp");
	}
	

%>
</body>
</html>