<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<% String bookId=request.getParameter("bookId");

List<String> cartItems = (List<String>) session.getAttribute("cartItems");
if (cartItems == null) {
    cartItems = new ArrayList<>();
}


t
cartItems.add(bookId);



session.setAttribute("cartItems", cartItems);

response.sendRedirect("ViewCart.jsp");
%>
</body>
</html>