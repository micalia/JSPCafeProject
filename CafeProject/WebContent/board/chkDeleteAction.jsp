<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="boards.BoardsDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<title>deleteAction</title>
</head>
<body>
<%
String id = null;
if (session.getAttribute("id") != null){
	id = (String) session.getAttribute("id");
}
if(id == null){ 
%>
	<script>
	alert('로그인을 하세요');
	location.href = '../member/login.jsp';
	</script>
<%
if(true) return;
}
int level = 1;
if (session.getAttribute("level") != null){
	level = (int) session.getAttribute("level");
}
if(level<17){
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('권한이 없습니다.');");
	script.println("history.back();");
	script.println("</script>");
	if(true) return;
}
String board_id = request.getParameter("board_id");
String b_page = request.getParameter("page");

if(request.getParameter("article_chk") == null ){
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('체크항목이 없습니다.');");
	script.println("history.back();");
	script.println("</script>");
	if(true) return;
}else{
	BoardsDAO boardsDAO = new BoardsDAO();
	String checkBoxes[] = request.getParameterValues("article_chk");
	int[] checkIntArr = new int[checkBoxes.length];
	for(int i=0; i<checkBoxes.length; i++){
		checkIntArr[i] = Integer.parseInt(checkBoxes[i]);
	} 
	
	for(int i=0;i<checkIntArr.length;i++) {
		int result = boardsDAO.delete(checkIntArr[i]);
		if(result == -1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('글 삭제에 실패했습니다.')");
			script.println("history.back()");
			script.println("</script>");
			if(true) return;
		}	
	} 
	
	%> 
	<script>
	location.href="list.jsp<%if(board_id != null || b_page != null){ %>?<%}if(board_id != null){ %>board_id=<%=board_id %><%} if(board_id != null && b_page != null){%>&<%}if(b_page != null){%>page=<%= b_page %><%}%>";
	</script>
	<%
}
	%> 
	
</body>
</html>