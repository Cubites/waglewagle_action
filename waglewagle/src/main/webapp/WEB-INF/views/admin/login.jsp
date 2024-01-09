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
    
    <link rel="stylesheet" href="/resources/css/admin/login.css"/>
    <script>
	     function loginCheck() {
	    	if ($("#admin-email").val() == '') {
	    		alert("이메일을 입력해 주세요");
	    		$("#admin-email").focus();
	    		return false;
	    	}
	    	if ($("#admins_pwd").val() == '') {
	    		alert("비밀번호를 입력해 주세요");
	    		$("#admins_pwd").focus();
	    		return false;
	    	}
	    	document.adminlogin.submit();
	    }
    </script>
</head> 


<body>

	<div id="header">
	    <div id="headerContainer">
	        <br/>
	        <img src="/resources/images/log.jpg" title="와글와글 로고"/> 
	    </div>
	</div>

    <div id="center">
        <div id="container">
            <div id="login-box">
	            <form action="/admin/login" method="post" id="adminlogin" name="adminlogin" onsubmit="return loginCheck();">
	            	<!-- header에서 id="board"이미 사용중이라서 board2로 함 -->
		            <div id="a">
		                <div class="text">
		                    아이디 &nbsp;&nbsp; <input type="email" name="admins_email" id="admin-email" placeholder="이메일을 입력하세요"/>
		                </div>
		                <div  class="text">
		                    비밀번호 <input type="password" id="admin-pwd" name="admins_pwd" placeholder="비밀번호를 입력하세요"/>
		                </div>
		                <div>
		                <div id="login_btn">
							<input type="button" id="loginbtn" value="로그인" onclick="loginCheck()">
		                </div>
	                	</div>
	            	</div>
	            </form>
            </div>
        </div>
    </div>
</body> 
</html>