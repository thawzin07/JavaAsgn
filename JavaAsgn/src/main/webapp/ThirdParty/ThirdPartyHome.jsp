<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Book Inventory Management</title>
<style>
    body {
        font-family: Arial, sans-serif;
        line-height: 1.6;
        margin: 20px;
    }

    h2 {
        color: #007bff;
        margin-bottom: 20px;
    }

    .section {
        margin-bottom: 30px;
        border: 1px solid #ccc;
        padding: 20px;
        border-radius: 5px;
    }

    .section h3 {
        margin-top: 0;
        margin-bottom: 15px;
    }

    .btn {
        background-color: #007bff;
        color: #fff;
        padding: 10px 20px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
    }

    .btn:hover {
        background-color: #0056b3;
    }
</style>
</head>
<body>
    <h2>Book Inventory Management</h2>

    <div class="section">
        <h3>Get Book Inventory Report</h3>
        <form action="<%= request.getContextPath()%>/BookInventoryReportTPServlet" method="get">
            <button type="submit" class="btn">Get Report</button>
        </form>
    </div>

    <div class="section">
        <h3>Create Book</h3>
        <button onclick="redirectTo('CreateBookTp.jsp')" class="btn">Create Book</button>
    </div>

    <div class="section">
        <h3>Update Book</h3>
        <button onclick="redirectTo('UpdateBookTp.jsp')" class="btn">Update Book</button>
    </div>

    <div class="section">
        <h3>Delete Book</h3>
        <button onclick="redirectTo('DeleteBookTp.jsp')" class="btn">Delete Book</button>
    </div>

    <script>
        function redirectTo(url) {
            window.location.href = url;
        }
    </script>
</body>
</html>