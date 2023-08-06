<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Delete Book</title>
</head>
<body>
<form action="<%= request.getContextPath()%>/DeleteBookServletTp" method="get" >
<label for="deleteid">Bookid to delete:</label><br/>
<input type="text" name="deleteid">
<input type="submit">

</form>

</body>
</html>