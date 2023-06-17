<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.io.InputStream, java.io.OutputStream, java.io.FileOutputStream" %>
<%@ page import="javax.servlet.http.Part" %>
<%@ page import="javax.servlet.annotation.MultipartConfig" %>
<%@ page import="java.sql.*" %>

<%@ page import="java.sql.*" %>
<%@ page import="java.io.IOException" %>
<% 
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
                 maxFileSize = 1024 * 1024 * 10, // 10MB
                 maxRequestSize = 1024 * 1024 * 50) // 50MB
public class VerifyUpdateProfile extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve the uploaded image file
        Part filePart = request.getPart("fileInput");

        // Generate a unique file name for the uploaded image
        String fileName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();

        // Specify the path where the image will be saved
        String uploadPath = getServletContext().getRealPath("../UserProfiles/") + fileName;

        // Save the image file to the specified path
        try (InputStream inputStream = filePart.getInputStream();
             OutputStream outputStream = new FileOutputStream(uploadPath)) {
            byte[] buffer = new byte[4096];
            int bytesRead;
            while ((bytesRead = inputStream.read(buffer)) != -1) {
                outputStream.write(buffer, 0, bytesRead);
            }
        }

        // Assuming you have obtained the updated values from the form data
        String username = request.getParameter("username");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String image = "../UserProfiles/" + fileName;

        // Get the current user ID from the session
        int userId = (int) request.getSession().getAttribute("sessUserID");

        try {
            // Step 1: Load JDBC Driver
            Class.forName("com.mysql.jdbc.Driver");

            // Step 2: Define Connection URL
            String connURL = "jdbc:mysql://localhost/javaassignment?user=root&password=root1234&serverTimezone=UTC";

            // Step 3: Establish connection to URL
            Connection conn = DriverManager.getConnection(connURL);

            // Step 4: Create a PreparedStatement
            String sql = "UPDATE user SET username=?, phone=?, email=?, password=?, image=? WHERE id=?";
            PreparedStatement pstmt = conn.prepareStatement(sql);

            // Step 5: Set parameter values
            pstmt.setString(1, username);
            pstmt.setString(2, phone);
            pstmt.setString(3, email);
            pstmt.setString(4, password);
            pstmt.setString(5, image);
            pstmt.setInt(6, userId);

            // Step 6: Execute the UPDATE query
            int rowsAffected = pstmt.executeUpdate();

            // Step 7: Close resources
            pstmt.close();
            conn.close();

            // Check if the update was successful
            if (rowsAffected > 0) {
                // Data updated successfully
                response.sendRedirect(response.encodeRedirectURL("ProfileTest.jsp?msgCode=successUpdate"));
                // Redirect to the profile page
            } else {
                // Error occurred during update
                response.sendRedirect(response.encodeRedirectURL("ProfileTest.jsp?msgCode=updateError"));
                // Redirect to an error page
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(response.encodeRedirectURL("ProfileTest.jsp?msgCode=updateError"));
            // Redirect to an error page
        }
}
%>
