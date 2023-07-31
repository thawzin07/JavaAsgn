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
    
Author             : Thet Htar San
Date                 : 5/06/2023
Copyright Notice     : NA
@(#)
Description         : JavaAsgn
Admission no        : P2235077
Class             : DIT/FT/2A/03

--%>


	<%@page import="java.sql.*"%>

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
        	session.setAttribute("role", rs.getString("role"));
        	
        	
        	
        	//out.println("ID:"+id+", Name:"+ name+"<br>");
        	
        }
        
          // Step 7: Close connection
          conn.close();
          
    //==================================================================================
    		if(found){
    			 session.setAttribute("sessLoginID", user);
    		        session.setAttribute("isLoggedIn", true);
    		        session.setAttribute("loginStatus", "success");
    		        session.setAttribute("msgCode", ""); 
    			
    		
    			session.setMaxInactiveInterval(30*60); //30*60=30 minutes
    			
    			if (session.getAttribute("role").equals("admin")){
    				response.sendRedirect("AdminLanding.jsp");
    			} else {
    				 response.sendRedirect(response.encodeRedirectURL("CategoryPublic.jsp"));
    			}
    			
    		}
    		else{
    			out.print("Sorry, login fail!");
    			 response.sendRedirect(response.encodeRedirectURL("Login2.jsp?msgCode=invalidLogin"));
    			
    		}
        
          //save
     } catch (Exception e) {
        out.println("Error :" + e);
     }

%>

</body>
</html>