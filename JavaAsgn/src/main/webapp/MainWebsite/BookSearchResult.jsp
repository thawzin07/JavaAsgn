<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="dbaccess.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<style>
body {
    font-family: Arial, sans-serif;
    background-color: #f0f0f0;
    margin: 0;
    padding: 0;
}

h3 {
    color: #333;
    margin-bottom: 10px;
}

h6 {
    color: #777;
    margin: 3px 0;
}

.book-container {
    display: flex;
    justify-content: center;
    align-items: center;
    min-height: 100vh;
}

.book-card {
    width: 500px;
    padding: 20px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    background-color: #fff;
    border-radius: 8px;
}

.book-card img {
    width: 100%;
    height: 300px;
    object-fit: cover;
    border-radius: 8px;
    margin-bottom: 10px;
}

h3, h6 {
    color: #333;
    margin-bottom: 5px;
}

h6 {
    font-weight: normal;
    color: #888;
}

h5 {
    font-weight: bold;
}

.green-text {
    color: green;
}

.red-text {
    color: red;
}

/* Add CSS to display labels and values side by side */
.book-card h3,
.book-card h6 {
    display: inline;
    margin-right: 5px;
    font-weight: bold;
}

.book-card h6 {
    color: #555;
    font-weight: normal;
}

/* Add a separator between label and value */
.book-card h6::after {
    content: ":";
    margin-right: 2px;
}

/* Add some spacing between label and value pairs */
.book-card h3,
.book-card h6 {
    margin-bottom: 5px;
}
.btn {
    display: inline-block;
    background-color: #3498db;
    color: #fff;
    padding: 8px 16px;
    border-radius: 4px;
    text-decoration: none;
    margin-top: 10px;
    transition: background-color 0.3s;
    border: none;
    cursor: pointer;
    font-size: 16px;
}

.btn:hover {
    background-color: #2980b9;
}
    
</style>
</head>
<script>
    function goBack() {
        window.history.back(); // Go back to the previous page
    }
</script>
<body>
    <button class="btn" onclick="goBack()">Go Back</button>
    <%   
        Book book = (Book) request.getAttribute("searchresult");

        if (book == null) {
    %>
    <h3>The book with the search title does not exist in inventory.</h3>
    <%
    } else {
    %>
     <h3>Your search Results</h3>
<div class="book-container">
    <div class="book-card">
        <img src="<%=request.getContextPath() + "/Graphics/" + book.getImage()%>">
        <!-- Display search book details -->
        <h3>Title:</h3>
        <p><%=book.getTitle()%></p>

        <h3>ISBN:</h3>
        <p><%=book.getISBN()%></p>

        <h3>Author:</h3>
        <p><%=book.getAuthor()%></p>

        <h3>Price Per Book:</h3>
        <p><%=book.getPrice()%></p>

        <h3>In Stock:</h3>
        <p><%=book.getQuantity()%></p>

        <h3>Publisher:</h3>
        <p><%=book.getPublisher()%></p>

        <h3>Publication Date:</h3>
        <p><%=book.getPublication_date()%></p>

        <h3 class="green-text">Sold Count:</h3>
        <p><%=book.getSold_count()%></p>

        <h3>Book ID:</h3>
        <p><%=book.getId()%></p>

        <h3>Category ID:</h3>
        <p><%=book.getCat_id()%></p>
    </div>
</div>
    <%
    }
    %>
</body>
</html>
