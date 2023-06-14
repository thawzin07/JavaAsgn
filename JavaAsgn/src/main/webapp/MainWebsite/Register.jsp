<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Register</title>
<%--
    
Author             : Thet Htar San
Date                 : 5/06/2023
Copyright Notice     : NA
@(#)
Description         : JavaAsgn
Admission no        : P2235077
Class             : DIT/FT/2A/03
testing push 
--%>
<jsp:include page="VerifyRegisterInput.jsp" />

<script src="inputvalidation.js"></script>

<script>
function cancelButton() {
    window.location.href="Login2.jsp";
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
</head>
<body>

<div class="container">
<div class="card">
<%
String message = request.getParameter("msgCode");
String errorMessage = request.getParameter("errMsg");

if (message != null && message.equals("duplicate")) {
   out.print("User already exists. Please try again!");
} else if (message != null && message.equals("invalidRegister")) {
    out.print("Invalid Register. Please try again!");
} else if (message != null && message.equals("errorRegister")) {
    out.print("Error Register. Please try again!");
} else if (errorMessage != null) {
    out.print("Error: " + errorMessage);
}

%>
<h1 align="center">Register</h1>
<form action="VerifyRegisterUser.jsp" method="POST" id="registerForm">
    <input type="text" name="username" id="username" placeholder="Username" oninput="validateUsername(); checkErrors()">
   <span id="username-error" class="error-message"></span> <br/><br/>
   
    <input type="text" name="email" id="email" placeholder="Email" oninput="validateEmail(); checkErrors()">
    <span id="email-error" class="error-message"></span> <br/><br/>
    
    <input type="text" name="phone" id="phone" placeholder="Phone" oninput="validatePhone(); checkErrors()"/> 
    <span id="phone-error" class="error-message"></span> <br/><br/>
    
    <input type="password" name="password1" id="password1" placeholder="Password" oninput="validatePassword(); checkErrors()"/> 
    <span id="password-error" class="error-message"></span><br/><br/>
    
    <input type="password" name="password2" id="password2" placeholder="Confirm Password"/> <br/>
   
    <p id="passwordError" style="color: red; display: none;">Passwords do not match. Please re-enter.</p>
    <p id="fieldError" style="color: red; display: none;">Please fill in all the fields.</p>
    <br/>
    <button class="blue-button" id="submitButton" onClick="validateForm(event)" disabled>Submit</button>
  
</form>
<button class="blue-button" onClick="cancelButton()">Cancel</button>
</div>
</div>


<style>
.container {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100;
}

.card {
    background-color: #E8DFDF;
    padding: 20px;
    box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.2);
    z-index: 1;
}

input {
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

.blue-button.disabled {
    background-color: gray;
    cursor: not-allowed;
}

.error-message {
    position: absolute;
    color: red;
    font-size: 12px;
}
</style>

</body>
</html>
