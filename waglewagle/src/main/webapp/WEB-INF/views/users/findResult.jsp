<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 찾기</title>
<link rel="stylesheet" href="/resources/css/common/common.css">
<link rel="stylesheet" href="/resources/css/users/findResult.css">
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script>
	$(function(){
		
		if("${result_type}" === 'find_id'){
			$("#formHeader").val("아이디 찾기");
			if("${users_email}" === 'NOT_EXIST'){
				$("#resultArea").addClass("hide");
				$("#resultArea_null").removeClass("hide");
			}else{
				$("#resultArea").removeClass("hide");
				$("#resultArea_null").addClass("hide");
			}
		}else{
			$("#formHeader").text("비밀번호 찾기");
			$("#resultArea").addClass("hide");
			$("#resultArea_null").removeClass("hide");
			
		}
	})
</script>
</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp"%>
	
	<div id="center">
		<div id="container">
			<div id="findFormArea">
				<div id="formHeaderArea">
					<div id="formHeader">아이디 찾기</div>
				</div>
				<div id="formContent">
					<!-- 아이디 있을 때  -->
					<div id="resultArea" class="">
						<div id="resultTxt1">
							<div class="textAlignCenter">고객님의 와글와글 아이디는</div>
						</div>
						<div id="resultTxt2">
							<div class="textAlignCenter"> ${users_email } 입니다.</div>
						</div>
						
						<div id="btnArea">
							<input type="button" id="toLogin"
								onclick="location.href='/users/login';" class="btn" value="로그인 페이지">
						</div>
					</div>
					
					<!-- 아이디 없을 때 -->
					<div id="resultArea_null" class="hide">
						<div id="resultTxt3">
							<div class="textAlignCenter">가입정보가 존재하지 않습니다.</div>
						</div>
						<div id="resultTxt4">
							<div class="textAlignCenter">아직 회원이 아니십니까?</div>
						</div>
						
						<div id="btnArea">
							<input type="button" id="toLogin"
								onclick="location.href='/users/join';" class="btn" value="회원가입 페이지">
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/common/footer.jsp"%>
</body>
</html>