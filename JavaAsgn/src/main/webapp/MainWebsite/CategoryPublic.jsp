<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
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

		String sqlBook = "SELECT title , author , image , cat_id from book";
		ResultSet rsB = stmt.executeQuery(sqlBook);

		while (rsB.next()) {
			String[] randomBook = new String[] { rsB.getString("cat_id"), rsB.getString("title"), rsB.getString("author"),
			rsB.getString("image") };
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
	%>
	<div
		style="display: flex; flex-direction: row; justify-content: center; width: 90%; height: 30%; margin: 20px auto;">

		<div
			style="display: flex; flex-direction: row; justify-content: center; width: 30%; height: 100%;">
			<img src="../Graphics/ShopIcon.jpg"
				style="width: 100%; height: 100%;">
		</div>

		<div
			style="display: flex; flex-direction: row; justify-content: center; width: 70%; height: 100%;">
			<h1 style="margin-left: 10px;">Welcome!</h1>
		</div>



		<div
			style="display: flex; flex-direction: column; justify-content: center; width: 30%; height: 100%;">
			<button style="margin-bottom: 10%" onClick="window.location.href='Register.jsp'">Sign Up</button>
			<button style="margin-bottom: 10%" onClick="window.location.href='Login2.jsp'">Log In</button>
		</div>
	</div>

	<form action="add2Cart.jsp" method="post">
		<!-- inline styling to div so that the whole form will appear at the center of user screen -->
		<div
			style="display: flex; flex-direction: row; justify-content: center;">
			<table border=1>
				<tr>
					<td>Category</td>
					<td>Books under Category</td>
				</tr>


				<%
				for (int i = 0; i < catArray.size(); i++) {
				%>
				<tr>
					<td><%=catArray.get(i)[1]%></td>

					<td>

						<table border=1 style="display: flex; width: 100%;">
							<%
							for (int j = 0; j < bookArray.size(); j++) {
								if (catArray.get(i)[0].equals(bookArray.get(j)[0])) {
							%>
							<tr style="display: flex; width: 100%;">
								<td
									style="flex: 30%; height: 150px; border: 1px solid black; box-sizing: border-box;">
									<img style="width: 100%; height: 100%; object-fit: contain;"
									alt="" src=<%= bookArray.get(j)[3] %>>
								</td>
								<td
									style="flex: 50%; height: 150px; border: 1px solid black; box-sizing: border-box;">
									<h5>
										Title:
										<%=bookArray.get(j)[1]%></h5>
									<h5>
										Author:
										<%=bookArray.get(j)[2]%></h5>
								</td>
								<td
									style="flex: 20%; height: 150px; border: 1px solid black; box-sizing: border-box;">
									<button type="submit">Add To Cart</button>
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
	</form>
</body>
</html>