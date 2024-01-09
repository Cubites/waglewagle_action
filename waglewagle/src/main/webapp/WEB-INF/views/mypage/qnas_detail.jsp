<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="/resources/css/mypage/qnas_detail.css">
	<script src="/resources/js/mypage/qnaRead.js"></script>
</head>
<body>
	<div id="qnaDetailContainer">
		<div id="qnaDetailBox">
			<div id="qnaTitle">
				<div>문의제목</div>
				<div>${qnaDetail.qnas_title}</div>
			</div>
			<div id="qnaContent">
				<div>문의내용</div>
				<div>${qnaDetail.qnas_content}</div>
			</div>
			<div id="qnaReply">
				<div>문의답변</div>
				<div>${qnaDetail.qnas_reply == null ? "" : qnaDetail.qnas_reply}</div>
			</div>
			<div id="goToListButton">문의 목록으로</div>
		</div>
	</div>
	<script>
		$("#goToListButton").click(function(){
		    location.href = "/mypage/qnas";
		})
	</script>
</body>
</html>