<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="boards.BoardsDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8");  %>
<jsp:useBean id="board_ids" class="boards.Board_ids" scope="page" />
<jsp:setProperty name="board_ids" property="boardName" />
<% 

if(board_ids.getBoardName() == null)
{
PrintWriter script = response.getWriter();
script.println("<script>");
script.println("alert('입력이 안 된 사항이 있습니다.')");
script.println("history.back()");
script.println("</script>");
if(true) return;
}
BoardsDAO boardsDAO = new BoardsDAO();
int result = boardsDAO.insertMenu(board_ids);
if(result == -1){
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('예상치 못한 오류가 발생했습니다.')");
	script.println("history.back()");
	script.println("</script>");
}else{
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("location.href='ManageMenu.jsp'");
	script.println("</script>");
} 
%>