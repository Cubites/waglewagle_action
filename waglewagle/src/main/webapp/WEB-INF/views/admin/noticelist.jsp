<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head> 
    <meta charset="utf-8">
    <title></title>
    <META name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, user-scalable=no"> 
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.css" />
    <link rel="stylesheet" href="/resources/css/admin/noticelist.css"/>
    <script>
	    function noticewrite(){
			 location.href = "/admin/noticewrite";
		}	    
	    function notice(){
			 location.href = "/admin/noticelist";
		}
		function qna(){
			 location.href = "/admin/qnalist";
		}
		function stats(){
			 location.href = "/admin/stats";
		}
		function user(){
			 location.href = "/admin/userManageList";
		}
		function goods(){
			 location.href = "/admin/goodsManageList";
		}
		function admin(){
			 location.href = "/admin/adminmanage";
		}
		function password(){
			 location.href = "/admin/changePwd";
		}
		
 		/* 리스트에서 공지 삭제하기 */
		function noticeDelete(notices_id){
		    if(confirm("선택한 공지를 정말로 삭제 하시겠습니까?")==true){
		    	location.href="/admin/noticedelete/"+notices_id;
		    }
		}
    </script>
</head> 
<body>
	<div id="header">
        <div id="headerContainer">
            <br/>
            <img src="/resources/images/log.jpg" title="와글와글 로고 "/ onclick="notice()">
        </div>
    </div>

    <div id="center">
        <div id="container">
            <div id="side-box">
                <div id="notice" onclick="notice()"><a href=""></a>공지</div>
                <div id="qna" onclick="qna()">문의</div>
                <div id="showdata" onclick="stats()">통계</div>
                <div id="adminuser" onclick="user()">회원관리</div>
                <div id="admingoods" onclick="goods()">상품관리</div>
                <div id="adminmaster" onclick="admin()">관리자 계정</div>
                <div id="chagepwd" onclick="password()">비밀번호 변경</div>
            </div>
            <div id="main-box">
				<!-- 검색 -->
             	<div id="plus">공지검색 &nbsp;
					<form method="get" name="searchForm" id="searchForm" action="/admin/noticelist">
						<input type="text" id="sNotice" name="searchWord" value="${noticesVO.searchWord}"  title="검색어입력하세요." placeholder="제목을 입력하세요.">&nbsp;&nbsp;
						<input type="submit" id="searchbtn" value="검색" title="검색">
					</form>
				</div>
                
                <!-- 공지리스트 -->
                <div class="noticelist">	
                    <table class="nlist">

                        <colgroup>
                            <col width="80px" />
                            <col width="*" />
                            <col width="100px" />
                            <col width="100px" />
                            <col width="100px" />
                        </colgroup>

                        <thead>
                            <tr>
                                <th>번호</th>
                                <th>제목</th>
                                <th>작성일</th>
                                <th>작성자</th>
                                <th>삭제하기</th>
                            </tr>
                        </thead>
                        
                        <tbody>
                        
                        
                        <c:if test="${empty list }">
                        	<tr>
                        		<td colspan="5">등록된 공지가 없습니다.</td>
                        	</tr>
                        </c:if>
                        
                        <c:forEach items="${list}" var="NoticesVO">
                        	<tr>
                        		<!-- 번호 -->
                        		<td>${NoticesVO.notices_id }</td>
                        		<!-- 제목 -->
                        		<td><a href="noticelist/${NoticesVO.notices_id}">${NoticesVO.notices_title}</a></td>
                        		<!-- 작성일 -->
                        		<td>${NoticesVO.notices_date}</td>
                        		<!-- 작성자 -->
                        		<td>${NoticesVO.admins_id}</td>
                        		<!-- 삭제버튼 -->
                        		<td><a href="#;" role="button" type="button" id="delbtn" onclick="noticeDelete(${NoticesVO.notices_id })">삭제하기</a></td>
                        	</tr>
                        </c:forEach>
                        </tbody>
                    </table>
                    
					<!--공지작성 버튼 -->
					<div>
						<div id="notice_button">
							<input type="button" id="writebtn" value="공지작성" onclick="noticewrite()">
						</div>
					</div>
                    
                    <div id="pp">
                    	<ul class="paging">
	                    	<li class="pg">
		                    	<c:if test="${prev}">
	                    		<a href="/admin/noticelist?page=${startPage-1}&searchWord=${noticesVO.searchWord}">이전</a>
		                    	</c:if>
	                    	</li>
	                    	
	                    	<c:forEach var="p" begin="${startPage}" end="${endPage}">
	                            <c:if test="${p != NoticesVO.page}">
	                            <li><a href="/admin/noticelist?page=${p}&searchWord=${noticesVO.searchWord}">${p}</a></li>
	                            </c:if>
	                        </c:forEach>
	
							<li class="pg">
							<c:if test="${next}">
	                    		<a href="/admin/noticelist?page=${map.endPage+1}&searchWord=${noticesVO.searchWord}">이후</a>
	                    	</c:if></li>
	                    </ul>
					</div>
                    
            	</div>
            </div>
        </div>
    </div>
</body> 
</html>