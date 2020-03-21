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
                ['Misc', ['fullscreen']]
                ],
                fontSizes: ['11', '13','14', '15', '16', '19', '24', '28', '30', '34', '38'],


});
// $('.summernote').summernote('fontSize', 15);
$('#writeForm').show();
});

    </script>

    <form name="writeForm" id="writeForm" style="display:none;"action="writeAction.jsp" onsubmit="return boardCheck()" method="post">
 
      <select name="boardid" id="boardid" style="width:156px;margin-bottom:9px;">
        <option value="" selected>게시판선택</option>
        <%
        for(int i = 0; i < menuList.size(); i++){
        	 %>
      <option value="<%= menuList.get(i).getBoard_id() %>"><%= menuList.get(i).getBoardName() %></option>
       <% } %>
      </select><br>
      <input type="text" name="subject" id="subject"value="" placeholder="게시글 제목을 입력하세요" autocomplete="off">
<textarea name="content" class="summernote"></textarea>
<button type="submit" >게시물업로드</button>
</form>

<script>


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
