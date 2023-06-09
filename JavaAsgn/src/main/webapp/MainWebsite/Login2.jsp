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
<script>
function redirectRegister(){
	window.location.href="Register.jsp";
}
function redirectGuest(){
	window.location.href="CategoryPublic.jsp";
}
</script>
 
</head>
<body>
<div class="container">
<div class="card">
<%
String message=request.getParameter("msgCode");

if(message!=null && message.equals("invalidLogin")){
out.print("Sorry, error in login.. <br><h2>Please try again!</h2>");
}
else if(message!=null && message.equals("successRegister")){
out.print("Please log in with the created account!");
}
//save
%>
<h1 align="center">Login</h1>
<form action="VerifyLoginUser.jsp" method="POST" >
<input type="text" name="username" placeholder="Username"/> <br/>
<input type="password" name="password" placeholder="Password"/> <br/>
<br>
<input type="submit" class="blue-button" value="Login" />


</form>
<button class="blue-button" onClick="redirectRegister()">Register as Member</button>
<button class="blue-button" onClick="redirectGuest()">Continue As Guest</button>

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