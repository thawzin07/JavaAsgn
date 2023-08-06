<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Payment Success</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            padding: 20px;
        }

        h2 {
            color: #007bff;
            margin-bottom: 20px;
        }

        button {
            background-color: #007bff;
            color: #fff;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            margin-top: 20px;
        }

        button:hover {
            background-color: #0056b3;
        }
    </style>
    <script>
        function redirectToHome() {
            window.location.href = "CategoryPublic.jsp";
        }
    </script>
</head>
<body>
    <%-- Check if the user is logged in --%>
    <%
    Boolean isLoggedIn = (Boolean) session.getAttribute("isLoggedIn");
    if (isLoggedIn == null || !isLoggedIn) {
        response.sendRedirect("Login2.jsp");
    }
    %>

    <%@include file="header.html" %>
    <h2>Payment Success!</h2>
    <button onClick="redirectToHome()">Go to Home</button>
    <%@include file="footer.html" %>

    
</body>
</html>
