<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*"%>
<%@ page import="dbaccess.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>AdminUpdateMemberForm</title>
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
	justify-content: center;
	align-items: center;
	height: 100vh;
}

form {
	margin: 20px;
}

label {
	display: inline-block;
	width: 100px;
	margin-right: 10px;
}

input[type="text"] {
	width: 200px;
	padding: 5px;
	margin-bottom: 10px;
}

.button_container {
	margin-top: 10px;
}

.confirm_button, .cancel_button {
	padding: 10px 20px;
	border: none;
	background-color: #007bff;
	color: #fff;
	cursor: pointer;
}

.cancel_button {
	background-color: #dc3545;
}

.button_container button:not(:last-child) {
	margin-right: 10px;
}
</style>
<script>
	function goBack() {
		history.back();
	}
	function reloadPage() {
		location.reload();
	}

	function validateUpdate() {
		event.preventDefault(); // Prevent default form submission

		var username = document.getElementById("username").value;
		var email = document.getElementById("email").value;
		var phone = document.getElementById("phone").value;
		var role = document.getElementById("role").value;

		role = role.toLowerCase();

		var isValid = true;
		var message;

		if (username === "" || email === "" || phone === "" || role === "") {
			message = "Input fiels cannot be empty";
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
	<button type="button" class="goBack" onclick="goBack()">Go
		Back</button>

	<div class="container">
		<%
		if (session.getAttribute("role") == null || !session.getAttribute("role").equals("admin")) {
			response.sendRedirect("CategoryPublic.jsp?");
		}


		String id = request.getParameter("id");

		%>
		<form action="<%=request.getContextPath()%>/UpdateMemberServlet"
			method="post" id="updateForm">
			<label for="username">Username:</label> <input type="text"
				id="username" name="username"><br> <label for="email">Email:</label>
			<input type="text" id="email" name="email"><br> <label
				for="phone">Phone:</label> <input type="text" id="phone"
				name="phone"><br> <label for="role">Role:</label> <input
				type="text" id="role" name="role"><br> <label
				for="joinedDate">Joined Date:</label> <input type="text"
				id="joinedDate" name="joinedDate"><br> <input
				type="hidden" id="id" name="id" value="<%=id %>">

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
										inputs[i].removeAttribute('readonly');
									}
								});
			</script>
			<%
			}
			%>

			<div class="button_container">
				<button class="confirm_button" name="confirm"
					onClick="validateUpdate()">Confirm Update</button>
				<button type="button" class="cancel_button" name="id"
					onclick="reloadPage()">Clear</button>
			</div>
		</form>
	</div>
</body>


</html>