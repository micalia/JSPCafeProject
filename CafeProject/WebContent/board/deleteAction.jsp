<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="users.UsersDAO" %>
<%@ page import="boards.BoardsDAO" %>
<%@ page import="boards.Boards" %>
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
		int level = 1;
		if (session.getAttribute("level") != null){
			level = (int) session.getAttribute("level");
		}
		if(id == null){%>
			<script>
			alert('로그인을 하세요');
			location.href = '../member/login.jsp';
			</script>");
		<%}
		int b_id = 0;
		if(request.getParameter("id")!=null){
			b_id = Integer.parseInt(request.getParameter("id"));
		}
		if(b_id == 0){%>
			<script>
			alert('유효하지 않은 글입니다.');
			location.href = 'list.jsp';
			</script>
			
			<%
		}else{
			
		}
		String b_page = request.getParameter("page");
		String board_id = request.getParameter("board_id");
		
		Boards boards = new BoardsDAO().show(b_id);
		int result = -1;
		if(id != null){
		if (id.equals(boards.getUser_id()) || level > 17){//level 18 이상부터 모든 게시물 삭제권한 부여
				BoardsDAO boardsDAO= new BoardsDAO();
				UsersDAO usersDAO = new UsersDAO();
				
				result = usersDAO.writeCountDown(b_id);
				if(result == -1){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글 삭제에 실패했습니다.')");
					script.println("history.back()");
					script.println("</script>");
					if(true)return;
				}
				result = boardsDAO.delete(b_id);
				if(result == -1){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글 삭제에 실패했습니다.')");
					script.println("history.back()");
					script.println("</script>");
					if(true)return;
				}
				else{
				%> 
				<script>
				location.href="list.jsp<%if(board_id != null || b_page != null){ %>?<%}if(board_id != null){ %>board_id=<%=board_id %><%} if(board_id != null && b_page != null){%>&<%}if(b_page != null){%>page=<%= b_page %><%}%>";
				</script>	
			<%	}
		}else{			
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href = 'list.jsp'");
			script.println("</script>");
			if(true)return;
						
		}
		} 
	%> 
	
</body>
</html>