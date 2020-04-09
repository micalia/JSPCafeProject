<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="boards.Boards" %>
<%@ page import="boards.Board_ids" %>
<%@ page import="boards.Reply" %>

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
		margin-top:11px;
		padding: 7px 14px;
		color: black; 
		border-radius: 0px; 
		border:1px solid #a8a8a8;
		float:right;
	}
	.submitReplyBtn{
		padding: 22px 29px;
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
	.replyContainer{
		width:100%;
		border-left:1px solid black;
		border-right:1px solid black;
		border-bottom:1px solid black;
		padding:11px 26px 16px 24px;
	}
	#comment_text{
    line-height: 14px;
    height: 41px;
	}
	

   #contact-form textarea {
  border: 1px solid black;
  overflow: hidden; /*overflow is set to auto at max height using JS */
  font-family:sans-serif;
  outline: none;
  min-height:62.8px;
  max-height:350px;
  height: auto;
  resize: none;
  width:100%;
      line-height: 19px;
}
.replyStyle{
	padding: 5px 0px;
}
.replyDelete{
	color:#696969;
	float:right;
	font-size:14px;
}
.replyDelete:hover{
	cursor:pointer;
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

    <div class="replyContainer">
    <ul id="cmt_list">
    <div class="board-box-line-dashed" style="margin-top:3px;"></div>
    <% ArrayList<Reply> replyList = boardsDAO.getReply(b_id); 
 
    for(int i = 0; i < replyList.size(); i++){
    %>
    <li class="replyStyle">
    <b><%= replyList.get(i).getNick()%></b> <span style="color:#595959;"><%= replyList.get(i).getTime().substring(0, 16).replace("-", ".")%></span><span class="replyDelete" onclick="replyDelete(<%= replyList.get(i).getNum()%>)">삭제</span><br>
     <%= replyList.get(i).getReply()%>
     </li>
    <div class="board-box-line-dashed" style="margin-top:3px;"></div>
    <%} %>
    </ul>
    <table>
    <tr>
	    <td style="width:706px;">
			    <div id="contact-form" >
			   <textarea rows="1" id="message" class="form-control" style="height:62.8px;"spellcheck="false"></textarea>
				</div>
		</td>
	    <td style="padding-bottom:15px;vertical-align:bottom;">
	    <script>
	   function replySubmit(){
	         var reply=$("#message").val();
	           $.ajax({
	                       url: "replyInsertAction.jsp?b_id=<%=b_id%>",
	                       type: 'GET',
	                       data: {
	                               'reply':reply
	                           },
	                       success: function (data) {
	                    		   $("#cmt_list").empty();
	                    		   $("#cmt_list").append("<div class='board-box-line-dashed' style='margin-top:3px;'></div>");
	                    	   for(var i=0; i<data.jreply.length; i++){
	                    		   $("#cmt_list").append("<li class='replyStyle'><b>" + data.jreply[i].nick + "</b> <span style='color:#595959;'>" + data.jreply[i].time + "</span><span class='replyDelete' onclick='replyDelete(" + data.jreply[i].num + ")'>삭제</span><br>" + data.jreply[i].reply + "</li><div class='board-box-line-dashed' style='margin-top:3px;'></div>");
	                    	   }
	                       },
	                       error: function (data) {
	                           alert(data.responseText);
	                       }
	                   });
	       }
   </script>
	    	<input type="button" class="btn btn-sm viewButton submitReplyBtn" onclick="replySubmit()" value="등록">
	    </td>
    </tr>
    </table>
    </div>
   <button class="btn btn-sm viewButton" onclick="location.href='list.jsp<%if(board_id != null || request.getParameter("page") != null){ %>?<%}if(board_id != null){ %>board_id=<%=request.getParameter("board_id") %><%} if(board_id != null && request.getParameter("page") != null){%>&<%}if(request.getParameter("page") != null){%>page=<%= request.getParameter("page") %><%}%>'">목록</button>
    <%if (id.equals(boards.getUser_id()) || level > 17){//level 18 이상부터 모든 게시물 삭제권한 부여
    %>
    	<button class="btn btn-sm viewButton" onclick="if(confirm('게시글을 삭제하시겠습니까?')){location.href='deleteAction.jsp?<%if(board_id != null){ %>board_id=<%=request.getParameter("board_id") %><%} if(board_id != null && request.getParameter("page") != null){%>&<%}if(request.getParameter("page") != null){%>page=<%=request.getParameter("page") %><%}if(board_id != null || request.getParameter("page") != null){ %>&<%} %>id=<%=request.getParameter("id") %>';}" style="margin-right:5px;">삭제</button>
    	<%} %>
    <% if(id != null){ if (id.equals(boards.getUser_id())){ %>
    
    <button class="btn btn-sm viewButton" onclick="location.href='update.jsp?<%if(board_id != null){ %>board_id=<%=request.getParameter("board_id") %>&<%} %>id=<%= request.getParameter("id") %>'" style="margin-right:5px;">수정</button>
   <% } }%>
   
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
    $('#contact-form').on( 'change keydown keyup paste cut', 'textarea', function () {  
    	  $(this).height(0).height(this.scrollHeight+2);
    	  if ($(this).height() >= 300) {
    	    $('textarea#message').css("overflow", "auto");
    	  }
    	  else {
    	    $('textarea#message').css("overflow", "hidden");
    	  }
    	}).find('textarea#message').change();
    
   function replyDelete(reply_num){
        	 $.ajax({
                    url: "deleteReply.jsp?b_id=<%=b_id%>",
                    type: 'GET',
                    data: {
                    		'reply_num':reply_num,
                        },
                    success: function (data) {
                    	$("#cmt_list").empty();
                    	$("#cmt_list").append("<div class='board-box-line-dashed' style='margin-top:3px;'></div>");
                 	   for(var i=0; i<data.jreply.length; i++){
                 		  $("#cmt_list").append("<li class='replyStyle'><b>" + data.jreply[i].nick + "</b> <span style='color:#595959;'>" + data.jreply[i].time + "</span><span class='replyDelete' onclick='replyDelete(" + data.jreply[i].num + ")'>삭제</span><br>" + data.jreply[i].reply + "</li><div class='board-box-line-dashed' style='margin-top:3px;'></div>");
                 	   }
                    },
                    error: function (data) {
                        alert(data.responseText);
                    }
                }); 
    }
    </script>
    
    
<%@ include file="../inc/footer.jsp" %>