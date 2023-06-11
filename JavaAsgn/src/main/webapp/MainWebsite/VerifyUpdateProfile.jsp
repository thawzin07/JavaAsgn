<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%
// Assuming you have obtained the updated values from the form data
String username = request.getParameter("username");
String phone = request.getParameter("phone");
String email = request.getParameter("email");
String password = request.getParameter("password");

// Get the current user ID from the session
int userId = (int) session.getAttribute("sessUserID");

try {
    // Step 1: Load JDBC Driver
    Class.forName("com.mysql.jdbc.Driver");

    // Step 2: Define Connection URL
    String connURL = "jdbc:mysql://localhost/javaassignment?user=root&password=root1234&serverTimezone=UTC";

    // Step 3: Establish connection to URL
    Connection conn = DriverManager.getConnection(connURL);

    // Step 4: Create a PreparedStatement
    String sql = "UPDATE user SET username=?, phone=?, email=?, password=? WHERE id=?";
    PreparedStatement pstmt = conn.prepareStatement(sql);

    // Step 5: Set parameter values
    pstmt.setString(1, username);
    pstmt.setString(2, phone);
    pstmt.setString(3, email);
    pstmt.setString(4, password);
    pstmt.setInt(5, userId);

    // Step 6: Execute the UPDATE query
    int rowsAffected = pstmt.executeUpdate();

    // Step 7: Close resources
    pstmt.close();
    conn.close();

    if (rowsAffected > 0) {
        // Data updated successfully
        response.sendRedirect("Profile.jsp?msgCode=successUpdate"); // Redirect to the profile page
    } else {
        // Error occurred during update
        response.sendRedirect("Profile.jsp?msgCode=updateError"); // Redirect to an error page
    }
} catch (Exception e) {
    e.printStackTrace();
    response.sendRedirect("Profile.jsp?msgCode=updateError"); // Redirect to an error page
}
%>
