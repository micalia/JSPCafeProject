<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="admins.AdminsDAO" %>
<%@ page import="admins.Level_name" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>멤버 등급 관리</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/bootstrap-4.4.1-dist/css/bootstrap.min.css">
<script src="<%=request.getContextPath()%>/js/jquery-3.4.1.min.js"></script>
<script src="<%=request.getContextPath()%>/bootstrap-4.4.1-dist/js/bootstrap.min.js"></script>
<style>
.tbl_level{
	margin:0 auto;
	margin-top:32px;
	width:936px;
}
.explain{
	width:100%;
}
.tbl_level td{
	vertical-align:top;
}
.p_input{
	width:39px;
}
.p_font{
	color:blue;
}
</style>

<script src="<%=request.getContextPath()%>/js/jquery-3.4.1.min.js"></script>
</head>
<body>
<%
AdminsDAO adminsDAO = new AdminsDAO();  
int lv_Info = adminsDAO.chkLevelExist();
ArrayList<Level_name> lvInfoArr = new ArrayList<Level_name>();
if(lv_Info == 0){%>
	<script>
		$(document).ready(function(){
		    document.getElementById("lvName_1").value = "새싹멤버";
		    document.getElementById("lvName_2").value = "일반멤버";
		    document.getElementById("lvName_3").value = "성실멤버";
		    document.getElementById("lvName_4").value = "열심멤버";
		    document.getElementById("lvName_5").value = "우수멤버";
		    document.getElementById("lvName_6").value = "감사멤버";

		    document.getElementById("explain_1").value = "가입 후 막 활동을 시작하는 멤버";
		    document.getElementById("explain_2").value = "카페 일반 멤버";
		    document.getElementById("explain_3").value = "카페활동을 성실히 하는 멤버";
		    document.getElementById("explain_4").value = "카페 열심 멤버";
		    document.getElementById("explain_5").value = "카페 우수 멤버";
		    document.getElementById("explain_6").value = "최고 고마운 VIP 멤버";
		    
		    var p_inputArr = document.getElementsByClassName("p_input")
		    for(var i=0;i<p_inputArr.length;i++){
		    	p_inputArr[i].value = "0";
		    }
		});
	</script>
<%}else{
	lvInfoArr = adminsDAO.getLevelInfoAdmin();
}
%>
<center style="margin-top:31px;">
<a href="<%=request.getContextPath()%>/home.jsp">
<img src="../img/cafeLogo.png"style="height:61px;">
</a><br><br>
<a href="./ManageHome.jsp">카페 관리자 메뉴</a>
</center>
<form action="levelInfoAction.jsp" method="post" onsubmit="return saveLevelInfo()">
<table class="tbl_level"border="1">
	<colgroup>
		<col width="32px">	
		<col width="179px">	
		<col width="572px">	
		<col width="92px">	
		<col width="">	
	</colgroup>
	<thead>
		<tr>
			<th><!-- 레벨 --></th>
			<th>등급명</th>
			<th>설명</th>
			<th>등업방식</th>
			<th><!-- 삭제 --></th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>①</td>
			<td><input type="text" id="lvName_1" name="lvName_1" class="levelName-input" maxlength="7" <%if(lv_Info != 0){ %>value="<%= lvInfoArr.get(0).getLevelName() %>"<%} %>></td>
			<td><input type="text" id="explain_1" name="explain_1" class="explain" maxlength="36" <%if(lv_Info != 0){ %>value="<%= lvInfoArr.get(0).getLv_explain() %>"<%} %>></td>
			<td></td>
			<td></td>
		</tr>
		<tr>
			<td>②</td>
			<td><input type="text" id="lvName_2" name="lvName_2" class="levelName-input" maxlength="7" <%if(lv_Info != 0){ %>value="<%= lvInfoArr.get(1).getLevelName() %>"<%if(lvInfoArr.get(1).getActivation() == 0 ){%>disabled<%}} %>></td>
			<td><input type="text" id="explain_2" name="explain_2" class="explain" maxlength="36" <%if(lv_Info != 0){ %>value="<%= lvInfoArr.get(1).getLv_explain() %>"<%if(lvInfoArr.get(1).getActivation() == 0 ){%>disabled<%}} %>>
				<p id="condition_2" <%if(lv_Info != 0){if(lvInfoArr.get(1).getActivation() != 2 ){%>style="display:none;"<%}}else{%>style="display:none;" <%} %>>
					<span class="p_font">게시글 </span><input type ="text" name="board_2" class="p_input" maxlength="5" autocomplete="off" <%if(lv_Info != 0){ %>value="<%= lvInfoArr.get(1).getBoardC() %>"<%if(lvInfoArr.get(1).getActivation() == 0 ){%>disabled<%}} %>><span class="p_font">개,</span>
					<span class="p_font">댓글 </span><input type = "text" name="comment_2" class="p_input" maxlength="5" autocomplete="off" <%if(lv_Info != 0){ %>value="<%= lvInfoArr.get(1).getCommentC() %>"<%if(lvInfoArr.get(1).getActivation() == 0 ){%>disabled<%}} %>><span class="p_font">개,</span>
					<span class="p_font">출석 </span><input type = "text" name="visit_2" class="p_input" maxlength="5" autocomplete="off" <%if(lv_Info != 0){ %>value="<%= lvInfoArr.get(1).getVisitC() %>"<%if(lvInfoArr.get(1).getActivation() == 0 ){%>disabled<%}} %>><span class="p_font">회 만족 시 자동등업</span>
				</p>
				<%if(lv_Info != 0){ 
					if(lvInfoArr.get(1).getActivation() == 0 ){%>
						<p id="deleteMsg_2" style="display:block;">해당등급이 삭제 되었습니다.</p>
					<%}else{%>
						<p id="deleteMsg_2" style="display:none;">해당등급이 삭제 되었습니다.</p>
					<%} 
				}else{%>
					<p id="deleteMsg_2" style="display:none;">해당등급이 삭제 되었습니다.</p>
				<%}%>
			</td>
			<td>
				<select id="selectLevel2" name="selectValue_2" class="selectValue" onchange="conditionChk(2)" <%if(lv_Info != 0){ if(lvInfoArr.get(1).getActivation() == 0 ){%>disabled<%}} %>>
					<option value="1">설정안함</option>
					<option value="2"<%if(lv_Info != 0){if(lvInfoArr.get(1).getActivation() == 2 ){%> selected<%}}%>>자동등업</option>
				</select>
			</td>
			<td>
			<%if(lv_Info != 0){ 
					if(lvInfoArr.get(1).getActivation() == 0){%>
						<button type="button" id="deleteBtn_2" class="btn btn-primary btn-sm" style="display:none;" onclick="levelDelete(2)">삭제</button>
						<button type="button" id="plusBtn_2" class="btn btn-primary btn-sm" onclick="levelPlus(2)">추가</button>
					<%}else{%>
						<button type="button" id="deleteBtn_2" class="btn btn-primary btn-sm" onclick="levelDelete(2)">삭제</button>
						<button type="button" id="plusBtn_2" class="btn btn-primary btn-sm" style="display:none;" onclick="levelPlus(2)">추가</button>
						<%}
				}else{%>
					<button type="button" id="deleteBtn_2" class="btn btn-primary btn-sm" onclick="levelDelete(2)">삭제</button>
					<button type="button" id="plusBtn_2" class="btn btn-primary btn-sm" style="display:none;" onclick="levelPlus(2)">추가</button>	
				<%} %>			
			</td>
		</tr>
		<tr>
			<td>③</td>
			<td><input type="text" id="lvName_3" name="lvName_3" class="levelName-input" maxlength="7" <%if(lv_Info != 0){ %>value="<%= lvInfoArr.get(2).getLevelName() %>"<%if(lvInfoArr.get(2).getActivation() == 0 ){%>disabled<%}} %>></td>
			<td><input type="text" id="explain_3" name="explain_3" class="explain" maxlength="36" <%if(lv_Info != 0){ %>value="<%= lvInfoArr.get(2).getLv_explain() %>"<%if(lvInfoArr.get(2).getActivation() == 0 ){%>disabled<%}} %>>
				<p id="condition_3" <%if(lv_Info != 0){if(lvInfoArr.get(2).getActivation() != 2 ){%>style="display:none;"<%}}else{%>style="display:none;" <%} %>>
					<span class="p_font">게시글 </span><input type ="text" name="board_3" class="p_input" maxlength="5" autocomplete="off" <%if(lv_Info != 0){ %>value="<%= lvInfoArr.get(2).getBoardC() %>"<%if(lvInfoArr.get(2).getActivation() == 0 ){%>disabled<%}} %>><span class="p_font">개,</span>
					<span class="p_font">댓글 </span><input type = "text" name="comment_3" class="p_input" maxlength="5" autocomplete="off" <%if(lv_Info != 0){ %>value="<%= lvInfoArr.get(2).getCommentC() %>"<%if(lvInfoArr.get(2).getActivation() == 0 ){%>disabled<%}} %>><span class="p_font">개,</span>
					<span class="p_font">출석 </span><input type = "text" name="visit_3" class="p_input" maxlength="5" autocomplete="off" <%if(lv_Info != 0){ %>value="<%= lvInfoArr.get(2).getVisitC() %>"<%if(lvInfoArr.get(2).getActivation() == 0 ){%>disabled<%}} %>><span class="p_font">회 만족 시 자동등업</span>
				</p>
				<%if(lv_Info != 0){ 
					if(lvInfoArr.get(2).getActivation() == 0 ){%>
						<p id="deleteMsg_3" style="display:block;">해당등급이 삭제 되었습니다.</p>
					<%}else{%>
						<p id="deleteMsg_3" style="display:none;">해당등급이 삭제 되었습니다.</p>
					<%} 
				}else{%>
					<p id="deleteMsg_3" style="display:none;">해당등급이 삭제 되었습니다.</p>
				<%}%>
			</td>
			<td>
				<select id="selectLevel3" name="selectValue_3" class="selectValue" onchange="conditionChk(3)" <%if(lv_Info != 0){ if(lvInfoArr.get(2).getActivation() == 0 ){%>disabled<%}} %>>
					<option value="1">설정안함</option>
					<option value="2"<%if(lv_Info != 0){if(lvInfoArr.get(2).getActivation() == 2 ){%> selected<%}}%>>자동등업</option>
				</select>
			</td>
			<td>
				<%if(lv_Info != 0){ 
					if(lvInfoArr.get(2).getActivation() == 0){%>
						<button type="button" id="deleteBtn_3" class="btn btn-primary btn-sm" style="display:none;" onclick="levelDelete(3)">삭제</button>
						<button type="button" id="plusBtn_3" class="btn btn-primary btn-sm" onclick="levelPlus(3)">추가</button>
					<%}else{%>
						<button type="button" id="deleteBtn_3" class="btn btn-primary btn-sm" onclick="levelDelete(3)">삭제</button>
						<button type="button" id="plusBtn_3" class="btn btn-primary btn-sm" style="display:none;" onclick="levelPlus(3)">추가</button>
						<%}
				}else{%>
					<button type="button" id="deleteBtn_3" class="btn btn-primary btn-sm" onclick="levelDelete(3)">삭제</button>
					<button type="button" id="plusBtn_3" class="btn btn-primary btn-sm" style="display:none;" onclick="levelPlus(3)">추가</button>	
				<%} %>				
			</td>
		</tr>
		<tr>
			<td>④</td>
			<td><input type="text" id="lvName_4" name="lvName_4" class="levelName-input" maxlength="7" <%if(lv_Info != 0){ %>value="<%= lvInfoArr.get(3).getLevelName() %>"<%if(lvInfoArr.get(3).getActivation() == 0 ){%>disabled<%}} %>></td>
			<td><input type="text" id="explain_4" name="explain_4" class="explain" maxlength="36" <%if(lv_Info != 0){ %>value="<%= lvInfoArr.get(3).getLv_explain() %>"<%if(lvInfoArr.get(3).getActivation() == 0 ){%>disabled<%}} %>>
				<p id="condition_4" <%if(lv_Info != 0){if(lvInfoArr.get(3).getActivation() != 2 ){%>style="display:none;"<%}}else{%>style="display:none;" <%} %>>
					<span class="p_font">게시글 </span><input type ="text" name="board_4" class="p_input" maxlength="5" autocomplete="off" <%if(lv_Info != 0){ %>value="<%= lvInfoArr.get(3).getBoardC() %>"<%if(lvInfoArr.get(3).getActivation() == 0 ){%>disabled<%}} %>><span class="p_font">개,</span>
					<span class="p_font">댓글 </span><input type = "text" name="comment_4" class="p_input" maxlength="5" autocomplete="off" <%if(lv_Info != 0){ %>value="<%= lvInfoArr.get(3).getCommentC() %>"<%if(lvInfoArr.get(3).getActivation() == 0 ){%>disabled<%}} %>><span class="p_font">개,</span>
					<span class="p_font">출석 </span><input type = "text" name="visit_4" class="p_input" maxlength="5" autocomplete="off" <%if(lv_Info != 0){ %>value="<%= lvInfoArr.get(3).getVisitC() %>"<%if(lvInfoArr.get(3).getActivation() == 0 ){%>disabled<%}} %>><span class="p_font">회 만족 시 자동등업</span>
				</p>
				<%if(lv_Info != 0){ 
					if(lvInfoArr.get(3).getActivation() == 0 ){%>
						<p id="deleteMsg_4" style="display:block;">해당등급이 삭제 되었습니다.</p>
					<%}else{%>
						<p id="deleteMsg_4" style="display:none;">해당등급이 삭제 되었습니다.</p>
					<%} 
				}else{%>
					<p id="deleteMsg_4" style="display:none;">해당등급이 삭제 되었습니다.</p>
				<%}%>
			</td>
			<td>
				<select id="selectLevel4" name="selectValue_4" class="selectValue" onchange="conditionChk(4)" <%if(lv_Info != 0){ if(lvInfoArr.get(3).getActivation() == 0 ){%>disabled<%}} %>>
					<option value="1">설정안함</option>
					<option value="2"<%if(lv_Info != 0){if(lvInfoArr.get(3).getActivation() == 2 ){%> selected<%}}%>>자동등업</option>
				</select>
			</td>
			<td>
				<%if(lv_Info != 0){ 
					if(lvInfoArr.get(3).getActivation() == 0){%>
						<button type="button" id="deleteBtn_4" class="btn btn-primary btn-sm" style="display:none;" onclick="levelDelete(4)">삭제</button>
						<button type="button" id="plusBtn_4" class="btn btn-primary btn-sm" onclick="levelPlus(4)">추가</button>
					<%}else{%>
						<button type="button" id="deleteBtn_4" class="btn btn-primary btn-sm" onclick="levelDelete(4)">삭제</button>
						<button type="button" id="plusBtn_4" class="btn btn-primary btn-sm" style="display:none;" onclick="levelPlus(4)">추가</button>
						<%}
				}else{%>
					<button type="button" id="deleteBtn_4" class="btn btn-primary btn-sm" onclick="levelDelete(4)">삭제</button>
					<button type="button" id="plusBtn_4" class="btn btn-primary btn-sm" style="display:none;" onclick="levelPlus(4)">추가</button>	
				<%} %>				
			</td>
		</tr>
		<tr>
			<td>⑤</td>
			<td><input type="text" id="lvName_5" name="lvName_5" class="levelName-input" maxlength="7" <%if(lv_Info != 0){ %>value="<%= lvInfoArr.get(4).getLevelName() %>"<%if(lvInfoArr.get(4).getActivation() == 0 ){%>disabled<%}} %>></td>
			<td><input type="text" id="explain_5" name="explain_5" class="explain" maxlength="36" <%if(lv_Info != 0){ %>value="<%= lvInfoArr.get(4).getLv_explain() %>"<%if(lvInfoArr.get(4).getActivation() == 0 ){%>disabled<%}} %>>
				<p id="condition_5" <%if(lv_Info != 0){if(lvInfoArr.get(4).getActivation() != 2 ){%>style="display:none;"<%}}else{%>style="display:none;" <%} %>>
					<span class="p_font">게시글 </span><input type ="text" name="board_5" class="p_input" maxlength="5" autocomplete="off" <%if(lv_Info != 0){ %>value="<%= lvInfoArr.get(4).getBoardC() %>"<%if(lvInfoArr.get(4).getActivation() == 0 ){%>disabled<%}} %>><span class="p_font">개,</span>
					<span class="p_font">댓글 </span><input type = "text" name="comment_5" class="p_input" maxlength="5" autocomplete="off" <%if(lv_Info != 0){ %>value="<%= lvInfoArr.get(4).getCommentC() %>"<%if(lvInfoArr.get(4).getActivation() == 0 ){%>disabled<%}} %>><span class="p_font">개,</span>
					<span class="p_font">출석 </span><input type = "text" name="visit_5" class="p_input" maxlength="5" autocomplete="off" <%if(lv_Info != 0){ %>value="<%= lvInfoArr.get(4).getVisitC() %>"<%if(lvInfoArr.get(4).getActivation() == 0 ){%>disabled<%}} %>><span class="p_font">회 만족 시 자동등업</span>
				</p>
				<%if(lv_Info != 0){ 
					if(lvInfoArr.get(4).getActivation() == 0 ){%>
						<p id="deleteMsg_5" style="display:block;">해당등급이 삭제 되었습니다.</p>
					<%}else{%>
						<p id="deleteMsg_5" style="display:none;">해당등급이 삭제 되었습니다.</p>
					<%} 
				}else{%>
					<p id="deleteMsg_5" style="display:none;">해당등급이 삭제 되었습니다.</p>
				<%}%>
			</td>
			<td>
				<select id="selectLevel5" name="selectValue_5" class="selectValue" onchange="conditionChk(5)" <%if(lv_Info != 0){ if(lvInfoArr.get(4).getActivation() == 0 ){%>disabled<%}} %>>
					<option value="1">설정안함</option>
					<option value="2"<%if(lv_Info != 0){if(lvInfoArr.get(4).getActivation() == 2 ){%> selected<%}}%>>자동등업</option>
				</select>
			</td>
			<td>
				<%if(lv_Info != 0){ 
					if(lvInfoArr.get(4).getActivation() == 0){%>
						<button type="button" id="deleteBtn_5" class="btn btn-primary btn-sm" style="display:none;" onclick="levelDelete(5)">삭제</button>
						<button type="button" id="plusBtn_5" class="btn btn-primary btn-sm" onclick="levelPlus(5)">추가</button>
					<%}else{%>
						<button type="button" id="deleteBtn_5" class="btn btn-primary btn-sm" onclick="levelDelete(5)">삭제</button>
						<button type="button" id="plusBtn_5" class="btn btn-primary btn-sm" style="display:none;" onclick="levelPlus(5)">추가</button>
						<%}
				}else{%>
					<button type="button" id="deleteBtn_5" class="btn btn-primary btn-sm" onclick="levelDelete(5)">삭제</button>
					<button type="button" id="plusBtn_5" class="btn btn-primary btn-sm" style="display:none;" onclick="levelPlus(5)">추가</button>	
				<%} %>			
			</td>
		</tr>
		<tr>
			<td>⑥</td>
			<td><input type="text" id="lvName_6" name="lvName_6" class="levelName-input" maxlength="7" <%if(lv_Info != 0){ %>value="<%= lvInfoArr.get(5).getLevelName() %>"<%if(lvInfoArr.get(5).getActivation() == 0 ){%>disabled<%}} %>></td>
			<td><input type="text" id="explain_6" name="explain_6" class="explain" maxlength="36" <%if(lv_Info != 0){ %>value="<%= lvInfoArr.get(5).getLv_explain() %>"<%if(lvInfoArr.get(5).getActivation() == 0 ){%>disabled<%}} %>>
				<p id="condition_6" <%if(lv_Info != 0){if(lvInfoArr.get(5).getActivation() != 2 ){%>style="display:none;"<%}}else{%>style="display:none;" <%} %>>
					<span class="p_font">게시글 </span><input type ="text" name="board_6" class="p_input" maxlength="5" autocomplete="off" <%if(lv_Info != 0){ %>value="<%= lvInfoArr.get(5).getBoardC() %>"<%if(lvInfoArr.get(5).getActivation() == 0 ){%>disabled<%}} %>><span class="p_font">개,</span>
					<span class="p_font">댓글 </span><input type = "text" name="comment_6" class="p_input" maxlength="5" autocomplete="off" <%if(lv_Info != 0){ %>value="<%= lvInfoArr.get(5).getCommentC() %>"<%}if(lvInfoArr.get(5).getActivation() == 0 ){%>disabled<%} %>><span class="p_font">개,</span>
					<span class="p_font">출석 </span><input type = "text" name="visit_6" class="p_input" maxlength="5" autocomplete="off" <%if(lv_Info != 0){ %>value="<%= lvInfoArr.get(5).getVisitC() %>"<%}if(lvInfoArr.get(5).getActivation() == 0 ){%>disabled<%} %>><span class="p_font">회 만족 시 자동등업</span>
				</p>
				<%if(lv_Info != 0){ 
					if(lvInfoArr.get(5).getActivation() == 0 ){%>
						<p id="deleteMsg_6" style="display:block;">해당등급이 삭제 되었습니다.</p>
					<%}else{%>
						<p id="deleteMsg_6" style="display:none;">해당등급이 삭제 되었습니다.</p>
					<%} 
				}else{%>
					<p id="deleteMsg_6" style="display:none;">해당등급이 삭제 되었습니다.</p>
				<%}%>
			</td>
			<td>
				<select id="selectLevel6" name="selectValue_6" class="selectValue" onchange="conditionChk(6)" <%if(lv_Info != 0){ if(lvInfoArr.get(5).getActivation() == 0 ){%>disabled<%}} %>>
					<option value="1">설정안함</option>
					<option value="2"<%if(lv_Info != 0){if(lvInfoArr.get(5).getActivation() == 2 ){%> selected<%}}%>>자동등업</option>
				</select>
			</td>
			<td>
				<%if(lv_Info != 0){ 
					if(lvInfoArr.get(5).getActivation() == 0){%>
						<button type="button" id="deleteBtn_6" class="btn btn-primary btn-sm" style="display:none;" onclick="levelDelete(6)">삭제</button>
						<button type="button" id="plusBtn_6" class="btn btn-primary btn-sm" onclick="levelPlus(6)">추가</button>
					<%}else{%>
						<button type="button" id="deleteBtn_6" class="btn btn-primary btn-sm" onclick="levelDelete(6)">삭제</button>
						<button type="button" id="plusBtn_6" class="btn btn-primary btn-sm" style="display:none;" onclick="levelPlus(6)">추가</button>
						<%}
				}else{%>
					<button type="button" id="deleteBtn_6" class="btn btn-primary btn-sm" onclick="levelDelete(6)">삭제</button>
					<button type="button" id="plusBtn_6" class="btn btn-primary btn-sm" style="display:none;" onclick="levelPlus(6)">추가</button>	
				<%} %>				
			</td>
		</tr>
		
	</tbody>
</table>
<center style="margin-top:15px;"><button type="submit" class="btn btn-primary">저장하기</button></center>
</form>
<script>
function conditionChk(num){
	var s_idChk = "selectLevel" + num;
	var s_id = document.getElementById(s_idChk);
	var sValue = s_id.options[s_id.selectedIndex].value;
	var condition = "condition_" + num;
	
	if(sValue == 2){
		document.getElementById(condition).style.display='block';
	}else{
		document.getElementById(condition).style.display='none';
	}
}

function levelDelete(num){
	var deleteBtn = "deleteBtn_" + num;
	var plusBtn = "plusBtn_" + num;
	var deleteMsg = "deleteMsg_" + num;
	var condition = "condition_" + num;
	var lvName = "lvName_" + num;
	var explain = "explain_" + num;
	var selectLevel = "selectLevel" + num;
	var board = "board_" + num;
	var comment = "comment_" + num;
	var visit = "visit_" + num;
	
	document.getElementById(deleteBtn).style.display='none';
	document.getElementById(plusBtn).style.display='block';	
	document.getElementById(deleteMsg).style.display='block';	
	document.getElementById(condition).style.display='none';	
	document.getElementById(lvName).disabled=true;	
	document.getElementById(explain).disabled=true;	
	document.getElementById(selectLevel).disabled=true;		
	document.getElementsByName(board)[0].disabled=true;		
	document.getElementsByName(comment)[0].disabled=true;		
	document.getElementsByName(visit)[0].disabled=true;		
}

function levelPlus(num){
	var plusBtn = "plusBtn_" + num;
	var deleteBtn = "deleteBtn_" + num;
	var deleteMsg = "deleteMsg_" + num;
	var condition = "condition_" + num;
	var lvName = "lvName_" + num;
	var explain = "explain_" + num;
	var selectLevel = "selectLevel" + num;
	var board = "board_" + num;
	var comment = "comment_" + num;
	var visit = "visit_" + num;
	var s_id = document.getElementById(selectLevel);//현재 체크된 value값 확인을 위함.
	var sValue = s_id.options[s_id.selectedIndex].value;
	
	document.getElementById(plusBtn).style.display='none';	
	document.getElementById(deleteBtn).style.display='block';
	document.getElementById(deleteMsg).style.display='none';
	if(sValue == 2){
		document.getElementById(condition).style.display='block';
	}else{
		document.getElementById(condition).style.display='none';
	}
	document.getElementById(lvName).disabled=false;	
	document.getElementById(explain).disabled=false;	
	document.getElementById(selectLevel).disabled=false;	
	document.getElementsByName(board)[0].disabled=false;	
	document.getElementsByName(comment)[0].disabled=false;	
	document.getElementsByName(visit)[0].disabled=false;	
}

function saveLevelInfo(){
	var selectValue_arr = document.getElementsByClassName("selectValue");
	var chkCountArr = new Array();
	var lv_1 = document.getElementsByName("lvName_1")[0];
	var ex_1 = document.getElementsByName("explain_1")[0];
	
	if(lv_1.value == ""){
		alert("등급을 입력하세요.");
		lv_1.focus();
		return false;
	}
	if(ex_1.value == ""){
		alert("설명을 입력하세요.");
		ex_1.focus();
		return false;
	}
   for(var i=0;i<selectValue_arr.length;i++){	//설정안함 옵션이라면 자동등업 조건의 값들을 모두 0으로 바꾸고 값들을 submit.
    		var num = selectValue_arr[i].id.replace("selectLevel","");
    		var board = "board_" + num;
    		var comment = "comment_" + num;
    		var visit = "visit_" + num;
    		var selectLevel = "selectLevel" + num;
    		var b = document.getElementsByName(board)[0];
    		var c = document.getElementsByName(comment)[0];
    		var v = document.getElementsByName(visit)[0];
    		var lvName = "lvName_" + num;
    		var explain = "explain_" + num;
    		
    		if(document.getElementById(selectLevel).disabled == false){
    			if(document.getElementById(lvName).value == ""){
    				alert("등급을 입력하세요.");
    				document.getElementById(lvName).focus();
    				return false;
    			}
    			if(document.getElementById(explain).value == ""){
    				alert("설명을 입력하세요.");
    				document.getElementById(explain).focus();
    				return false;
    			}
    		}
    	if(selectValue_arr[i].value == 1){
    		b.value = 0;
    		c.value = 0;
    		v.value = 0;
    	}else if(document.getElementById(selectLevel).disabled == false){
    		if(b.value == ""){
    			alert("자동등업 조건을 입력해주세요.");
    			b.focus();
    			return false;
    		}else if(c.value == ""){
    			alert("자동등업 조건을 입력해주세요.");
    			c.focus();
    			return false;
    		}else if(v.value == ""){
    			alert("자동등업 조건을 입력해주세요.");
    			v.focus();
    			return false;
    		}
    		var regexp = /^[0-9]*$/;
    		if(!regexp.test(b.value)){
    			alert("자동등업 조건은 1~99999 사이의 숫자로 입력해주세요.");
    			b.focus();
    			return false;
    		}else if(!regexp.test(c.value))	{
    			alert("자동등업 조건은 1~99999 사이의 숫자로 입력해주세요.");
    			c.focus();
    			return false;
    		}else if(!regexp.test(v.value)){
    			alert("자동등업 조건은 1~99999 사이의 숫자로 입력해주세요.");
    			v.focus();
    			return false;
    		}
    		chkCountArr.push(num);
    		
    	}   	
   }
   
   
   for(i=0; i<chkCountArr.length; i++){
	   var board = "board_" + chkCountArr[i];
	   var comment = "comment_" + chkCountArr[i];
	   var visit = "visit_" + chkCountArr[i];
	   if(chkCountArr[i+1]){
	   var lvName = "lvName_" + chkCountArr[i+1];
	   var lvNameVal = document.getElementById(lvName).value;
	   var board2 = "board_" + chkCountArr[i+1];
	   var b1 = document.getElementsByName(board)[0].value;
	   var b2 = document.getElementsByName(board2)[0].value; 
	   var comment2 = "comment_" + chkCountArr[i+1];
	   var c1 = document.getElementsByName(comment)[0].value;
	   var c2 = document.getElementsByName(comment2)[0].value; 
	   var visit2 = "visit_" + chkCountArr[i+1];
	   var v1 = document.getElementsByName(visit)[0].value;
	   var v2 = document.getElementsByName(visit2)[0].value; 
	   
	   var bchk = 0;
	   var cchk = 0;
	   var vchk = 0;
	   
		   if(b1 < b2){
			   bchk += 2;
		   }else if(b1 == b2){
			   bchk += 1;
		   }
		   
		   if(c1 < c2){
			   cchk += 2;
		   }else if(c1 == c2){
			   cchk += 1;
		   }

		   if(v1 < v2){
			   vchk += 2;
		   }else if(v1 == v2){
			   vchk += 1;
		   }

		   var result = bchk + cchk + vchk;
		   if(bchk == 0 || cchk == 0 || vchk == 0){
			   alert(lvNameVal + "의 등업 조건이 낮은 등급보다 높아야 합니다");
			   event.preventDefault();
			   return false;
		   }else if(result <= 3){   // 등급 조건중 최소 한개 이상은 전에 값보다 커야한다. 
				alert(lvNameVal + "의 등업 조건이 낮은 등급보다 높아야 합니다");
				event.preventDefault();
			   return false;
		   }
		   
	   }
   }

}
</script>

</body>
</html>