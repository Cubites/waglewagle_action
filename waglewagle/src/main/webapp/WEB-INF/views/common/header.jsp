<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<header>
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;200;300;400;500;600;700;800;900&display=swap" rel="stylesheet">
</header>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<body>
	<div id="header">
		<div id="headerContainer">
			<div id="headerTop">
				<a href="/" id="headerTopLeft">
					<img alt="logo" src="/resources/images/logo.png">
				</a>
				<div id="headerTopCenter" class="text_center">
					<div id=searchBox>
						<img alt="search" src="/resources/images/search.png">			
						<input type="text" placeholder="상품명 혹은 거래 제목을 검색해보세요!" id="searchWord" />
					</div>
				</div>
				<div id="headerTopRight">
					<c:if test='${!empty sessionScope.users_info.users_nick}'>
						<div>${sessionScope.users_info.users_nick} 님</div>
					</c:if>
					<c:if test='${empty sessionScope.users_info.users_nick}'>
						<div class="text_center">
							<a href="/users/login" class="text_center">로그인</a>
						</div>
					</c:if>
					<div class="text_center">
						<img src="/resources/images/mypageIcon.png">
						<c:if test='${!empty sessionScope.users_info.users_nick}'>
							<div id="myMenu">
								<a href="/mypage/auctions">마이페이지</a>
								<a href="javascript:void(0);" id="logoutButton">로그아웃</a>
							</div>
						</c:if>
					</div>
				</div>
			</div>
			
			<div id="headerBottom">
				<div id="headerBottomLeft">
					<img src="/resources/images/menu.png">
					<ul>
						<li>
							패션 / 뷰티
							<ul>
								<li class="category" value="2">여성의류</li>
								<li class="category" value="3">남성의류</li>
								<li class="category" value="4">코트</li>
								<li class="category" value="5">어린이</li>
								<li class="category" value="6">신발</li>
								<li class="category" value="7">가방 / 지갑</li>
								<li class="category" value="8">시계</li>
								<li class="category" value="9">주얼리</li>
								<li class="category" value="10">미용</li>
							</ul>
						</li>
						<li>
							전자기기
							<ul>
								<li class="category" value="12">노트북</li>
								<li class="category" value="13">데스크탑</li>
								<li class="category" value="14">웨어러블</li>
								<li class="category" value="15">휴대폰</li>
								<li class="category" value="16">태블릿</li>
								<li class="category" value="17">컴퓨터 주변기기</li>
								<li class="category" value="18">카메라</li>
								<li class="category" value="19">콘솔 게임기</li>
							</ul>
						</li>
						<li>
							반려동물
							<ul>
								<li class="category" value="21">소모품</li>
								<li class="category" value="22">옷</li>
								<li class="category" value="23">장난감</li>
							</ul>
						</li>
						<li class="category" value="26">생활 / 가전</li>
						<li class="category" value="24">도서 / 음반</li>
						<li class="category" value="25">기타</li>
					</ul>
					<!-- 
					<ul>
						<c:forEach var="cate1" items="${categoryFirst}" varStatus="status1">
							<li>
								<a href="#">${cate1.value}</a>
								<ul>
									<c:forEach var="cate2" items="${categorySecond[cate1.key]}">
										<li><a href="#">${cate2}</a>
									</c:forEach>
								</ul>
							</li>
						</c:forEach>
					</ul>
					-->
				</div>
				<div id="headerBottomCenter">
					<a href="/board/noticelist" class="text_center">공지사항</a>
					<a href="/boards/qnas/write" class="text_center">문의하기</a>				
				</div>
				<a href="/goods/regist" id="headerBottomRight">
					<img src="/resources/images/shopping.png">
					<span>상품등록</span>
				</a>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		$("#logoutButton").click(function() {
		   if(confirm("로그아웃 하시겠습니까?")) {
		       location.href="/users/logout";
		   }
		});
		
		// 검색어 입력하고 엔터키 눌렀을 때
        $("#searchWord").keyup(function (event) {  
            var searchText = event.target.value.toLowerCase();  
            if (event.keyCode === 13) {  
            	let encode= encodeURI("/goods/search?search_word="+searchText);
             	location.href= encode;
            }
        });  
		
		// 카테고리 눌렀을 때
		$(".category").click(function (event) {  
            var searchCategory = event.target.value;  
           	location.href= "/goods/search?category_id="+searchCategory;

        }); 
		
	</script>
</body>
</html>