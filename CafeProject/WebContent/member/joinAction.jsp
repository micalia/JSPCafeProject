<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="users.UsersDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); 
String year = request.getParameter("year");
String month = request.getParameter("month");
String date = request.getParameter("date");
String born = year + "_" + month + "_" + date;

String nationNo = request.getParameter("nationNo");
String phone = request.getParameter("phone");
String phoneInfo = nationNo + "_" +phone;
%>
<jsp:useBean id="users" class="users.Users" scope="page" />
<jsp:setProperty name="users" property="id" />
<jsp:setProperty name="users" property="password" />
<jsp:setProperty name="users" property="nick" />
<jsp:setProperty name="users" property="born" value="<%= born %>"/>
<jsp:setProperty name="users" property="gender" />
<jsp:setProperty name="users" property="email" />
<jsp:setProperty name="users" property="phone" value="<%= phoneInfo %>" />
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%

	if(users.getId() == null || users.getPassword() == null || users.getNick() == null || users.getBorn() == null 
			|| users.getGender() == null || users.getPhone() == null)
	{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력이 안 된 사항이 있습니다.')");
		script.println("history.back()");
		script.println("</script>");
	}
	
	UsersDAO usersDAO = new UsersDAO();
	if(users.getEmail() != null){
		int result = usersDAO.join(users);
		if(result == -1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('예상치 못한 오류가 발생했습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}else{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href='../home.jsp'");
			script.println("</script>");
		}
	}else{
		int result = usersDAO.noEmailJoin(users);
		if(result == -1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('예상치 못한 오류가 발생했습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}else{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href='../home.jsp'");
			script.println("</script>");
		}
	}  
		
%>
</body>
</html>