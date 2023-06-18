<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<script>
function addToCart(bookId){
	
	 <%
	
	 if (session.getAttribute("loginStatus") != null) { %>
    // User is logged in, add the book to cart
    var form = document.createElement('form');
    form.method = 'post';
    form.action = 'AddToCart.jsp';
    var input = document.createElement('input');
    input.type = 'hidden';
    input.name = 'bookId';
    input.value = bookId;
    form.appendChild(input);
    
   
    
    document.body.appendChild(form);
    form.submit();

    
   
  <% } else { %>
    // User is not logged in, display alert to log in
    alert('You need to log in to add the book to cart.');
  <% } %>
}
</script>
<style>
body {
	font-family: Arial, sans-serif;
	background-color: #f5f5f5;
}

.container {
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	margin: 20px auto;
	max-width: 800px;
	padding: 20px;
	background-color: #fff;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

.header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 20px;
}

.header img {
	width: 30%;
	height: auto;
	margin-right: 10px;
}

.header h1 {
	font-size: 24px;
	margin: 0;
}

.button-container {
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: flex-end;
	margin-top: 20px;
}

.button-container button {
	width: 150px;
	padding: 10px 20px;
	font-size: 16px;
	border-radius: 5px;
	border: none;
	background-color: #4285f4;
	color: #fff;
	cursor: pointer;
	margin-bottom: 10px;
}

.button-container button:hover {
	background-color: #3367d6;
}

table {
	width: 100%;
	border-collapse: collapse;
	margin-top: 20px;
}

table th, table td {
	padding: 10px;
	border: 1px solid #ccc;
}

table th {
	background-color: #f5f5f5;
}

table img {
	width: 100%;
	height: auto;
	object-fit: cover;
	border-radius: 5px;
	display: block;
	margin-left: auto;
	margin-right: auto;
}

table h5 {
	margin: 5px 0;
}

table td:first-child {
	width: 30%;
}

table td:last-child {
	width: 70%;
}

table button {
	padding: 5px 10px;
	font-size: 14px;
	border-radius: 3px;
	border: none;
	background-color: #4285f4;
	color: #fff;
	cursor: pointer;
}

table button:hover {
	background-color: #3367d6;
}

table td button {
	display: flex;
	justify-content: center;
	align-items: center;
	margin: 5px auto;
	width: 80%;
}

table td button:first-child {
	background-color: #4285f4;
	color: #fff;
	margin-bottom: 10px;
}

table td button:last-child {
	background-color: #ff0000;
	color: #fff;
}
</style>





</head>
<body>
	<%
	//---------------START - initialisation of variables--------------------
	Boolean found = false; //to indicate if found or not
	ArrayList<String[]> catArray = new ArrayList<String[]>();
	ArrayList<String[]> bookArray = new ArrayList<String[]>();
	int catId;
	//---------------ENd   - initialization of variables-------------------
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

		String sqlBook = "SELECT title , author , image , cat_id, id from book";
		ResultSet rsB = stmt.executeQuery(sqlBook);

		while (rsB.next()) {
			String[] randomBook = new String[] { rsB.getString("cat_id"), rsB.getString("title"), rsB.getString("author"),
			rsB.getString("image"), rsB.getString("id") };
			bookArray.add(randomBook);
		}

		// Step 7: Close connection
		conn.close();
	} catch (Exception e) {
		out.println("Error :" + e);
	}

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

		String sqlStr = "SELECT name, id FROM category ";
		ResultSet rs = stmt.executeQuery(sqlStr);

		// Step 6: Process Result
		while (rs.next()) {
			String[] randomCat = new String[] { rs.getString("id"), rs.getString("name") };
			catArray.add(randomCat);
		}

		// Step 7: Close connection
		conn.close();
	} catch (Exception e) {
		out.println("Error :" + e);
	}

	String loginStatus = (String) session.getAttribute("loginStatus");
	String cart, details;
	String user = "";
	if (request.getParameter("user") != null) {
		user = request.getParameter("user");
	}

	if (loginStatus != null) {
		cart = "alert('successfully added the book to cart!')";
		details = "window.location.href='BookDetails.jsp'";
	} else {
		cart = "alert('you need to log in to add the book to cart')";
		details = "alert('you need to log in to view book details')";
		
	}
	%>
	<div class="container">
		<div class="header">
			<img src="../Graphics/ShopIcon.jpg" alt="Shop Icon">
			<h1>
				Welcome!
				<%=user%></h1>

			<div class="button-container">

				<%
				if (loginStatus != null) {
				%>


				<button onClick="window.location.href='Profile.jsp'">Profile
				</button>
				<button onClick="window.location.href='ViewCart.jsp'">View
					Cart</button>
				<%
				} else {
				%>
				<button onClick="window.location.href='Register.jsp'">Sign
					Up</button>
				<button onClick="window.location.href='Login2.jsp'">Log In</button>
				<%
				}
				%>
			</div>
		</div>

		<div class="table-container">
			<table>
				<tr>
					<th>Category</th>
					<th>Books under Category</th>
				</tr>

				<%
				for (int i = 0; i < catArray.size(); i++) {
				%>
				<tr>
					<td><%=catArray.get(i)[1]%></td>

					<td>
						<table>
							<%
							for (int j = 0; j < bookArray.size(); j++) {
								if (catArray.get(i)[0].equals(bookArray.get(j)[0])) {
							%>
							<tr
								style="display: flex; flex-direction: row; justify-content: center;">
								<td style="width: 30%;"><img src="<%=bookArray.get(j)[3]%>"
									alt="Book Cover"></td>
								<td style="width: 50%;">
									<h5>
										Title:
										<%=bookArray.get(j)[1]%></h5>
									<h5>
										Author:
										<%=bookArray.get(j)[2]%></h5>
								</td>
								<td style="width: 20%;">


									<button type="submit" onclick="addToCart('<%= bookArray.get(j)[4] %>')">Add To Cart</button>
									<%
									if (loginStatus != null) {
									%>
									<form action="BookDetails.jsp" method="post">
										<button type="submit" onClick="<%=details%>" name="id"
											value="<%=bookArray.get(j)[4]%>">
											View Details of
											<%=bookArray.get(j)[1]%>
										</button>
									</form> <%
 } else {
 %>
									<button type="submit" onClick="<%=details%>" name="title"
										value="<%=bookArray.get(j)[1]%>">
										View Details of
										<%=bookArray.get(j)[1]%>
									</button> <%
 }
 %>
								</td>
							</tr>
							<%
							}
							}
							%>
						</table>
					</td>
				</tr>
				<%
				}
				%>
			</table>
		</div>

	</div>
</body>

</html>