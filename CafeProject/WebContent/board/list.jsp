<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="boards.Boards" %>
<%@ page import="java.lang.Math" %>
<%@ page import="java.text.SimpleDateFormat" %>
    <%@ page import="java.util.Date" %>
<%@ include file="../inc/main.jsp" %>   
<%
int pageSize, currentPage, startRow, cot;
int count =0;
ArrayList<Boards> list = null;
pageSize = 15; // ==>> pageSize2변수 값도 바꿔 줘야함. 한 페이지에 출력할 레코드 수 php_ view_article
String pageNum = request.getParameter("page");
if (pageNum == null){ // 클릭한게 없으면 1번 페이지php
	pageNum = "1";
}
if(board_id == null){
	if(search == null){
			count = allCount; //전체글수 php_total_article	
		}else if(find.equals("writer")){//글쓴이
			count = boardsDAO.getCountSearchWriter(search);
		}else if(find.equals("sub")){//제목
			count = boardsDAO.getCountSearchSub(search);
		}else if(find.equals("sub_con")){//제목 + 내용
			count = boardsDAO.getCountSearch(search);
		}
	
	currentPage = Integer.parseInt(pageNum);
	startRow = (currentPage - 1) * pageSize;//php_start
	cot =count-(pageSize*(currentPage-1));
	if (count > 0) {
		if(search == null){
			list = boardsDAO.getList(startRow, pageSize);		
		}else if(find.equals("writer")){//글작성자 -> 닉네임 + 아이디
			list = boardsDAO.getSearchWriterList(search, startRow, pageSize);
		}else if(find.equals("sub")){//제목
			list = boardsDAO.getSearchSubList(search, startRow, pageSize);
		}else if(find.equals("sub_con")){//제목 + 내용
			list = boardsDAO.getSearchList(search, startRow, pageSize);
		}
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
.boardName{
	font-size:22px;
	margin-bottom:17px;
}
.post_btns{
	width:100%;
	overflow:hidden;
	height:auto;
	margin-top:9px;
}
input.defaultCheckbox{
	width:16px;
	height:16px;
}
.td_chk{
	padding-right:0px !important;
	padding-left:12px !important;
}
.search-input{
	width:209px;
	margin:0 auto;
	display:inline;
	border-radius:0px;
	vertical-align:bottom;
	color:#333;
}
.searchBox-bottom{
	margin-top:15px;
	width:100%;
	height:auto;
	overflow:hidden;
	text-align:center;
}
.search-top{
	margin-bottom:15px;
}
.serach-select{
	width:107px;
	display:inline;
	border-radius:0px;
	vertical-align:bottom;
	margin-right:5px;
	color:#333;
}
.divide-line{
	color:#d1d1d1;
	margin-top:7px;
	margin-bottom:0px;
}
</style>
<div class = "article-board">
<% 
if(request.getParameter("board_id") == null){
	if(request.getParameter("search") == null){%>
	<h3 class="boardName"><b>전체글보기</b></h3>
		<%}else{%>
		<div class="searchBox-bottom search-top">
	<form action="<%=request.getContextPath()%>/board/list.jsp" method="get" onsubmit="return searchTopChk()">
	<select name="find"class="form-control-sm serach-select">
	  <option value="sub_con"<%if(find.equals("sub_con")){ %>selected<%} %>>제목+내용</option>
	  <option value="sub"<%if(find.equals("sub")){ %>selected<%} %>>제목만</option>
	  <option value="writer"<%if(find.equals("writer")){ %>selected<%} %>>글작성자</option>
</select><input class="form-control-sm search-input" name="search"id="searchBarTop" type="text" autocomplete="off" <%if(request.getParameter("search") != null){%>value="<%=search %>"<%} %> placeholder="검색어를 입력해주세요"><button type="submit" class="btn btn-info btn-sm" style="border-radius:0px;width:51px;">검색</button>
	</form>
	</div>
	<%} %>
	<%}else{
		if(boardsDAO.getBoardName(Integer.parseInt(request.getParameter("board_id"))) == null){%>
			 <script>
			 alert("카페 운영진이 삭제했거나 없는 게시판입니다.");
			 history.back();
			 </script>
		<%}else{%>
		<h3 class="boardName"><b><%= boardsDAO.getBoardName(Integer.parseInt(request.getParameter("board_id"))) %></b></h3>
		<%}
}%>
<table>
<colgroup>
<%if(level>17){ %>
<col style="width:11px;">
<col style="width:88px;">
<col>
<col style="width:107px;">
<col style="width:91px;">
<col style="width:68px;">
<%}else{ %>
<col style="width:88px;">
<col>
<col style="width:118px;">
<col style="width:91px;">
<col style="width:68px;">
<%} %>
</colgroup>
	<thead>
		<tr>
			<%if(level>17){ %><th></th><%} %>
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
			<%if(level>17){ %><td class="td_chk"><input type="checkbox" id="article_chk"class="defaultCheckbox" name="article_chk" value="<%= list.get(i).getId()%>" style="float:right;"></td><%} %>
				<td class="td_num"><%= list.get(i).getId()%></td>
				<td class="td_subject"><a href = "view.jsp?<%if(find != null){%>find=<%=find %>&<%}if(search != null){ %>search=<%=search %>&<%} %><%if(board_id != null){ %>board_id=<%=request.getParameter("board_id") %><%} if(board_id != null && request.getParameter("page") != null){%>&<%}if(request.getParameter("page") != null){%>page=<%=request.getParameter("page") %><%}if(board_id != null || request.getParameter("page") != null){ %>&<%} %>id=<%= list.get(i).getId() %>"><%= list.get(i).getSubject()%></a></td>
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
<%if(id != null){ %>
<div class="post_btns">
<%if(level>17){ %><label for="all_chk"oncontextmenu="return false" onselectstart="return false" ondragstart="return false"style="margin-left:12px;"><input type="checkbox" onclick="allChk(this)" id="all_chk"class="defaultCheckbox" name="article_chk" value=""style="margin-right:5px;">전체선택</label><%} %>
<button onclick="location.href='write.jsp<%if(board_id != null){%>?board_id=<%=board_id%><%}%>'"class="btn btn-link btn-sm" style ="float:right;padding: 6px 14px;color: black; border-radius: 0px; border:1px solid #a8a8a8 !important;">글쓰기</button>
<%if(level>17){ %><button onclick="checkDelete()"class="btn btn-link btn-sm" style ="float:right;padding: 6px 14px;color: black; border-radius: 0px; border:1px solid #a8a8a8 !important;margin-right:6px;">삭제</button><%} %>
</div>
<%} %>
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
			<a href="list.jsp?<%if(find != null){ %>find=<%=find %>&<%}if(search != null){ %>search=<%=search %>&<%} %>page=<%=prev_group%>">이전</a>
	<%	}else{%>
			<a href="list.jsp?board_id=<%=board_id %>&page=<%=prev_group%>">이전</a>
		<%	}
	}
	for(int i=startPage; i < endPage; i++){ // 페이지 블록 번호
		if(i >pageCount2)break;
	if(i==currentPage){ // 현재 페이지에는 링크를 설정하지 않음
				if(board_id == null){%>
					<a href="list.jsp?<%if(find != null){ %>find=<%=find %>&<%}if(search != null){ %>search=<%=search %>&<%} %>page=<%=i%>"class="active"><%=i %></a>
				<%	}else{	%>
					<a href="list.jsp?board_id=<%=board_id %>&page=<%=i%>"class="active"><%=i %></a>
					<% }
			}else{ // 현재 페이지가 아닌 경우 링크 설정
				if(board_id == null){	%>
					<a href="list.jsp?<%if(find != null){ %>find=<%=find %>&<%}if(search != null){ %>search=<%=search %>&<%} %>page=<%=i%>"><%=i %></a>
				<%	}else{%>
					<a href="list.jsp?board_id=<%=board_id %>&page=<%=i%>"><%=i %></a>
					<%}
				}
	} // for end
	
	if(endPage <pageCount2){ // 현재 블록의 마지막 페이지보다 페이지 전체 블록수가 클경우 다음 링크 생성
					if(board_id == null){%>
						<a href="list.jsp?<%if(find != null){ %>find=<%=find %>&<%}if(search != null){ %>search=<%=search %>&<%} %>page=<%=startPage + 10 %>">다음</a>
					<% }else{%>
						<a href="list.jsp?board_id=<%=board_id %>&page=<%=startPage + 10 %>">다음</a>
					<%}
		}
	}
%>
</div>
</div>
<%}else{%>
	<tr>
	<td colspan="6">
	<div class="nodata">등록된 게시글이 없습니다.</div>
	</td>
	</tr>
	</tbody>
	</table>
	</div>
<% }%>
<%if(count>0){ %>
<hr class="divide-line">
<%} %>
	<div class="searchBox-bottom">
	<form action="<%=request.getContextPath()%>/board/list.jsp" method="get" onsubmit="return searchBottomChk()">
	<select name="find"class="form-control-sm serach-select">
	  <option value="sub_con">제목+내용</option>
	  <option value="sub">제목만</option>
	  <option value="writer">글작성자</option>
</select><input class="form-control-sm search-input" name="search"id="searchBarBottom" type="text" autocomplete="off" placeholder="검색어를 입력해주세요"><button type="submit" class="btn btn-info btn-sm" style="border-radius:0px;width:51px;">검색</button>
	</form>
	</div>	
		</div>
</div> 
<script>
function allChk(source){
	checkboxes = document.getElementsByName('article_chk');
	  for(var i=0, n=checkboxes.length;i<n;i++) {
		    checkboxes[i].checked = source.checked;
	  }
}

function checkDelete(){
	//var array = []
	var checkboxes = document.querySelectorAll('#article_chk:checked')

	var f = document.createElement("form"); // form 엘리멘트 생성 
	f.setAttribute("method","post"); // method 속성을 post로 설정
	f.setAttribute("action","chkDeleteAction.jsp?<%if(board_id != null){ %>board_id=<%=request.getParameter("board_id") %><%} if(board_id != null && request.getParameter("page") != null){%>&<%}if(request.getParameter("page") != null){%>page=<%=request.getParameter("page") %><%}%>"); // submit했을 때 무슨 동작을 할 것인지 설정
	document.body.appendChild(f); // 현재 페이지에 form 엘리멘트 추가 
	
	for(i=0;i<checkboxes.length;i++){
		var chk = document.createElement("input"); // input 엘리멘트 생성 
		chk.setAttribute("type","hidden"); // type 속성을 hidden으로 설정	
		chk.setAttribute("name","article_chk"); // name 속성을 'm_nickname'으로 설정 
		chk.setAttribute("value",checkboxes[i].value); // value 속성을 neilong에 담겨있는 값으로 설정 		
		f.appendChild(chk); // form 엘리멘트에 input 엘리멘트 추가 
	}

	f.submit(); 
	
}
	function searchBottomChk(){
		if(document.getElementById("searchBarBottom").value == ""){
			alert("검색어를 입력하세요.");
			return false;
		}
	}
	
	function searchTopChk(){
		if(document.getElementById("searchBarTop").value == ""){
			alert("검색어를 입력하세요.");
			return false;
		}
	}
</script>
<%@ include file="../inc/footer.jsp" %> 