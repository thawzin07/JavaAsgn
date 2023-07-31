<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%--
    
Author             : Thet Htar San
Date                 : 24/05/2023
Copyright Notice     : NA
@(#)
Description         : JavaAsgn
Admission no        : P2235077
Class             : DIT/FT/2A/03
--%>
<%
    // Invalidate the session
    request.getSession().invalidate();

    // Redirect to Login2.jsp
    response.sendRedirect("Login2.jsp");
%>
