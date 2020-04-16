<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<!-- <style>
.title_box{
	width:954px;
	height:298px;
	border:1px solid black;
	margin:0 auto;
}
</style> -->
<script src="<%=request.getContextPath()%>/js/jquery.min.js"></script>  
<script src="<%=request.getContextPath()%>/js/bootstrap.min.js"></script>
<script src="<%=request.getContextPath()%>/js/croppie.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/bootstrap.min.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/croppie.css" />
</head>
<body>
<style>
#uploaded_image{
	border:1px solid black;
	width:1080px;
	height:180px;
}
.img-thumbnail{
	padding:0px;
}
.modal-dialog{
	width:1145px;
}
.cr-boundary{
	margin-left:17px;
	border:1px solid black;
}
input[type=range]{
	width:1080px;
}
.cr-slider{
	max-width:1080px;
}
.croppie-container .cr-slider-wrap{
	margin:15px 0px;
}
  .container {
  width: 1170px;
  max-width: none !important;
}  
</style>
<center style="margin-top:42px;">
    <a href="<%=request.getContextPath()%>/home.jsp">
      <img src="<%=request.getContextPath()%>/img/cafeLogo.png"style="height:61px;">
    </a>
</center>
<!-- <div class="title_box">

</div> -->
  		
 <div class="container">
        
			<div class="panel panel-default" style="margin-top:55px;">
  				<div class="panel-heading">타이틀 이미지 업로드</div>
  				<div class="panel-body" align="center">
  					<input type="file" name="upload_image" id="upload_image" />
  					<br />
  					<div id="uploaded_image"></div>
  				</div>
  			</div>
  		</div>
  		
  		<div id="uploadimageModal" class="modal" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
      		<div class="modal-header">
        		<button type="button" class="close" data-dismiss="modal">&times;</button>
        		<h4 class="modal-title">타이틀 이미지 업로드</h4>
      		</div>
      		<div class="modal-body">
        		<div class="row">
  					<div class="col-xs-8 text-center" style="padding-left:30px;">
						  <div id="image_demo" style="width:350px; margin-top:30px"></div>
						  <button class="btn btn-success crop_image"style="margin-top:5px;margin-left:331px;">이미지 업로드</button>
  					</div>
  					
					
				</div>
      		</div>
      		<div class="modal-footer">
        		<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
      		</div>
    	</div>
    </div>
</div>
						 <center><button class="btn btn-success" id="dataSubmit">바로적용</button> 
						 &nbsp;&nbsp;
						 <button class="btn btn-danger" onclick="titleImgRemove()">현재 타이틀 이미지 제거</button></center>
				  	

<script>  
$(document).ready(function(){

	$image_crop = $('#image_demo').croppie({
    enableExif: true,
    maxZoom: 10,
    viewport: {
      width:1080,
      height:180,
      type:'square' //circle
    },
    boundary:{
      width:1080,
      height:180
    }
  });
	
  $('#upload_image').on('change', function(){
    var reader = new FileReader();
    reader.onload = function (event) {
      $image_crop.croppie('bind', {
        url: event.target.result
      }).then(function(){
      });
    }
    reader.readAsDataURL(this.files[0]);
    $('#uploadimageModal').modal('show');
  });

  $('.crop_image').click(function(event){
    $image_crop.croppie('result', {
      type: 'canvas',
      size: 'viewport'
    }).then(function(response){
      $.ajax({
        url:"uploadTitle.jsp",
        type: "POST",
        data:{"image": response},
        success:function(data)
        {
        	console.log(data.url);
        	//"<img src=\"" + imageName + "\" class=\"img-thumbnail\" type=\"image/png\" />"
          $('#uploadimageModal').modal('hide');
          $('#uploaded_image').html(data);
        }
      });
    })
  });

  $('#dataSubmit').on('click', function(e) {
      var imageData=$("#imageData").val();

      $.ajax({
                  url: "titleUpload.jsp",
                  type: 'post',
                  data: {
                  		'imageData':imageData,
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
  function titleImgRemove(){
      $.ajax({
                  url: "titleImgRemove.jsp",
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