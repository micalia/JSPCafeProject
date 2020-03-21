<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="users.UsersDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="users" class="users.Users" scope="page"/>
<jsp:setProperty name="users" property="id"/>
<jsp:setProperty name="users" property="password"/>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("id") != null){
			userID = (String) session.getAttribute("id");
		}
		if(userID != null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 로그인이 되어있습니다.')");
			script.println("location.href = '../home.jsp'");
			script.println("</script>");
		}
		
		UsersDAO usersDAO= new UsersDAO();
		int result = usersDAO.login(users.getId(), users.getPassword());
		int level = usersDAO.getLevel(users.getId());
		
		if(result == -1 || level == -1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('존재하지 않는 아이디입니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else if(result == -2 || level == -2){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('데이터베이스 오류가 발생했습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else if(result ==1){
			session.setAttribute("nick", usersDAO.getNick(users.getId()));
			session.setAttribute("id", users.getId());
			session.setAttribute("level", level);
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = '../home.jsp'");
			script.println("</script>");
		}
		else if(result == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('비밀번호가 틀립니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		
	%>
</body>
</html>