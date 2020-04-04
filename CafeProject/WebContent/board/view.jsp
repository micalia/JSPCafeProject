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
	String board_id = request.getParameter("board_id");
	%>
	<style>
	.board-box-line-dashed{
	    border-bottom-style: dashed;
	    border-bottom-width: 1px;
        opacity: 0.7;
        clear:both;
	}
	.boardContent{
		padding: 0px 43px;
		margin-top: 20px;
	}
	.viewButton{
		margin-top:13px;
		padding: 7px 14px;
		color: black; 
		border-radius: 0px; 
		border:1px solid #a8a8a8;
		float:right;
	}
	#writerProfile{
		border: none;
		width: 24px; 
		height: 24px; 
		float:left; 
		border-radius:50%;
		margin-right:4px;
	}
	#subjectTable{
		width:auto;
		float:left;
	}
	#subjectTable td{
		padding: 2px 3px;
	}
	.subjectBox{
		width:608px;
		overflow:hidden;
		height:auto;
		float:left;
	}
	.subjectBar{
		width:100%;
	}
	</style>
	<div class = "content-border" style="padding:14px;">
	<div class="subjectBar">
	<div class="subjectBox">
 <table id="subjectTable">
   <tr>
   <td>
   <b><%= boards.getSubject() %></b>
    </td>
    <td><span style="color:gray;">|</span></td>
    <td style="white-space:nowrap;"><%= boards.getBoardName() %></td>
    </tr>
    </table>
    </div>
    <div style="float:right;font-size:14px;color:#666;padding-top:1px;"><%= boards.getUploadDate().substring(0, 16).replace("-", ".") %></div>
</div>
    <div class = "board-box-line-dashed" style="margin-top:3px;"></div>
      <div style="padding-top:8px;">
      <img src="<%=request.getContextPath()%>/img/profile.jpg" id="writerProfile" class="profileImg"><b><%= boards.getNick() %>(<%= boards.getUser_id().substring(0,4) %>****)</b>
      </div>
    <div class="boardContent">
    <%= boards.getContent() %>
    </div>
    </div>
   <button class="btn btn-sm viewButton" onclick="location.href='list.jsp<%if(board_id != null || request.getParameter("page") != null){ %>?<%}if(board_id != null){ %>board_id=<%=request.getParameter("board_id") %><%} if(request.getParameter("page") != null){%>&page=<%= request.getParameter("page") %><%}%>'">목록</button>
    <% if (id.equals(boards.getUser_id())){ %>
    <button class="btn btn-sm viewButton" onclick="location.href='update.jsp?<%if(board_id != null){ %>board_id=<%=request.getParameter("board_id") %>&<%} %>id=<%= request.getParameter("id") %>'" style="margin-right:5px;">수정</button>
   <% } %>
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