<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>멤버 등급 관리</title>
<style>
.tbl_level{
	margin:0 auto;
	margin-top:188px;
	width:920px;
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
<table class="tbl_level"border="1">
	<colgroup>
		<col width="33">	
		<col width="120">	
		<col width="614">	
		<col width="101">	
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
			<td><input type="text" class="levelName-input" maxlength="7"></td>
			<td><input type="text" class="explain" maxlength="36"></td>
			<td></td>
			<td></td>
		</tr>
		<tr>
			<td>②</td>
			<td><input type="text" id="lvName_2" class="levelName-input" maxlength="7"></td>
			<td><input type="text" id="explain_2" class="explain" maxlength="36">
				<p id="condition_2" style="display:none;">
					<span class="p_font">게시글 </span><input type ="text" class="p_input" maxlength="5"><span class="p_font">개,</span>
					<span class="p_font">댓글 </span><input type = "text" class="p_input" maxlength="5"><span class="p_font">개,</span>
					<span class="p_font">출석 </span><input type = "text" class="p_input" maxlength="5"><span class="p_font">회 만족 시 자동등업</span>
				</p>
				<p id="deleteMsg_2" style="display:none;">해당등급이 삭제 되었습니다.</p>
			</td>
			<td>
				<select id="selectLevel2" onchange="conditionChk(2)">
					<option value="1">설정안함</option>
					<option value="2">자동등업</option>
				</select>
			</td>
			<td>
				<button type="button" id="deleteBtn_2" class="btn btn-primary btn-sm" onclick="levelDelete(2)">삭제</button>
				<button type="button" id="plusBtn_2" class="btn btn-primary btn-sm" style="display:none;" onclick="levelPlus(2)">추가</button>				
			</td>
		</tr>
		<tr>
			<td>③</td>
			<td><input type="text" class="levelName-input" maxlength="7"></td>
			<td><input type="text" class="explain" maxlength="36"></td>
			<td>
				<select>
					<option value="1">설정안함</option>
					<option value="2">자동등업</option>
				</select>
			</td>
			<td><button type="button" class="btn btn-primary btn-sm">Primary</button></td>
		</tr>
		<tr>
			<td>④</td>
			<td><input type="text" class="levelName-input" maxlength="7"></td>
			<td><input type="text" class="explain" maxlength="36"></td>
			<td>
				<select>
					<option value="1">설정안함</option>
					<option value="2">자동등업</option>
				</select>
			</td>
			<td><button type="button" class="btn btn-primary btn-sm">Primary</button></td>
		</tr>
		<tr>
			<td>⑤</td>
			<td><input type="text" class="levelName-input" maxlength="7"></td>
			<td><input type="text" class="explain" maxlength="36"></td>
			<td>
				<select>
					<option value="1">설정안함</option>
					<option value="2">자동등업</option>
				</select>
			</td>
			<td><button type="button" class="btn btn-primary btn-sm">Primary</button></td>
		</tr>
		<tr>
			<td>⑥</td>
			<td><input type="text" class="levelName-input" maxlength="7"></td>
			<td><input type="text" class="explain" maxlength="36"></td>
			<td>
				<select>
					<option value="1">설정안함</option>
					<option value="2">자동등업</option>
				</select>
			</td>
			<td><button type="button" class="btn btn-primary btn-sm">Primary</button></td>
		</tr>
	</tbody>
</table>
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
	
	document.getElementById(deleteBtn).style.display='none';
	document.getElementById(plusBtn).style.display='block';	
	document.getElementById(deleteMsg).style.display='block';	
	document.getElementById(condition).style.display='none';	
	document.getElementById(lvName).disabled=true;	
	document.getElementById(explain).disabled=true;	
	document.getElementById(selectLevel).disabled=true;		
}

function levelPlus(num){
	var plusBtn = "plusBtn_" + num;
	var deleteBtn = "deleteBtn_" + num;
	var deleteMsg = "deleteMsg_" + num;
	var condition = "condition_" + num;
	var lvName = "lvName_" + num;
	var explain = "explain_" + num;
	var selectLevel = "selectLevel" + num;
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
}
</script>
</body>
</html>