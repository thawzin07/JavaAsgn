<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.util.*"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<style>
.container {
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	margin: 20px auto;
	max-width: 1150px;
	padding: 20px;
	background-color: #fff;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

table {
  table-layout: fixed;
  width: 100%;
}

th {
  width: 12.5%; 
}

td:first-child img {
  width: 100%;
  height: auto;
  display: block;
  max-width: 100%;
}


</style>
<script>
	function confirmDelete() {
		return confirm("Are you sure you want to delete the member?");
	}
</script>
</head>
<body>
<%
if (session.getAttribute("role") == null || !session.getAttribute("role").equals("admin")) {
	response.sendRedirect("CategoryPublic.jsp?");
}

ArrayList<String[]> userArray = new ArrayList<String[]>();

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

	String sqlmember = "SELECT * from javaassignment.user";
	ResultSet rs = stmt.executeQuery(sqlmember);

	// Step 6 : Process the results
	while (rs.next()) {
		String[] randomUser = new String[]{rs.getString("id"), rs.getString("username"), rs.getString("role"),
		rs.getString("phone"), rs.getString("email"), rs.getString("joinedDate"), rs.getString("password"), rs.getString("last_updated"), rs.getString("image")};
		userArray.add(randomUser);
	}

	// Step 7: Close connection
	conn.close();
} catch (Exception e) {
	out.println("Error :" + e);
}

session.setAttribute("userArray", userArray);
%>
<div class="container">
<table border=1>
 	<tr>
 		<th>Profile Image</th>
 		<th>ID</th>
 		<th>Username</th>
 		<th>Role</th>
 		<th>Phone</th>
 		<th>Email</th>
 		<th>JoinedDate</th>
 		<th>Password</th>
 		<th>Last_update</th>
 		<th>Admin Tools</th>
 	</tr>
 	
 	<%
 	for (int i = 0 ; i < userArray.size() ; i++){
 		%>
 		<tr>
 		<td><img alt="" src=" <%= userArray.get(i)[8] %> "></td>
 		
 		<% 
 		for (int j = 0 ; j < userArray.get(i).length-1 ; j++) {
 			%>
 			<td><%= userArray.get(i)[j] %></td>
 			<%
 		}
 		%>
 		<%
 		String role = userArray.get(i)[2] ;
 		String userStr = "Member";
 		if (role.equals("admin")){
 			userStr = "Admin";
 		}
 		
 		if (role.equals("user")){
 			%>
 			<td> 
 			<form action="AdminUpdateMemberForm.jsp" method="post">
										<button type="submit" onClick="" name="id"
											value="<%=userArray.get(i)[0]%>" style="background-color: #00FFFF">
											Update <%= userStr %>
										</button>
									</form>
 		<form action="DeleteMember.jsp" method="post">
										<button type="submit" onClick="return confirmDelete();"
											name="id" value="<%=userArray.get(i)[0]%>">Delete <%= userStr %></button> 
									</form>
 		
 		</td>
 		
 			<%
 		} else {
 			%>
 			<td>
 			
 			
 			</td>
 			<%
 		}
 		%>
 		</tr>
 		<%
 	}
 	%>
</table>
</div>


</body>
</html>