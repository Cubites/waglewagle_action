<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sample</title>
<link rel="stylesheet" href="/resources/css/common/common.css">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="/resources/js/goods/goodsRead.js"></script>
<link rel="stylesheet" href="/resources/css/chat/chat.css">

<style>
/* 12- 15  오후 추가 모달 관련 css*/
.modal {
	position: absolute;
	width: 100%;
	height: 100%;
	min-height: 720px;
	left: 0;
	top: 0;
	display: none;
}

.modal-Content {
	border: 1px solid black;
	width: 400px;
	height: 200px;
	background: #fff;
	border-radius: 10px;
	position: relative;
	top: 45%;
	left: 50%;
	margin-top: -100px;
	margin-left: -200px;
	text-align: center;
	box-sizing: border-box;
	padding: 80px 0;
	line-height: 23px;
	color: #ed5565;
	z-index: 20;
}

#submitModal {
	display: flex;
	flex-direction: column;
	display: none;
}

#submitModalText+div {
	display: flex;
	flex-direction: row;
	width: auto;
	height: 100%;
	line-height: 30px;
	justify-content: space-evenly;
}

.submitFont {
	margin-top: 20px;
	color: black;
	font-weight: bold;
	border-color: 1px;
	display: inline-block;
	height: 30px;
	width: 70px;
	border-radius: 7px;
	cursor: pointer;
}

#submitModalText {
	color: #ed5565;
	font-weight: bold;
}

#submitModal-Content {
	padding: 60px 0;
}
/*모달 관련 css*/
</style>

<script>
	// 모바일로 접속했는지, 웹으로 접속했는지 확인하기
	if (navigator.platform !== "Win32") {
		location.href = "/auctions/${me.goods_id}"; 
	}

	//모달창에서 거래확정인지, 거래 파기인지 확인하기 위해
	let modalAction;
	$(function() {

		$("#auctionEnd").click(function() {
			showModal("거래를 확정하시겠습니까?<br> 한번 확정된 거래는 취소하실 수 없습니다.", "submit");
		})
		$("#reportUser").click(function() {
			goReportForm();
		})

		$("#inputbutton").click(function() {
			chatting();
		})

		let pressEvent = $("#chatinput").on("keyup", function(key) {

			if (key.keyCode == 13) {
				chatting();
			}

		})

	})

	function chatting() {

		let chatClone = document.querySelector(".chatme").cloneNode(true);
		chatClone.classList.remove("hide");
		let inputDom = document.querySelector("#chatinput");

		if (inputDom.value !== '') {
			let chatText = chatClone.querySelector(".chatContent");
			chatText.innerText = inputDom.value;
			chatSend(inputDom.value);
			inputDom.value = "";
			document.querySelector("#chatShowArea").appendChild(chatClone);

		}
	}

	function eventClear() {
		$("#chatinput").off("keyup");
	}

	function chatSend(text) {

		$.ajax({

			url : "/chat/send",
			type : "post",
			contentType : "application/x-www-form-urlencoded; charset=UTF-8",

			data : {
				"chat_content" : text,
				"chat_send" : "${me.users_id}",
				"chat_recieve" : "${oppsite.users_id}",
				"goods_id" : "${me.goods_id}"
			},
			success : function(data) {
				
			}

		})
	}

	//텍스트에 대해 모달창 보여주는 함수
	function showModal(text, command) {

		if (command !== "submit" && command !== "report") {
			let modalContent = $("#basicModal-Content");
			modalContent.text(text);
			$("#basicModal").fadeIn();
			return false;
		}
		let submitModal = $("#submitModalText");
		submitModal.html(text);
		modalAction = command;
		$("#submitModal").fadeIn();
		return true;

	}

	//모달창에서ok를 누르면!  
	function isOk(status) {

		if (status === true) {
			//ajax보내는 함수 정의
			auctionEnd();
		}

		$("#submitModal").fadeOut();

	}
	//모달 관련 함수 끝

	function goReportForm() {

		let submitForm = $("#reportForm");
		submitForm.submit();

	}
	
	function auctionEnd(){
		
		$.ajax({
			
			url:"/auctions/end/${me.goods_id}",
			type:"post",
			data:{"auctions_end_seller":"${me.auctions_ing_seller}",
				"auctions_end_buyer":"${me.auctions_ing_buyer}",
				"auctions_end_price":"${me.auctions_ing_price}",
				"goods_id":"${me.goods_id}"},
			contentType:"application/x-www-form-urlencoded;charset=utf-8",
			success:function(data){
				
				showModal(data,"result");
				setTimeout(() => {
				location.href="/mypage/auctions_end_bought";
				}, 2000);
			},
			error:function(xhr){
				
				showModal(xhr.responseText,"reject");
	   			setTimeout(() => {
	   				location.reload(true);
					}, 2000);
			}
			
			
		})
		
	}
	
	
	
	
</script>


</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp"%>
	<%@ include file="/WEB-INF/views/common/quickmenu.jsp" %>
	<div id="center">
		<div id="container">

			<div id="wrap">
				<!--  
				<form id="reportForm" action="/report/user" method="get"
					style="display: none;" enctype="application/x-www-form-urlencoded">
					<input type="hidden" name="users_id" value="${oppsite.users_id}">
					<input type="hidden" name="goods_id" value="${oppsite.goods_id}">
					<input type="hidden" name="reports_type" value=0>
				</form>
				 -->
				<form id="reportForm" action="/report/user/${oppsite.users_id}/${me.users_id}/0/${oppsite.goods_id}" method="get"
					style="display: none;">
					
				</form>
				<div id="chatBoxes">

					<div id="leftBox1">
						<div id="imgBox">
							<div id="imgleft" class="imgButton">
								<img src="/resources/images/chat/realLeft.jpg" alt="">
							</div>
							<div id="imgContainer">
								<div id="imgContent">

									<div id="imagewrap">
										<div id="slideList">
											<!-- 업로드된 이미지 받아오기 -->
											<img class="imgs" src="/upload${me.goods_th_img}" />
											<c:forEach items="${images}" var="img" begin="0">
												<c:if test="${img.images_loc != me.goods_th_img}">
													<img class="imgs" src="/upload${img.images_loc}" />
												</c:if>
											</c:forEach>
										</div>
									</div>

								</div>
								<div id="textContent">
									<div id="goodsTitle">
										<span>판매상품</span> <span id="titleContent">${me.goods_title}</span>
									</div>

									<div id="seller">

										<c:choose>
											<c:when test="${me.memberType eq 'seller'}">
												<span>판매자</span>
												<span>${me.users_nick}</span>
											</c:when>
											<c:otherwise>
												<span>판매자</span>
												<span>${oppsite.users_nick}</span>
											</c:otherwise>
										</c:choose>

									</div>

									<div id="actionPrice">
										<span>낙찰 가격</span><span>${me.auctions_ing_price}</span>
									</div>

									<div id="addr">


										<c:choose>
											<c:when test="${me.memberType eq 'seller'}">
												<span>거래 장소</span>
												<span>${me.users_address}</span>
											</c:when>
											<c:otherwise>
												<span>거래 장소</span>
												<span>${oppsite.users_address}</span>
											</c:otherwise>
										</c:choose>

									</div>

								</div>
							</div>
							<div id="imgRight" class="imgButton">
								<img src="/resources/images/chat/realRight.jpg" alt="">
							</div>
						</div>
						<c:if test="${me.memberType eq 'buyer'}"> 
						<div id="mobileNotification">
							<div id="notice1">
								<img src="/resources/images/chat/light.jpg" alt="">
								<div>
									모바일로 '<span>거래 확정하기</span>'가 가능해요!
								</div>
							</div>
							<div id="notice2">제품을 받고 거래 확정하기를 반드시 눌러주세요.</div>
						</div>
						
						<div class="leftbutton" id="auctionEnd">
							<img id="endImg" src="/resources/images/chat/ok.png" alt="" />
							<div id="endFont">거래 확정하기</div>
						</div>
						<div class="leftbutton" id="reportUser">
							<img id="reportImg"
								src="/resources/images/chat/Danger Square.png" alt="" />
							<div id="reportFont">거래 파기 신고하기</div>
						</div>
						</c:if>
					</div>


					<div id="right">
						<div id="textArea">
							<div id="placeholders">
								<span id="place1">거래완료를 위해 쪽지를 주고 받으세요.</span> <span>(거래장소,시간정하기)</span>
							</div>

							<div id="chatShowArea">


								<c:forEach items="${chats}" var="chat">

									<c:choose>

										<c:when test="${chat.chat_send eq me.users_id}">

											<!-- 나의 영역 -->
											<div class="chatme">
												<div class="chatNick" id="myNick">${users_info.users_nick}</div>
												<div class="imgAndContent">

													<div>
														<img class="chatimg" src="/upload/${me.users_image}"
															alt="">
													</div>

													<div class="chatContentWrap">
														<div class="chatContent">${chat.chat_content}</div>
													</div>

												</div>
											</div>
											<!--         -->

										</c:when>

										<c:otherwise>

											<!-- 상대방 영역 -->
											<div class="chatop">
												<div class="chatNick" id="opNick">${oppsite.users_nick}</div>
												<div class="imgAndContent">
													<div>
														<img class="chatimg" src="/upload/${oppsite.users_image}"
															alt="">
													</div>

													<div class="chatContentWrap">
														<div class="chatContent">${chat.chat_content}</div>
													</div>

												</div>
											</div>
											<!--         -->

										</c:otherwise>

									</c:choose>

								</c:forEach>




								<!-- 상대방 영역 -->
								<div class="chatop hide">
									<div class="chatNick" id="opNick">${oppsite.users_nick}</div>
									<div class="imgAndContent">
										<div>
											<img class="chatimg" src="/upload/${oppsite.users_image}"
												alt="">
										</div>

										<div class="chatContentWrap">
											<div class="chatContent"></div>
										</div>

									</div>
								</div>
								<!--         -->

								<!-- 나의 영역 -->
								<div class="chatme hide">
									<div class="chatNick" id="myNick">${users_info.users_nick}</div>
									<div class="imgAndContent">

										<div>
											<img class="chatimg" src="/upload/${me.users_image}" alt="">
										</div>

										<div class="chatContentWrap">
											<div class="chatContent"></div>
										</div>

									</div>
								</div>
								<!--         -->

							</div>

						</div>


						<div id="chatInputArea">
							<div id="chatinputwrap">
								<input type="text" id="chatinput">
								<div id="inputbutton">보내기</div>
							</div>
						</div>

					</div>


				</div>
			</div>


		</div>
	</div>

	<!-- 모달창 -->
	<div id="basicModal" class="modal">
		<div id="basicModal-Content" class="modal-Content"></div>
	</div>

	<div id="submitModal" class="modal">
		<div id="submitModal-Content" class="modal-Content">
			<div id="submitModalText"></div>
			<div>
				<div id="modalOk" onclick="isOk(true)">
					<span class="submitFont">확인</span>
				</div>
				<div id="modalCancle" onclick="isOk(false)">
					<span class="submitFont">취소</span>
				</div>
			</div>
		</div>
	</div>
	<!-- 모달창 끝 -->

	<%@ include file="/WEB-INF/views/common/footer.jsp"%>

	<script src="/resources/js/goods/slideChat.js"></script>
	<script src="/resources/js/goods/slide.js"></script>
</body>
</html>