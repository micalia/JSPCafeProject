<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./inc/main.jsp" %>
    <%@ page import="boards.Boards" %>
    <%@ page import="java.util.ArrayList" %>
    <style>
    .mainTableList td{
    	height: 28px;
    	padding-top:6px;
    	padding-botton:6px;
		border-bottom: 1px solid #e5e5e5;
    }
    .allList{
    	padding-bottom: 8px;
	border-bottom: 1px solid #777777;
    }
    </style>
        <div class="cafe_intro" id="cafe_intro">
<%		String gateContent = adminsDAO.getGateContent();
		if(gateContent == null){
%>
<img src="<%=request.getContextPath()%>/img/DefaultGateImg.png"style="width:860px; height:290.4px;">
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
                    	
                    	ArrayList<Boards> list = boardsDAO.mainGetList();
                    	for(int i = 0; i < list.size(); i++){
                    %>
                    <tr>
                        <td class="td_subject"><b>·</b>&nbsp;&nbsp;<a class = "subjectcss" href ="./board/view.jsp?id=<%= list.get(i).getId() %>"><%= list.get(i).getSubject() %></a></td>
                        <td class="td_nick"><%= list.get(i).getNick() %></td>
                        <td class="td_date"><%= list.get(i).getUploadDate().substring(0, 10).replace("-", "/") %></td>
                        <td class="td_view"><%= list.get(i).getHit() %></td>
                    </tr>
                   <%
                    	}
                   %>
                </table>
            </div>

<%@ include file="./inc/footer.jsp" %>