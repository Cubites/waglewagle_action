<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/resources/css/common/quickmenu.css">
</head>
<body>
	<c:if test="${users_info != null }">
		<div id="quickContainer">
			<div id="users_id" class="hide">${users_info.users_id }</div>
			<div id="textContainer">
				<div id="bidAlertNotice">
					<a href="/mypage/auctions_ing">
						<div id="bidNotice">낙찰 알림</div>
					</a>
				</div>
				<div id="qnaNoticeArea">
					<a href="/mypage/qnas">
						<div id="qnaNotice">문의 알림</div>
					</a>
				</div>
			</div>
			<div id="imgContainer">
				<img alt="" src="/resources/images/default_profile.png">
			</div>		
		</div>
	</c:if>
</body>

<script>
$(document).ready(function(){
	  var currentPosition = parseInt($("#quickContainer").css("top"));
	  $(window).scroll(function() {
	    var position = $(window).scrollTop(); 
	    $("#quickContainer").stop().animate({"top":position+currentPosition+"px"},500);
	  });
	  
	  if($("#users_id").text() !== ""){
		  $.ajax({
				url:"/isCheckNotice_bid",
				data:{users_id : $("#users_id").text()},
				success: function(data){
					if(data === 'true'){ //알림 다 읽음
						$("#bidNotice").css("color", "black");
						isCheckEmailDup = false;
					}else{ //안 읽은 알림 있음
						$("#bidNotice").css("color", "red");
					}
				}
			})
	  }
	  
});

$(function(){
	if($("#users_id").text() !== ""){
	  $.ajax({
			url:"/isCheckNotice_qna",
			data:{users_id : $("#users_id").text()},
			success: function(data){
				if(data === 'true'){ //알림 다 읽음
					$("#qnaNotice").css("color", "black");
					isCheckEmailDup = false;
				}else{ //안 읽은 알림 있음
					$("#qnaNotice").css("color", "red");
				}
			}
		})
	}
})
</script>
</html>