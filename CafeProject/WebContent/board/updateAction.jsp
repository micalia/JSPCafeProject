<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="boards.BoardsDAO" %>
<%@ page import="boards.Boards" %>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<% request.setCharacterEncoding("UTF-8"); %>
	<%	
		String id = null;
		if (session.getAttribute("id") != null){
			id = (String) session.getAttribute("id");
		}
		if(id == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href = '../member/login.jsp'");
			script.println("</script>");
		}
		int b_id = 0;
		if(request.getParameter("id")!=null){
			b_id = Integer.parseInt(request.getParameter("id"));
		}
		if(b_id == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href = 'list.jsp'");
			script.println("</script>");
		}
		int board_id = 0;
		if(request.getParameter("board_id")!=null){
			board_id = Integer.parseInt(request.getParameter("board_id"));
		}
		 Boards boards = new BoardsDAO().show(b_id);
		 if (!id.equals(boards.getUser_id())){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href = 'list.jsp'");
			script.println("</script>");
		}else{
			if (request.getParameter("board_id") == null || request.getParameter("subject") == null || request.getParameter("content") == null
					|| request.getParameter("board_id").equals("") || request.getParameter("subject").equals("") || request.getParameter("content").equals("")){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('입력이 안 된 사항이 있습니다.')");
					script.println("history.back()");
					script.println("</script>");
				}else{
					BoardsDAO boardsDAO= new BoardsDAO();
					int result = boardsDAO.update(board_id, request.getParameter("subject"), request.getParameter("content"), b_id);
					if(result == -1){
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('글 수정에 실패했습니다.')");
						script.println("history.back()");
						script.println("</script>");
					}
					else{
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("location.href = 'view.jsp?board_id=" + board_id + "&id=" + b_id +"'");
						script.println("</script>");
					}
				}
		
		}
		
	%>
	</body>
</html>