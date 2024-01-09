// 폼 제출 버튼 클릭 -> 동네리스트, 전화번호 값 hidden 태그에 저장 후 제출
$(function(){
	$("#changeBtn").click(function(){
	
		if(!validPwd || !pwdIsEqual){
           alert("비밀번호를 확인해주세요.");
           $("#users_pwd").focus();
           return;
        }else{
           $("#changePwdForm").submit();
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