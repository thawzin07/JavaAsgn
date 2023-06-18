<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

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
    session.setAttribute("guestSession",true);
}
</script>
 
</head>
<body>
<div class="container">
<div class="card">
<%
String message=request.getParameter("msgCode");

if(message!=null && message.equals("invalidLogin")){
out.print("<h2 align='center'>Username or password is wrong.</h2>");
}
else if(message!=null && message.equals("successRegister")){
out.print("Please log in with the created account!");
}
//save
%>
<%
Boolean isLoggedIn = (Boolean) session.getAttribute("isLoggedIn");
if (isLoggedIn != null && isLoggedIn) {
    response.sendRedirect("CategoryPublic.jsp");
}
%>
<h1 align="center">Login</h1>
<form action="VerifyLoginUser.jsp" method="POST" >
    <input type="text" name="username" placeholder="Username"/> <br/>
    <input type="password" name="password" placeholder="Password"/> <br/>
    <br>
    <div style="text-align: center;">
        <input type="submit" class="login-button" value="Login" />
    </div>
</form>
<div class="button-container">
    <button class="blue-button" onClick="redirectRegister()">Register as Member</button>
    <button class="blue-button" onClick="redirectGuest()">Continue As Guest</button>
</div>

</div>

</div>

<style>
.container {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 50vh;
}

.card {
    background-color: #E8DFDF;
    padding: 20px;
    box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.2);
    z-index: 1;
}
input{
	width: 400px;
	height: 30px;
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
    align-items: center;
}

.login-button {
    background-color: blue;
    color: white;
    padding: 5px 10px;
    border: none;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 14px;
    cursor: pointer;
    width:300px;
    align-items: center;
    align: center;
}

.button-container {
    text-align: center;
    margin-top: 20px;
}

.button-container button {
    margin-right: 10px;
}
</style>

</body>
</html>
