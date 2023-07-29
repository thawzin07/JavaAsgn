<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
<%@ page import="java.util.*" %>
<%@page import="mybooks.CartItems" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>AddToCart</title>
<%--
    
Author             : Thet Htar San
Date                 : 5/06/2023
Copyright Notice     : NA
@(#)
Description         : JavaAsgn
Admission no        : P2235077
Class             : DIT/FT/2A/03

--%>
</head>
<body>
<%
    String bookId = request.getParameter("bookId");
    int bookid = Integer.parseInt(bookId);
    String title = "";
    String image = "";
    float price = 0.0f;
    int qty = 0;
  	
  	int id=0;

    try {
        // Step1: Load JDBC Driver
        Class.forName("com.mysql.jdbc.Driver");  

        // Step 2: Define Connection URL
        String connURL = "jdbc:mysql://localhost/javaassignment?user=root&password=root1234&serverTimezone=UTC";

        // Step 3: Establish connection to URL
        Connection conn = DriverManager.getConnection(connURL); 
        // Step 4: Create Statement object
        Statement stmt = conn.createStatement();
        // Step 5: Execute SQL Command
        String sqlStr = "SELECT title, price, quantity, image, id FROM book WHERE id=?";  
        PreparedStatement pstmt = conn.prepareStatement(sqlStr);
        pstmt.setString(1, bookId);

        ResultSet rs = pstmt.executeQuery();
        while(rs.next()) {
            qty = rs.getInt("quantity");
            title = rs.getString("title");
            price = rs.getFloat("price");
            image = rs.getString("image");
            id=rs.getInt("id");
        }

        // Step 7: Close connection
        conn.close();
    } catch (Exception e) {
        out.println("Error: " + e);
    }

 
   
   CartItems item=new CartItems(title,qty,price,id, image);
   @SuppressWarnings("unchecked")
   ArrayList<CartItems> cartItems= (ArrayList<CartItems>) session.getAttribute("cartBooks");
   if(cartItems==null){
	   cartItems=new ArrayList<CartItems>();
	   
   }
   cartItems.add(item);
   session.setAttribute("cartBooks",cartItems);
    response.sendRedirect("ViewCart.jsp");
%>
</body>
</html>
