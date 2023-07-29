<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="mybooks.*" %>
      <%@ page import="java.util.ArrayList" %>
        <%@ page import="java.util.List" %>
       
<!DOCTYPE html>
<html>
<head>
<%--
    
Author             : Thet Htar San
Date                 : 5/06/2023
Copyright Notice     : NA
@(#)
Description         : JavaAsgn
Admission no        : P2235077
Class             : DIT/FT/2A/03

--%>
    <meta charset="ISO-8859-1">
    <title>View Cart</title>
    <script >
    function goBack(){
    	  window.history.back();
    }
    function removeBookFromCart(isbn) {
        var xhr = new XMLHttpRequest();
        xhr.open("GET", "RemoveFromCart.jsp?isbn=" + isbn, true);
        xhr.send();
        // You can also handle the response here if needed
        xhr.onreadystatechange = function () {
            if (xhr.readyState === XMLHttpRequest.DONE) {
                // If the request is successful, reload the page to update the cart view
                if (xhr.status === 200) {
                    location.reload();
                } else {
                    // Handle any errors if needed
                }
            }
        };
    }	
    
    </script>
 <style>
 .container{
  text-align: center;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh; 
 }
 body{
  background-color: #E8DFDF;
  }
  .blue-button {
    background-color: blue;
    color: white;
    padding: 5px 10px;
    border: none;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 14px;
    cursor: pointer;
    align-items: center;
}
  .red-button {
    background-color: red;
    color: white;
    padding: 5px 10px;
    border: none;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 14px;
    cursor: pointer;
    align-items: center;
}
img{
width:150px;
height:auto;
}
 
 </style>
</head>
<body>
<%
Boolean isLoggedIn = (Boolean) session.getAttribute("isLoggedIn");
if (isLoggedIn == null || !isLoggedIn) {
    response.sendRedirect("Login2.jsp");
}
%>
<button onClick="goBack()">Go Back</button>
    <h1>View Cart</h1>
    <div class="container">
    <table border=1>
        <tr>
            <th>Title</th>
            <th>Price</th>
            <th>Image</th>
            <th>Qty</th>
          
        </tr>
     
        <%
            // Retrieve the book list from session
            List<cartBooks> bookList = (List<cartBooks>) session.getAttribute("bookCart");
            if (bookList != null && !bookList.isEmpty()) {
                
                for (cartBooks book : bookList) {
                    String title = book.getTitle();
                    float price = book.getPrice();
                    String image = book.getImage();
                    int qty=book.getQty();
                   String isbn=book.getISBN();

                   
        %>
        
        <tr>
            <td><%= title %></td>
            <td>$<%= price %></td>
            <td><%=isbn %></td>
            <td><img src="<%= image %>" alt="Book Cover"></td>
            <td> 
            <%--drop down box to change the qty, the maximum will be the qty in the database --%>
            <select id="quantityDropdown" name="quantity" >
                    <% for (int i = 1; i <= qty; i++) { %>
                        <option value="<%= i %>"><%= i %></option>
                    <%
                    } %>
            </select>
            </td>
              <td>
        <button class="red-button" onclick="removeBookFromCart(<%= isbn %>)">Remove</button>
    </td>
            
           
            
        </tr>
        
        
		
        
        <%
                }
            } else {

        %>
        <tr>
            <td colspan="3">Your cart is empty.</td>
            
        </tr>
        <%
            }
        %>
    </table>
    </div>
    <p>Final prices will be calculated at checkout.
        <button class="blue-button"> Checkout</button>
        
</body>
</html>