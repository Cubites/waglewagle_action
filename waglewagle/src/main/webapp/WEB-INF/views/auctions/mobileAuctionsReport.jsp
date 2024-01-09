<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>거래 확정 신고 모바일 버전</title>
    <link rel="stylesheet" href="/resources/css/auctions/mobileAuctionsReport.css">
</head>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<body>
    <div id="container">
        <div id="logo">
        </div>
        <div id="content">
            <div id="report_reasons">
                <input type="checkbox" id="toggle" hidden>
                <label for="toggle" id="toggle-label" onclick="clickToggle()">
                    <img src="/resources/images/mobile/toggle_img.png" id="toggle_img">
                    <p id="before_select">신고 사유 선택하기</p>
                    <p id="after_select_1">"이미지와 실제 상품이 너무 다름"</p>
                    <p id="after_select_2">"판매자가 거래 장소에 나오지 않음"</p>
                    <p id="after_select_3">"기타 사유"</p>
                </label>
                <ul id="menu">
                    <li class="menu-item" value="1" onclick="clickReason(event)">이미지와 실제 상품이 너무 다름</li>
                    <li class="menu-item" value="2" onclick="clickReason(event)">판매자가 거래 장소에 나오지 않음</li>
                    <li class="menu-item" value="3" onclick="clickReason(event)">기타 사유</li>
                </ul>
            </div>
            <textarea id="report_detail" placeholder="신고 사유를 &#13;&#10; 상세히 작성해주세요."></textarea>
        </div>
        <div id="btns">
            <div id="report_com">
                <div id="report_com_space" onClick="submitReport()">
                    <img src="/resources/images/mobile/complete_img.png" id="com_img">
                    <div id="report_com_btn">신고하기</div>
                </div>
            </div>
            <div id="back">
                <div id="back_space" onClick="goBack()">
                    <img src="/resources/images/mobile/back_img.png" id="back_img">
                    <div id="back_btn">돌아하기</div>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
		
		// 신고할 제목과 내용
		var report_title = "";
		var report_content = "";
		
		// 신고 사유 토글 보였다 안보였다 하는 함수
		function clickToggle() {
			const menu = document.getElementById('menu');
			menu.style.height = "20vh";
			menu.style.minHeight = "10vh";
			menu.style.opacity = 1;
		}
			
		
		// 선택한 신고 사유 보이도록 하는 함수
		function clickReason(e) {
			const reason = e.target.value;
			if (reason == 1) {
				$("#after_select_1").show();
				$("#before_select").hide();
				$("#after_select_2").hide();
				$("#after_select_3").hide();
				$("#toggle_img").hide();
				report_title = "0"
			} else if (reason == 2) {
				$("#after_select_2").show();
				$("#before_select").hide();
				$("#after_select_1").hide();
				$("#after_select_3").hide();
				$("#toggle_img").hide();
				report_title = "1"
			} else {
				$("#after_select_3").show();
				$("#before_select").hide();
				$("#after_select_1").hide();
				$("#after_select_2").hide();
				$("#toggle_img").hide();
				report_title = "2"
			}
			// 토글 자동으로 닫기
			const menu = document.getElementById('menu');
			menu.style.height = 0;
			menu.style.minHeight = 0;
			menu.style.opacity = 0;
		}
		
		
		// 신고 접수 되는 함수
		function submitReport() {
	        // URL에서 "goods_id" 파라미터 값을 추출
			var currentUrl = window.location.pathname;
	        var goods_id = currentUrl.split('/')[3];
	
			report_content = document.getElementById('report_detail').value;
			if (report_title === "") {
				alert("신고 사유를 선택해주세요!")
			} else if (report_content === "") {
				alert("신고 사유를 상세히 작성해주세요!")
			} else if (confirm("정말 신고하실 건가요?")) {
				report_data = report_title + " - "+ report_content
				$.ajax({
					type: "post",
					async: true,
					url: "/auctions/report/comfirm/" + goods_id,
					dataType: "text",
					data : {
						report_data: report_data
					},
					success: function(data, textStatus) {
						if (data != "ok") {
							alert("신고가 불가능한 물품입니다.");	
						} else {
							location.href = "/auctions/report/complete";							
						}
					},
					error: function(data, textStatus) {
						alert("신고가 처리되지 않았습니다. 다시 시도해주세요.")
					}
				})
			}
			
		}
		
		// 뒤로 돌아가는 함수
		function goBack() {
			if (confirm("정말 되돌아가실 건가요?")) {
				location.href = "/auctions";			
			}
		}
	</script>
</body>
</html>