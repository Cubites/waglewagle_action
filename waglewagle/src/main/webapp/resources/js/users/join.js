// 폼 제출 버튼 클릭 -> 동네리스트, 전화번호 값 hidden 태그에 저장 후 제출
$(function(){
	$("#joinBtn").click(function(){
		$("#phoneResult").val($("#phoneFront").val() + '-' + $("#phoneBack").val().slice(0,4) + '-' + $("#phoneBack").val().slice(4));
		
		var dongResult = '';
		for(var i=0; i<3; i++){
			if(dongList[i].length > 0){
				dongResult += (dongList[i] + ',');
			}
		}
		while(dongResult.slice(-1) === ','){
			dongResult = dongResult.slice(0, -1);
		}
		
		$("#users_addr_list").val(dongResult);
		
		if(!validEmail){//이메일 형식 체크
           alert("이메일 형식을 확인해주세요.");
           $("#users_email").focus();
           return;
        }else if(!isCheckEmailDup){//이메일 확인 버튼
           alert("이메일을 확인해주세요.");
           $("#isEmailDup").focus();
           return;
        }else if(!isValidEmail){//이메일 인증
           alert("이메일을 인증을 완료해주세요.");
           $("#validNum").focus();
           return;
        }else if(!validPwd || !pwdIsEqual){
           alert("비밀번호를 확인해주세요.");
           $("#users_pwd").focus();
           return;
        }else if(!isCheckNickDup){
           alert("닉네임을 확인해주세요.");
           $("#users_nick").focus();
           return;
        }else if($("#users_name").val().length < 1 || $("#users_name").val() === ""){
           alert("이름을 입력해주세요.");
           $("#users_name").focus();
           return;
        }else if($("#phoneBack").val().length < 1 || $("#phoneBack").val() === ""){
           alert("전화번호를 입력해주세요.");
           $("#phoneBack").focus();
           return;
        }else{
           $("#joinForm").submit();
        }
		 $("#joinForm").submit();
	})
})

//이메일 형식 체크(정규식)
function isEmail(email){
	let reg = new RegExp("([!#-'*+/-9=?A-Z^-~-]+(\.[!#-'*+/-9=?A-Z^-~-]+)*|\"\(\[\]!#-[^-~ \t]|(\\[\t -~]))+\")@([!#-'*+/-9=?A-Z^-~-]+(\.[!#-'*+/-9=?A-Z^-~-]+)*|\[[\t -Z^-~]*])");
	
	return reg.test(email);
}

//이메일 형식 올바른지 아닌지
var validEmail = false;
//입력된 이메일 값 실시간 체크
$(function(){
	$("#users_email").keyup(function(){
		 
		if(!isEmail($("#users_email").val())){
			$("#emailCheckText").text("올바른 이메일을 입력해주세요.");
			$("#emailCheckText").css('visibility', 'visible');
			$("#isEmailDup").attr("disabled", true);
			validEmail = false;
		}else{
			$("#emailCheckText").css('visibility', 'hidden');
			$("#isEmailDup").attr("disabled", false);
			validEmail = true;
		}
	})
})

//이메일 중복 체크 여부 : 했으면 true
var isCheckEmailDup = false;
$(function(){	
	// 이메일 중복 체크
	$("#isEmailDup").click(function(){
		if(validEmail){
		
			$.ajax({
				url:"emaildup",
				data:{users_email : $("#users_email").val()},
				success: function(data){
					if(data === 'true'){
						$("#emailCheckText").text("중복된 이메일입니다.");
						$("#emailCheckText").css('visibility', 'visible');
						$("#users_email").focus();
						isCheckEmailDup = false;
					}else{
						$("#emailCheckText").text("사용가능한 이메일입니다.")
						$("#users_email").attr('readonly', 'readonly');
						$("#emailCheckText").css('visibility', 'visible');
						isCheckEmailDup = true;
					}
				}
			})
		}
	})
	
})

var sendNumClicked = false;
var intervalVar;
$(function(){
	$("#sendNum").click(function(){
		if(!isCheckEmailDup){
			alert("이메일 확인을 해주세요.")
		}else{
			sendNumClicked = true;
			$('#sendNum').prop('value', '인증번호 재전송');
			$('#validNum').val('');
			$.ajax({
				url:"send_authnum",
				type: "post",
				data:{users_email : $("#users_email").val()},
				success: function(data){
					console.log(data);
				}
			});
			
			resetTimer();
		}
		
	});
	
	function resetTimer(){
		clearInterval(intervalVar);
		
		timeSec = 180;
		$("#timer").prop('value', getTimeString(timeSec));
		//console.log("timeSec before : " + timeSec);
		
		intervalVar = setInterval(function(){
			if(timeSec !== 0){
				timeSec -= 1;
				$('#timer').prop('value', getTimeString(timeSec));
			}else{
				clearInterval(intervalVar);
				intervalVar = undefined;
			}
			//console.log("timeSec after : " + timeSec);
		}, 1000);
	}
	
	function getTimeString(sec){
	      var minutes = '' + Math.floor(sec / 60);
	      var dividedSec = sec % 60;
	      if (dividedSec < 10) {
	         dividedSec = '0' + dividedSec;
	      }
	      return minutes + ":" + dividedSec;
	}
});	

var isValidEmail = false;
$(function(){
	$("#validCheck").click(function(){
		if(sendNumClicked && timeSec > 0){
			$.ajax({
				url:"check_authnum",
				data:{validNum : $("#validNum").val()},
				type: "post",
				success: function(data){
					console.log(data);
					$('#timer').val('');
					if(data === 'true'){
						clearInterval(intervalVar);
						intervalVar = undefined;
						alert("인증이 완료되었습니다.");
						isValidEmail = true;
					}else{
						alert("인증번호가 일치하지 않습니다.");
						isValidEmail = false;
					}
				}
			});
		}
	})
})

//비밀번호 형식 체크(정규식)
function isPassword(password){
	//let reg = /^(((?=.*[a-zA-Z])(?=.*[0-9]))|((?=.*[a-zA-Z])(?=.*[!@#$%^&*]))|((?=.*[!@#$%^&*])(?=.*[0-9]))).{8,20}$/;
	let reg = new RegExp("(((?=.*[a-zA-Z])(?=.*[0-9]))|((?=.*[a-zA-Z])(?=.*[!@#$%^&*]))|((?=.*[!@#$%^&*])(?=.*[0-9]))).{8,20}$");

	return reg.test(password);
}


//비밀번호 형식 올바른지 아닌지
var validPwd = false;
var pwdIsEqual = false;
$(function(){
	//입력된 이메일 값 실시간 체크
	$("#users_pwd").keyup(function(){
		 
		if(!isPassword($("#users_pwd").val())){
			$("#pwdCheckTxt").text("영문,특수문자,숫자 중 2가지 이상 포함해 8~20자로 작성해 주세요!");
			$("#pwdCheckTxt").css('visibility', 'visible');
			validPwd = false;
		}else{
			$("#pwdCheckTxt").css('visibility', 'hidden');
			validPwd = true;
		}
	})
	
	$("#users_pwd2").keyup(function(){
		 
		if($("#users_pwd").val() !== $("#users_pwd2").val()){
			$("#pwdCheckTxt").text("비밀번호가 일치하지 않습니다.");
			$("#pwdCheckTxt").css('visibility', 'visible');
			pwdIsEqual = false;
		}else{
			$("#pwdCheckTxt").css('visibility', 'hidden');
			pwdIsEqual = true;
		}
	})
})


//닉네임 중복 체크
var isCheckNickDup = false;
$(function(){	
	$("#checkNickBtn").click(function(){
		if($("#users_nick").val() === ''){
			alert("닉네임을 입력해주세요.");
		}else{
			$.ajax({
				url:"nickcheck",
				data:{users_nick : $("#users_nick").val()},
				success: function(data){
					if(data === 'true'){
						$("#nickCheckTxt").text("중복된 닉네임입니다.");
						$("#nickCheckTxt").css('visibility', 'visible');
						$("#users_nick").focus();
						isCheckNickDup = false;
					}else{
						$("#nickCheckTxt").text("사용가능한 닉네임입니다.")
						$("#users_nick").attr('readonly', 'readonly');
						$("#nickCheckTxt").css('visibility', 'visible');
						isCheckNickDup = true;
					}
				}
			})
		}
	
	})
	
})

var dongList = ['', '', '']

function clickAddDong1() {
    new daum.Postcode({
        oncomplete: function(data) {
            
            var dongName = '';

            if(data.bname !== '' && data.bname1 === ''){
            	dongName += data.bname;
            }else if(data.bname !== '' && data.bname1 !== ''){
            	dongName += data.bname1;
            }
            
            $(document).ready(function(){
            	$("#interest_dong1 > .addDongBtn").val(dongName);
            	$("#interest_dong1 > .addDongBtn").css('backgroundColor', '#CF5C5C');
            	$("#interest_dong1 > .addDongBtn").css('fontSize', '15px');	                	
            });
            var jibun = ''
            if(data.jibunAddress === ''){
            	jibun += data.autoJibunAddress;
            }else{
            	jibun += data.jibunAddress;
            }
            var a = dongName.charAt(dongName.length-1);
            var dongnae = jibun.substring(0, jibun.lastIndexOf(a)+1);
            
           
            dongList[0] = dongnae;

        }
    }).open();
}
function clickAddDong2() {
    new daum.Postcode({
        oncomplete: function(data) {
            
            var dongName = '';
            
            if(data.bname !== '' && data.bname1 === ''){
            	dongName += data.bname;
            }else if(data.bname !== '' && data.bname1 !== ''){
            	dongName += data.bname1;
            }
            
            $(document).ready(function(){
            	$("#interest_dong2 > .addDongBtn").val(dongName);
            	$("#interest_dong2 > .addDongBtn").css('backgroundColor', '#CF5C5C');
            	$("#interest_dong2 > .addDongBtn").css('fontSize', '15px');	
            });
            var jibun = ''
            if(data.jibunAddress === ''){
            	jibun += data.autoJibunAddress;
            }else{
            	jibun += data.jibunAddress;
            }
            var a = dongName.charAt(dongName.length-1);
            var dongnae = jibun.substring(0, jibun.lastIndexOf(a)+1);
            
            dongList[1] = dongnae;
        }
    }).open();
}
function clickAddDong3() {
    new daum.Postcode({
        oncomplete: function(data) {
            
            var dongName = '';
            
            if(data.bname !== '' && data.bname1 === ''){
            	dongName += data.bname;
            }else if(data.bname !== '' && data.bname1 !== ''){
            	dongName += data.bname1;
            }
            
            $(document).ready(function(){
            	$("#interest_dong3 > .addDongBtn").val(dongName);
            	$("#interest_dong3 > .addDongBtn").css('backgroundColor', '#CF5C5C');
            	$("#interest_dong3 > .addDongBtn").css('fontSize', '15px');	
            });
            var jibun = ''
            if(data.jibunAddress === ''){
            	jibun += data.autoJibunAddress;
            }else{
            	jibun += data.jibunAddress;
            }
            var a = dongName.charAt(dongName.length-1);
            var dongnae = jibun.substring(0, jibun.lastIndexOf(a)+1);
            
            dongList[2] = dongnae;
        }
    }).open();
}