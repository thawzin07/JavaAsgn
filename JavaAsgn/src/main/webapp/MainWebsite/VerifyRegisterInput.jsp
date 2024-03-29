<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Verify Register Form Input</title>
</head>
<%--
    
Author             : Thet Htar San
Date                 : 5/06/2023
Copyright Notice     : NA
@(#)
Description         : JavaAsgn
Admission no        : P2235077
Class             : DIT/FT/2A/03

--%>
<body>

	<script>
function validateForm(event) {
    event.preventDefault(); // Prevent default form submission
    
    var username = document.getElementById("username").value;
    var email = document.getElementById("email").value;
    var phone = document.getElementById("phone").value;
    var address=document.getElementById("address").value;
    var postal=document.getElementById("postalCode").value;
    var password1 = document.getElementById("password1").value;
    var password2 = document.getElementById("password2").value;
    
    var passwordError = document.getElementById("passwordError");
    var fieldError = document.getElementById("fieldError");
  
   
    var isValid = true;
    

    if (username === "" || email === "" || phone === "" || address==="" || postal==="" || password1 === "" || password2 === "") {
        fieldError.style.display = "block";
        isValid = false;
    } else {
        fieldError.style.display = "none";
    }

    if (password1 !== password2) {
        passwordError.style.display = "block";
        document.getElementById("password2").value = "";
        isValid = false;
    } else {
        passwordError.style.display = "none";
    }
    
    if (isValid) {
        document.getElementById("registerForm").submit(); 
        // Submit the form
    }
  

  
}
</script>
</body>
</html>
