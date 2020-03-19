var loginFlag=false;

function loginCheck() {

    var id = $("#id").val();
    var oMsg = $("#idMsg");
    var oInput = $("#id");

    if ( id == "") {
        showErrorMsg(oMsg,"아이디를 입력해주세요.");
        $('#id').focus();
        return false;
    }else {
        hideMsg(oMsg);
    }


    var pwd = $("#pwd").val();
    var oMsg = $("#pwdMsg");
    var oInput = $("#pwd");

    if ( pwd == "") {
        showErrorMsg(oMsg,"비밀번호를 입력해주세요.");
        $('#pwd').focus();
        return false;
    }else {
        hideMsg(oMsg);
    }

    $.ajax({

        type:"POST",
        url: "/loginAjax" ,
        data:{
            "_token": $('#token').val(),
            id:id,
            password:pwd
            },
            async:false,
        dataType: "json",
        success : function(data) {

            var result = data.substr(4);

            if (result == "Y") {
                loginFlag=true;
                page_move();
              } else {
                showErrorMsg(oMsg, "가입하지 않은 아이디이거나, 잘못된 비밀번호입니다.");
                loginFlag=false;
            }
        }
    });
    return loginFlag;
}

function showErrorMsg(obj, msg) {

    obj.attr("class", "error_next_box");
    obj.html(msg);
    obj.show();

}

function hideMsg(obj) {
    obj.hide();
}

function page_move(){
    var f=document.loginForm;
    f.action="/login";
    f.method="post";
    f.submit();
}
