<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.lang.Math" %>
<%
double a = 483/15.0;
out.println(a+"<br>");
double pageCount = (double)Math.ceil(483 / 15.0);

out.println(pageCount);
int a2 = (int)Math.round(pageCount);
out.println(a2);
%>