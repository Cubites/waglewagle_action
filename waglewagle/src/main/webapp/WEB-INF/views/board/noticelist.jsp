<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sample</title>
	<link rel="stylesheet" href="/resources/css/common/common.css">
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<link rel="stylesheet" href="/resources/css/board/noticelist.css">
</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp"%>
	<%@ include file="/WEB-INF/views/common/quickmenu.jsp" %>
	<div id="center">
		<div id="container">

			<div style="width: 100%; height: 600px;">
				<!-- 공지 표시 영역 -->
				<!-- 여기부분 작성함 -->
				<!-- 공지리스트 -->
				
				<div class="noticelist">
				<h2>공지사항</h2>
					<table class="notice">
						<thead>
							<tr>
								<th>번호</th>
								<th class="tSize">제목</th>
								<th class="dSize">등록일</th>
							</tr>
						</thead>
						<tbody>
							<c:if test="${empty list }">
								<tr>
									<td colspan="3">등록된 공지가 없습니다.</td>
								</tr>
							</c:if>
							
							<c:forEach items="${list}" var="NoticesVO">
								<tr>
									<!-- 번호 -->
									<th scope="row">${NoticesVO.notices_id }</th>
									<!-- 제목 -->
                					<td class="tSize"><a href="noticelist/${NoticesVO.notices_id}">${NoticesVO.notices_title}</a></td>
                					<!-- 작성일 -->
                					<td class="dSize">${NoticesVO.notices_date}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					
				</div>
				
				<div>
					<ul class="paging">
						<c:if test="${prev}">
							<li><a
								href="/board/noticelist?page=${startPage-1}&searchWord=${noticesVO.searchWord}">이전</a>
							</li>
						</c:if>

						<c:forEach var="p" begin="${startPage}" end="${endPage}">
							<c:if test="${p != NoticesVO.page}">
								<li><a
									href="/board/noticelist?page=${p}&searchWord=${noticesVO.searchWord}">${p}</a>
								</li>
							</c:if>
						</c:forEach>

						<c:if test="${map.prev}">
							<li><a
								href="/board/noticelist?page=${map.endPage+1}&searchWord=${noticesVO.searchWord}">이후</a></li>
						</c:if>
					</ul>
				</div>

			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/common/footer.jsp"%>
</body>
</html>