<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../inc/main.jsp" %>
<link href="<%=request.getContextPath()%>/summernote/summernote-bs4.min.css" rel="stylesheet">
<script src="<%=request.getContextPath()%>/summernote/summernote-bs4.min.js"></script>
<script src="<%=request.getContextPath()%>/summernote/lang/summernote-ko-KR.js"></script>
<style>
  #subject{
    width: 478px;
    margin-bottom: 9px;
  }
#writeForm{
	width: 708.4px;
	margin:0 auto;	
	
}
.writeContainer{
	border:1px solid #a8a8a8;
	padding: 15px;
}
</style>
	
<script type="text/javascript">
$(document).ready(function() {
            $('.summernote').summernote({

                width: 708.4,
                height: 390,
                lang : 'ko-KR',
                toolbar:[
                ['Font Style', ['fontname']],
                ['style', ['bold', 'italic', 'underline']],
                ['fontsize'],
                ['font', ['strikethrough']],
                ['color', ['color']],
                ['para', ['paragraph']],
                ['height', ['height']],
                ['Insert', ['picture']],
                ['video'],
                ['Insert', ['link']],
                ['Misc', ['fullscreen']],
                ['codeview']
                ],
                fontSizes: ['11', '13','14', '15', '16', '19', '24', '28', '30', '34', '38'],
                callbacks:{
                    onImageUpload : function(files, editor, welEditable) {
                     sendFile(files[0], editor, welEditable);
                    }
                }
                   
});
// $('.summernote').summernote('fontSize', 15);
$('#writeForm').show();
});

    </script>
<div class = "writeContainer">
    <form name="writeForm" id="writeForm" style="display:none;"action="writeAction.jsp" onsubmit="return boardCheck()" method="post">
 
      <select name="board_id" id="boardid" style="width:156px;margin-bottom:9px;">
        <option value="" selected>게시판선택</option>
        <%
        for(int i = 0; i < menuList.size(); i++){
        	 %>
      <option value="<%= menuList.get(i).getBoard_id() %>"><%= menuList.get(i).getBoardName() %></option>
       <% } %>
      </select><br>
      <input type="text" name="subject" id="subject"value="" placeholder="게시글 제목을 입력하세요" autocomplete="off">
<textarea name="content" class="summernote"></textarea>
<center><button type="submit" class="btn btn-link btn-sm" style ="margin-top:13px;padding: 7px 14px;color: black; border-radius: 0px; border:1px solid #a8a8a8 !important;">확인</button></center>
</form>
</div>
<script>
 function sendFile(file,editor,welEditable) {
	 

    data = new FormData();
    data.append("file", file);
     $.ajax({
       url: "imageUpload.jsp", // image 저장 소스imageUpload.jsp
       data: data,
      cache: false,
      contentType: false,
       processData: false, 
       type: 'POST',
       success: function(data){
    	   console.log(data.url);
    	   var image = $('<img>').attr('src', '' + data.url); // 에디터에 img 태그로 저장을 하기 위함
           $('.summernote').summernote("insertNode", image[0]); // summernote 에디터에 img 태그를 보여줌
       },
       error: function(data) {
           alert('error : ' +data);
       }
    });
 }
function boardCheck()
{
    var some = $('#boardid').find('option:selected').val();
    var subject = document.getElementById("subject").value;
    var myText = $('.summernote').summernote('isEmpty')? '' : $('.summernote').summernote('code');
    if (some == ''){
        alert('게시판을 선택하세요');
        return false;
    }
    if (subject == ''){
        alert('제목을 입력하세요');
        return false;
    }
    if(myText == ''){
        alert('내용을 입력하세요');
        return false;
    }
    
}
</script>

<%@ include file="../inc/footer.jsp" %>
