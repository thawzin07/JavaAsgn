
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="your.package.Book" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>View Cart</title>
</head>
<body>
<%
Boolean isLoggedIn = (Boolean) session.getAttribute("isLoggedIn");
if (isLoggedIn == null || !isLoggedIn) {
    response.sendRedirect("Login2.jsp");
}
%>
    <h1>View Cart</h1>
    <table>
        <tr>
            <th>Title</th>
            <th>Price</th>
            <th>Image</th>
        </tr>
        <%@ page import="java.util.ArrayList" %>
        <%@ page import="java.util.List" %>
        <%@ page import="java.math.BigDecimal" %>
        <%@ page import="java.text.NumberFormat" %>
        <%
            // Retrieve the book list from session
            List<Book> bookList = (List<Book>) session.getAttribute("bookCart");
            if (bookList != null && !bookList.isEmpty()) {
                // Iterate over the book list and display the book details
                for (Book book : bookList) {
                    String title = book.getTitle();
                    float price = book.getPrice();
                    String image = book.getImage();

                    // Format the price as currency
                    NumberFormat currencyFormat = NumberFormat.getCurrencyInstance();
                    String formattedPrice = currencyFormat.format(price);

                    // Display the book details in a table row
        %>
        <tr>
            <td><%= title %></td>
            <td><%= formattedPrice %></td>
            <td><img src="<%= image %>" alt="Book Cover"></td>
        </tr>
        <%
                }
            } else {
                // Display a message if the cart is empty
        %>
        <tr>
            <td colspan="3">Your cart is empty.</td>
        </tr>
        <%
            }
        %>
    </table>
</body>
</html>
