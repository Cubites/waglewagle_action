//이메일 형식 체크(정규식)
function isEmail(email){
	let reg = new RegExp("([!#-'*+/-9=?A-Z^-~-]+(\.[!#-'*+/-9=?A-Z^-~-]+)*|\"\(\[\]!#-[^-~ \t]|(\\[\t -~]))+\")@([!#-'*+/-9=?A-Z^-~-]+(\.[!#-'*+/-9=?A-Z^-~-]+)*|\[[\t -Z^-~]*])");
	
	return reg.test(email);
}

var sendNumClicked = false;
var intervalVar;
$(function(){
	$('form').each(function(){
			this.reset();
	})

	$("#sendNum").click(function(){
		if(!isEmail($("#users_email").val())){
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


$(function(){
		//탭 변경
		$("#formHeaderId").click(function(){
			$(this).css("background-color", "#CF5C5C");
			$(this).css("color", "#fff");
			$("#findIdForm").removeClass('hide');
			$("#formHeaderPwd").css("background-color", "#E8E8E8");
			$("#formHeaderPwd").css("color", "#000");
			$("#findPwdForm").addClass('hide');
			
		})
		$("#formHeaderPwd").click(function(){
			$(this).css("background-color", "#CF5C5C");
			$(this).css("color", "#fff");
			$("#findPwdForm").removeClass('hide');
			$("#formHeaderId").css("background-color", "#E8E8E8");
			$("#formHeaderId").css("color", "#000");
			$("#findIdForm").addClass('hide');
			
		})
		
		
		// form 제출
		// 아이디 찾기 form 제출
		$("#findIdBtn").click(function(){
			$("#phoneResult").val($("#phoneFront").val() + '-' + $("#phoneBack").val().slice(0,4) + '-' + $("#phoneBack").val().slice(4));
			
			if($("#users_name1").val().length < 1 || $("#users_name1").val() === ""){
	           alert("이름을 입력해주세요.");
	           $("#users_name1").focus();
	           return;
	        }else if($("#phoneBack").val().length < 1 || $("#users_name").val() === ""){
	            alert("전화번호를 입력해주세요.");
	            $("#phoneBack").focus();
	            return;
	         }else{
 				$("#findIdForm").submit();
		    }
		})
		
		//비밀번호 찾기 form 제출
		$("#findPwdBtn").click(function(){
			if($("#users_name2").val().length < 1 || $("#users_name2").val() === ""){
	           alert("이름을 입력해주세요.");
	           $("#users_name2").focus();
	           return;
	        }else if(!isValidEmail){//이메일 인증
	           alert("이메일을 인증을 완료해주세요.");
	           $("#validNum").focus();
	           return;
		    }else{
 				$("#findPwdForm").submit();
		    }
		})
		
		// 비밀번호 변경 form 제출
		$("#changePwdBtn").click(function(){
		
			if(validPwd && pwdIsEqual){
 				$("#changePwdForm").submit();
			}else{
				alert("비밀번호를 확인해주세요.");
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
			$("#pwdCheckTxt").text("숫자, 알파벳, 특수문자 중 2가지 이상을 포함해 8~20글자로 작성해 주세요!");
			$("#pwdCheckTxt").css('visibility', 'visible');
			console.log("false");
			validPwd = false;
		}else{
			console.log("true");
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