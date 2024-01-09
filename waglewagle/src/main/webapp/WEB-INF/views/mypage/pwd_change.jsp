<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="/resources/css/mypage/pwd_change.css">
</head>
<body>
	<div id="auctionsContainer">
        <div id="pwdNow" class="pwdBox">
            <div>현재 비밀번호</div>
            <input type="password">
        </div>
        <div id="newPwd" class="pwdBox">
            <div>새 비밀번호</div>
            <input type="password">
        </div>
        <div id="alertMessageBox">
            
        </div>
        <div id="newPwdConfirm" class="pwdBox">
            <div>비밀번호 확인</div>
            <input type="password">
        </div>
        <div id="pwdChangeButton">비밀번호 수정</div>
	</div>
    <script>
	    const reg = /^(((?=.*[a-zA-Z])(?=.*[0-9]))|((?=.*[a-zA-Z])(?=.*[!@#$%^&*]))|((?=.*[!@#$%^&*])(?=.*[0-9]))).{8,20}$/;
		const valid = new RegExp(reg);
	
		// 새 비밀번호의 비밀번호 규칙 검증
		document.querySelector("#newPwd>input").addEventListener("input", (e) => {
		    if(e.target.value.length < 8 || e.target.value.length > 20) {
		        $("#alertMessageBox").text("비밀번호는 8자이상 20자이하만 가능합니다.");
		    } else if(!valid.test(e.target.value)) {
		        $("#alertMessageBox").text("영문, 숫자, 특수문자 중 2가지 이상을 넣어야합니다.");
		    } else {
		        $("#alertMessageBox").text("");
		    }
		});
	
		// 비밀번호 변경
		document.getElementById("pwdChangeButton").addEventListener("click", (e) => {
		    const pwds = document.getElementsByClassName("pwdBox");
		    let pwdVals = [];
	
		    for(let i=0; i<pwds.length; i++){
		        pwdVals.push(pwds[i].getElementsByTagName("input")[0].value);
		    }
		    // 현재 비밀번호 검증
		    $.ajax({
		        url: "/pwd/check",
		        type: 'post',
				contentType: 'application/json',
		        data: JSON.stringify({
		            data: pwdVals[0]
		        }),
		        success: function(data) {
		            if(data){ // 입력한 현재 비밀번호가 올바른 경우
		                if(valid.test(pwdVals[1])){ // 새 비밀번호가 비밀번호 규칙을 준수한 경우
		                    if(pwdVals[1] != pwdVals[2]){ // 새 비밀번호와 비밀번호 확인이 일치하지 않는 경우
		                        alert("새 비밀번호와 비밀번호 확인이 일치하지 않습니다.");
		                        document.querySelector("#newPwd>input").value = null;
		                        document.querySelector("#newPwdConfirm>input").value = null;
		                        document.querySelector("#newPwd>input").focus();
		                    } else { // 새 비밀번호와 비밀번호 확인이 일치하는 경우
		                    	if(pwdVals[0] == pwdVals[1]){ // 현재 비밀번호와 새 비밀번호가 일치하는 경우
		                    		alert("현재 비밀번호가 새 비밀번호와 일치합니다.");
		                    	} else { // 현재 비밀번호와 새 비밀번호가 일치하지 않는 경우
			                        $.ajax({
			                            url: "/pwd/change",
			                            type: 'post',
			                            contentType: 'application/json',
			                            data: JSON.stringify({
			                                data: pwdVals[1]
			                            }),
			                            success: function(data) {
			                                if(data){ // 비밀번호 변경이 성공한 경우
			                                    alert("비밀번호가 변경되었습니다.");
			                                    location.href = '/mypage/auctions';
			                                } else {
			                                    alert("비밀번호 변경에 실패하였습니다. 잠시후에 다시 시도해 주세요.");
			                                }
			                            }
			                        });
			                    }
		                    }
		                } else { // 새 비밀번호가 비밀번호 규칠을 준수하지 못한 경우
		                    alert("새 비밀번호를 사용할 수 없습니다. 영문, 숫자, 특수문자 중 2가지 이상 포함하고 8자이상 20자이하로 입력해주세요.");
		                }
		            } else { // 입력한 현재 비밀번호가 올바르지 않는 경우 
		                alert("현재 비밀번호가 올바르지 않습니다.");
		            }
		        }
		    });
		});
    </script>
</body>
</html>