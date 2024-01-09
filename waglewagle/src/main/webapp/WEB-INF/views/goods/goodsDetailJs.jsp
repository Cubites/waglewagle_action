<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

	<script>

		//유저의 찜상태 체크
		var userlike = "${userFavor}" === 'true';
		var expDate = "${goods.goods_exp}";
		$(function () {
			
			$("#goPayment").click(function(){
				location.href = "/payment";
			})

			if ("${rejectmsg}" !== "") {

				showModal("${rejectmsg}", "result");
			}

			//신고하기 화면으로 넘어감
			$("#sirenimg").click(() => {
				location.href = "/report/${goods.goods_id}/${users_info.users_id}";
			});
			//숫자만 입력가능 및 콤마로 자동 변환 이벤트
			let inputDom = document.querySelector("#submitPoint > input");
			inputDom.addEventListener("input", function (e) {
				let val = e.target.value.replace(/[^0-9]/g, '');
				e.target.value = val.replace(/\d(?=(?:\d{3})+$)/g, '$&,');
			});
			////////////////////////////////////////

			//찜버튼 클릭 이벤트
			$("#likebox").click(function () {
				if (window.userlike === false) {
					$("#likeImage").attr("src", "/resources/images/goods/favorite.jpg");
					changeFavors(1);
				} else {
					$("#likeImage").attr("src", "/resources/images/goods/favorite_border.jpg");
					changeFavors(-1);
				}
				userlike = !userlike;
				storeUserFavor(userlike);
			})
			////////////////////////////////

			//잘못 입력에 대한 모달꺼지는 것 정의
			$("#basicModal").click(() => {
				$("#basicModal").fadeOut();
			})
			////////////////////////////////

			//시간 계산하는 기능 1초마다 실행되도록 함 
			setInterval(() => {
				displayRemainingTime();
			}, 1000);
			////////////////////////////////

			//DB에서 읽어온 주소 중 동만 읽어옴 
			displayDong();
			///////////////////////////


		})



		function displayRemainingTime() {

			//1일 05시간 30분
			const now = new Date();
			const end = new Date(window.expDate);
			const timeRemain = end - now;

			let timeString = "";
			if (timeRemain <= 0) {
				$("#timeVal").text("0일 0시간 0분");
				$("#timeVal").css({ "color": "#838383" });
				return;
			}
			const days = Math.floor(timeRemain / (1000 * 60 * 60 * 24));
			const hours = ("0" + Math.floor(timeRemain % (1000 * 60 * 60 * 24) / (1000 * 60 * 60))).slice(-2);
			const minutes = ("0" + Math.floor(timeRemain % (1000 * 60 * 60) / (1000 * 60))).slice(-2);
			const seconds = Math.floor(timeRemain % (1000 * 60) / 1000);



			$("#timeVal").text(days + "일 " + hours + "시간 " + minutes + "분");


		}

		//찜 버튼 관련 
		//찜버튼 눌렀을 때 좋아유 수 변화를 위해 
		function changeFavors(num) {
			let favorsDom = $("#jjimcnt");
			let val = Number(favorsDom.text()) + num;
			favorsDom.text(val);
		}



		//가격 검증 관련 (프론트 검증 물론 입력못하게 막아두긴함)
		function askingPriceCheck() {
			let askPriceDom = $("#submitPoint > input");
			let askPrice = askPriceDom.val();
			let askPriceNoComma = askPrice.replace(/,/g, "");

			//숫자 검증
			if (askPriceValidation(askPriceNoComma)) {
				//검증 완료 후 숫자 변환 

				showModal("제출하신 가격은 <span id='priceComma'>" + askPrice + "</span>원 입니다.<br>" +
					"한번 제출한 가격은 취소할 수 없습니다. <br>" +
					"계속 진행하시겠습니까?", "submit");

			}
		}
		//제출된 가격을 검사하는 함수
		function askPriceValidation(price) {
			var num = Number(price);
			//숫자가 아니거나, 정수가 아닐시
			if (Number.isNaN(num) || !Number.isInteger(num)) {
				showModal("제출된 가격을 확인해주세요", "reject");
				return false;
			} else if (num < 0) {
				showModal("0보다 작은 숫자는 입력하실 수 없습니다.", "reject");
				return false;
			}

			return true;

		}
		//텍스트에 대해 모달창 보여주는 함수
		function showModal(text, command) {

			if (command !== "submit") {
				let modalContent = $("#basicModal-Content");
				modalContent.text(text);
				$("#basicModal").fadeIn();
				return false;
			}
			let submitModal = $("#submitModalText");
			submitModal.html(text);
			$("#submitModal").fadeIn();
			return true;

		}

		//모달창에서ok를 누르면!  
		function isOk(status) {


			if (status === true) {
				//ajax보내는 함수 정의
				askPrice();
			}

			$("#submitModal").fadeOut();

		}
		//모달 관련 함수 끝

		function displayDong() {
			let jibun = "${goods.goods_address}".split(" ");

			let dong = jibun[jibun.length - 1];

			$("#dong").text(dong);

		}

		//찜버튼 눌렀을 때 DB에 반영 
		function storeUserFavor(status) {
			//users_info.users_id;
			$.ajax({
				url: "/goods/favor",
				type: "post",
				data: {
					"goodsId": "${goods.goods_id}",
					"status": userlike
				},
				success: function () {
				}
			});
		}
		/////////////////////////////////////


		function askPrice() {
			let askPriceDom = $("#submitPoint > input");
			let askPrice = askPriceDom.val();
			let askPriceNoComma = askPrice.replace(/,/g, "");

			$.ajax({
				url: "/bids/askPrice",
				type: "post",
				data: {
					"users_id": "${goods.users_id}", "goods_id": "${goods.goods_id}"
					, "bids_price": askPriceNoComma, "point_usable": "${usersPoint.point_usable}", "goods_start_price": "${goods.goods_start_price}"
				},
				contentType: "application/x-www-form-urlencoded;charset=utf-8",
				success: function (data) {
					console.log(data);
					showModal(data, "");
					setTimeout(() => {
						location.reload(true);
					}, 2000);
				},
				error: function (xhr, error, msg) {
					showModal(xhr.responseText, "reject");
					setTimeout(() => {
						location.reload(true);
					}, 2000);
				}
			})
		}






	</script>