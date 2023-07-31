<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List"%>
<%@ page import="mybooks.cartBooks"%>
<%
    String isbn = request.getParameter("isbn");
    //String bookToRemove = Integer.parseInt(bookId);

    // Retrieve the book list from session
    List<cartBooks> bookList = (List<cartBooks>) session.getAttribute("bookCart");
    if (bookList != null) {
        // Find the book with the specified bookId and remove it from the list
        for (int i = 0; i < bookList.size(); i++) {
            cartBooks book = bookList.get(i);
            if (book.getIsbn() == isbn) {
                bookList.remove(i);
                break;
            }
        }

        // Update the session with the updated book list
        session.setAttribute("bookCart", bookList);
    }
%>