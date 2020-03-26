<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="boards.Boards" %>
<%@ page import="java.lang.Math" %>

<%@ include file="../inc/main.jsp" %>   
<%
	int count = boardsDAO.getCount(); //전체글수 php_total_article
	int pageSize = 15; // ==>> pageSize2변수 값도 바꿔 줘야함. 한 페이지에 출력할 레코드 수 php_ view_article
	// 페이지 링크를 클릭한 번호 / 현재 페이지
	String pageNum = request.getParameter("page");
	if (pageNum == null){ // 클릭한게 없으면 1번 페이지php
		pageNum = "1";
	}
	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage - 1) * pageSize;//php_start
	int cot =count-(pageSize*(currentPage-1));
	ArrayList<Boards> list = null;
	if (count > 0) {
		// getList()메서드 호출 / 해당 레코드 반환
		list = boardsDAO.getList(startRow, pageSize);
	}

	// 연산을 하기 위한 pageNum 형변환 / 현재 페이지

	// 해당 페이지에서 시작할 레코드 / 마지막 레코드
	//int endRow = currentPage * pageSize;

	

%>
<table>
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
					for (int i = 0; i < list.size(); i++) {
					
			%>

			<tr>
				<td><%= list.get(i).getId()%></td>
				<td><a href = "view.jsp?id=<%= list.get(i).getId() %>"><%= list.get(i).getSubject()%></a></td>
				<td><%= list.get(i).getNick()%></td>
				<td><%= list.get(i).getUploadDate().substring(0, 10).replace("-", ".")%></td>
				<td><%= list.get(i).getHit()%></td>
			</tr>
		<%
		cot--;
			}
		%> 
	</tbody>
</table>

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
					%>
								<a href="list.jsp?page=<%=prev_group%>">[이전]</a>	
					<%			
							}
							for(int i=startPage; i < endPage; i++){ // 페이지 블록 번호
								if(i >pageCount2)break;
							if(i==currentPage){ // 현재 페이지에는 링크를 설정하지 않음
					%>
									[<%=i %>]
					<%									
								}else{ // 현재 페이지가 아닌 경우 링크 설정
					%>
									<a href="list.jsp?page=<%=i%>">[<%=i %>]</a>
					<%	
								}
							} // for end
							
							if(endPage <pageCount2){ // 현재 블록의 마지막 페이지보다 페이지 전체 블록수가 클경우 다음 링크 생성
					%>
								<a href="list.jsp?page=<%=startPage + 10 %>">[다음]</a>
					<% 
								}
							}
						}
					%>

<%@ include file="../inc/footer.jsp" %> 