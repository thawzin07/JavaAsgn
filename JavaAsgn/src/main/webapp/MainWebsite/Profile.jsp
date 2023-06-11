<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Profile</title>
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
<script>
    function enableEdit(fieldId) {
        var field = document.getElementById(fieldId);
        field.readOnly = false;
        field.classList.add("editable-field");
        field.focus();
    }

  
    function handleFileSelect(event) {
      var file = event.target.files[0];
      var reader = new FileReader();
      reader.onload = function(e) {
        document.getElementById('profileImg').src = e.target.result;
      };
      reader.readAsDataURL(file);
    }
    
    function goBack(){
    	   window.history.back();
    }

</script>

<style>
.container {
  display: flex;
}

.picture {
  flex: 1;
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
</style>
</head>
<body>
<%
String profilePhoto = (String) session.getAttribute("sessPhoto");
%>
    <button onclick="goBack()">Go Back</button>
<div class="container">
  <div class="picture">
    <img id="profileImg" src="<%= profilePhoto %>" style="width: 100%; height: 100%;">
    <input type="file" id="fileInput" class="hidden" accept="image/*" onchange="handleFileSelect(event)">
    <button onclick="document.getElementById('fileInput').click()">Change Photo</button>
  </div> 

   <h1>Profile</h1>
  <div class="form">
  
    
    <form action="VerifyUpdateProfile.jsp">
      <label for="username">Username:</label>
      <input type="text" id="username" name="username" value="<%= session.getAttribute("sessUsername") %>" readonly onclick="enableEdit('username')"><br>

      <label for="phone">Phone:</label>
      <input type="text" id="phone" name="phone" value="<%= session.getAttribute("sessPhone") %>" readonly onclick="enableEdit('phone')"><br>

      <label for="email">Email:</label>
      <input type="text" id="email" name="email" value="<%= session.getAttribute("sessEmail") %>" readonly onclick="enableEdit('email')"><br>

      <label for="password">Password:</label>
      <input type="password" id="password" name="password" value="<%= session.getAttribute("sessPassword") %>" readonly onclick="enableEdit('password')"><br>
        
      <label for="userID">User ID:</label>
      <input type="text" id="userID" name="userID" value="<%= session.getAttribute("sessUserID") %>" readonly><br>
      
      <input type="submit" value="Update Profile">
    </form>
  </div>
</div>


</body>
</html>
