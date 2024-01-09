<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>회원가입</title>
	<link rel="stylesheet" href="/resources/css/common/common.css">
	<link rel="stylesheet" href="/resources/css/users/join.css">
	<script src="https://code.jquery.com/jquery-latest.min.js"></script>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="/resources/js/users/join.js"></script>
</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp" %>
	<div id="center">
		<div id="container">
			<div id="joinFormArea">
				<div id="formHeader">회원가입</div>
				<div id="formContent">
					<form id="joinForm" method="post" action="/users/join">
						<!-- input data  -->
						<div id="inputArea">
							<div id="emailArea">
								<div class="formText">이메일</div>
								<div class="space-between" id="enterEmail">
									<input type="text" size="27" class="formInput" id="users_email" name="users_email"> <input type="button" class="basicBtn pinkBtn" value="이메일확인" id="isEmailDup"><br>
								</div>
								
								<div id="emailCheckText">이메일 체크 메세지</div>
								
								<div class="space-between">
									<div class="flex">
										<input type="text" size="10" id="validNum" class="formInput">
										<input type="text" size="2" id="timer" value="" readonly>
									</div>
									<div id="validButtons">
										<input type="button" class="pinkBtn" id="sendNum" value="인증번호 발송"><input type="button" id="validCheck" value="인증번호 확인"><br>
									</div>
								</div>
							</div>
							<div id="passwordArea">
								<div id="pwd1">
									<div class="formText">비밀번호</div>
									<input type="password" size="38" class="formInput" id="users_pwd" name="users_pwd" placeholder="영문,특수문자,숫자 중 2가지 이상 포함하여 8~20자로 작성해주세요"><br>
								</div>
								<div id="pwd2">
									<div class="formText">비밀번호 확인</div>
									<input type="password" size="38" class="formInput" id="users_pwd2">
								</div>
								<div class="flex-end">
									<div id="pwdCheckTxt">비밀번호가 일치하지 않습니다.</div>
								</div>
							</div>
							<div id="nickArea">
								<div class="formText">닉네임</div>
								<div  class="space-between">
									<input type="text" size="27" id="users_nick" name="users_nick" class="formInput"><input type="button" id="checkNickBtn" class="basicBtn pinkBtn" value="중복확인"><br>
								</div>
								<div id="nickCheckTxt">사용가능한 닉네임입니다.</div>
							</div>
							<div id="name_gender">
								<div id="nameArea">
									<div class="formText">이름</div>
									<input type="text" size="27" id="users_name" name="users_name" class="formInput"><br>
								</div>
								<div id="genderArea">	
									<div class="formText">성별</div>
									<select name="users_gender">
										<option value="0">남자</option>
										<option value="1">여자</option>
									</select>
								</div>
							</div>
							<div id="phoneArea">
								<div class="formText">연락처</div>
								<div id="phoneNumber">
									<select name="pn" id="phoneFront">
										<option value="010">010</option>
										<option value="011">011</option>
										<option value="016">016</option>
									</select>
									<input type="text" size="30" id="phoneBack" class="formInput" placeholder="'-'없이 입력해주세요"><br>
									<input type="hidden" id="phoneResult" name="users_phone" value="">
								</div>
							</div>
							<div id="dongArea">
								<div class="formText" id="interest_dong">관심 지역 설정</div>
								<!-- 주소검색 버튼
								<input type="button" onclick="sample4_execDaumPostcode()" value="주소검색하기"><br>
								 -->
								 
								<div id="addDongBtnArea">
									<div id="interest_dong1">
										<input type="button" class="addDongBtn" onclick="clickAddDong1()" value="+">
									</div>
									<div id="interest_dong2">
										<input type="button" class="addDongBtn" onclick="clickAddDong2()" value="+">
									</div>
									<div id="interest_dong3">
										<input type="button" class="addDongBtn" onclick="clickAddDong3()" value="+">
									</div>
								</div>
								<div name="dongResult">
									<input type="hidden" id="users_addr_list" name="users_addr_list" value="">
								</div>
							</div>
						</div>
						<!-- submit 버튼 -->
						<div id="submitArea">
							<input type="button" id="joinBtn" class="pinkBtn" value="회원가입">
						</div>
						
					</form>	
				</div>
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>