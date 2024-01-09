<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 페이지</title>
	<link rel="stylesheet" href="/resources/css/common/common.css">
	<link rel="stylesheet" href="/resources/css/users/login.css">
	<script src="https://code.jquery.com/jquery-latest.min.js"></script>
	<script src="/resources/js/users/login.js"></script>
</head>

<body>
	<%@ include file="/WEB-INF/views/common/header.jsp"%>
	<div id="center">
		<div id="container">
			<div id="loginFormArea">
				<div id="formHeader">로그인</div>
				<div id="formContent">
					<form id="loginForm" method="post" action="/users/login">
						<!-- input data  -->
						<div id="inputArea">
							<div id="emailArea">
								<div class="formText">아이디</div>
								<input type="text" size="35" class="formInput" id="users_email" name="users_email">
							</div>
							<div id="passwordArea">
								<div id="pwd">
									<div class="formText">비밀번호</div>
									<input type="password" size="35" class="formInput" id="users_pwd" name="users_pwd">
								</div>
								<div id="findInfoArea">
									<div id="findInfo">
										<a href="find_info">아이디/비밀번호 찾기</a>
									</div>
								</div>
							</div>
								
						</div>

						<!-- submit 버튼 -->
						<div id="buttonArea">
							<div id="loginBtnArea">
								<input type="button" class="btn" id="loginBtn" value="로그인">
							</div>
							<div id="joinBtnArea">
								<input type="button" class="btn" id="joinBtn" onclick="location.href='join';" value="회원가입">
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/common/footer.jsp"%>
</body>
</html>