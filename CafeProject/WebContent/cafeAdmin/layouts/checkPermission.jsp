<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title></title>
</head>
<body>
<%
		String id = null;
	if (session.getAttribute("id") != null){
		id = (String) session.getAttribute("id");
	}
	String nick = null;
	if (session.getAttribute("nick") != null){
		nick = (String) session.getAttribute("nick");
	}
	int level = 1;
	if (session.getAttribute("level") != null){
		level = (int) session.getAttribute("level");
	}
	if(id == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('권한이 없습니다.')");
		script.println("location.href = '../home.jsp'");
		script.println("</script>");
	}
	%>
	
<% if(level < 10){  %>
<script>
alert('권한이 없습니다');
window.location = "/";
</script>
<% } %>

