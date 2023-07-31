<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>AdminBookDetails</title>
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
	height: 45%;
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

	function showAlert() {
		var message = "You have updated successfully!";
		alert(message);
	}

	function validateUpdate() {
		event.preventDefault(); // Prevent default form submission

		var isbn = document.getElementById("isbn").value;
		var title = document.getElementById("title").value;
		var author = document.getElementById("author").value;
		var price = document.getElementById("price").value;
		var quantity = document.getElementById("quantity").value;
		var publisher = document.getElementById("publisher").value;
		var publication_date = document.getElementById("publication_date").value;
		var cat_id = document.getElementById("cat_id").value;

		var isValid = true;

		if (isbn === "" || title === "" || author === "" || price === ""
				|| quantity === "" || publisher === ""
				|| publication_date === "" || cat_id === "") {
			var message = "Fields cannot be empty"
			isValid = false;
		} else if (/[a-zA-Z]/.test(isbn) || /[a-zA-Z]/.test(price)
				|| /[a-zA-Z]/.test(quantity) || /[a-zA-Z]/.test(cat_id)) {
			var message = "ISBN, price, quantity or category ID can only be numbers "
			isValid = false;
		}

		if (isValid) {
			document.getElementById("updateForm").submit();
			// Submit the form
		} else {
			alert(message);
		}

	}
</script>

</head>
<body>
	<%
	Boolean isLoggedIn = (Boolean) session.getAttribute("isLoggedIn");
	if (isLoggedIn == null || !isLoggedIn) {
		response.sendRedirect("Login2.jsp");
	}
	%>

	<%
	String id = request.getParameter("id") != null ? request.getParameter("id") : (String) session.getAttribute("book_id");

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

		String sqlStr = "SELECT ISBN , title , author , price , publisher , publication_date , image , b.cat_id, quantity ,  name from book b , category c where b.id = ? and b.cat_id = c.id";
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
			<form action="AdminUpdateBook.jsp" method="post" id="updateForm">

				<label for="ISBN">ISBN :</label> <input type="text" id="isbn"
					name="isbn" value="<%=rs.getString("ISBN")%>" readonly><br>
				<label for="title">Title :</label> <input type="text" id="title"
					name="title" value="<%=rs.getString("title")%>" readonly><br>
				<label for="author">Author :</label> <input type="text" id="author"
					name="author" value="<%=rs.getString("author")%>" readonly><br>
				<label for="price">Price :</label> <input type="text" id="price"
					name="price" value="<%=rs.getString("price")%>" readonly><br>
				<label for="publisher">Publisher :</label> <input type="text"
					name="publisher" id="publisher"
					value="<%=rs.getString("publisher")%>" readonly><br> <label
					for="category">Category ID :</label> <input type="text"
					name="cat_id" id="cat_id" value="<%=rs.getString("cat_id")%>"
					readonly><br> <label for="quantity">Quantity :</label>
				<input type="text" name="quantity" id="quantity"
					value="<%=rs.getString("quantity")%>" readonly><br> <label
					for="publication_date">Publication Date :</label> <input
					type="text" id="publication_date" name="publication_date"
					value="<%=rs.getString("publication_date")%>" readonly><br>

				<input type="hidden" id="id" name="id" value="<%=id%>">


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

				<button class="confirm_button" name="confirm"
					onClick="validateUpdate()">Confirm Update</button>


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