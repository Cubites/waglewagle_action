<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sample</title>
<link rel="stylesheet" href="/resources/css/common/common.css">
<link rel="stylesheet" href="/resources/css/report/report.css">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">


	let reportResult = "${result}";
	
	$(function() {
		

		$("#submit").click(function() {

			showmodal("정말로 신고하시겠습니까?","report");

		});
		
		if (reportResult !== "") {
			
			showmodal(reportResult,"result");
		}
		
		
		

	})

	function showmodal(text, status) {
		
		
		if (status === "result") {

			let modalContent = $("#basicModal-Content");
			modalContent.text(text);
			$("#basicModal").fadeIn();
			
			setTimeout(()=>{
				$("#basicModal").fadeOut();
			},2000)
			
			//신고 완료 후 다시 돌아가는 페이지 (유저신고인 경우 main으로 일단 보냄)
			if("${path}" === "" ){
				
			setTimeout(() => {
				location.href="/goods/${goods_id}";				
			}, 1000);
			
			}else{
			
			setTimeout(() => {
				location.href="${path}";				
			}, 1000);
				
			}
		}else{

		let submitModal = $("#submitModalText");
		submitModal.html(text);
		$("#submitModal").fadeIn();
		}

	}

	function isOk(status) {

		if (status === true) {
			let reportType = $("#reson option:selected").val();
			let reportContent = $("#textBox").val().trim();
			let result = reportType+"-"+reportContent;
			$("#report_content").val(result);
			$("#reportForm").submit();

		}else{
			
		
		}

		$("#submitModal").fadeOut();
	}
	
	function goback(url){
		if(isGoodsReport()){
		location.href="/goods/"+url;
		}else{
			location.href="/chat/"+url;
		}
	}
	
	function isGoodsReport(){
		if("${report}" === ""){
			return true
		}
		return false;
	}
</script>

<style type="text/css">
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

#reson {
	width: 100%;
	height: 100%;
	border: none;
	border-radius: 10px;
}
</style>
</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp"%>
	<%@ include file="/WEB-INF/views/common/quickmenu.jsp"%>
	<div id="center">
		<div id="container">
			<div id="wrap">
				<c:choose>
					<c:when test="${empty report}">
						<form id="reportForm" action="/report/goods" method="post"
							enctype="application/x-www-form-urlencoded"
							style="display: none;">
							<input type="hidden" value="${goods.users_id}" name="users_id">
							<input type="hidden" value="${goods.goods_id}" name="goods_id">
							<input type="hidden" value="1" name="reports_type"> <input
								type="hidden" name="reports_content" id="report_content">
						</form>

					</c:when>
					<c:otherwise>

						<form id="reportForm" action="/report/goods" method="post"
							enctype="application/x-www-form-urlencoded"
							style="display: none;">
							<input type="hidden" value="${report.users_id}" name="users_id">
							<input type="hidden" value="${report.goods_id}" name="goods_id">
							<input type="hidden" value="0" name="reports_type"> <input
								type="hidden" name="reports_content" id="report_content">
						</form>

					</c:otherwise>

				</c:choose>

				<div id="reportBox">
					<c:choose>
						<c:when test="${empty report}">
							<div id="reportTop">${goods.goods_title}</div>
						</c:when>
						<c:otherwise>
							<div id="reportTop">
								<select id="reson" name="reson">
									<option id="reson1" value=0>이미지와 실제 상품이 너무 다름</option>
									<option id="reson2" value=1>판매자가 거래 장소에 나오지 않음</option>
									<option id="reson3" value=2>기타 사유</option>
								</select>
							</div>
						</c:otherwise>
					</c:choose>
					<div id="reportMid">
						<textarea id="textBox"
							placeholder="&#13;&#10;신고 사유를 자세하게 적어주세요 &#13;&#10;&#13;&#10;- 부적절한 상품 &#13;&#10;&#13;&#10;- 과도한 가격 &#13;&#10;&#13;&#10;- 사기 전과가 있는 판매자"></textarea>

					</div>


					<div id="reportFooter">
						<div id="submit">신고하기</div>
						<c:choose>
							<c:when test="${empty report}">
								<div id="cancle" onclick="goback('${goods.goods_id}')">돌아가기</div>
							</c:when>
							<c:otherwise>
								<div id="cancle" onclick="goback('${report.goods_id}')">돌아가기</div>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</div>
		</div>
	</div>





	<%@ include file="/WEB-INF/views/common/footer.jsp"%>
	<!-- 모달창 -->
	<div id="basicModal" class="modal">
		<div id="basicModal-Content" class="modal-Content"></div>
	</div>
	<!-- 확인 취소 모달 -->
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
	<!-- 새로고침용 -->
	<form id="reportForm" action="/report/user" method="post"
		style="display: none;" enctype="application/x-www-form-urlencoded">
		<input type="hidden" name="users_id" value="${report.users_id}">
		<input type="hidden" name="goods_id" value="${report.goods_id}">
		<input type="hidden" name="reports_type" value=0>
	</form>
</body>
</html>