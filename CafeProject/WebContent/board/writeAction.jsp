<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="users.UsersDAO" %>
<%@ page import="boards.BoardsDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="boards" class="boards.Boards" scope="page"/>
<jsp:setProperty name="boards" property="subject"/>
<jsp:setProperty name="boards" property="content"/>

	<%	
		int board_id = Integer.parseInt(request.getParameter("board_id"));

		String id = null;
		if (session.getAttribute("id") != null){
			id = (String) session.getAttribute("id");
		}
		String nick = null;
		if (session.getAttribute("nick") != null){
			nick = (String) session.getAttribute("nick");
		}
		if(id == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href = '../member/login.jsp'");
			script.println("</script>");
		}else{
			if (boards.getContent() == null || boards.getSubject() == null){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('입력이 안 된 사항이 있습니다.')");
					script.println("history.back()");
					script.println("</script>");
				}else{
					BoardsDAO boardsDAO= new BoardsDAO();
					int boardNum = boardsDAO.getNext();
					int result = boardsDAO.write(boardNum ,board_id, nick, id, boards.getSubject(), boards.getContent());
					if(result == -1){
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('글쓰기에 실패했습니다.')");
						script.println("history.back()");
						script.println("</script>");
					}
					else{
						UsersDAO usersDAO = new UsersDAO();
						usersDAO.writeCountUp(id);
						PrintWriter script = response.getWriter();
						String SboardNum = Integer.toString(boardNum);
						script.println("<script>");
						script.println("location.href = './view.jsp?id=" + SboardNum + "'");
						script.println("</script>");
					}  
				}
		
		}  
		
	%>