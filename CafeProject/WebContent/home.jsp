<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./inc/main.jsp" %>
    <%@ page import="boards.Boards" %>
    <%@ page import="java.util.ArrayList" %>
    <%@ page import="java.text.SimpleDateFormat" %>
    <%@ page import="java.util.Date" %>
    <style>
    .mainTableList{
    	table-layout:fixed;
    	word-wrap: break-word;
    word-break: break-word;
    }
    .mainTableList td{
    overflow: hidden;
    	height: 28px;
    	padding-top:6px;
    	padding-botton:6px;
		border-bottom: 1px solid #e5e5e5;
    }
    .allList{
    	padding-bottom: 8px;
	border-bottom: 1px solid #777777;
    }/* 
    .td_subject{
    	text-overflow:ellipsis;
    	overflow:hidden;
    	white-space:nowrap;
    } */
    .td_nick{
    	text-overflow:ellipsis;
    	overflow:hidden;
    	width:100px;
    	white-space:nowrap;
    }
    .td_date{
    	text-align:center;
    }
    .board-list{
    display: table-cell;
    padding-top: 1px;
    }
    .inner_list{
        width: auto;
    	    word-wrap: break-word;
    word-break: break-word;
    table-layout: fixed;
    display: table;
    }
    .subjectcss{
    	display: table-cell;
    	    line-height: 19px;
    }
    .subject_append{
    	display: table;
    margin-left: 3px;
    white-space: nowrap;
    vertical-align: 0;
    color:red;
    font-weight:600;
    }
    .subject_dot{
    display: table-cell;
        width: 11px;
            padding-left: 0;
    padding-right: 8px;
    text-align: center;
    vertical-align: middle;
    }
    .inner{
    display: -webkit-box;
    overflow: hidden;
    text-overflow: ellipsis;
    -webkit-line-clamp: 1;
    -webkit-box-orient: vertical;
    word-break: break-all;
    height: 20px;
    }
    .le_re{
    	margin-right:2px;
    }
    .ri_re{
   		margin-left:2px; 
    }
    </style>
        <div class="cafe_intro" id="cafe_intro">
<%		String gateContent = adminsDAO.getGateContent();
		if(gateContent == null){
%>
<img src="<%=request.getContextPath()%>/img/DefaultGateImg.png"style="width:860px;">
<%}else{ %>
		<%=gateContent %>
<%} %>
        </div>

            <div class="tableContainer">
                <div class="allList">전체글보기</div>
                <table class="mainTableList">
                    <colgroup>
                    <col>
                    <col width="120">
                    <col width="100">
                    <col width="80">
                    </colgroup>
                   <%
                    	SimpleDateFormat timeFormat = new SimpleDateFormat("yyyy.MM.dd");
                   		Date time = new Date();
                   		String currentTime = timeFormat.format(time);
                   		
                    	ArrayList<Boards> list = boardsDAO.mainGetList();
                    	for(int i = 0; i < list.size(); i++){
                    %>
                    <tr>
                        <td class="td_subject">
	                        <div class="subject_dot">
	                        	<b>·</b>
	                        </div>
	                        <div class="board-list">
		                        <div class="inner_list">
		                        	<a class = "subjectcss" href ="./board/view.jsp?id=<%= list.get(i).getId() %>"><span class="inner"><%= list.get(i).getSubject() %></span></a>
			                        <div class="subject_append">
			                        	<% if(list.get(i).getReplyCount() > 0){ %>
			                        	<span class="le_re">[</span><%= list.get(i).getReplyCount()%><span class="ri_re">]</span>
			                        	<%} %>
			                        </div>
		                        </div>
	                        </div>
                        </td>
                        <td class="td_nick"><%= list.get(i).getNick() %></td>
                        <td class="td_date"><%if(currentTime.equals(list.get(i).getUploadDate().substring(0, 10).replace("-", "."))){%>
                        <%= list.get(i).getUploadDate().substring(11,16)%>
                        <%}else{ %><%=list.get(i).getUploadDate().substring(0, 10).replace("-", ".")%><%} %></td>
                        <td class="td_view"><%= list.get(i).getHit() %></td>
                    </tr>
                   <%
                    	}
                   %>
                </table>
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
<%@ include file="./inc/footer.jsp" %>