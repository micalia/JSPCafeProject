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
		background-color:white;
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
		width:97%;
		margin:0 auto;
		padding:11px 24px 16px 22px;
		background-color:#f9f9f9;
		margin-bottom:12px;
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
.replyArrow{
	width:15px;
	height:9px;
	margin-left:8px;
}
.replyOfreply{
	font-size:13px;
	color:#696969;
}
.replyOfreply:hover{
	cursor:pointer;
}
	</style>
	<div class="contentContainer" style="border:1px solid black;">
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
    <% ArrayList<Reply> replyList = boardsDAO.getReply(b_id); 
 	
    	int a = -1;
    	int b = -1;
    for(int i = 0; i < replyList.size(); i++){
    	if(i%2 == 0){
    		a = replyList.get(i).getBundle();
    	}else{
    		b = replyList.get(i).getBundle();
    	}
    	 if(a == b){
    	 	if(replyList.get(i).getRec_user_id() != null){%>
    	 		<span style='color:#ff630f;margin-left:13px;float:left'><b>┖</b></span>
        		<li class="replyStyle" id="replyNum_<%= replyList.get(i).getNum()%>" data-replyText="off"style='float:right;width:742px;'>
    		    <b><%= replyList.get(i).getNick()%></b> <span style="color:#595959;"><%= replyList.get(i).getTime().substring(0, 16).replace("-", ".")%></span><img src="<%=request.getContextPath()%>/img/replyArrow.png" class="replyArrow"><span class="replyOfreply" id="rereply_<%= replyList.get(i).getNum()%>"onclick="replyOfreply(<%= replyList.get(i).getNum()%>, <%= replyList.get(i).getBundle()%>, '<%= replyList.get(i).getNick()%>', '<%= replyList.get(i).getUser_id()%>')">답글</span><span class="replyDelete" onclick="if(confirm('답글을 삭제하시겠습니까?')){replyDelete(<%= replyList.get(i).getNum()%>, <%= replyList.get(i).getBundle()%>);}">삭제</span><br>
    		     <span style="color:#828282;"><%= replyList.get(i).getRec_nick()%></span>&nbsp;&nbsp;<%= replyList.get(i).getReply()%>
    		     </li>		
    	 	<%}else{%>
    	 <span style='color:#ff630f;margin-left:13px;float:left'><b>┖</b></span>
    		<li class="replyStyle" id="replyNum_<%= replyList.get(i).getNum()%>" data-replyText="off"style='float:right;width:742px;'>
		    <b><%= replyList.get(i).getNick()%></b> <span style="color:#595959;"><%= replyList.get(i).getTime().substring(0, 16).replace("-", ".")%></span><img src="<%=request.getContextPath()%>/img/replyArrow.png" class="replyArrow"><span class="replyOfreply" id="rereply_<%= replyList.get(i).getNum()%>"onclick="replyOfreply(<%= replyList.get(i).getNum()%>, <%= replyList.get(i).getBundle()%>, '<%= replyList.get(i).getNick()%>', '<%= replyList.get(i).getUser_id()%>')">답글</span><span class="replyDelete" onclick="if(confirm('답글을 삭제하시겠습니까?')){replyDelete(<%= replyList.get(i).getNum()%>, <%= replyList.get(i).getBundle()%>);}">삭제</span><br>
		     <%= replyList.get(i).getReply()%>
		     </li>
    	 		
    	 	<%}
    	 %>
    	 
    	<%}else{
    			if(replyList.get(i).getUser_id().equals("none")){%>
    			<li class="replyStyle" id="replyNum_<%= replyList.get(i).getNum()%>" data-replyText="off">삭제된 댓글입니다.</li>
    			
    			<%}else{%>
    				<li class="replyStyle" id="replyNum_<%= replyList.get(i).getNum()%>" data-replyText="off">
    			    <b><%= replyList.get(i).getNick()%></b> <span style="color:#595959;"><%= replyList.get(i).getTime().substring(0, 16).replace("-", ".")%></span><img src="<%=request.getContextPath()%>/img/replyArrow.png" class="replyArrow"><span class="replyOfreply" id="rereply_<%= replyList.get(i).getNum()%>"onclick="replyOfreply(<%= replyList.get(i).getNum()%>, <%= replyList.get(i).getBundle()%>)">답글</span><span class="replyDelete" onclick="if(confirm('댓글을 삭제하시겠습니까?')){replyDelete(<%= replyList.get(i).getNum()%>,<%= replyList.get(i).getBundle()%>);}">삭제</span><br>
    			     <%= replyList.get(i).getReply()%>
    			     </li>
    			<%}%>
		    
    	<%} 
    %>
    <div class="board-box-line-dashed" style="margin-top:3px;"></div>
    <%} %>
    </ul>
    <table>
    <tr>
	    <td style="width:706px;padding-right:0px;">
			    <div id="contact-form" >
			   <textarea rows="1" id="message" class="form-control" style="height:62.8px;"spellcheck="false"></textarea>
				</div>
		</td>
	    <td style="padding-bottom:15px;vertical-align:bottom;padding-right:0px;">
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
	                    	   document.getElementById("message").value='';	                    	   
	                    		   $("#cmt_list").empty();
	                    		   var a, b;
		                    	   for(var i=0; i<data.jreply.length; i++){
		                    		 if(i%2 == 0){
		                    			 a = data.jreply[i].bundle;
		                    		 }else{
		                    			 b = data.jreply[i].bundle;
		                    		 }
		                    		 
	 									if(a == b){
	 										if(data.jreply[i].rec_nick != null){
	 											$("#cmt_list").append("<span style='color:#ff630f;margin-left:13px;float:left'><b>┖</b></span><li class='replyStyle' id='replyNum_"+ data.jreply[i].num +"' data-replyText='off'style='float:right;width:742px;'><b>" + data.jreply[i].nick + "</b> <span style='color:#595959;'>" + data.jreply[i].time + "</span><img src='<%=request.getContextPath()%>/img/replyArrow.png' class='replyArrow'><span class='replyOfreply' id='rereply_"+ data.jreply[i].num +"' onclick='replyOfreply("+ data.jreply[i].num +"," + data.jreply[i].bundle + ",\"" + data.jreply[i].nick + "\",\"" + data.jreply[i].user_id + "\")'>답글</span><span class='replyDelete' onclick='if(confirm(\"답글을 삭제하시겠습니까?\")){replyDelete(" + data.jreply[i].num + "," + data.jreply[i].bundle + ");}'>삭제</span><br> <span style='color:#828282;'>" + data.jreply[i].rec_nick + "</span>&nbsp;&nbsp;" + data.jreply[i].reply + "</li><div class='board-box-line-dashed' style='margin-top:3px;'></div>");
	 										}else{
	 										$("#cmt_list").append("<span style='color:#ff630f;margin-left:13px;float:left'><b>┖</b></span><li class='replyStyle' id='replyNum_"+ data.jreply[i].num +"' data-replyText='off'style='float:right;width:742px;'><b>" + data.jreply[i].nick + "</b> <span style='color:#595959;'>" + data.jreply[i].time + "</span><img src='<%=request.getContextPath()%>/img/replyArrow.png' class='replyArrow'><span class='replyOfreply' id='rereply_"+ data.jreply[i].num +"' onclick='replyOfreply("+ data.jreply[i].num +"," + data.jreply[i].bundle + ",\"" + data.jreply[i].nick + "\",\"" + data.jreply[i].user_id + "\")'>답글</span><span class='replyDelete' onclick='if(confirm(\"답글을 삭제하시겠습니까?\")){replyDelete(" + data.jreply[i].num + "," + data.jreply[i].bundle + ");}'>삭제</span><br>" + data.jreply[i].reply + "</li><div class='board-box-line-dashed' style='margin-top:3px;'></div>");
	 										}
		                    		   }else{
		                    			   if(data.jreply[i].user_id == 'none'){
		                    				   $("#cmt_list").append("<li class='replyStyle' id='replyNum_"+ data.jreply[i].num +"' data-replyText='off'style=''>삭제된 댓글입니다.</li><div class='board-box-line-dashed' style='margin-top:3px;'></div>");
		                    			   }else{
		                    		   			$("#cmt_list").append("<li class='replyStyle' id='replyNum_"+ data.jreply[i].num +"' data-replyText='off'style=''><b>" + data.jreply[i].nick + "</b> <span style='color:#595959;'>" + data.jreply[i].time + "</span><img src='<%=request.getContextPath()%>/img/replyArrow.png' class='replyArrow'><span class='replyOfreply' id='rereply_"+ data.jreply[i].num +"' onclick='replyOfreply("+ data.jreply[i].num +"," + data.jreply[i].bundle + ")'>답글</span><span class='replyDelete' onclick='if(confirm(\"댓글을 삭제하시겠습니까?\")){replyDelete(" + data.jreply[i].num + "," + data.jreply[i].bundle + ");}'>삭제</span><br>" + data.jreply[i].reply + "</li><div class='board-box-line-dashed' style='margin-top:3px;'></div>");
		                    				   
		                    			   }
		                    		   }
	                    		   }
	                       },
	                       error: function (data) {
	                           alert(data.responseText);
	                       }
	                   });
	       }
	   
	   function rereplySubmit(){
	        var rereply=$("#rerepleText").val();
	        var bundleData=$("#bundleData").val();
	        var rec_nick=$("#rec_nick").val();
	        var rec_id=$("#rec_id").val();
	           $.ajax({
	                       url: "replyInsertAction.jsp?b_id=<%=b_id%>",
	                       type: 'GET',
	                       data: {
	                               'rereply':rereply,
	                               'bundleData' :bundleData,
	                               'rec_nick':rec_nick,
	                               'rec_id':rec_id
	                           },
	                       success: function (data) {
	                    	   document.getElementById("message").value='';	                    	   
	                    		   $("#cmt_list").empty();
	                    		   var a, b;
	                    	   for(var i=0; i<data.jreply.length; i++){
	                    		 if(i%2 == 0){
	                    			 a = data.jreply[i].bundle;
	                    		 }else{
	                    			 b = data.jreply[i].bundle;
	                    		 }
	                    		 
	                    		 if(a == b){
										if(data.jreply[i].rec_nick != null){
											$("#cmt_list").append("<span style='color:#ff630f;margin-left:13px;float:left'><b>┖</b></span><li class='replyStyle' id='replyNum_"+ data.jreply[i].num +"' data-replyText='off'style='float:right;width:742px;'><b>" + data.jreply[i].nick + "</b> <span style='color:#595959;'>" + data.jreply[i].time + "</span><img src='<%=request.getContextPath()%>/img/replyArrow.png' class='replyArrow'><span class='replyOfreply' id='rereply_"+ data.jreply[i].num +"' onclick='replyOfreply("+ data.jreply[i].num +"," + data.jreply[i].bundle + ",\"" + data.jreply[i].nick + "\",\"" + data.jreply[i].user_id + "\")'>답글</span><span class='replyDelete' onclick='if(confirm(\"답글을 삭제하시겠습니까?\")){replyDelete(" + data.jreply[i].num + "," + data.jreply[i].bundle + ");}'>삭제</span><br> <span style='color:#828282;'>" + data.jreply[i].rec_nick + "</span>&nbsp;&nbsp;" + data.jreply[i].reply + "</li><div class='board-box-line-dashed' style='margin-top:3px;'></div>");
 										}else{
 										$("#cmt_list").append("<span style='color:#ff630f;margin-left:13px;float:left'><b>┖</b></span><li class='replyStyle' id='replyNum_"+ data.jreply[i].num +"' data-replyText='off'style='float:right;width:742px;'><b>" + data.jreply[i].nick + "</b> <span style='color:#595959;'>" + data.jreply[i].time + "</span><img src='<%=request.getContextPath()%>/img/replyArrow.png' class='replyArrow'><span class='replyOfreply' id='rereply_"+ data.jreply[i].num +"' onclick='replyOfreply("+ data.jreply[i].num +"," + data.jreply[i].bundle + ",\"" + data.jreply[i].nick + "\",\"" + data.jreply[i].user_id + "\")'>답글</span><span class='replyDelete' onclick='if(confirm(\"답글을 삭제하시겠습니까?\")){replyDelete(" + data.jreply[i].num + "," + data.jreply[i].bundle + ");}'>삭제</span><br>" + data.jreply[i].reply + "</li><div class='board-box-line-dashed' style='margin-top:3px;'></div>");
 										}
	                    		   }else{
	                    			   if(data.jreply[i].user_id == 'none'){
	                    				   $("#cmt_list").append("<li class='replyStyle' id='replyNum_"+ data.jreply[i].num +"' data-replyText='off'style=''>삭제된 댓글입니다.</li><div class='board-box-line-dashed' style='margin-top:3px;'></div>");
	                    			   }else{
	                    				   $("#cmt_list").append("<li class='replyStyle' id='replyNum_"+ data.jreply[i].num +"' data-replyText='off'style=''><b>" + data.jreply[i].nick + "</b> <span style='color:#595959;'>" + data.jreply[i].time + "</span><img src='<%=request.getContextPath()%>/img/replyArrow.png' class='replyArrow'><span class='replyOfreply' id='rereply_"+ data.jreply[i].num +"' onclick='replyOfreply("+ data.jreply[i].num +"," + data.jreply[i].bundle + ")'>답글</span><span class='replyDelete' onclick='if(confirm(\"댓글을 삭제하시겠습니까?\")){replyDelete(" + data.jreply[i].num + "," + data.jreply[i].bundle + ");}'>삭제</span><br>" + data.jreply[i].reply + "</li><div class='board-box-line-dashed' style='margin-top:3px;'></div>");
	                    				   
	                    			   }
	                    		   }
                    		   }
	                       },
	                       error: function (data) {
	                           alert(data.responseText);
	                       }
	                   }); 
	       }
	   
	   function replyOfreply(num, bundle, nick, rec_id){
		  var confirm = "#replyNum_" + num;
		  var rereplyNum = "rereply_" + num;
		  
		   //alert(confirm);
		   //alert(document.getElementById('replyNum_29').dataset.replyText);
		   var data_confirm = $(confirm).attr("data-replyText");
		   //$('.replyStyle').find('.replyOfreply').text("할로");
		    if (data_confirm == "off"){
			  
			   $('.replyStyle').each(function(index, item){
				 if($(item).attr("data-replyText") == "on"){
					 $(item).attr("data-replyText", "off");
					 $(item).find('.replyOfreply').text("답글");
					$('#replyBox').remove();
				 }
			  });
			   $(confirm).attr("data-replyText","on");
			   document.getElementById(rereplyNum).innerHTML = "답글취소";
			   if(nick != null){
		   $("<div id='replyBox'><div class='board-box-line-dashed' style='margin-top:3px;'></div><li class='replyStyle'><table><tr><td style='width:697px;padding-right:0px;'><div id='contact-form'><span style='color:#ff630f;margin-left:13px;'><b>┖</b></span> \n" +
		   "<textarea rows='1' id='rerepleText' class='form-control' style='height:62.8px;float:right;width:650px;' spellcheck='false' placeholder='" + nick + "님께 답글쓰기'></textarea></div></td>\n" +
		   "<td style='padding-bottom:15px;vertical-align:bottom;padding-right:0px;'><input type='hidden' id='bundleData' value='" + bundle + "'><input type='hidden' id='rec_nick' value='" + nick + "'><input type='hidden' id='rec_id' value='" + rec_id + "'><input type='button' class='btn btn-sm viewButton submitReplyBtn' onclick='rereplySubmit()' value='등록'></td></tr></table>"+
		   "</li></div>").insertAfter(confirm);
			   }else{
				   $("<div id='replyBox'><div class='board-box-line-dashed' style='margin-top:3px;'></div><li class='replyStyle'><table><tr><td style='width:697px;padding-right:0px;'><div id='contact-form'><span style='color:#ff630f;margin-left:13px;'><b>┖</b></span> \n" +
						   "<textarea rows='1' id='rerepleText' class='form-control' style='height:62.8px;float:right;width:650px;' spellcheck='false'></textarea></div></td>\n" +
						   "<td style='padding-bottom:15px;vertical-align:bottom;padding-right:0px;'><input type='hidden' id='bundleData' value='" + bundle + "'><input type='button' class='btn btn-sm viewButton submitReplyBtn' onclick='rereplySubmit()' value='등록'></td></tr></table>"+
						   "</li></div>").insertAfter(confirm);
			   }
		   }else{
			   $(confirm).attr("data-replyText","off");
			   document.getElementById(rereplyNum).innerHTML = "답글";
			   $('#replyBox').remove();
		   }  
	   }
   </script>
	    	<input type="button" class="btn btn-sm viewButton submitReplyBtn" onclick="replySubmit()" value="등록">
	    </td>
    </tr>
    </table>
    </div>
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
    
   function replyDelete(reply_num, bundle){
        	 $.ajax({
                    url: "deleteReply.jsp?b_id=<%=b_id%>",
                    type: 'GET',
                    data: {
                    		'reply_num':reply_num,
                    		'bundle':bundle
                        },
                    success: function (data) {
                    	$("#cmt_list").empty();
                    	var a, b;
                 	   for(var i=0; i<data.jreply.length; i++){
                 		  if(i%2 == 0){
                 			 a = data.jreply[i].bundle;
                 		 }else{
                 			 b = data.jreply[i].bundle;
                 		 }
                 		 
                 		if(a == b){
								if(data.jreply[i].rec_nick != null){
									$("#cmt_list").append("<span style='color:#ff630f;margin-left:13px;float:left'><b>┖</b></span><li class='replyStyle' id='replyNum_"+ data.jreply[i].num +"' data-replyText='off'style='float:right;width:742px;'><b>" + data.jreply[i].nick + "</b> <span style='color:#595959;'>" + data.jreply[i].time + "</span><img src='<%=request.getContextPath()%>/img/replyArrow.png' class='replyArrow'><span class='replyOfreply' id='rereply_"+ data.jreply[i].num +"' onclick='replyOfreply("+ data.jreply[i].num +"," + data.jreply[i].bundle + ",\"" + data.jreply[i].nick + "\",\"" + data.jreply[i].user_id + "\")'>답글</span><span class='replyDelete' onclick='if(confirm(\"답글을 삭제하시겠습니까?\")){replyDelete(" + data.jreply[i].num + "," + data.jreply[i].bundle + ");}'>삭제</span><br> <span style='color:#828282;'>" + data.jreply[i].rec_nick + "</span>&nbsp;&nbsp;" + data.jreply[i].reply + "</li><div class='board-box-line-dashed' style='margin-top:3px;'></div>");
									}else{
									$("#cmt_list").append("<span style='color:#ff630f;margin-left:13px;float:left'><b>┖</b></span><li class='replyStyle' id='replyNum_"+ data.jreply[i].num +"' data-replyText='off'style='float:right;width:742px;'><b>" + data.jreply[i].nick + "</b> <span style='color:#595959;'>" + data.jreply[i].time + "</span><img src='<%=request.getContextPath()%>/img/replyArrow.png' class='replyArrow'><span class='replyOfreply' id='rereply_"+ data.jreply[i].num +"' onclick='replyOfreply("+ data.jreply[i].num +"," + data.jreply[i].bundle + ",\"" + data.jreply[i].nick + "\",\"" + data.jreply[i].user_id + "\")'>답글</span><span class='replyDelete' onclick='if(confirm(\"답글을 삭제하시겠습니까?\")){replyDelete(" + data.jreply[i].num + "," + data.jreply[i].bundle + ");}'>삭제</span><br>" + data.jreply[i].reply + "</li><div class='board-box-line-dashed' style='margin-top:3px;'></div>");
									}
            		   }else{
            			   if(data.jreply[i].user_id == 'none'){
            				   $("#cmt_list").append("<li class='replyStyle' id='replyNum_"+ data.jreply[i].num +"' data-replyText='off'style=''>삭제된 댓글입니다.</li><div class='board-box-line-dashed' style='margin-top:3px;'></div>");
            			   }else{
            				   $("#cmt_list").append("<li class='replyStyle' id='replyNum_"+ data.jreply[i].num +"' data-replyText='off'style=''><b>" + data.jreply[i].nick + "</b> <span style='color:#595959;'>" + data.jreply[i].time + "</span><img src='<%=request.getContextPath()%>/img/replyArrow.png' class='replyArrow'><span class='replyOfreply' id='rereply_"+ data.jreply[i].num +"' onclick='replyOfreply("+ data.jreply[i].num +"," + data.jreply[i].bundle + ")'>답글</span><span class='replyDelete' onclick='if(confirm(\"댓글을 삭제하시겠습니까?\")){replyDelete(" + data.jreply[i].num + "," + data.jreply[i].bundle + ");}'>삭제</span><br>" + data.jreply[i].reply + "</li><div class='board-box-line-dashed' style='margin-top:3px;'></div>");
            				   
            			   }
            		   } 
             		   }
                    },
                    error: function (data) {
                        alert(data.responseText);
                    }
                }); 
    }
   
  
    </script>
    
    
<%@ include file="../inc/footer.jsp" %>