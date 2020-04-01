<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0">
    <title>가입페이지</title>
    <script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <link href="http://maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
    <style media="screen">
      .yy, .mm, .dd{display: table-cell;
        table-layout: fixed;
        width: 147px;
        vertical-align: middle;
      }
      .born{
        display: table;
        width: 100%;
      }
      .header{
            padding: 10px 0 17px;
      }
      .blue{font-size:14px;color:#2d4df9!important}
      .error_next_box{display:block;margin:9px 0 -2px;font-size:14px;line-height:14px;color:red}
    </style>
    <script src="../js/NumberAuthentication.js"></script>
  </head>
  <body>

    <div class="container">
      <div class="row justify-content-center">
        <div class="col-md-5" >

            <div class="card-body">
              <div class="header">
              <center>
              <a href="<%=request.getContextPath()%>/home.jsp">
                <img src="../img/cafeLogo.png"style="height:44px;">
              </a></center>
            </div>

              <form name="joinForm"class="form-horizontal" method="post"  action="">
          
                <div class="form-group">
                  <label for="user_id" class="cols-sm-2 control-label"><b>아이디</b></label>
                  <div class="cols-sm-10">
                    <div class="input-group">
                      <span class="input-group-addon"><i class="fa fa-user fa" aria-hidden="true"></i></span>
                      <input type="text" class="form-control" name="id" id="id" maxlength="25" autocomplete="off"/>
                    </div>
                    <span class="error_next_box" id="idMsg" style="display:none;" aria-live="assertive"></span>
                  </div>
                </div>

                <div class="form-group">
                  <label for="password" class="cols-sm-2 control-label"><b>비밀번호</b></label>
                  <div class="cols-sm-10">
                    <div class="input-group">
                      <span class="input-group-addon"><i class="fa fa-lock fa-lg" aria-hidden="true"></i></span>
                      <input type="password" value = "asdfasdf"class="form-control" name="password" id="pswd1"maxlength="25" />
                    </div>
                    <span class="error_next_box" id="pswd1Msg" style="display:none;" aria-live="assertive"></span>
                  </div>
                </div>

                <div class="form-group">
                  <label for="confirm" class="cols-sm-2 control-label"><b>비밀번호 재확인</b></label>
                  <div class="cols-sm-10">
                    <div class="input-group">
                      <span class="input-group-addon"><i class="fa fa-lock fa-lg" aria-hidden="true"></i></span>
                      <input type="password" value = "asdfasdf"class="form-control"id="pswd2"maxlength="25"/>
                    </div>
                    <span class="error_next_box" id="pswd2Msg" style="display:none;" aria-live="assertive"></span>
                  </div>
                </div>

                <div class="form-group">
                  <label for="nick" class="cols-sm-2 control-label"><b>닉네임</b></label>
                  <div class="cols-sm-10">
                    <div class="input-group">
                      <span class="input-group-addon"><i class="fa fa-user fa" aria-hidden="true"></i></span>
                      <input type="text" class="form-control" name="nick" id="nick"maxlength="12" autocomplete="off"/>
                    </div>
                    <span class="error_next_box" id="nickMsg" style="display:none;" aria-live="assertive"></span>
                  </div>
                </div>
                <div class="form-group">

                <label for="name" class="cols-sm-2 control-label"><b>생년월일</b></label>
                <div class="born">

                    <div class="input-group yy" style="margin-right:0px;">
                      <span class="input-group-addon"><i class="fa fa-user fa" aria-hidden="true"></i></span>
                      <input type="text" value = "1977" class="form-control" name="year" id="yy"style="width:100%;" placeholder="년(4자)" maxlength="4"/>
                    </div>

                  <div class="col-sm-4 mm">
                    <select id="mm" name="month" class="selectpicker form-control"aria-label="월"style="width:100%; padding-left:9.5px!important;padding-right:9.5px;!important">
                      <option value="">월</option>
                      <option value="1" selected>1</option>
                      <option value="2">2</option>
                      <option value="3">3</option>
                      <option value="4">4</option>
                      <option value="5">5</option>
                      <option value="6">6</option>
                      <option value="7">7</option>
                      <option value="8">8</option>
                      <option value="9">9</option>
                      <option value="10">10</option>
                      <option value="11">11</option>
                      <option value="12">12</option>
                    </select>
                  </div>
                  <div class="input-group dd" style="margin-right:0px;">
                    <span class="input-group-addon"><i class="fa fa-user fa" aria-hidden="true"></i></span>
                    <input type="text" class="form-control" value = "3" name="date" id="dd"style="width:100%;" maxlength="2" placeholder="일"/>
                  </div>
                </div>
                <span class="error_next_box" id="birthdayMsg" style="display:none;" aria-live="assertive"></span>
              </div>

                <div class="form-group">
                <label for="gender" class="cols-sm-2 control-label"><b>성별</b></label>
                <div class="col-sm-12"style="padding:0px;">
                  <select id="gender" name="gender"class="selectpicker form-control">
                    <option value="" >성별</option>
                    <option value="b">남자</option>
                    <option value="g" selected>여자</option>
                  </select>
                </div>
                <span class="error_next_box" id="genderMsg" style="display:none;" aria-live="assertive"></span>
              </div>
                <div class="form-group">
                  <label for="email" class="cols-sm-2 control-label"><b>본인 확인 이메일</b> (선택)</label>
                  <div class="cols-sm-10">
                    <div class="input-group">
                      <span class="input-group-addon"><i class="fa fa-envelope fa" aria-hidden="true"></i></span>
                      <input type="text" class="form-control" name="email" id="email" autocomplete="off" maxlength="50" />
                    </div>
                  </div>
                  <span class="error_next_box" id="emailMsg" style="display:none;" aria-live="assertive"></span>
                </div>

                <div class="form-group">
                <label for="phone" class="cols-sm-2 control-label"><b>휴대전화</b></label>
                    <div class="col-sm-12"style="padding:0px;">
                  <select class="selectpicker form-control" name="nationNo"id="nationNo">
                    <%@ include file="../inc/ariaCode.jsp" %>
                  </select>
                  </div>
                </div>

                <div class="form-group">
                  <div class="cols-sm-10">
                    <div class="input-group">
                      <span class="input-group-addon"><i class="fa fa-user fa" aria-hidden="true"></i></span>
                        <!-- <form> -->
                      <input type="text" class="form-control" value ="01011111111"name="phone" id="phoneNo"autocomplete="off"/>
                      <div id="recaptcha-container"></div>
                      <button type="button" id="btnSend" class="btn btn-primary" style="border-radius: 0;">인증번호받기</button>
                      <!-- </form> -->

                      </div>
                    </div>
                  </div>


                  <div class="form-group">
                    <div class="cols-sm-10">
                      <div class="input-group">
                        <span class="input-group-addon"><i class="fa fa-user fa" aria-hidden="true"></i></span>
                          <!-- <form> -->
                            <input type="text" class="form-control" id="verificationCode" value = "187200" placeholder="인증번호를 입력하세요" autocomplete="off" disabled>
                            <!-- <button type="button" onclick="codeverify()">입력</button> -->
                          <!-- </form> -->
                      </div>
                      <span class="error_next_box" id="phoneNoMsg" style="display:none;" aria-live="assertive"></span>
                      <span class="error_next_box" id="authNoMsg" style="display:none" aria-live="assertive"></span>
                    </div>
                  </div>

                  <div class="form-group ">
                    <button type="button" id="btnJoin" class="btn btn-primary btn-lg btn-block login-button">가입하기</button>
                  </div>

              </form>
            </div>


        </div>
      </div>
    </div>
    <!-- Firebase App (the core Firebase SDK) is always required and must be listed first -->
    <script src="https://www.gstatic.com/firebasejs/6.2.0/firebase-app.js"></script>
<script src="https://www.gstatic.com/firebasejs/6.0.2/firebase.js"></script>
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
    <script src="../js/validation.js"></script>
<script src="../js/libphonenumber/closure-library/node_modules/google-closure-library/closure/goog/base.js"></script>
<script>
  goog.require('goog.proto2.Message');
</script>
<script src="../js/libphonenumber/javascript/i18n/phonenumbers/phonemetadata.pb.js"></script>
<script src="../js/libphonenumber/javascript/i18n/phonenumbers/phonenumber.pb.js"></script>
<script src="../js/libphonenumber/javascript/i18n/phonenumbers/metadata.js"></script>
<script src="../js/libphonenumber/javascript/i18n/phonenumbers/shortnumbermetadata.js"></script>
<script src="../js/libphonenumber/javascript/i18n/phonenumbers/phonenumberutil.js"></script>
<script src="../js/libphonenumber/javascript/i18n/phonenumbers/asyoutypeformatter.js"></script>
<script src="../js/libphonenumber/javascript/i18n/phonenumbers/shortnumberinfo.js"></script>
<script src="../js/libphonenumber/javascript/i18n/phonenumbers/demo.js"></script>
  </body>
</html>
