<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Third Party Update Book</title>
<style>
body {
    font-family: Arial, sans-serif;
    background-color: #f5f5f5;
    padding: 20px;
}

.container {
    max-width: 500px;
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
    <h2>Third Party Update Book</h2>
    <form action="<%= request.getContextPath()%>/UpdateBookTpServlet" method="post" id="updateForm" enctype="multipart/form-data">
        <label for="bookid">Book ID:</label>
        <input type="text" id="bookid" name="bookid"><br>

        <label for="isbn">ISBN:</label>
        <input type="text" id="isbn" name="isbn"><br>

        <label for="title">Title:</label>
        <input type="text" id="title" name="title"><br>

        <label for="author">Author:</label>
        <input type="text" id="author" name="author"><br>

        <label for="price">Price:</label>
        <input type="text" id="price" name="price"><br>

        <label for="publisher">Publisher:</label>
        <input type="text" name="publisher" id="publisher"><br>

        <label for="category">Category ID:</label>
        <input type="text" name="cat_id" id="cat_id"><br>

        <label for="quantity">Quantity:</label>
        <input type="text" name="quantity" id="quantity"><br>

        <label for="publication_date">Publication Date:</label>
        <input type="text" id="publication_date" name="publication_date"><br>

        <input type="submit" value="Update">
    </form>
</div>

<%@include file="footer.html" %>

</body>
</html>
