<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0">
    <title></title>
    <script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <link href="http://maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
    <style media="screen">

      .header{
            padding: 62px 0 0;
            height: 168px;
      }
#marginId{
  margin-bottom: 14px;
}
#marginPwd{
  margin-bottom: 31px;
}
input[class="form-control"] {
    height: 48px;
}
.error_next_box{display:block;margin:9px 0 -2px;font-size:14px;line-height:14px;color:red}
#loginMaintain:hover{
    cursor: pointer;
}
    </style>

  </head>
  <body oncontextmenu="return false" onselectstart="return false" ondragstart="return false">
    <script>
        function enter(){
            if(event.keyCode == 13){
                loginCheck();
            }
        }
    </script>

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

              <form name="loginForm"class="form-horizontal" method="post" action="">
                
                <div class="form-group" id="marginId">
                  <div class="cols-sm-10">
                    <div class="input-group">
                      <span class="input-group-addon"><i class="fa fa-user fa" aria-hidden="true"></i></span>
                      <input type="text" class="form-control" name="id" id="id" maxlength="25" placeholder="아이디"autocomplete="off"style="border-radius:0;" onKeypress="enter();" autofocus />
                    </div>
                    <span class="error_next_box" id="idMsg" style="display:none;"></span>
                  </div>
                </div>

                <div class="form-group" id="marginPwd">
                  <div class="cols-sm-10">
                    <div class="input-group">
                      <span class="input-group-addon"><i class="fa fa-lock fa-lg" aria-hidden="true"></i></span>
                      <input type="password" class="form-control" name="password" id="pwd" placeholder="비밀번호"maxlength="25" style="border-radius:0;"onKeypress="enter();" />
                    </div>
                    <span class="error_next_box" id="pwdMsg" style="display:none;"></span>
                  </div>
                </div>

                  <div class="form-group ">
                    <button type="button" id="btnJoin" class="btn btn-primary btn-lg btn-block login-button" style="height:55px; border-radius:0;" onclick="loginCheck()">로그인</button>
                  </div>

                  <div style="margin-top:23px; ">
                  <span class="form-group checkbox">

                    <label id = "loginMaintain"><input type="checkbox" name="remember" > 로그인 상태 유지</label>

                  </span>

                  <span class="form-group">
                        <a class="btn btn-link" href="#" style="padding:0px; float:right;">
                            비밀번호를 잊으셨나요?
                        </a>
                    </span>
                </div>

              </form>
            </div>
        </div>
      </div>
    </div>

<script src="../js/loginValidation.js"></script>
  </body>
</html>
