window.onload=function () {
  render();
};
function render() {
    window.recaptchaVerifier=new firebase.auth.RecaptchaVerifier('recaptcha-container',{
  'size': 'invisible',
  'callback': function(response) {
    // reCAPTCHA solved, allow signInWithPhoneNumber.
    onSignInSubmit();
  }
});
    recaptchaVerifier.render();
}
function phoneAuth() {

    var plus="+";
    var areaCode=document.getElementById('nationNo').value;
    var phonenum=document.getElementById('phoneNo').value;

    var phone=plus.concat(areaCode,phonenum);

    //phone number authentication function of firebase
    //it takes two parameter first one is number,,,second one is recaptcha
    firebase.auth().signInWithPhoneNumber(phone,window.recaptchaVerifier).then(function (confirmationResult) {
        //s is in lowercase
        firebase.auth().signInAnonymously().catch(function(error) {
  // Handle Errors here.
  var errorCode = error.code;
  var errorMessage = error.message;
  // ...
});
        window.confirmationResult=confirmationResult;
        coderesult=confirmationResult;
        alert("인증번호를 발송했습니다.");
        $('#verificationCode').attr('disabled', false);
    }).catch(function (error) {
        alert(error.message);
    });
}
function codeverify() {
    var email = $("#email").val();
    submitFlag = true;

    if(email==""){
    
        if (checkId()
                    & checkPswd1()
                    & checkPswd2()
                    & checkNick()
                    & checkBirthday()
                    & checkGender()
                    //checkEmail()
                    & checkPhoneNo()
                    & checkAuthNo()
                  ) {
                    var code=document.getElementById('verificationCode').value;
                    coderesult.confirm(code).then(function (result) {
                      var phoneNum =  phoneNumberParser();
                      var user=result.user;
                      if(phoneNum!=user.phoneNumber){
                        alert("인증된 휴대폰번호와 입력된 휴대폰번호가 다릅니다.")
                        return false;
                      }

                      alert("휴대전화가 인증되었습니다.");
                      page_move();
                    }).catch(function (error) {
                      alert("휴대전화 인증에 실패했습니다.");
                    });
                    return true;
                  } else {
                    // alert("회원가입실패");
                    return false;
                  }
      }else{
                  if (checkId()
                  & checkPswd1()
                  & checkPswd2()
                  & checkNick()
                  & checkBirthday()
                  & checkGender()
                  & checkEmail()
                  & checkPhoneNo()
                  & checkAuthNo()
                ) {
                  var code=document.getElementById('verificationCode').value;
                  coderesult.confirm(code).then(function (result) {
                        var phoneNum =  phoneNumberParser();
                        var user=result.user;
                        if(phoneNum!=user.phoneNumber){
                          alert("인증된 휴대폰번호와 입력된 휴대폰번호가 다릅니다.")
                          return false;
                        }

                        alert("휴대전화가 인증되었습니다.");
                        page_move();
                      }).catch(function (error) {
                        alert("휴대전화 인증에 실패했습니다.");
                      });
                      return true;
                } else {
                  // alert("회원가입실패");
                  return false;
                }
      }
}

function page_move(){
    var f=document.joinForm;
    f.action="joinAction.jsp";
    f.method="post";
    f.submit();
}
