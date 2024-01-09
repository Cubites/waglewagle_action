<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="/resources/css/mypage/auctions.css">
	<link rel="stylesheet" href="/resources/css/mypage/auctions_end.css">
</head>
<body>
	<div id="auctionsContainer">
		<div id="acTitle">'<span>${users_info.users_nick}</span>'님의 구매 완료 목록</div>
		<div id="itemsList">
			<c:if test="${fn:length(ListData) == 0}">
				<div id="noItems">구매 완료된 상품이 없습니다.</div>
			</c:if>
			<c:if test="${fn:length(ListData) != 0}">
				<!-- 구매 완료 상품 반복 -->
				<c:forEach var="item" items="${ListData}">
					<a class="itemBox" href="#">
						<img class="wayMark" src='/resources/images/buy_icon.png'>
						<div 
							class="thumbnailBox"
							style="background-image: url('/upload/${item.goods_th_img}')"
						>
							<img class="stampImg" src="/resources/images/auctions_end_icon.png">
						</div>
						<div class="itemTitle">${item.goods_title}</div>
						<div class="varPriceBox">
							낙찰가 : <fmt:formatNumber value="${item.purchase_price}" pattern="#,###" />원
						</div>
						<div class="staticValuesBox">
							<p>거래완료일 : <fmt:formatDate value="${item.auctions_end_date}" pattern="yyyy.MM.dd"/></p>
						</div>
					</a>
				</c:forEach>
				<!-- /구매 완료 상품 반복 -->
			</c:if>
		</div>
		<!-- pagination -->
		<div id="pagingBox">
			<ul>
				<c:if test="${pageNum10 != 0}">
					<li><a href="/mypage/auctions_end_brought?page=${pageNum10}&scroll=0">&#60;</a></li>
				</c:if>
				<c:forEach var="num" begin="${pageNum10 + 1}" end="${(pageNumMax - pageNum10) < 10 ? pageNumMax : pageNum10 + 10}" step="1">
					<c:if test="${pageNum1 == num}">
						<li class="nowPage">
							<a href="/mypage/auctions_end_brought?page=${num}&scroll=0">${num}</a>
						</li>
					</c:if>
					<c:if test="${pageNum1 != num}">
						<li>
							<a href="/mypage/auctions_end_brought?page=${num}&scroll=0">${num}</a>
						</li>
					</c:if>
				</c:forEach>
				<c:if test="${(pageNumMax - pageNum10) > 10}">
					<li><a href="/mypage/auctions_end_brought?page=${pageNum10 + 11}&scroll=0">&#62;</a></li>
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
	</script>
</body>
</html>