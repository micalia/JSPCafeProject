<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="boards.Boards" %>
<%@ page import="boards.Board_ids" %>

<%@ include file="../inc/main.jsp" %>

<%
	int b_id = 0;
	if(request.getParameter("id")!=null){
		b_id = Integer.parseInt(request.getParameter("id"));
	}
	if(b_id == 0){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 글입니다.')");
		script.println("location.href = '../home.jsp'");
		script.println("</script>");
	}
	
	Boards boards = boardsDAO.show(b_id);
	if(session.getAttribute("nick") != null){
	if(!session.getAttribute("nick").equals(boards.getNick()))boardsDAO.hitUp(b_id);
	}else{
		boardsDAO.hitUp(b_id);
	}
	%>
	<style>
	.board-box-line-dashed{
	    border-bottom-style: dashed;
	    border-bottom-width: 1px;
        opacity: 0.7;
	}
	.boardContent{
		padding: 0px 43px;
		margin-top: 20px;
	}
	</style>
	<div class = "content-border" style="padding:14px;">
 
   <b><%= boards.getSubject() %></b> &nbsp;
    <span style="color:gray;">|</span>&nbsp; 
    <%= boards.getBoardName() %>
    <div style="float:right;font-size:14px;color:#666;padding-top:1px;"><%= boards.getUploadDate().substring(0, 16).replace("-", ".") %></div>

    <div class = "board-box-line-dashed" style="margin-top:3px;"></div>
      <div style="padding-top:8px;">
      <img src="<%=request.getContextPath()%>/img/profile.jpg" style="border: none;width: 24px; height: 24px; float:left; border-radius:50%;margin-right:4px;"class="profileImg"><b><%= boards.getNick() %>(<%= boards.getUser_id().substring(4) %>****)</b>
      </div>
    <div class="boardContent">
    <%= boards.getContent() %>
    </div>
    </div>
    
    <script>
    var i, frames;
    frames = document.getElementsByTagName("iframe");
    for (i = 0; i < frames.length; ++i)
    {
          // The iFrame
        if (!frames[i].hasAttribute("allowfullscreen")) {
            frames[i].setAttribute('allowFullScreen', '')
        }
    }
    </script>
<%@ include file="../inc/footer.jsp" %>