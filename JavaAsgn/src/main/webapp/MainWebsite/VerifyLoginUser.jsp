<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%--
Author: Thet Htar San
Date: 15/5/2023
Description: ST0510/JAD/Week 5 Submission
 --%>

<%@page import ="java.sql.*"%>

<%
String user=request.getParameter("username");
String pwd=request.getParameter("password");
	int id;
	String name;
	String passwd;
	String email;
	String phone;
	String profilePhoto;
	
	
	boolean found=false;
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
          String sqlStr = "SELECT * FROM user WHERE username=? and password=?";  
        //  String rownum="SELECT ROW_NUMBER() OVER () as row_number * FROM member";
        System.out.println(sqlStr);
        PreparedStatement pstmt=conn.prepareStatement(sqlStr);
        pstmt.setString(1,user);
        pstmt.setString(2,pwd);
          ResultSet rs = pstmt.executeQuery();
        while(rs.next()){
        	found=true;
        	id=rs.getInt("id");
        	name=rs.getString("username");
        	passwd=rs.getString("password");
        	phone=rs.getString("phone");
        	email=rs.getString("email");
        	profilePhoto=rs.getString("image");
        	session.setAttribute("sessUsername",name);
        	session.setAttribute("sessPassword",passwd);
        	session.setAttribute("sessPhone",phone);
        	session.setAttribute("sessEmail",email);
        	session.setAttribute("sessUserID",id);
        	session.setAttribute("sessPhoto",profilePhoto);
        	
        	
        	
        	//out.println("ID:"+id+", Name:"+ name+"<br>");
        	
        }
        
          // Step 7: Close connection
          conn.close();
          
    //==================================================================================
    		if(found){
    			session.setAttribute("sessLoginID",user);
    		
    		
    			
    			
    			session.setAttribute("loginStatus", "success");
    			session.setMaxInactiveInterval(3*60); //3 seconds //3*60=3 minutes
    			//test
    		//	out.print("Loginid:"+user+"<br>");
    		//	out.print("Password:"+pwd);
    		//	out.print("<h1>Welcome!"+user+"</h1>");
    			//response.sendRedirect("displayMember.jsp");
    			response.sendRedirect("CategoryMember.jsp?user="+user);
    		}
    		else{
    			out.print("Sorry, login fail!");
    			response.sendRedirect("login.jsp?msgCode=invalidLogin");
    			
    		}
        
          //save
     } catch (Exception e) {
        out.println("Error :" + e);
     }

%>

</body>
</html>