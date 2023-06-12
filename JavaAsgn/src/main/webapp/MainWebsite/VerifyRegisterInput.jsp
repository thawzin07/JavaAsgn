<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Verify Register Form Input</title>
</head>
<body>

<script>
function validateForm(event) {
    event.preventDefault(); // Prevent default form submission
    
    var username = document.getElementById("username").value;
    var email = document.getElementById("email").value;
    var phone = document.getElementById("phone").value;
    var password1 = document.getElementById("password1").value;
    var password2 = document.getElementById("password2").value;
    var passwordError = document.getElementById("passwordError");
    var fieldError = document.getElementById("fieldError");
   
    var isValid = true;

    if (username === "" || email === "" || phone === "" || password1 === "" || password2 === "") {
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
