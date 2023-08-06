<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Delete Book</title>
<style>
body {
    font-family: Arial, sans-serif;
    background-color: #f5f5f5;
    padding: 20px;
}

.container {
    max-width: 400px;
    margin: 0 auto;
}

form {
    background-color: #fff;
    padding: 20px;
    border-radius: 4px;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
}

label {
    display: block;
    font-weight: bold;
    margin-bottom: 10px;
}

input[type="text"] {
    width: 100%;
    padding: 8px;
    border: 1px solid #ccc;
    border-radius: 4px;
}

input[type="submit"] {
    background-color: #007bff;
    color: #fff;
    border: none;
    padding: 8px 16px;
    border-radius: 4px;
    cursor: pointer;
    font-size: 16px;
}

input[type="submit"]:hover {
    background-color: #0056b3;
}

</style>
</head>
<body>

<%@include file="header.html" %>

<div class="container">
    <h2>Delete Book</h2>
    <form action="<%= request.getContextPath()%>/DeleteBookServletTp" method="get">
        <label for="deleteid">Book ID to delete:</label>
        <input type="text" name="deleteid" id="deleteid">
        <input type="submit" value="Delete">
    </form>
</div>

<%@include file="footer.html" %>

</body>
</html>
