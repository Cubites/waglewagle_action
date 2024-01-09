<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head> 
    <meta charset="utf-8">
    <title></title>
    <META name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, user-scalable=no"> 
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.css" />
    
    <link rel="stylesheet" href="/resources/css/admin/join.css"/>
    <script>
	    function notice(){
		   location.href = "/admin/noticelist";
	    }
	    function qna(){
	       location.href = "/admin/qnalist";
	    }
	    function stats(){
	       location.href = "/admin/stats";
	    }
	    function user(){
	       location.href = "/admin/usermanage";
	    }
	    function goods(){
	       location.href = "/admin/goodsmanage";
	    }
	    function admin(){
	       location.href = "/admin/adminmanage";
	    }
	    function password(){
	       location.href = "/admin/changePwd";
	    }
    </script>
</head> 

<body>
    <div id="header">
        <div id="headerContainer">
            <br/>
            <img src="/resources/images/log.jpg" title="와글와글 로고"/ onclick="notice()">
        </div>
    </div>

    <div id="center">
        <div id="container">
            
            <div id="side-box">
                <div id="notice" onclick="notice()">공지</div>
                <div id="qna" onclick="qna()">문의</div>
                <div id="showdata" onclick="stats()">통계</div>
                <div id="adminuser" onclick="user()">회원관리</div>
                <div id="admingoods" onclick="goods()">상품관리</div>
                <div id="adminmaster" onclick="admin()">관리자 계정</div>
                <div id="chagepwd" onclick="password()">비밀번호 변경</div>
            </div>

            <div id="main-box">
                <div id="plus">
                    <div id="head-plus">관리자 추가</div>
                    <div id="body-plus">
                        <table cellpadding="5" cellspacing="0" background-color="eeeeee">
   
                            <tr>
	                            <td>*아이디</td>
	                            <td>
	                          		<input class="onborder" id="admin-email" type="text" placeholder="wagle123@gmail.com"/>
	                                <input type="button" value="중복확인" id="emailCheck">
	                            </td>
                            </tr>
                      
                            <tr>
	                            <td>*비밀번호</td>
	                            <td><input class="onborder" id="admin-pwd" type="password" min="8" placeholder="영문,숫자 합 8자리 이상"/></td>
                            </tr>
                      
                            <tr>
	                            <td>*비밀번호확인</td>
	                            <td><input class="onborder" id="admin-pwd-confirm" type="password" min="8" placeholder="동일한 비밀번호를 입력"/> </td>
                            </tr>
                      
                            <tr>
	                            <td>*이름</td>
	                            <td><input class="onborder" id="admin-name" type="text" max="10" placeholder="이름을 입력하세요."/></td>
                            </tr>
                      
                            <tr>
	                            <td>*전화번호:</td>
	                            <td>
	                           		<input class="onborder phoneNumPart" type="text" size="3" value="010"> -
	                                <input class="onborder phoneNumPart" type="text" size="4"> -
	                                <input class="onborder phoneNumPart" type="text" size="4">
	                            </td>
                            </tr>
                   
                            <tr>
	                            <td>*관리자 권한</td>
	                            <td>
	                            	<select name="admin_role" class="onborder" id="admin_role">
		                                <option value="3">====전체====</option>
		                                <option value="2">일반 관리자</option>
		                                <option value="1">부관리자</option>
	                                </select>            
                        		</td>
                         	</tr>
                         </table>

                        <button id="joinbtn" onclick="addAdmin()">추가하기</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script>
    	let dupCheck = false;
    	$("#admin-email").change(function(){
    	   dupCheck = false; 
    	});
	    const reg = /^((?=.*[a-zA-Z])(?=.*[0-9])).{8,}$/;
	    const valid = new RegExp(reg);
	    const reg2 = /^[0-9]*$/;
	    const valid2 = new RegExp(reg2);
	    
	    function addAdmin() {
	    	if ($("#admin-email").val() == '') {
	    		alert("아이디을 입력해 주세요");
	    		$("#admin-email").focus();
	    	} else if(!dupCheck){
	    	    alert("아이디 중복체크를 해주세요");
	    	} else if ($("#pwd").val() == '') {
	    		alert("비밀번호를 입력해 주세요");
	    		$("#pwd").focus();
	    	} else if(!valid.test($("#admin-pwd").val())){
	    	    alert("비밀번호는 영문, 숫자를 적어도 하나씩 포함하고 8자리 이상이어야합니다.");
	    		$("#admin-pwd").focus();
	    	} else if($("#admin-pwd").val() != $("#admin-pwd-confirm").val()){
	    	    alert("비밀번호와 비밀번호확인이 일치하지 않습니다");
	    		$("#admin-pwd-confirm").focus();
	    	} else if($("#admin-name").val() == ''){
	    	    alert("이름을 적어야합니다.");
	    		$("#admin-name").focus();
	    	} else {
	    	    let phone = "";
	    	    let phoneCheck = 0;
	    	    $(".phoneNumPart").each(function(index, item){
	    			if($(item).val() == ""){
	    				phoneCheck++;
	    			}
	    			if(!valid2.test($(item).val())){
	    			    phoneCheck++;
	    			}
	    			phone += $(item).val() + "-";
	    	    });
	    	    if(phoneCheck != 0){
	    			alert("올바른 전화번호를 입력해주세요.");
	    	    } else if($("#admin_role").val() != 1 && $("#admin_role").val() != 2){
	    			alert("관리자 권한을 선택해주세요.");
	    	    } else {
		    		$.ajax({
		    			url: "/admin/add/admin_account",
		    			type: "post",
		    			contentType: "application/json",
		    			data: JSON.stringify({
		    			    admins_email: $("#admin-email").val(),
		    			    admins_pwd: $("#admin-pwd").val(),
		    			    admins_name: $("#admin-name").val(),
		    			    admins_phone: phone.slice(0, phone.lastIndexOf("-")),
		    			    admins_role: $("#admin_role").val()
		    			}),
		    			success: function(data){
		    			    if(data){
		    					alert("정상적으로 계정이 생성되었습니다");
		    					location.href = "/admin/adminmanage";
		    			    } else {
		    					alert("계정 생성에 실패했습니다. 잠시후에 다시 시도해주세요.");
		    			    }
		    			}
		    	    });
	    	    }
	    	}
	    }
	    
	    
	    function selectDiv(element) {
	        const selectedDiv = document.querySelector('.selected');
	        if (selectedDiv) {
	            selectedDiv.classList.remove('selected');
	        }
	
	        element.classList.add('selected');
	    }
	
	
		$("#emailCheck").click(function(){ //click이벤트가 실행되면 -> ajax가 실행되는거고 
		    if($('#admin-email').val() == ""){
				alert("이메일을 입력해주세요.");
				return;
		    }
			$.ajax({
				url:'/admin/check/duplication',
				type: 'post',
				contentType: "application/json",
				data:JSON.stringify({
				    admins_email: $('#admin-email').val()
				}),
				success:function(res){ //(요청이 정상적으로 일어나면 실행되는것) or 실행한 경우를 굳이 코딩해줘서 출력하지는 않는다.
					if(!res){
						alert('이메일이 중복되었습니다.');
						$("#email").val('');
						$("#email").focus();
					}else{
						dupCheck = true;
						alert('사용가능한 이메일입니다.');
						//$('#email').attr('readonly','readonly'); //수정이 안되게 하는거...
					} 
				}
				
			})
		});
    </script>
</body> 
</html>