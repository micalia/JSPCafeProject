<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
<link rel="stylesheet" href="<%=request.getContextPath()%>/bootstrap-4.4.1-dist/css/bootstrap.min.css">
    <script src="<%=request.getContextPath()%>/js/jquery-3.4.1.min.js"></script>
    <script src="<%=request.getContextPath()%>/summernote/popper.min.js"></script>
    <script src="<%=request.getContextPath()%>/bootstrap-4.4.1-dist/js/bootstrap.min.js"></script>
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
	padding: 15px;
}
</style>
	<center style="margin-top:42px;">
    <a href="<%=request.getContextPath()%>/home.jsp">
      <img src="<%=request.getContextPath()%>/img/cafeLogo.png"style="height:61px;">
    </a>
</center>
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
    <form name="writeForm" id="writeForm" style="display:none;" onsubmit="return boardCheck()" method="post">
 
<textarea id="gateContent" class="summernote"></textarea>
<center>
<button id="dataSubmit"class="btn btn-link btn-sm" style ="margin-top:13px;padding: 7px 14px;color: black; border-radius: 0px; border:1px solid #a8a8a8 !important;">확인</button>
&nbsp;&nbsp;
</center>
</form>

<center><button class="btn btn-danger" onclick="if(confirm('기존 카페대문을 삭제하시겠습니까?')){gateContentRemove();}" style="margin-top:20px;border-radius:0px;">현재 카페대문 제거</button></center>
</div>
<script>
 function sendFile(file,editor,welEditable) {
	 

    data = new FormData();
    data.append("file", file);
     $.ajax({
       url: "gateImageUpload.jsp", // image 저장 소스imageUpload.jsp
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
    var myText = $('.summernote').summernote('isEmpty')? '' : $('.summernote').summernote('code');
   
    if(myText == ''){
        alert('내용을 입력하세요');
        return false;
    }
    
}
$(document).ready(function(){
	$('#dataSubmit').on('click', function(e) {
	    var gateContent=$("#gateContent").val();
	
	    $.ajax({
	                url: "gateUploadAction.jsp",
	                type: 'post',
	                data: {
	                		'gateContent':gateContent,
	                    },
	                success: function (data) {
	                    if (data['status']==true) {
	                        alert(data['message']);
	                    } else {
	                        alert('오류가 발생했습니다');
	                    }
	                },
	                error: function (data) {
	                    alert(data.responseText);
	                }
	            });
	});
});  

function gateContentRemove(){
    $.ajax({
                url: "gateContentRemove.jsp",
                type: 'post',
                success: function (data) {
                    if (data['status']==true) {
                        alert(data['message']);
                    } else {
                        alert('오류가 발생했습니다');
                    }
                },
                error: function (data) {
                    alert(data.responseText);
                }
            });
}
</script>
</body>
</html>