<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
    <title>거래 확정 모바일 버전</title>
    <link rel="stylesheet" href="/resources/css/auctions/mobileAuctions.css">
</head>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<body>
    <div id="container">
        <div id="logo">
        </div>
        <div id="content">
            <img id="auction_img" src="/upload/${auction_ing_info.goods_th_img }">
				
            <div id="auction_goods">
                <div id="auction_title">
                    <div id="title">
                        판매 상품
                    </div>
                    <div id="goods_title">${auction_ing_info.goods_title }</div>
                </div>
                <div id="auction_price">
                    <div id="price">
                        낙찰 가격
                    </div>
                    <div id="goods_price">${auction_ing_info.auctions_ing_price }원</div>
                </div>
                <div id="auction_comment">
                    해당 상품의 거래가 완료되었나요?
                </div>
            </div>
        </div>
        <div id="btns">
            <div id="auc_com">
                <div id="auc_com_space" onClick="completeAuction(${auction_ing_info.goods_id })">
                    <img src="/resources/images/mobile/complete_img.png" id="com_img">
                    <div id="auc_com_btn">거래 완료하기</div>
                </div>
            </div>
            <div id="report">
                <div id="report_space" onClick="goReport(${auction_ing_info.goods_id })">
                    <img src="/resources/images/mobile/report_img.png" id="report_img">
                    <div id="auc_report_btn">거래 파기 신고하기</div>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
    	// 거래 완료하기
    	function completeAuction(goods_id) {
    		if (confirm("정말 거래가 완료되었나요?")) {
    			$.ajax({
    				type: "post",
    				async: true,
    				url: "/auctions/comfirm/" + goods_id,
    				success: function(data, textStatus) {
    					location.href = "/auctions/complete";
    				},
    				error: function(data, textStatus) {
						alert("거래 완료가 처리되지 않았습니다. 다시 시도해주세요.")
					}
    			})
    		}
    	}
    	// 신고하러 이동
    	function goReport(goods_id) {
    		location.href = "/auctions/report/" + goods_id;
    	}
    	
    </script>
</body>
</html>