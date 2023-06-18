<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Profile</title>
<%--
    
Author             : Thet Htar San
Date                 : 24/05/2023
Copyright Notice     : NA
@(#)
Description         : JavaAsgn
Admission no        : P2235077
Class             : DIT/FT/2A/03
--%>
<style>
    .editable-field {
        border: none;
        background-color: transparent;
        font-size: inherit;
        font-family: inherit;
        cursor: pointer;
    }
    .editable-field:focus {
        outline: none;
        border-bottom: 1px solid blue;
    }
</style>
<script src="inputvalidation.js"></script>
<script>
    function enableEdit(fieldId) {
        var field = document.getElementById(fieldId);
        field.readOnly = false;
        field.classList.add("editable-field");
        field.focus();
    }

    function goBack() {
        window.history.back();
    }
    
    function logout() {
        window.location.href = "Logout.jsp";
    }
    
    function checkErrors() {
        var errorMessages = document.querySelectorAll(".error-message");
        var submitButton = document.getElementById("submitButton");
        
        for (var i = 0; i < errorMessages.length; i++) {
            if (errorMessages[i].innerText !== "") {
                submitButton.disabled = true;
                submitButton.classList.add("disabled");
                return;
            }
        }
        
        submitButton.disabled = false;
        submitButton.classList.remove("disabled");
    }

</script>

<style>

  .editable-field {
    border: none;
    background-color: transparent;
    font-size: inherit;
    font-family: inherit;
    cursor: pointer;
  }

  .editable-field:focus {
    outline: none;
    border-bottom: 1px solid blue;
  }
	body{
	 background-color: #E8DFDF;}
  .container {
    display: flex;
   
  }
  img{
  width:50px;
  height:50px;
  }

  .form {
    flex: 1;
    margin-left: 20px;
  }

  .form input {
    width: 100%;
  }

  .hidden {
    display: none;
  }

  .error-message {
    position: absolute;
    color: red;
    font-size: 12px;
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

  .blue-button.disabled {
     background-color: grey;
    color: black;
    padding: 5px 10px;
    border: none;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 14px;
    cursor: pointer;
    align-items: center;
  }
  
  .logoutButton{
  background-color: blue;
    color: white;
    padding: 5px 10px;
    border: none;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 14px;
    cursor: pointer;
    align-items: right;
    margin-left: auto; 
  }
  
</style>
</head>
<body>
<%
Boolean isLoggedIn = (Boolean) session.getAttribute("isLoggedIn");
if (isLoggedIn == null || !isLoggedIn) {
    response.sendRedirect("Login2.jsp");
}
String message = request.getParameter("msgCode");


if (message != null && message.equals("duplicate")) {
   out.print("Username/Email/Phone already exists. Please try again!");
}
else if (message != null && message.equals("duplicate")){
	out.print("Update Error!");
}
%>


<button onclick="goBack()">Go Back</button>
<div class="container">
   <h1>Profile</h1>
  <div class="form">
    <form action="VerifyUpdateProfile.jsp">
    <img src="<%=session.getAttribute("sessPhoto") %>">
      <label for="username">Username:</label>
      <input type="text" id="username" name="username" value="<%= session.getAttribute("sessUsername") %>" readonly onclick="enableEdit('username')" oninput="validateUsername(); checkErrors()"><br>
      <span id="username-error" class="error-message"></span><br/><br/>

      <label for="phone">Phone:</label>
      <input type="text" id="phone" name="phone" value="<%= session.getAttribute("sessPhone") %>" readonly onclick="enableEdit('phone')" oninput="validatePhone(); checkErrors()"><br>
      <span id="phone-error" class="error-message"></span><br/><br/>

      <label for="email">Email:</label>
      <input type="text" id="email" name="email" value="<%= session.getAttribute("sessEmail") %>" readonly onclick="enableEdit('email')" oninput="validateEmail(); checkErrors()"><br>
      <span id="email-error" class="error-message"></span><br/><br/>

      <label for="password">Password:</label>
      <input type="password" id="password" name="password" value="<%= session.getAttribute("sessPassword") %>" readonly onclick="enableEdit('password')" oninput="validatePassword(); checkErrors()"><br>
      <span id="password-error" class="error-message"></span><br/><br/>

      <label for="userID">User ID:</label>
      <input type="text" id="userID" name="userID" value="<%= session.getAttribute("sessUserID") %>" readonly><br>
      
      <button class="blue-button" id="submitButton" onClick="validateForm(event)" disabled>Update Profile</button>
    </form>
    <button class="logoutButton" onclick="logout()">Logout</button>
  </div>
</div>
</body>
</html>
