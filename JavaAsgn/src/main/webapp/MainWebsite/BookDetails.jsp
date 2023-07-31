<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>BookDetails</title>
<%--

    
Author             : Thaw Zin Htun
Date                 : 14/05/2023
Copyright Notice     : NA
@(#)
Description         : JavaAsgn
Admission no        : P2234894
Class             : DIT/FT/2A/03
--%>
<style>
body {
	font-family: Arial, sans-serif;
	background-color: #f5f5f5;
}

.container {
	display: flex;
	margin: 20px auto;
	max-width: 800px;
	padding: 20px;
	background-color: #fff;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

.container img {
	width: 45%;
	height: auto;
}

.bookDetails_container {
	flex-grow: 1;
	margin-left: 20px;
	border-left: 1px solid #ccc;
	padding-left: 20px;
	display: flex;
	flex-direction: column;
	justify-content: flex-start;
	align-items: flex-start;
}

.bookDetails_container .confirm_button {
	background-color: lightgreen;
	margin-top: auto;
}

.bookDetails_container .cancel_button {
	background-color: lightcoral;
	margin-top: 8px;
	flex-grow: 1;
	width: 100%;
}

.bookDetails_container .confirm_button:hover {
	opacity: 0.8;
	background-color: green;
}

.bookDetails_container .cancel_button:hover {
	opacity: 0.8;
	background-color: red;
}

label {
	display: block;
	margin-bottom: 5px;
}

input[type="text"] {
	width: 100%;
	margin-bottom: 10px;
	padding: 5px;
	border: 1px solid #ccc;
	border-radius: 4px;
}
</style>

<script>
	function reloadPage() {
		location.reload();
	}
</script>

</head>
<body>
	<%
	Boolean isLoggedIn = (Boolean) session.getAttribute("isLoggedIn");
	if (isLoggedIn == null || !isLoggedIn) {
		response.sendRedirect("Login2.jsp");
	}

	String id = request.getParameter("id");
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

		String sqlStr = "SELECT ISBN , title , author , price , publisher , publication_date , image , b.cat_id,  name from book b , category c where b.id = ? and b.cat_id = c.id";
		PreparedStatement pstmt = conn.prepareStatement(sqlStr);
		pstmt.setString(1, id);
		ResultSet rs = pstmt.executeQuery();

		// Step 6: Process Results 
		while (rs.next()) {
	%>
	<div class="container">
		<img src="<%=rs.getString("image")%>" alt="Book Cover">
		<div class="bookDetails_container">
			<h4>
				The book is under category "<%=rs.getString("name").toUpperCase()%>"
			</h4>
			<br>
			<form action="AdminUpdateMember.jsp" method="post">

				<label for="ISBN">ISBN :</label> <input type="text" id="ISBN"
					value="<%=rs.getString("ISBN")%>" readonly><br> <label
					for="title">Title :</label> <input type="text" id="title"
					value="<%=rs.getString("title")%>" readonly><br> <label
					for="author">Author :</label> <input type="text" id="author"
					value="<%=rs.getString("author")%>" readonly><br> <label
					for="price">Price :</label> <input type="text" id="price"
					value="<%=rs.getString("price")%>" readonly><br> <label
					for="publisher">Publisher :</label> <input type="text"
					id="publisher" value="<%=rs.getString("publisher")%>" readonly><br>

				<label for="publication_date">Publication Date :</label> <input
					type="text" id="publication_date"
					value="<%=rs.getString("publication_date")%>" readonly><br>

				<%
				if (session.getAttribute("role") != null && session.getAttribute("role").equals("admin")) {
				%>
				<script>
					window
							.addEventListener(
									'DOMContentLoaded',
									function() {
										var inputs = document
												.querySelectorAll('.bookDetails_container input[readonly]');
										for (var i = 0; i < inputs.length; i++) {
											inputs[i]
													.removeAttribute('readonly');
										}
									});
				</script>



				<button type="submit" class="confirm_button" name="id"
					value="<%String[] data = { id, rs.getString("cat_id") };%>">Confirm
					Update</button>
			</form>
			<div class="button_container">
				<button type="submit" class="cancel_button" name="id"
					value="<%=id%>" onclick="reloadPage()">Cancel</button>

			</div>
			<%
			}
			%>


		</div>
	</div>
	<%
	}

	// Step 7: Close connection
	conn.close();
	} catch (Exception e) {
	out.println("Error :" + e);
	}
	%>
</body>
</html>