<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Profile</title>
</head>
<body>
    <h1>Profile</h1>

    <%-- Retrieve the profile photo URL from the session attribute --%>
    <% String profilePhoto = (String) session.getAttribute("sessPhoto"); %>

    <%-- Display the profile photo using the retrieved URL --%>
    <img src="<%= profilePhoto %>" alt="Profile Photo">

    <form>
        <p>Username: <%= session.getAttribute("sessUsername") %></p>
        <p>UserID: <%= session.getAttribute("sessUserID") %></p>
        <p>Phone: <%= session.getAttribute("sessPhone") %></p>
        <p>Email: <%= session.getAttribute("sessEmail") %></p>
        <p>Password: <%= session.getAttribute("sessPassword") %></p>

        <input type="text" name="loginid" id="loginid" placeholder="Username">
        <input type="text" name="password" id="password" placeholder="Password">
        <input type="text" name="phone" id="phone" placeholder="Phone Number">
        <input type="text" name="email" id="email" placeholder="Email">
        <input type="text" name="userid" id="userid" placeholder="ID">
    </form>

</body>
</html>
