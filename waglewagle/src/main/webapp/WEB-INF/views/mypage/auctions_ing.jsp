<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="/resources/css/mypage/auctions.css">
	<link rel="stylesheet" href="/resources/css/mypage/auctions_ing.css">
</head>
<body>
	<div id="auctionsContainer">
		<div id="acTitle">'<span>${users_info.users_nick}</span>'님의 거래 중인 목록</div>
		<div id="itemsList">
			<c:if test="${fn:length(ListData) == 0}">
				<div id="noItems">거래 중인 상품이 없습니다.</div>
			</c:if>
			<c:if test="${fn:length(ListData) != 0}">
				<!-- 거래 중인 상품 반복 -->
				<c:forEach var="item" items="${ListData}">
					<a class="itemBox" href="/chat/${item.goods_id}">
						<c:if test="${item.auctions_ing_read == 0}">
							<div class="newMark">NEW</div>
						</c:if>
						<img class="wayMark" src='/resources/images/${item.buyer_id == users_info.users_id ? "buy_icon.png" : "sell_icon.png"}'>
						<img class="goodsThumb" src="/upload/${item.goods_th_img}">
						<div class="itemTitle">${item.goods_title}</div>
						<div class="varPriceBox">
							낙찰가 : <fmt:formatNumber value="${item.purchase_price}" pattern="#,###" />원
						</div>
						<div class="staticValuesBox">
							<p>마감일 : <fmt:formatDate value="${item.goods_exp}" pattern="yyyy.MM.dd"/></p>
						</div>
					</a>
				</c:forEach>
				<!-- /거래 중인 상품 반복 -->
			</c:if>
		</div>
		<!-- pagination -->
		<div id="pagingBox">
			<ul>
				<c:if test="${pageNum10 != 0}">
					<li><a href="/mypage/auctions_ing?page=${pageNum10}&scroll=0">&#60;</a></li>
				</c:if>
				<c:forEach var="num" begin="${pageNum10 + 1}" end="${(pageNumMax - pageNum10) < 10 ? pageNumMax : pageNum10 + 10}" step="1">
					<c:if test="${pageNum1 == num}">
						<li class="nowPage">
							<a href="/mypage/auctions_ing?page=${num}&scroll=0">${num}</a>
						</li>
					</c:if>
					<c:if test="${pageNum1 != num}">
						<li>
							<a href="/mypage/auctions_ing?page=${num}&scroll=0">${num}</a>
						</li>
					</c:if>
				</c:forEach>
				<c:if test="${(pageNumMax - pageNum10) > 10}">
					<li><a href="/mypage/auctions_ing?page=${pageNum10 + 11}&scroll=0">&#62;</a></li>
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