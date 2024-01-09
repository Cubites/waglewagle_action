<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="/resources/css/mypage/qnas_list.css">
</head>
<body>
	<div id="qnaContainer">
		<div id="qnaList">
			<div id="qnaListHeader">
				<div>번호</div>
				<div>문의 제목</div>
				<div>등록일</div>
			</div>
			<ul>
				<c:if test="${fn:length(ListData) == 0}">
					<li id="noItems">문의한 내역이 없습니다.</li>
				</c:if>
				<c:if test="${fn:length(ListData) != 0}">
					<!-- 문의글 반복 -->
					<c:forEach var="item" items="${ListData}">
						<li>
							<a href="/mypage/qnas/detail?id=${item.qnas_id}" style="${item.qnas_reply == null ? '' : (item.qnas_read == 0 ? 'background-color: #FBE3E3' : '')}">
								<div>${item.rownum}</div>
								<div>${item.qnas_title}</div>
								<div><fmt:formatDate value="${item.qnas_date}" pattern="yyyy.MM.dd"/></div>
							</a>
						</li>
					</c:forEach>
					<!-- /문의글 반복 -->
				</c:if>
			</ul>
		</div>
		<!-- pagination -->		
		<div id="pagingBox">
			<ul>
				<c:if test="${pageNum10 != 0}">
					<li><a href="/mypage/qnas?page=${pageNum10}&scroll=0">&#60;</a></li>
				</c:if>
				<c:forEach var="num" begin="${pageNum10 + 1}" end="${(pageNumMax - pageNum10) < 10 ? pageNumMax : pageNum10 + 10}" step="1">
					<c:if test="${pageNum1 == num}">
						<li class="nowPage">
							<a href="/mypage/qnas?page=${num}&scroll=0">${num}</a>
						</li>
					</c:if>
					<c:if test="${pageNum1 != num}">
						<li>
							<a href="/mypage/qnas?page=${num}&scroll=0">${num}</a>
						</li>
					</c:if>
				</c:forEach>
				<c:if test="${(pageNumMax - pageNum10) > 10}">
					<li><a href="/mypage/qnas?page=${pageNum10 + 11}&scroll=0">&#62;</a></li>
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