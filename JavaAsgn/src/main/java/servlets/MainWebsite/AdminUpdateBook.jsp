<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>AdminUpdateBook</title>
<%--
Author             : Thaw Zin Htun
Date                 : 14/05/2023
Copyright Notice     : NA
@(#)
Description         : JavaAsgn
Admission no        : P2234894
Class             : DIT/FT/2A/03
--%>
</head>
<body>

	<%
	String isbn, title, author, price, publisher, publication_date, quantity, id, cat_id;

	String image = "../Graphics/DefaultProfile.jpg";

	id = request.getParameter("id");
	cat_id = request.getParameter("cat_id");
	isbn = request.getParameter("isbn");
	title = request.getParameter("title");
	author = request.getParameter("author");
	price = request.getParameter("price");
	publisher = request.getParameter("publisher");
	quantity = request.getParameter("quantity");
	publication_date = request.getParameter("publication_date");

	session.setAttribute("book_id", id);

	try {
		Class.forName("com.mysql.jdbc.Driver");

		// Step 1: Define Connection URL
		String connURL = "jdbc:mysql://localhost/javaassignment?user=root&password=root1234&serverTimezone=UTC";

		// Step 2: Establish connection to URL
		Connection conn = DriverManager.getConnection(connURL);

		// Step 3: Create Statement object
		Statement stmt = conn.createStatement();

		// Step 4: Create a PreparedStatement
		String sql = "UPDATE javaassignment.book SET ISBN=?, title=?, author=?, price=?, quantity=?, publisher=?, publication_date=?, cat_id=?, image=? WHERE id=?";
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

		// Step 6: Execute the UPDATE query
		int rowsAffected = pstmt.executeUpdate();

		// Step 7: Close resources
		pstmt.close();
		conn.close();

		if (rowsAffected > 0) {
			session.setAttribute("book_id", id);
		}

		response.sendRedirect("AdminBookDetails.jsp");
	} catch (Exception e) {
		e.printStackTrace();
		response.reset();
		response.sendRedirect("AdminBookDetails.jsp");
	}
	%>
</body>
</html>
