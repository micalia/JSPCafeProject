<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
   	String Host = "jdbc:mysql://localhost:3306/t2";
	Connection connection = null;
	Statement statement = null;
	ResultSet rs = null;
	Class.forName("com.mysql.jdbc.Driver");
	connection = DriverManager.getConnection(Host, "root", "");
	statement = connection.createStatement();
	PreparedStatement ps=null;
%>
