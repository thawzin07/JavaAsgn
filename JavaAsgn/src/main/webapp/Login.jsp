<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>LoginLanding</title>
<%--
    
Author             : Thet Htar San
Date                 : 24/05/2023
Copyright Notice     : NA
@(#)
Description         : JavaAsgn
Admission no        : P2235077
Class             : DIT/FT/2A/03
--%>
 
 
</head>
<body>
<div class="container">
<div class="card">
<%
String message=request.getParameter("errCode");

if(message!=null && message.equals("invalidLogin")){
out.print("Sorry, error in login.. <br><h2>Please try again!</h2>");
}%>
<h1 align="center">Login</h1>
<form action="VerifyUser.jsp" method="POST" >
<input type="text" name="loginid" placeholder="Username"/> <br/>
<input type="password" name="password" placeholder="Password"/> <br/>
<br>
<button class="blue-button" onClick="Register.jsp">Register as Member</button>
<button class="blue-button">Continue As Guest</button>

</form>

</div>

</div>

<style>
  .container {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
  }
  .card {
    background-color: #E8DFDF;
    padding: 20px;
    box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.2);
    z-index: 1;
  }
  form {
    position: relative;
    background-color: transparent;
    padding: 20px;

    z-index: 2;
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
      align-items:center;
    }
</style>

</body>
</html>