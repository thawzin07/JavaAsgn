<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, java.io.*, javax.servlet.http.Part" %>

<%
// Helper method to get the filename from a Part object
private String getFilename(Part part) {
    String contentDisposition = part.getHeader("content-disposition");
    String[] parts = contentDisposition.split(";");
    for (String partItem : parts) {
        if (partItem.trim().startsWith("filename")) {
            return partItem.substring(partItem.indexOf('=') + 1).trim().replace("\"", "");
        }
    }
    return null;
}

String username = request.getParameter("username");
String phone = request.getParameter("phone");
String email = request.getParameter("email");
String password = request.getParameter("password");

// Get the current user ID from the session
int userId = (int) session.getAttribute("sessUserID");

try {
    Part filePart = request.getPart("photo"); // Assuming the file input element has name="photo"

    // Get the filename and input stream of the photo
    String photoFilename = getFilename(filePart);
    InputStream photoInputStream = filePart.getInputStream();

    // Step 1: Load JDBC Driver
    Class.forName("com.mysql.jdbc.Driver");

    // Step 2: Define Connection URL
    String connURL = "jdbc:mysql://localhost/javaassignment?user=root&password=root1234&serverTimezone=UTC";

    // Step 3: Establish connection to URL
    Connection conn = DriverManager.getConnection(connURL);

    // Step 4: Create a PreparedStatement for updating the profile information
    String sql = "UPDATE user SET username=?, phone=?, email=?, password=? WHERE id=?";
    PreparedStatement pstmt = conn.prepareStatement(sql);

    // Step 5: Set parameter values for profile information
    pstmt.setString(1, username);
    pstmt.setString(2, phone);
    pstmt.setString(3, email);
    pstmt.setString(4, password);
    pstmt.setInt(5, userId);

    // Step 6: Execute the profile information UPDATE query
    int rowsAffected = pstmt.executeUpdate();

    // Step 7: Close the PreparedStatement
    pstmt.close();

    // Step 8: Check if profile information update was successful
    if (rowsAffected > 0) {
        // Profile information updated successfully
        // Proceed to update the profile photo if a file was uploaded
        if (photoInputStream != null) {
            // Create a new PreparedStatement for updating the profile photo
            sql = "UPDATE user SET image=? WHERE id=?";
            pstmt = conn.prepareStatement(sql);

            // Set parameter values for the profile photo update
            pstmt.setBinaryStream(1, photoInputStream);
            pstmt.setInt(2, userId);

            // Execute the profile photo UPDATE query
            pstmt.executeUpdate();

            // Close the PreparedStatement
            pstmt.close();
        }

        // Close the database connection
        conn.close();

        // Redirect to the profile page with a success message
        response.sendRedirect("Profile.jsp?msgCode=successUpdate");
    } else {
        // Error occurred during profile information update
        // Close the database connection
        conn.close();

        // Redirect to an error page
        response.sendRedirect("Profile.jsp?msgCode=updateError");
    }
} catch (Exception e) {
    e.printStackTrace();

    // Redirect to an error page
    response.sendRedirect("Profile.jsp?msgCode=updateError");
}
%>
