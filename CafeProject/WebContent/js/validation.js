  var idFlag = false;
  var pwFlag = false;
  var nickFlag = false;
      var submitFlag = false;
    $(document).ready(function() {

        //region unreal id
        $("#id").blur(function() {
            idFlag = false;
            checkId("first");
        });

        $("#pswd1").blur(function() {
            pwFlag = false;
            checkPswd1();
        }).keyup(function(event) {
            checkShiftUp(event);
        }).keypress(function(event) {
            checkCapslock(event);
        }).keydown(function(event) {
            checkShiftDown(event);
        });

        $("#pswd2").blur(function() {
            checkPswd2();
        }).keyup(function(event) {
            checkShiftUp(event);
        }).keypress(function(event) {
            checkCapslock2(event);
        }).keydown(function(event) {
            checkShiftDown(event);
        });
        $("#nick").blur(function() {
            nickFlag = false;
            checkNick("first");
        });
        $("#yy").blur(function() {
            checkBirthday();
        });

        $("#mm").change(function() {
            checkBirthday();
        });

        $("#dd").blur(function() {
            checkBirthday();
        });

        $("#gender").change(function() {
            checkGender();
        });

        $("#email").blur(function() {
            checkEmail();
        });

        $("#phoneNo").blur(function() {
            checkPhoneNo();
        });

        $("#btnSend").click(function() {
            sendSmsButton();
            return false;
        });

        $("#verificationCode").blur(function() {
            authFlag = false;
            checkAuthNo();
        });

        $("#btnJoin").click(function(event) {
              codeverify();
              //NumberAuthentication.js


        });
    });
    //endregion

    //region unreal 가입
    function checkId(event) {
        if(idFlag) return true;

        var id = $("#id").val();
        var oMsg = $("#idMsg");
        var oInput = $("#id");
        var isID = /^[a-z0-9_\-]{5,20}$/;

        if ( id == "") {
            showErrorMsg(oMsg,"필수 정보입니다.");
            setFocusToInputObject(oInput);
            return false;
        }

        if (!isID.test(id)) {
            showErrorMsg(oMsg,"5~20자의 영문 소문자, 숫자와 특수기호(_),(-)만 사용 가능합니다.");
            setFocusToInputObject(oInput);
            return false;
        }

        idFlag = false;
        $.ajax({
            type:"POST",
            url: "./ajaxCheck.jsp",
            data:{
                "m" : "checkId",
                "id":id
                },
                async:false,
//            dataType: "json",
            success : function(data,event) {
                var result = data.substr(4);
                if (result[0] == "Y") {
                    // if (event == "first") {
                    //     showSuccessMsg(oMsg, "사용 가능한 아이디입니다.");
                    // } else {
                    //     hideMsg(oMsg);
                    // }

                    showSuccessMsg(oMsg, "사용 가능한 아이디입니다.");
                    idFlag = true;

                } else {
                	
                    showErrorMsg(oMsg, "이미 사용중인 아이디입니다.");
                    setFocusToInputObject(oInput);
                    idFlag = false;
                }

            }
        });
        return idFlag;

    }
    function checkPswd1() {
      var oInput = $("#pswd1");
        if(pwFlag) return true;

        var pw = $("#pswd1").val();
        // var oImg = $("#pswd1Img");
        // var oSpan = $("#pswd1Span");
        var oMsg = $("#pswd1Msg");
        // var oInput = $("#pswd1");


        if (pw == "") {
            showErrorMsg(oMsg,"필수 정보입니다.");
            setFocusToInputObject(oInput);
            return false;
        }
        if (isValidPasswd(pw) != true) {
            // showPasswd1ImgByStep(oImg, oSpan, 1);
            showErrorMsg(oMsg,"8~16자 영문 대 소문자, 숫자, 특수문자를 사용하세요.");
            setFocusToInputObject(oInput);
            return false;
        }
        hideMsg(oMsg);
        pwFlag = false;

        return true;
    }

    function checkPswd2() {
        var pswd1 = $("#pswd1");
        var pswd2 = $("#pswd2");
        var oMsg = $("#pswd2Msg");
        // var oImg = $("#pswd2Img");
        // var oBlind = $("#pswd2Blind");
        var oInput = $("#pswd2");

        if (pswd2.val() == "") {
            // showPasswd2ImgByDiff(oImg, false);
            showErrorMsg(oMsg,"필수 정보입니다.");
            // oBlind.html("설정하려는 비밀번호가 맞는지 확인하기 위해 다시 입력 해주세요.");
            setFocusToInputObject(oInput);
            return false;
        }
        if (pswd1.val() != pswd2.val()) {
            // showPasswd2ImgByDiff(oImg, false);
            showErrorMsg(oMsg,"비밀번호가 일치하지 않습니다.");
            // oBlind.html("설정하려는 비밀번호가 맞는지 확인하기 위해 다시 입력 해주세요.");
            setFocusToInputObject(oInput);
            return false;
        } else {
            // showPasswd2ImgByDiff(oImg, true);
            // oBlind.html("일치합니다");
            hideMsg(oMsg);
            return true;
        }

        return true;
    }

    function checkNick(event) {
        if(nickFlag) return true;

        var nick = $("#nick").val();
        var oMsg = $("#nickMsg");
        var oInput = $("#nick");

        if ( nick == "") {
            showErrorMsg(oMsg,"필수 정보입니다.");
            setFocusToInputObject(oInput);
            return false;
        }

        var isNick = /^[가-힣ㄱ-ㅎㅏ-ㅣa-zA-Z0-9]{1,12}$/;
        if (!isNick.test(nick)) {
            showErrorMsg(oMsg,"1~12자의 한글, 영어 대소문자, 숫자만 입력가능합니다.");
            setFocusToInputObject(oInput);
            return false;
        }

        nickFlag = false;
        $.ajax({
            type:"POST",
            url: "./ajaxCheck.jsp",
            data:{
                "m" : "checkNick",
                "nick":nick
                },
                async:false,
//            dataType: "json",
            success : function(data) {

                var result = data.substr(4);

                if (result[0] == "Y") {
                    showSuccessMsg(oMsg, "사용 가능한 닉네임입니다.");
                    nickFlag = true;
                  } else {
                    showErrorMsg(oMsg, "이미 사용중인 닉네임입니다.");
                    setFocusToInputObject(oInput);
                    nickFlag = false;
                }
            }
        });
        return nickFlag;
    }

    function checkBirthday() {
        var agentType = "";
        if(agentType == "iOS_App") {
            return true;
        }

        var birthday;
        var yy = $("#yy").val();
        var mm = $("#mm option:selected").val();
        var dd = $("#dd").val();
        var oMsg = $("#birthdayMsg");
        var lang = "ko_KR";

        var oyy = $("#yy");
        var omm = $("#mm");
        var odd = $("#dd");

        if (yy == "" && mm == "" && dd == "") {
            showErrorMsg(oMsg,"태어난 년도 4자리를 정확하게 입력하세요.");
            setFocusToInputObject(oyy);
            return false;
        }

        if (mm.length == 1) {
            mm = "0" + mm;
        }
        if (dd.length == 1) {
            dd = "0" + dd;
        }

        if(yy == "") {
            showErrorMsg(oMsg,"태어난 년도 4자리를 정확하게 입력하세요.");
            setFocusToInputObject(oyy);
            return false;
        }
        if(yy.length != 4 || yy.indexOf('e') != -1 || yy.indexOf('E') != -1) {
            showErrorMsg(oMsg,"태어난 년도 4자리를 정확하게 입력하세요.");
            setFocusToInputObject(oyy);
            return false;
        }
        if(mm == "") {
            showErrorMsg(oMsg,"태어난 월을 선택하세요.");
            setFocusToInputObject(omm);
            return false;
        }
        if(dd == "") {
            showErrorMsg(oMsg,"태어난 일(날짜) 2자리를 정확하게 입력하세요.");
            setFocusToInputObject(odd);
            return false;
        }
        if(dd.length != 2 || dd.indexOf('e') != -1 || dd.indexOf('E') != -1) {
            showErrorMsg(oMsg,"태어난 일(날짜) 2자리를 정확하게 입력하세요.");
            setFocusToInputObject(odd);
            return false;
        }

        birthday = yy + mm + dd;
        if (!isValidDate(birthday)) {
            showErrorMsg(oMsg,"생년월일을 다시 확인해주세요.");
            setFocusToInputObject(oyy);
            return false;
        }
        $("#birthday").val(birthday);

        var age = calcAge(birthday);
        if (age < 0) {
            showErrorMsg(oMsg,"미래에서 오셨나봐요 ㅎㅎ");
            setFocusToInputObject(oyy);
            return false;
        } else if (age >= 100) {
            showErrorMsg(oMsg,"정말요?");
            setFocusToInputObject(oyy);
            return false;
        // } else if (age < 14) {
        //     showErrorMsg(oMsg,"만 14세 미만의 어린이는 보호자 동의가 필요합니다.");
        //     if(lang == "ko_KR") {
        //         if ($("#joinMode").val() == "unreal") {
        //             showJuniverMobileTab();
        //         }
        //         return true;
        //     } else {
        //         hideJuniverTab();
        //         return false;
        //     }
        } else {
            hideMsg(oMsg);
            // hideJuniverTab();
            return true;
        }
        return true;
    }

    function checkGender() {
        var agentType = "";
        if(agentType == "iOS_App") {
            return true;
        }

        var gender = $("#gender").val();
        var oMsg = $("#genderMsg");
        var oInput = $("#gender");

        if (gender == "") {
            showErrorMsg(oMsg,"필수 정보입니다.");
            setFocusToInputObject(oInput);
            return false;
        }
        hideMsg(oMsg);
        return true;
    }

    function checkEmail() {
        var id = $("#id").val();
        var email = $("#email").val();
        var oMsg = $("#emailMsg");
        var oInput = $("#email");

        if (email == "") {
            hideMsg(oMsg);
            return true;
        }

        var isEmail = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
        var isHan = /[ㄱ-ㅎ가-힣]/g;
        if (!isEmail.test(email) || isHan.test(email)) {
            showErrorMsg(oMsg,"이메일 주소를 다시 확인해주세요.");
            return false;
        }

        emailFlag = false;
        $.ajax({
            type:"POST",
            url: "./ajaxCheck.jsp",
            data:{
                "m" : "checkEmail",
                "email":email
                },
                async:false,
//            dataType: "json",
            success : function(data) {

                var result = data.substr(4);

                if (result[0] == "Y") {
                    hideMsg(oMsg);
                    emailFlag = true;
                } else {
                    showErrorMsg(oMsg, "이미 다른계정에서 사용 중인 이메일입니다.");
                    setFocusToInputObject(oInput);
                    emailFlag = false;
                }
                // return emailFlag;
            }
        });

        return emailFlag;
    }

    function checkPhoneNo() {
        var phoneNo = $("#phoneNo").val();
        var oMsg = $("#phoneNoMsg");
        var oInput = $("#phoneNo");
        var num = /^[0-9]*$/;

        if (phoneNo == "") {
            showErrorMsg(oMsg,"필수 정보입니다.");
            setFocusToInputObject(oInput);
            return false;
        }

        if (!num.test(phoneNo)) {
            showErrorMsg(oMsg,"형식에 맞지 않는 번호입니다.");
            setFocusToInputObject(oInput);
            return false;
        }

        hideMsg(oMsg);
        return true;
    }

    function sendSmsButton() {
        var nationNo = $("#nationNo").val();
        var phoneNo = $("#phoneNo").val();
        // var key = $("#token_sjoin").val();
        var oMsg = $("#phoneNoMsg");
        // var lang = "ko_KR";

        phoneNo = phoneNo.replace(/ /gi, "").replace(/-/gi, "");
        $("#phoneNo").val(phoneNo);
        authFlag = false;

        $("#authNoMsg").hide();
        if(nationNo == "82" && !isCellPhone(phoneNo)) {
            showErrorMsg(oMsg,"형식에 맞지 않는 번호입니다.");
            return false;
        }
        phoneAuth();
        //NumberAuthentication.js
        return false;
    }
    function checkAuthNo() {
        var authNo = $("#verificationCode").val();
        var oMsg = $("#authNoMsg");
        var oInput = $("#verificationCode");

        if (authNo == "") {
            showErrorMsg(oMsg,"인증이 필요합니다.");
            setFocusToInputObject(oInput);
            return false;
        }
        return true;

    }
    function setFocusToInputObject(obj) {
        if(submitFlag) {
            submitFlag = false;
            obj.focus();
        }
    }
    function showErrorMsg(obj, msg) {
        obj.attr("class", "error_next_box");
        obj.html(msg);
        obj.show();
    }
    function showSuccessMsg(obj, msg) {
        obj.attr("class", "error_next_box blue");
        obj.html(msg);
        obj.show();
    }
    function hideMsg(obj) {
        obj.hide();
    }
    // function showPasswd1ImgByStep(oImg, oSpan, step) {
    //     if("IE8" == "") {
    //         return false;
    //     }
    //     if(step == 1) {
    //         oImg.attr("class", "ps_box int_pass_step1");
    //         oSpan.attr("class", "step_txt txt_red");
    //         oSpan.html("사용불가");
    //     } else {
    //         oImg.attr("class", "ps_box int_pass");
    //         oSpan.attr("class", "step_txt");
    //         oSpan.html("");
    //     }
    // }

        function isValidPasswd(str) {
            var cnt = 0;
            if (str == "") {
                return false;
            }

            /* check whether input value is included space or not */
            var retVal = checkSpace(str);
            if (retVal) {
                return false;
            }
            if (str.length < 8) {
                return false;
            }
            for (var i = 0; i < str.length; ++i) {
                if (str.charAt(0) == str.substring(i, i + 1))
                    ++cnt;
            }
            if (cnt == str.length) {
                return false;
            }

            var isPW = /^[A-Za-z0-9`\-=\\\[\];',\./~!@#\$%\^&\*\(\)_\+|\{\}:"<>\?]{8,16}$/;
            if (!isPW.test(str)) {
                return false;
            }

            return true;
        }
    var isShift = false;
    function checkShiftUp(e) {
        if (e.which && e.which == 16) {
            isShift = false;
        }
    }

    function checkShiftDown(e) {
        if (e.which && e.which == 16) {
            isShift = true;
        }
    }

    function checkSpace(str) {
        if (str.search(/\s/) != -1) {
            return true;
        } else {
            return false;
        }
    }

    function checkCapslock(e) {
        var myKeyCode = 0;
        var myShiftKey = false;
        if (window.event) { // IE
            myKeyCode = e.keyCode;
            myShiftKey = e.shiftKey;
        } else if (e.which) { // netscape ff opera
            myKeyCode = e.which;
            myShiftKey = isShift;
        }

        var oMsg = $("#pswd1Msg");
        if ((myKeyCode >= 65 && myKeyCode <= 90) && !myShiftKey) {
            showErrorMsg(oMsg,"Caps Lock이 켜져 있습니다.");
        } else if ((myKeyCode >= 97 && myKeyCode <= 122) && myShiftKey) {
            showErrorMsg(oMsg,"Caps Lock이 켜져 있습니다.");
        } else {
            hideMsg(oMsg);
        }
    }
    function checkCapslock2(e) {
        var myKeyCode = 0;
        var myShiftKey = false;
        if (window.event) { // IE
            myKeyCode = e.keyCode;
            myShiftKey = e.shiftKey;
        } else if (e.which) { // netscape ff opera
            myKeyCode = e.which;
            myShiftKey = isShift;
        }

        var oMsg = $("#pswd2Msg");
        if ((myKeyCode >= 65 && myKeyCode <= 90) && !myShiftKey) {
            showErrorMsg(oMsg,"Caps Lock이 켜져 있습니다.");
        } else if ((myKeyCode >= 97 && myKeyCode <= 122) && myShiftKey) {
            showErrorMsg(oMsg,"Caps Lock이 켜져 있습니다.");
        } else {
            hideMsg(oMsg);
        }
    }
    function calcAge(birth) {
        var date = new Date();
        var year = date.getFullYear();
        var month = (date.getMonth() + 1);
        var day = date.getDate();
        if (month < 10)
            month = '0' + month;
        if (day < 10)
            day = '0' + day;
        var monthDay = month + '' + day;

        birth = birth.replace('-', '').replace('-', '');
        var birthdayy = birth.substr(0, 4);
        var birthdaymd = birth.substr(4, 4);

        var age = monthDay < birthdaymd ? year - birthdayy - 1 : year - birthdayy;
        return age;
    }
    function isValidDate(param) {
        try {
            param = param.replace(/-/g, '');

            // 자리수가 맞지않을때
            if (isNaN(param) || param.length != 8) {
                return false;
            }

            var year = Number(param.substring(0, 4));
            var month = Number(param.substring(4, 6));
            var day = Number(param.substring(6, 8));

            if (month < 1 || month > 12) {
                return false;
            }

            var maxDaysInMonth = [ 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 ];
            var maxDay = maxDaysInMonth[month - 1];

            // 윤년 체크
            if (month == 2 && (year % 4 == 0 && year % 100 != 0 || year % 400 == 0)) {
                maxDay = 29;
            }

            if (day <= 0 || day > maxDay) {
                return false;
            }
            return true;

        } catch (err) {
            return false;
        }


    }
    function isCellPhone(p) {
        var regPhone = /^((01[1|6|7|8|9])[1-9][0-9]{6,7})$|(010[1-9][0-9]{7})$/;
        return regPhone.test(p);
    }
