<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="dbaccess.Book"%>

<%@ page import="java.util.*"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Book Inventory Report For Third Party</title>
<style>
body {
    font-family: Arial, sans-serif;
    background-color: #f5f5f5;
    padding: 20px;
}

.container {
    max-width: 1200px;
    margin: 0 auto;
}

h2 {
    color: #007bff;
    margin-bottom: 20px;
}

.book-container {
    display: flex;
    flex-wrap: wrap;
    justify-content: space-between;
}

.book-card {
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    padding: 10px;
    margin: 10px;
    flex-basis: calc(25% - 40px);
    background-color: #fff;
}

.book-card img {
    max-width: 100%;
    height: auto;
    margin-bottom: 10px;
    max-height: 150px;
}

.book-details h3, .book-details h6 {
    color: #333;
    margin-bottom: 5px;
}

.book-details h6 {
    font-weight: normal;
    color: #888;
}

.book-details h5 {
    font-weight: bold;
}

.sold-count {
    color: green;
}

.low-stock {
    color: red;
}

.btn {
    display: inline-block;
    background-color: #007bff;
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
    background-color: #0056b3;
}



</style>

</head>
<script>
    function goBack() {
        window.history.back(); // Go back to the previous page
    }
</script>


<body >

<%@include file="header.html" %>
	
	<%
	@SuppressWarnings("unchecked")
	ArrayList<Book> books = (ArrayList<Book>) session.getAttribute("topsales");
	@SuppressWarnings("unchecked")
	ArrayList<Book> books2 = (ArrayList<Book>) session.getAttribute("leastsales");
	@SuppressWarnings("unchecked")
	ArrayList<Book> books3 = (ArrayList<Book>) session.getAttribute("lowstock");
	
	
	//ArrayList<Book> books3 = (ArrayList<Book>) session.getAttribute("lowstock");
	%>
	


	<div class="container">

    <h2>Top 3 Selling Books</h2>

    <div class="book-container">
        <%
        for (Book book : books) {
        %>
        <div class="book-card">
            <img src="<%=request.getContextPath() + "/Graphics/" + book.getImage()%>">
            <div class="book-details">
                <h3><%=book.getTitle()%></h3>
                <h6>ISBN</h6>
                <%=book.getISBN()%>
                <h6>Author</h6>
                <%=book.getAuthor()%>
                <h6>Price Per Book</h6>
                <%=book.getPrice()%>
                <h6>In Stock</h6>
                <%=book.getQuantity()%>
                <h6>Publisher</h6>
                <%=book.getPublisher()%>
                <h6>Publication Date</h6>
                <%=book.getPublication_date()%>
                <h5 class="sold-count">Sold Count</h5>
                <%=book.getSold_count()%>
                <h6>Book ID</h6>
                <%=book.getId()%>
                <h6>Category ID</h6>
                <%=book.getCat_id()%>
            </div>
        </div>
        <%
        }
        %>
    </div>

    <h2>3 Least Selling Books</h2>

    <div class="book-container">
        <%
        for (Book book : books2) {
        %>
        <div class="book-card">
            <img src="<%=request.getContextPath() + "/Graphics/" + book.getImage()%>">
            <div class="book-details">
                <h3><%=book.getTitle()%></h3>
                <h6>ISBN</h6>
                <%=book.getISBN()%>
                <h6>Author</h6>
                <%=book.getAuthor()%>
                <h6>Price Per Book</h6>
                <%=book.getPrice()%>
                <h6>In Stock</h6>
                <%=book.getQuantity()%>
                <h6>Publisher</h6>
                <%=book.getPublisher()%>
                <h6>Publication Date</h6>
                <%=book.getPublication_date()%>
                <h5 class="sold-count">Sold Count</h5>
                <%=book.getSold_count()%>
                <h6>Book ID</h6>
                <%=book.getId()%>
                <h6>Category ID</h6>
                <%=book.getCat_id()%>
            </div>
        </div>
        <%
        }
        %>
    </div>

    <h2 style="color: red;">Low Stock Level Books</h2>

    <div class="book-container">
        <%
        for (Book book : books3) {
        %>
        <div class="book-card">
            <img src="<%=request.getContextPath() + "/Graphics/" + book.getImage()%>">
            <div class="book-details">
                <h3><%=book.getTitle()%></h3>
                <h6>Book ID</h6>
                <%=book.getId()%>
                <h6>Category ID</h6>
                <%=book.getCat_id()%>
                <h6>ISBN</h6>
                <%=book.getISBN()%>
                <h6>Author</h6>
                <%=book.getAuthor()%>
                <h6>Price Per Book</h6>
                <%=book.getPrice()%>
                <h6>Current Stock Count</h6>
                <%=book.getQuantity()%>
                <h5 class="low-stock">Sold Count</h5>
                <%=book.getSold_count()%>
            </div>
        </div>
        <%
        }
        %>
    </div>

</div>


	<%@include file="footer.html" %>

</body>
</html>