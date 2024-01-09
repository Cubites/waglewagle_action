<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 찾기</title>
<link rel="stylesheet" href="/resources/css/common/common.css">
	<link rel="stylesheet" href="/resources/css/users/changePwd.css">
	<script src="https://code.jquery.com/jquery-latest.min.js"></script>
	<script src="/resources/js/users/changePwd.js"></script>
</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp"%>
	<div id="center">
		<div id="container">
			<div id="findFormArea">
				<div id="formHeaderArea">
					<div id="formHeader">비밀번호 변경하기</div>				
				</div>
				<div id="formContent">
					<form id="changePwdForm" method="post" action="/users/change_pwd">
						<!-- input data : change pwd -->
						<div id="inputAreaChangePwd">
							<div id="passwordArea">
								<div id="pwd1">
									<div class="formText">비밀번호</div>
									<input type="password" size="40" class="formInput" id="users_pwd" name="users_pwd" placeholder="영문,특수문자,숫자 포함 8자 이상"><br>
								</div>
								<div id="pwd2">
									<div class="formText">비밀번호 확인</div>
									<input type="password" size="40" class="formInput" id="users_pwd2">
									<div class="flex-end">
										<div id="pwdCheckTxt">비밀번호가 일치하지 않습니다.</div>
									</div>
								</div>
							</div>
						</div>
						<div><input type="hidden" name="users_id" value="${vo.users_id }"></div>
						<div id="btnArea">
							<input type="button" id="changeBtn" class="btn" value="비밀번호 변경하기">
						</div>
						
					</form>	
				</div>
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/common/footer.jsp"%>
</body>
</html>