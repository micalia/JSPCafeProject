<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="boards.Boards" %>
<%@ page import="java.lang.Math" %>
<%@ page import="java.text.SimpleDateFormat" %>
    <%@ page import="java.util.Date" %>
<%@ include file="../inc/main.jsp" %>   
<%
String board_id = request.getParameter("board_id");
int count, pageSize, currentPage, startRow, cot;
ArrayList<Boards> list = null;
pageSize = 15; // ==>> pageSize2변수 값도 바꿔 줘야함. 한 페이지에 출력할 레코드 수 php_ view_article
String pageNum = request.getParameter("page");
if (pageNum == null){ // 클릭한게 없으면 1번 페이지php
	pageNum = "1";
}
if(board_id == null){
	count = boardsDAO.getCount(); //전체글수 php_total_article
	currentPage = Integer.parseInt(pageNum);
	startRow = (currentPage - 1) * pageSize;//php_start
	cot =count-(pageSize*(currentPage-1));
	if (count > 0) {
		list = boardsDAO.getList(startRow, pageSize);
			if(list.size() == 0){
						currentPage -= 1;
						if(currentPage > 0) {%>
						<script>
						location.href="list.jsp<%if(board_id != null || pageNum != null){ %>?<%}if(board_id != null){ %>board_id=<%=board_id %><%} if(board_id != null && pageNum != null){%>&<%}if(pageNum != null){%>page=<%= currentPage %><%}%>";
						</script>
						<%
						/* startRow = (currentPage - 1) * pageSize;//php_start
						cot =count-(pageSize*(currentPage-1));
							if (count > 0) {
								list = boardsDAO.getList(startRow, pageSize);
							} */
						}
					}
	}

}else{
	int boardId = Integer.parseInt(board_id);
	count = boardsDAO.getCountInMenu(boardId); //전체글수 php_total_article
	
	currentPage = Integer.parseInt(pageNum);
	startRow = (currentPage - 1) * pageSize;//php_start
	cot =count-(pageSize*(currentPage-1));
	if (count > 0) {
		list = boardsDAO.getListInMenu(boardId, startRow, pageSize);
		if(list.size() == 0){
			currentPage -= 1;
			if(currentPage > 0) {%>
			<script>
			location.href="list.jsp<%if(board_id != null || pageNum != null){ %>?<%}if(board_id != null){ %>board_id=<%=board_id %><%} if(board_id != null && pageNum != null){%>&<%}if(pageNum != null){%>page=<%= currentPage %><%}%>";
			</script>
			<%
				
			/* startRow = (currentPage - 1) * pageSize;//php_start
			cot =count-(pageSize*(currentPage-1));
				if (count > 0) {
					list = boardsDAO.getListInMenu(boardId, startRow, pageSize);
				} */
			}
		}
	}

}
	

%>
<style>
.article-board{
	width: 100%;
	word-break: break-all;
	word-wrap: break-word;
	word-break: break-word;
	table-layout: fixed;
	border-collapse: collapse;
	font-size:13px !important;
}
.article-board thead th{
	height: 40px;
	padding: 2px;
	border-top: 1px solid #666;
	border-bottom: 1px solid #e5e5e5;
	text-align: center;
}
.article-board tbody td {
	height: 28px;
	padding: 6px 7px;
	border-bottom: 1px solid #e5e5e5;
}
.article-board .td_date {
	text-align: center;
	white-space: nowrap;
}
.article-board .td_view {
	text-align: center;
}
.article-board .td_num {
	text-align: center;
}
 .article-board .td_subject a{
	color:black;
}
.pagination {
  display: inline-block;
  font-size:15px;
}

.pagination a {
  color: black;
  float: left;
  padding: 6px 10px;
  text-decoration: none;
 
  margin:0 3px;
}

.pagination a.active {
  color:#26a8ff;
  border: 1px solid #ddd;
  background-color:white;
}

.pagination a:hover {text-decoration:underline;}
.paging{
	margin-top: 26px;
	height: 40px;
	text-align: center;
} 
.nodata{
    padding: 100px 0;
    text-align: center;
}
</style>
<div class = "article-board">
<table>
<colgroup>
<col style="width:88px;">
<col>
<col style="width:118px;">
<col style="width:91px;">
<col style="width:68px;">
</colgroup>
	<thead>
		<tr>
			<th></th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>조회</th>			
		</tr>
	</thead>
	<tbody>
		 <%
				if (count > 0) { // 데이터베이스에 데이터가 있으면
					//int number = count - (currentPage - 1) * pageSize; // 글 번호 순번 
					SimpleDateFormat timeFormat = new SimpleDateFormat("yyyy.MM.dd");
                   		Date time = new Date();
                   		String currentTime = timeFormat.format(time);
					for (int i = 0; i < list.size(); i++) {
					
			%>

			<tr>
				<td class="td_num"><%= list.get(i).getId()%></td>
				<td class="td_subject"><a href = "view.jsp?<%if(board_id != null){ %>board_id=<%=request.getParameter("board_id") %><%} if(board_id != null && request.getParameter("page") != null){%>&<%}if(request.getParameter("page") != null){%>page=<%=request.getParameter("page") %><%}if(board_id != null || request.getParameter("page") != null){ %>&<%} %>id=<%= list.get(i).getId() %>"><%= list.get(i).getSubject()%></a></td>
				<td><%= list.get(i).getNick()%></td>
				<td class="td_date"><%if(currentTime.equals(list.get(i).getUploadDate().substring(0, 10).replace("-", "."))){%>
                        <%= list.get(i).getUploadDate().substring(11,16)%>
                        <%}else{ %><%=list.get(i).getUploadDate().substring(0, 10).replace("-", ".")%><%} %></td>
				<td class="td_view"><%= list.get(i).getHit()%></td>
			</tr>
		<%
		cot--;
			}
		%> 
	</tbody>
</table>
</div>

<div class="paging">
<div class="pagination">
<%	// 페이징  처리
						if(count > 0){
						
						int startPage;
						int endPage;		
						double pageSize2 = 15.0;
							// 총 페이지의 수, pagesize = 레코드수
							double pageCount = (double)Math.ceil(count / pageSize2);//total_page php
							
							// 한 페이지에 보여줄 시작 및 끝 번호(예 : 1, 2, 3 ~ 10 / 11, 12, 13 ~ 20)
							int chk = currentPage%10;
							if(chk == 0){
								startPage = currentPage-9;
							}else{
								 startPage = currentPage-currentPage%10+1;
							}
							//int startPage = ((currentPage-1)/pageBlock)*pageBlock+1;
							endPage = startPage + 10;
							//그룹이동//php
							//currentpage = 현재 페이지번호
							// 마지막 페이지가 총 페이지 수 보다 크면 endPage를 pageCount로 할당
							int prev_group=startPage-1;
							if(prev_group<1)prev_group=1;
							//다음그룹php
							int pageCount2 = (int)Math.round(pageCount);
							int next_group=endPage;
							if(next_group>pageCount)next_group=pageCount2;//double=>int로 형변환
							
							/* if(endPage > pageCount){
								endPage = pageCount;
							} */
							// 한 페이지에 보여줄 페이지 블럭(링크) 수
							int pageBlock = 10;
							if(currentPage>pageBlock){ // 페이지 블록수보다 startPage가 클경우 이전 링크 생성
							if(board_id == null){ %>
									<a href="list.jsp?page=<%=prev_group%>">이전</a>
							<%	}else{%>
									<a href="list.jsp?board_id=<%=board_id %>&page=<%=prev_group%>">이전</a>
								<%	}
							}
							for(int i=startPage; i < endPage; i++){ // 페이지 블록 번호
								if(i >pageCount2)break;
							if(i==currentPage){ // 현재 페이지에는 링크를 설정하지 않음
										if(board_id == null){%>
											<a href="list.jsp?page=<%=i%>"class="active"><%=i %></a>
										<%	}else{	%>
											<a href="list.jsp?board_id=<%=board_id %>&page=<%=i%>"class="active"><%=i %></a>
											<% }
									}else{ // 현재 페이지가 아닌 경우 링크 설정
										if(board_id == null){	%>
											<a href="list.jsp?page=<%=i%>"><%=i %></a>
										<%	}else{%>
											<a href="list.jsp?board_id=<%=board_id %>&page=<%=i%>"><%=i %></a>
											<%}
										}
							} // for end
							
							if(endPage <pageCount2){ // 현재 블록의 마지막 페이지보다 페이지 전체 블록수가 클경우 다음 링크 생성
											if(board_id == null){%>
												<a href="list.jsp?page=<%=startPage + 10 %>">다음</a>
											<% }else{%>
												<a href="list.jsp?board_id=<%=board_id %>&page=<%=startPage + 10 %>">다음</a>
											<%}
								}
							}
						}else{%>
							<tr>
							<td colspan="6">
							<div class="nodata">등록된 게시글이 없습니다.</div>
							</td>
							</tr>
							</tbody>
							</table>
							</div>
						<% }%>
								</div>
		
</div> 
<%@ include file="../inc/footer.jsp" %> 