<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="/resources/css/common/common.css">
	<link rel="stylesheet" href="/resources/css/qna/main.css">
	<script src="https://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp" %>
	<%@ include file="/WEB-INF/views/common/quickmenu.jsp" %>
	<div id="center">
		<div id="container">
			<div id="qnaBox">
				<div id="qnaTitleBox">
					<div>문의제목</div>
					<input type="text" placeholder="문의제목을 입력해주세요.">
				</div>
				<div id="qnaContentBox">
					<div>문의내용</div>
					<textarea placeholder="문의내용을 입력해주세요."></textarea>
				</div>
				<div id="qnaSubmitButton" class="dragBlock">문의하기</div>
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
	<script>
		$("#qnaSubmitButton").click(function(){
		    if($("#qnaTitleBox > input").val() == "" || $("#qnaTitleBox > input").val() == null){
				alert("문의 제목을 입력해주세요.");
				$("#qnaTitleBox > input").focus();
		    }else if($("#qnaContentBox > textarea").val() == "" || $("#qnaContentBox > textarea").val() == null){ 
		    	alert("문의 내용을 입력해주세요.");
		    	$("#qnaContentBox > textarea").focus();
			}else{
				$.ajax({
				    url: "/boards/qnas/write",
				    type: "post",
				    contentType: 'application/json',
				    data: JSON.stringify({
						title: $("#qnaTitleBox > input").val(),
						content: $("#qnaContentBox > textarea").val() 
				    }),
				    success: function(data) {
						if(data){
						    alert("문의가 정상적으로 접수되었습니다.");
						    location.href="/mypage/qnas";
						} else {
						    alert("문의 접수 중 문제가 발생하였습니다. 잠시 후 다시 시도해주세요.");
						}
				    }
				});
		    }
		});
		
	</script>
</body>
</html>