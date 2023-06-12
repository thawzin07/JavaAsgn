<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    // Invalidate the session
    request.getSession().invalidate();

    // Redirect to Login2.jsp
    response.sendRedirect("Login2.jsp");
%>
