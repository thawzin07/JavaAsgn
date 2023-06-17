<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import ="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<%
String id, username , email , phone , role , password, joinedDate ; 

String image = "../Graphics/DefaultProfile.jpg";


id = request.getParameter("id");
username = request.getParameter("username");
password = request.getParameter("password");
email = request.getParameter("email");
phone = request.getParameter("phone");
role = request.getParameter("role");
joinedDate = request.getParameter("joinedDate");

session.setAttribute("user_id", id);



	try {
		Class.forName("com.mysql.jdbc.Driver");  

		//Step 2: Define Connection URL
		String connURL = "jdbc:mysql://localhost/javaassignment?user=root&password=root1234&serverTimezone=UTC";

		//Step 3: Establish connection to URL
		Connection conn = DriverManager.getConnection(connURL); 
		//Step 4: Create Statement object
		Statement stmt = conn.createStatement();
		   
	    // Step 4: Create a PreparedStatement
	    String sql = "UPDATE javaassignment.user SET username=? , role=?, phone=?, email=?, joinedDate = ?, image =?, password=? where id=?";
	    PreparedStatement pstmt = conn.prepareStatement(sql);

	    // Step 5: Set parameter values
	    pstmt.setString(1, username);
	    pstmt.setString(2, role);
	    pstmt.setString(3, phone);
	    pstmt.setString(4, email);
	    pstmt.setString(5, joinedDate);
	    pstmt.setString(6, image);
	    pstmt.setString(7, password);
	    pstmt.setString(8, id);

	    // Step 6: Execute the INSERT query
	    int rowsAffected = pstmt.executeUpdate();

	    // Step 7: Close resources
	    pstmt.close();
	    conn.close();

	    if(rowsAffected > 0){
	    	session.setAttribute("user_id", id);
	    }
	    response.sendRedirect("AdminViewMembers.jsp");
	} 
	catch (Exception e) {
	    e.printStackTrace();
	    response.reset();
	    response.sendRedirect("AdminViewMembers.jsp");
	}
	

%>
</body>
</html>