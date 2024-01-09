<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="/resources/css/mypage/auctions.css">
</head>
<body>
	<div id="auctionsContainer">
		<div id="acTitle">'<span>${users_info.users_nick}</span>'님의 경매중인 목록</div>
		<div id="itemsList">
			<c:if test="${fn:length(ListData) == 0}">
				<div id="noItems">거래 중인 상품이 없습니다.</div>
			</c:if>
			<c:if test="${fn:length(ListData) != 0}">
			<!-- 경매 중인 상품 반복 -->
			<c:forEach var="item" items="${ListData}">
				<a class="itemBox auctionsItem" href="/goods/${item.goods_id}">
					<img class="wayMark" src='/resources/images/${item.bids_price != null ? "buy_icon.png" : "sell_icon.png"}'>
					<img class="goodsThumb" src="/upload/${item.goods_th_img}">
					<div class="itemTitle">${item.goods_title}</div>
					<div class="varPriceBox">
						<c:if test="${item.bids_price != null}">
							호가 : <fmt:formatNumber value="${item.bids_price}" pattern="#,###" />원
						</c:if>
					</div>
					<div class="staticValuesBox">
						<p>시작가 : <fmt:formatNumber value="${item.goods_start_price}" pattern="#,###" />원</p>
						<p>평균가 : <fmt:formatNumber value="${item.goods_avg_price}" pattern="#,###" />원</p>
						<p>마감일 : <fmt:formatDate value="${item.post_date}" pattern="yyyy.MM.dd"/></p>
					</div>
					<c:if test="${item.goods_access == 1}">
						<div class="blockBoxForAccess">
							<p>접근 금지된 상품입니다.</p>
							<p>(누르면 메인 페이지로 넘어갑니다)</p>
						</div>
					</c:if>
				</a>
			</c:forEach>
			<!-- /경매 중인 상품 반복 -->
			</c:if>
		</div>
		<!-- pagination -->
		<div id="pagingBox">
			<ul>
				<c:if test="${pageNum10 != 0}">
					<li><a href="/mypage/auctions?page=${pageNum10}&scroll=0">&#60;</a></li>
				</c:if>
				<c:forEach var="num" begin="${pageNum10 + 1}" end="${(pageNumMax - pageNum10) < 10 ? pageNumMax : pageNum10 + 10}" step="1">
					<c:if test="${pageNum1 == num}">
						<li class="nowPage">
							<a href="/mypage/auctions?page=${num}&scroll=0">${num}</a>
						</li>
					</c:if>
					<c:if test="${pageNum1 != num}">
						<li>
							<a href="/mypage/auctions?page=${num}&scroll=0">${num}</a>
						</li>
					</c:if>
				</c:forEach>
				<c:if test="${(pageNumMax - pageNum10) > 10}">
					<li><a href="/mypage/auctions?page=${pageNum10 + 11}&scroll=0">&#62;</a></li>
				</c:if>
			</ul>
		</div>
		<!-- /pagination -->
	</div>
	<script>
		// 목록 페이지 넘어갈 때 스크롤 높이 고정
		window.scrollTo({top: "${scrollY}"});
		window.addEventListener("scroll", () => {
			let scrollVal = window.scrollY;
			let aTags = document.getElementById("pagingBox").querySelectorAll("a");
			for(let aa of aTags){
			    aa.href = aa.href.substr(0, aa.href.indexOf("&scroll=")) + "&scroll=" + scrollVal;
			}
		});
		
		function goToGoods(goods_id){
		    $.ajax({
		        url: "/update/favor_areas",
		        type: 'post',
				contentType: 'application/json',
		        data: JSON.stringify({
					addr: areasStr
				}),
		        success: function(data) {
					if(data){
						alert("괌시지역이 저장되었습니다.");
					} else {
						alert("관심지역 저장이 되지 않았습니다. 잠시 후에 다시 시도해주세요.");
					}
				}
			});
		}
	</script>
</body>
</html>