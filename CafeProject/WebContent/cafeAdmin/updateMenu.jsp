<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="boards.BoardsDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="org.json.simple.JSONObject"%>
<% request.setCharacterEncoding("UTF-8");  %>
<% 
int board_id = Integer.parseInt(request.getParameter("board_id"));
 BoardsDAO boardsDAO = new BoardsDAO();

int result = boardsDAO.updateMenu(board_id, request.getParameter("boardName"));
if(result == -1){
	JSONObject json = new JSONObject();
	json.put("error", "예상치 못한 오류가 발생했습니다.");
	response.setCharacterEncoding("UTF-8");
	response.setContentType("application/json");
	out.print(json.toJSONString());
}else{
	JSONObject json = new JSONObject();
	json.put("status", true);
	json.put("message", "카테고리를 수정했습니다.");
	response.setCharacterEncoding("UTF-8");
	response.setContentType("application/json");
	out.print(json.toJSONString());
} 
%>