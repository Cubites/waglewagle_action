<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>포인트 충전</title>
<link rel="stylesheet" href="/resources/css/common/common.css">
<link rel="stylesheet" href="/resources/css/payment/payment.css">
</head>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<!-- iamport.payment.js -->
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<script type="text/javascript">
	
	// 금액 추가하는 함수
	function addAmount(e) {
		// 입력값
		const addValue = parseInt(e.target.value, 10);
		// 원래 값 (정수로 변환한 값이 NaN이라면 0으로 변환)
		const originalValue = isNaN(parseInt($('#amount_input').val(), 10)) ? 0 : parseInt($('#amount_input').val(), 10);
		// 정수로 변환한 값을 더해줌
        document.getElementById('amount_input').value = originalValue + addValue;
		// 입력한 값 확인하는 함수 실행 
        checkAmount();
	}
	
	// 금액 확인하는 함수
	function checkAmount() {
		if ($('#amount_input').val() < 1000) {
			$('#amount_p').show();
			$('#payment_btn').attr("disabled", true);
			$('#payment_btn').css("background-color", "#858585");

		} else {
			$('#amount_p').hide();
			$('#payment_btn').attr("disabled", false);
			$('#payment_btn').css("background-color", "#CF5C5C");
		}
	}
	
	// 결제하는 함수
	function possiblePayment() {
		if ($('#payment_btn').attr("disabled") === undefined) {
			// 내 상점의 가맹점 식별코드 입력
			IMP.init("imp65015223");
			IMP.request_pay({
			    pg: "inicis",
			    pay_method: "card",
			    name : '결제테스트',
			    amount : $('#amount_input').val(),
			    buyer_name : '구매자'
			  }, function (rsp) { // callback
				  	console.log('->>', rsp);
				    if (rsp.success) {
				    	$.ajax({
				    		type: "post",
				    		async: true,
				    		url: "/payment",
				    		dataType: "text",
				    		data: {
				    			paylog_cash: rsp.paid_amount,
				    			paylog_type: rsp.pay_method
				    		},
				    		success: function(data, textStatus) {
						      	if (data!=="") {
						      		console.log("결제 완료!")
						      		alert("결제가 완료되었습니다.");
							      	location.href = "/mypage/auctions";
						      	} else {
						      	    alert("결제 완료에 실패하였습니다.");
						      	}
				    		},
				    		error: function(data, textStatus) {
				    			alert("결제 완료에 실패하였습니다.")
				    		}
				    	})
				    } else {
				      var msg = '결제에 실패하였습니다.';
				      msg += '에러내용 : ' + rsp.error_msg;
				      alert(msg);
				    }
			  });
		} else {
			alert("금액을 다시 입력해주세요.")
		}
	}
</script>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp"%>
	<%@ include file="/WEB-INF/views/common/quickmenu.jsp" %>
	<div id="center">
		<div id="container">
			<!-- 이 주석부터 -->
			<div id="title">
				<div id="wallet_img"></div>
				<p id="title_p1">충전하기</p>
				<p id="title_p2">원하는 금액을 포인트로 충전할 수 있어요!</p>
			</div>
			<div id="content">
				<div id="content_box">
					<div id="content_box_top">
						<p id="content_p1">충전 금액</p>
						<p id="content_p2">충전하고 싶은 금액을 입력해주세요</p>
					</div>
					<div id="content_box_center">
						<div id="content_btns">
							<input type="button" value="1000" id="amount_btn" onClick="addAmount(event)">
							<input type="button" value="10000" id="amount_btn" onClick="addAmount(event)"> 
							<input type="button" value="50000" id="amount_btn" onClick="addAmount(event)"> 
							<input type="button" value="직접입력" id="amount_btn">
						</div>
						<div>
							<input type="text" placeholder="금액을 입력하세요." id="amount_input" onChange="checkAmount()">
							<p id="amount_p">최소 1,000원 이상을 입력해주세요.</p>
						</div>
					</div>
					<input type="button" value="결제하기" id="payment_btn" onClick="possiblePayment()">
				</div>
			</div>
		</div>
		<!-- 이 주석까지 지우고 작업하세요 -->
	</div>
	<%@ include file="/WEB-INF/views/common/footer.jsp"%>
</body>
</html>