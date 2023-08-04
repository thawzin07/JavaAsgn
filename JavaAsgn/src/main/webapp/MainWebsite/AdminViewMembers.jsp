<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@ page import="dbaccess.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>AdminViewMembers</title>
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

	ArrayList<User> userArray = (ArrayList<User>) session.getAttribute("userArray");
	
	

	//session.setAttribute("userArray", userArray);
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
				<th>Total_spend</th>
				<th>Last_update</th>
				<th>Admin Tools</th>
			</tr>

			<%
			for (int i = 0; i < userArray.size(); i++) {
			%>
			<tr>
				<td><img alt="" src=" <%=userArray.get(i).getImage() %> "></td>

				<td><%= userArray.get(i).getUserid() %></td>
				<td><%= userArray.get(i).getUsername() %></td>
				<td><%= userArray.get(i).getRole() %></td>
				<td><%= userArray.get(i).getPhone() %></td>
				<td><%= userArray.get(i).getEmail() %></td>
				<td><%= userArray.get(i).getJoinedDate() %></td>
				<td><%= userArray.get(i).getTotalspent() %></td>
				<td><%= userArray.get(i).getLast_update() %></td>
				
				<%
				String role = userArray.get(i).getRole();
				String userStr = "Member";
				if (role.equals("admin")) {
					userStr = "Admin";
				}

				if (role.equals("user")) {
				   session.setAttribute("tempArray", userArray);
				%>
				<td>
					<form action="AdminUpdateMemberForm.jsp" method="post">
						<button type="submit" onClick="" name="id"
							value="<%=userArray.get(i).getUserid() %>"
							style="background-color: #00FFFF">
							Update
							<%=userStr%>
						</button>
					</form>
					<form action="<%= request.getContextPath()%>/DeleteMemberServlet" method="post">
						<button type="submit" onClick="return confirmDelete();" name="id"
							value="<%=userArray.get(i).getUserid() %>">
							Delete
							<%=userStr%></button>
					</form>

				</td>

				<%
				} else {
				%>
				<td></td>
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