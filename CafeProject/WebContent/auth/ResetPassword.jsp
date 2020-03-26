<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0">
    <title></title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/bootstrap-4.4.1-dist/css/bootstrap.min.css">
    <script src="<%=request.getContextPath()%>/js/jquery-3.4.1.min.js"></script>
    <script src="<%=request.getContextPath()%>/bootstrap-4.4.1-dist/js/bootstrap.min.js"></script>
    <style media="screen">

	.header{
	      padding: 62px 0 0;
	      height: 168px;
	}

	
	input[class="form-control"] {
	    height: 48px;
	}
    </style>

  </head>
  <body oncontextmenu="return false" onselectstart="return false" ondragstart="return false">


    <div class="container">
      <div class="row justify-content-center">
        <div class="col-md-5" >

            <div class="card-body" style="margin-top:40px;">
              <div class="header">
              <center>
              <a href="<%=request.getContextPath()%>/home.jsp">
                <img src="../img/cafeLogo.png"style="height:61px;">
              </a></center>
            </div>

<center style="font-size:20px; color:blue;">비밀번호를 잊으셨나요?</center>
              <form name="loginForm"class="form-horizontal" method="post" action="">
                
                <div class="form-group" >
                  <div class="cols-sm-10">
                    <div class="input-group">
                      <span class="input-group-addon"><i class="fa fa-user fa" aria-hidden="true"></i></span>
                      <input type="email" class="form-control" name="email" id="email" maxlength="25" placeholder="아이디"autocomplete="off"style="border-radius:0;" onKeypress="enter();" autofocus />
                    </div>
                    
                  </div>
                </div>


                  <div class="form-group ">
                    <button type="button" id="btn-resetPassword" class="btn btn-primary btn-lg btn-block login-button" style="height:55px; border-radius:0;" onclick="loginCheck()">비밀번호 재설정</button>
                  </div>


              </form>
            </div>
        </div>
      </div>
    </div>
     <!-- Firebase App (the core Firebase SDK) is always required and must be listed first -->
    <script src="https://www.gstatic.com/firebasejs/6.3.1/firebase-app.js"></script>
    <script src="https://www.gstatic.com/firebasejs/6.3.1/firebase-auth.js"></script>
    <script src="https://www.gstatic.com/firebasejs/6.3.1/firebase-database.js"></script>
    <script src="https://www.gstatic.com/firebasejs/6.3.1/firebase-storage.js"></script>
    
    <!-- TODO: Add SDKs for Firebase products that you want to use
         https://firebase.google.com/docs/web/setup#available-libraries -->

    <script>
      // Your web app's Firebase configuration
      var firebaseConfig = {
        apiKey: "AIzaSyAr59258r5_Z3g6jlyzDOeu9dX0QkzhMqI",
        authDomain: "shinseolproject.firebaseapp.com",
        databaseURL: "https://shinseolproject.firebaseio.com",
        projectId: "shinseolproject",
        storageBucket: "shinseolproject.appspot.com",
        messagingSenderId: "552280214916",
        appId: "1:552280214916:web:3443b9e036dd61dd39a1d1",
        measurementId: "G-LNBTH2RK22"
      };
      // Initialize Firebase
      firebase.initializeApp(firebaseConfig);

    </script>
    <script>
/*     firebase.auth().onAuthStateChanged(function(user)
    		{
    			if(user)
    				{
    					window.location.href = "../home.jsp";
    				}
    		}); */
    $("#btn-resetPassword").click(function()
    		{
    			var auth = firebase.auth();
    			var email = $("#email").val();
    			
    			if(email != "")
    				{
    					auth.sendPasswordResetEmail(email).then(function()
    							{
    								alert("입력하신 이메일로 인증 번호를 보냈습니다.");
    							})
    							.catch(function(error)
    							{
    								var errorCode = error.code;
    								var errorMessage = error.message;
    								
    								console.log(errorCode);
    								console.log(errorMessage);
    								
    								alert("Message : " + errorMessage);
    							});
    				}
    			else
    				{
    					alert("이메일을 입력해주세요");
    				}
    		});
    </script>

</body>
</html>