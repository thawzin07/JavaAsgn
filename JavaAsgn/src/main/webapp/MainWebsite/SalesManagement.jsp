<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*, dbaccess.*" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Sales Management</title>
    
</head>
<body>
<%@include file="header.html" %>
    <% // Fetch data and calculate total price
        ArrayList<PurchaseItem> purchasedItems = new ArrayList<>();
   
        float grandTotal = 0;

      
        try {
            Connection conn = DBConnection.getConnection();
            String sqlSelect = "SELECT p.book_id, b.title AS book_name, b.price, u.username, p.count, p.purchased_date "
                    + "FROM purchase p JOIN book b ON p.book_id = b.id JOIN user u ON p.user_id = u.id";
            PreparedStatement selectStmt = conn.prepareStatement(sqlSelect);
            ResultSet rs = selectStmt.executeQuery();
            
          
            

            while (rs.next()) {
                PurchaseItem purchaseBean = new PurchaseItem();
                purchaseBean.setBookid(Integer.parseInt(rs.getString("book_id")));
                purchaseBean.setBookname(rs.getString("book_name"));
                purchaseBean.setUsername(rs.getString("username"));
                purchaseBean.setCount(rs.getInt("count"));
                purchaseBean.setDatePurchased(rs.getString("purchased_date"));
				float price=rs.getFloat("price");
				int count=rs.getInt("count");
				float total=price*count;
				grandTotal+=total;
                purchasedItems.add(purchaseBean);
            }
            rs.close();
            selectStmt.close();
            conn.close();
            
            
           
          
           
           
           
          
        } catch (Exception e) {
            e.printStackTrace();
        }
    %>


    <h2>Sales Of Books</h2>
    <p>Total Price of All Purchases: $<%= grandTotal %></p>

    <h3>Purchased Items</h3>
    <table border="1">
        <tr>
            <th>Book ID</th>
            <th>Book Name</th>
            <th>Username</th>
            <th>Count</th>
            <th>Date Purchased</th>
           
        </tr>
        <% for (PurchaseItem item : purchasedItems) { %>
        <tr>
            <td><%= item.getBookid() %></td>
            <td><%= item.getBookname() %></td>
            <td><%= item.getUsername() %></td>
            <td><%= item.getCount() %></td>
            <td><%= item.getDatePurchased() %></td>
            
        </tr>
        <% } %>
      
        
    </table>
    
      
   
    
    <form action="<%= request.getContextPath() %>/GetBookSalesByPeriod" method="post">
    <h3>Get Purchase Data By Period</h3>
    <label for="datefrom">Date From: (Example: 2023-08-04)</label> <br/>
    <input type="text" name="datefrom"><br/>
    
    <label for="dateto">Date To: (Example: 2023-08-04)</label><br/>
    <input type="text" name="dateto"><br/>
    
    <input type="submit" name="Submit">
    </form>
    
      <form action="<%= request.getContextPath() %>/GetBookSalesByMonth" method="post">
    <h3>Get Purchase Data By Month</h3>
    <label for="month">Month: (Example: 08)</label> <br/>
    <input type="text" name="month"><br/>
    
   
    
    <input type="submit" name="Submit">
    </form>
    
       <form action="<%= request.getContextPath() %>/GetTopTenUsers" method="get">
    <h3>Get Top Ten Users</h3>
  
    <input type="submit" name="Submit">
    </form>
    
      <form action="<%= request.getContextPath() %>/GetUsersByBookId" method="post">
    <h3>Get Users By Book ID</h3>
    <label for="bookid">Enter Book ID:</label>
  <input type="text" name="bookid"><br/>
    <input type="submit" name="Submit">
    </form>
    
    <%@include file="footer.html" %>
</body>
</html>