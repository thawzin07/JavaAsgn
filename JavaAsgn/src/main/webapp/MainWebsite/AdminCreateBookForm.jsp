<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<style>
.container {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100vh;
}
form {
  margin: 20px;
}

label {
  display: inline-block;
  width: 100px;
  margin-right: 10px;
}

input[type="text"] {
  width: 200px;
  padding: 5px;
  margin-bottom: 10px;
}

.button_container {
  margin-top: 10px;
}

.confirm_button, .cancel_button {
  padding: 10px 20px;
  border: none;
  background-color: #007bff;
  color: #fff;
  cursor: pointer;
}

.cancel_button {
  background-color: #dc3545;
}

.button_container button:not(:last-child) {
  margin-right: 10px;
}

</style>
<script>
function goBack() {
    history.back();
  }
	function reloadPage() {
		location.reload();
	}
	
	function showAlert() {
	      var message = "You have updated successfully!";
	      alert(message);
	    } 
	
	function validateUpdate() {
	    event.preventDefault(); // Prevent default form submission
	    
	    var isbn = document.getElementById("isbn").value;
	    var title = document.getElementById("title").value;
	    var author = document.getElementById("author").value;
	    var price = document.getElementById("price").value;
	    var quantity = document.getElementById("quantity").value;
	    var publisher = document.getElementById("publisher").value;
	    var publication_date = document.getElementById("publication_date").value;
	    var cat_id = document.getElementById("cat_id").value;
	  
	   
	    var isValid = true;
	    

	    if (isbn === "" || title === "" || author ==="" || price ==="" || quantity ==="" || 
	    		publisher ==="" || publication_date ==="" || cat_id ==="") {
	        var message = "Fields cannot be empty"
	        isValid = false;
	    } else if (/[a-zA-Z]/.test(isbn) || /[a-zA-Z]/.test(price) || /[a-zA-Z]/.test(quantity) || /[a-zA-Z]/.test(cat_id)) {
	    	var message = "ISBN, price, quantity or category ID can only be numbers "
		        isValid = false;
	    }
	    
	    if (isValid) {
	        document.getElementById("updateForm").submit(); 
	        // Submit the form
	    } else {
	    	alert(message);
	    }
	  
	}
</script>
</head>
<body>
<button type="button" class="goBack" onclick="goBack()">Go Back</button>

  <div class="container">
    <%
    if (session.getAttribute("role") == null || !session.getAttribute("role").equals("admin")) {
      response.sendRedirect("CategoryPublic.jsp?");
    }

    String cat_id = request.getParameter("cat_id");
    %>
    <form action="AdminCreateBookLogic.jsp" method="post" id="updateForm">

				<label for="ISBN">ISBN :</label> 
				<input type="text" id="isbn" name="isbn"
					 ><br> 
					<label
					for="title">Title :</label> 
					<input type="text" id="title" name="title"
					 ><br> 
					<label
					for="author">Author :</label> 
					<input type="text" id="author" name="author"
					 ><br> 
					<label
					for="price">Price :</label> 
					<input type="text" id="price" name="price"
					 ><br> 
					<label
					for="publisher">Publisher :</label> 
					<input type="text" name="publisher"
					id="publisher" ><br>

				<label for="category">Category ID :</label> <input type="text" name="cat_id"
					id="cat_id" value="<%= cat_id %>"><br>

				<label for="quantity">Quantity :</label> <input type="text" name="quantity"
					id="quantity"><br>

				<label for="publication_date">Publication Date :</label> <input
					type="text" id="publication_date" name="publication_date"
					><br>
					

				<button class="confirm_button" name="confirm" onClick="validateUpdate()"
					>Confirm </button>
	<div class="button_container">
				<button type="submit" class="cancel_button" name="id"
					onclick="reloadPage()">Cancel</button>

			</div>
				
			</form>
			
  </div>
</body>


</html>